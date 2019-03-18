raise "#{node['platform']} is not a supported platform in the nginx::source recipe" unless platform_family?('rhel', 'amazon', 'fedora', 'debian', 'suse')

node.normal['nginx']['binary'] = node['nginx']['source']['sbin_path']
node.normal['nginx']['daemon_disable'] = true

user node['nginx']['user'] do
  system true
  shell  '/bin/false'
  home   node['nginx']['user_home']
  manage_home true
  not_if { node['nginx']['source']['use_existing_user'] }
end

include_recipe 'nginx::ohai_plugin' if node['nginx']['ohai_plugin_enabled']
include_recipe 'nginx::commons_dir'
include_recipe 'nginx::commons_script'
build_essential 'install compilation tools'

src_filepath = "#{Chef::Config['file_cache_path']}/nginx-#{node['nginx']['source']['version']}.tar.gz"

# install prereqs
package value_for_platform_family(
  %w(rhel fedora amazon) => %w(pcre-devel openssl-devel tar zlib-devel),
  %w(suse) => %w(pcre-devel libopenssl-devel tar),
  %w(debian) => %w(libpcre3 libpcre3-dev libssl-dev tar zlib1g-dev)
)

remote_file 'nginx source' do
  source   node['nginx']['source']['url']
  checksum node['nginx']['source']['checksum']
  path     src_filepath
  backup   false
  retries  4
end

node.run_state['nginx_force_recompile'] = false
node.run_state['nginx_configure_flags'] =
  node['nginx']['source']['default_configure_flags'] | node['nginx']['configure_flags']
node.run_state['nginx_source_env'] = {}

include_recipe 'nginx::commons_conf'

cookbook_file "#{node['nginx']['dir']}/mime.types" do
  source 'mime.types'
  notifies :reload, 'service[nginx]', :delayed
end

# Unpack downloaded source so we could apply nginx patches
# in custom modules - example http://yaoweibin.github.io/nginx_tcp_proxy_module/
# patch -p1 < /path/to/nginx_tcp_proxy_module/tcp.patch
bash 'unarchive_source' do
  cwd  ::File.dirname(src_filepath)
  code <<-EOH
    tar zxf #{::File.basename(src_filepath)} -C #{::File.dirname(src_filepath)} --no-same-owner
  EOH
  not_if { ::File.directory?("#{Chef::Config['file_cache_path'] || '/tmp'}/nginx-#{node['nginx']['source']['version']}") }
end

node['nginx']['source']['modules'].each do |ngx_module|
  include_recipe ngx_module
end

configure_flags       = node.run_state['nginx_configure_flags']
nginx_force_recompile = node.run_state['nginx_force_recompile']

bash 'compile_nginx_source' do
  cwd ::File.dirname(src_filepath)
  environment node.run_state['nginx_source_env']
  code <<-EOH
    cd nginx-#{node['nginx']['source']['version']} &&
    ./configure #{node.run_state['nginx_configure_flags'].join(' ')} &&
    make && make install
  EOH

  not_if do
    nginx_force_recompile == false &&
      node.automatic_attrs['nginx'] &&
      node.automatic_attrs['nginx']['version'] == node['nginx']['source']['version'] &&
      node.automatic_attrs['nginx']['configure_arguments'].sort == configure_flags.sort
  end

  notifies :restart, 'service[nginx]'
  notifies :reload,  'ohai[reload_nginx]', :immediately if node['nginx']['ohai_plugin_enabled']
end

case node['nginx']['init_style']
when 'upstart'
  # we rely on this to set up nginx.conf with daemon disable instead of doing
  # it in the upstart init script.
  node.normal['nginx']['daemon_disable'] = node['nginx']['upstart']['foreground']

  template '/etc/init/nginx.conf' do
    source 'nginx-upstart.conf.erb'
    variables(lazy { { pid_file: pidfile_location } })
  end

  service 'nginx' do
    provider Chef::Provider::Service::Upstart
    supports status: true, restart: true, reload: true
    action   [:start, :enable]
  end
when 'systemd'

  systemd_prefix = platform_family?('suse') ? '/usr/lib' : '/lib'

  template "#{systemd_prefix}/systemd/system/nginx.service" do
    source 'nginx.service.erb'
  end

  # This ensures the systemd unit file is reload in the case of a nginx version downgrade/upgrade
  # And previous version (newer or older) is stopped so service resource starts the newly compiled version
  execute 'nginx - systemctl daemon-reload' do
    action :nothing
    command 'systemctl daemon-reload'
    # Subscribes to unit file and systemctl daemon-reload
    subscribes :run, "template[#{systemd_prefix}/systemd/system/nginx.service]", :immediately
    # Notifies service to :stop in case a nginx version is running so service resource below starts the right version
    # newer version if upgrade, older version if downgrade
    notifies :stop, 'service[nginx]', :immediately
  end

  service 'nginx' do
    provider Chef::Provider::Service::Systemd
    supports status: true, restart: true, reload: true
    action   [:reload, :start, :enable]
  end
else
  node.normal['nginx']['daemon_disable'] = false

  generate_init = true

  case node['platform']
  when 'debian', 'ubuntu'
    generate_template = true
    defaults_path     = '/etc/default/nginx'
  when 'freebsd'
    generate_init     = false
  else
    generate_template = true
    defaults_path     = '/etc/sysconfig/nginx'
  end

  template '/etc/init.d/nginx' do
    source 'nginx.init.erb'
    mode   '0755'
    variables(lazy { { pid_file: pidfile_location } })
  end if generate_init

  if generate_template # ~FC023
    template defaults_path do
      source 'nginx.sysconfig.erb'
    end
  end

  service 'nginx' do
    supports status: true, restart: true, reload: true
    action   [:start, :enable]
  end
end

node.run_state.delete('nginx_configure_flags')
node.run_state.delete('nginx_force_recompile')

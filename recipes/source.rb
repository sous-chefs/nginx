#
# Cookbook:: nginx
# Recipe:: source
#
# Author:: Adam Jacob (<adam@chef.io>)
# Author:: Joshua Timberman (<joshua@chef.io>)
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright:: 2009-2017, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

raise "#{node['platform']} is not a supported platform in the nginx::source recipe" unless platform_family?('rhel', 'fedora', 'debian', 'suse')

node.normal['nginx']['binary'] = node['nginx']['source']['sbin_path']
node.normal['nginx']['daemon_disable'] = true

user node['nginx']['user'] do
  system true
  shell  '/bin/false'
  home   '/var/www'
  not_if { node['nginx']['source']['use_existing_user'] }
end

include_recipe 'chef_nginx::ohai_plugin'
include_recipe 'chef_nginx::commons_dir'
include_recipe 'chef_nginx::commons_script'
include_recipe 'build-essential::default'

src_filepath = "#{Chef::Config['file_cache_path']}/nginx-#{node['nginx']['source']['version']}.tar.gz"

# install prereqs
package value_for_platform_family(
  %w(rhel fedora) => %w(pcre-devel openssl-devel tar),
  %w(suse) => %w(pcre-devel libopenssl-devel tar),
  %w(debian) => %w(libpcre3 libpcre3-dev libssl-dev tar)
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

include_recipe 'chef_nginx::commons_conf'

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
  cwd  ::File.dirname(src_filepath)
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
  notifies :reload,  'ohai[reload_nginx]', :immediately
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

  service 'nginx' do
    provider Chef::Provider::Service::Systemd
    supports status: true, restart: true, reload: true
    action   [:start, :enable]
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

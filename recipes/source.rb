#
# Cookbook Name:: nginx
# Recipe:: source
#
# Author:: Adam Jacob (<adam@chef.io>)
# Author:: Joshua Timberman (<joshua@chef.io>)
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright 2009-2013, Chef Software, Inc.
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

# This is for Chef 10 and earlier where attributes aren't loaded
# deterministically (resolved in Chef 11).
node.load_attribute_by_short_filename('source', 'nginx') if node.respond_to?(:load_attribute_by_short_filename)

nginx_url = node['nginx']['source']['url'] ||
            "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"

node.set['nginx']['binary']          = node['nginx']['source']['sbin_path']
node.set['nginx']['daemon_disable']  = true

unless node['nginx']['source']['use_existing_user']
  user node['nginx']['user'] do
    system true
    shell  '/bin/false'
    home   '/var/www'
  end
end

include_recipe 'nginx::ohai_plugin'
include_recipe 'nginx::commons_dir'
include_recipe 'nginx::commons_script'
include_recipe 'build-essential::default'

src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/nginx-#{node['nginx']['source']['version']}.tar.gz"
packages = value_for_platform_family(
  %w(rhel fedora suse) => %w(pcre-devel openssl-devel),
  %w(gentoo)      => [],
  %w(default)     => %w(libpcre3 libpcre3-dev libssl-dev)
)

packages.each do |name|
  package name
end

remote_file nginx_url do
  source   nginx_url
  checksum node['nginx']['source']['checksum']
  path     src_filepath
  backup   false
end

node.run_state['nginx_force_recompile'] = false
node.run_state['nginx_configure_flags'] =
  node['nginx']['source']['default_configure_flags'] | node['nginx']['configure_flags']

include_recipe 'nginx::commons_conf'

cookbook_file "#{node['nginx']['dir']}/mime.types" do
  source 'mime.types'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  notifies :reload, 'service[nginx]', :delayed
end

# source install depends on the existence of the `tar` package
package 'tar'

# Unpack downloaded source so we could apply nginx patches
# in custom modules - example http://yaoweibin.github.io/nginx_tcp_proxy_module/
# patch -p1 < /path/to/nginx_tcp_proxy_module/tcp.patch
bash 'unarchive_source' do
  cwd  ::File.dirname(src_filepath)
  code <<-EOH
    tar zxf #{::File.basename(src_filepath)} -C #{::File.dirname(src_filepath)}
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
when 'runit'
  node.set['nginx']['src_binary'] = node['nginx']['binary']
  include_recipe 'runit::default'

  runit_service 'nginx'

  service 'nginx' do
    supports       :status => true, :restart => true, :reload => true
    reload_command "#{node['runit']['sv_bin']} hup #{node['runit']['service_dir']}/nginx"
  end
when 'bluepill'
  include_recipe 'bluepill::default'

  template "#{node['bluepill']['conf_dir']}/nginx.pill" do
    source 'nginx.pill.erb'
    mode   '0644'
  end

  bluepill_service 'nginx' do
    action [:enable, :load]
  end

  service 'nginx' do
    supports       :status => true, :restart => true, :reload => true
    reload_command "[[ -f #{node['nginx']['pid']} ]] && kill -HUP `cat #{node['nginx']['pid']}` || true"
    action         :nothing
  end
when 'upstart'
  # we rely on this to set up nginx.conf with daemon disable instead of doing
  # it in the upstart init script.
  node.set['nginx']['daemon_disable']  = node['nginx']['upstart']['foreground']

  template '/etc/init/nginx.conf' do
    source 'nginx-upstart.conf.erb'
    owner  'root'
    group  node['root_group']
    mode   '0644'
  end

  service 'nginx' do
    provider Chef::Provider::Service::Upstart
    supports :status => true, :restart => true, :reload => true
    action   :nothing
  end
else
  node.set['nginx']['daemon_disable'] = false

  generate_init = true

  case node['platform']
  when 'gentoo'
    generate_template = false
  when 'debian', 'ubuntu'
    generate_template = true
    defaults_path    = '/etc/default/nginx'
  when 'freebsd'
    generate_init    = false
  else
    generate_template = true
    defaults_path    = '/etc/sysconfig/nginx'
  end

  template '/etc/init.d/nginx' do
    source 'nginx.init.erb'
    owner  'root'
    group  node['root_group']
    mode   '0755'
  end if generate_init

  if generate_template
    template defaults_path do
      source 'nginx.sysconfig.erb'
      owner  'root'
      group  node['root_group']
      mode   '0644'
    end
  end

  service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action   :enable
  end
end

node.run_state.delete('nginx_configure_flags')
node.run_state.delete('nginx_force_recompile')

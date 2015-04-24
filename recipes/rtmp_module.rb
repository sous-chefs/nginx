#
# Cookbook Name:: nginx
# Recipe:: rtmp_module
#
# Author:: Shaun Keenan (<skeenan@gmail.com>)
#
# Copyright 2015, Shaun Keenan
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

tar_location = "#{Chef::Config['file_cache_path']}/rtmp_module.tar.gz"
module_location = "#{Chef::Config['file_cache_path']}/rtmp_module/#{node['nginx']['rtmp']['source_checksum']}"

remote_file tar_location do
  source   node['nginx']['rtmp']['source_url']
  checksum node['nginx']['rtmp']['source_checksum']
  owner    'root'
  group    node['root_group']
  mode     '0644'
end

directory module_location do
  owner     'root'
  group     node['root_group']
  mode      '0755'
  recursive true
  action    :create
end

bash 'extract_rtmp' do
  cwd  ::File.dirname(tar_location)
  user 'root'
  code <<-EOH
    tar -zxf #{tar_location} -C #{module_location}
  EOH
  not_if { ::File.exist?("#{module_location}/rtmp-nginx-module-#{node['nginx']['rtmp']['version']}/config") }
end

node.run_state['nginx_configure_flags'] =
    node.run_state['nginx_configure_flags'] | ["--add-module=#{module_location}/nginx-rtmp-module-#{node['nginx']['rtmp']['version']}/"]


template "#{node['nginx']['dir']}/rtmp.conf" do
  source 'modules/rtmp.conf.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  notifies :reload, 'service[nginx]', :delayed
end

directory node['nginx']['rtmp']['stat_root'] do
  owner     'root'
  group     node['root_group']
  mode      '0755'
  recursive true
end

remote_file "#{node['nginx']['rtmp']['stat_root']}/stat.xsl" do 
  source "file://#{module_location}/nginx-rtmp-module-#{node['nginx']['rtmp']['version']}/stat.xsl"
  owner  'root'
  group  node['root_group']
  mode   '0644'
  notifies :reload, 'service[nginx]', :delayed
end

template "#{node['nginx']['dir']}/sites-available/rtmp-hls" do
  source 'modules/rtmp-hls.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  notifies :reload, 'service[nginx]', :delayed
end
nginx_site 'rtmp-hls' do
  enable node['nginx']['rtmp']['hls']
end
template "#{node['nginx']['dir']}/sites-available/rtmp-stat" do
  source 'modules/rtmp-stat.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  notifies :reload, 'service[nginx]', :delayed
end
nginx_site 'rtmp-stat' do
  enable node['nginx']['rtmp']['stat']
end
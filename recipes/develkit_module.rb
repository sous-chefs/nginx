#
# Cookbook Name:: nginx
# Recipe:: develkit_module
#
# Author:: Carlos Martin <inean.es@gmail.com>
#
# Copyright 2013, Carlos Martin
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

develkit_src_filename = "develkit-nginx-module-v#{node['nginx']['develkit']['version']}.tar.gz"
develkit_src_filepath = "#{Chef::Config['file_cache_path']}/#{develkit_src_filename}"
develkit_extract_path = "#{Chef::Config['file_cache_path']}/nginx_develkit_module/#{node['nginx']['develkit']['checksum']}"

remote_file develkit_src_filepath do
  source   node['nginx']['develkit']['url']
  checksum node['nginx']['develkit']['checksum']
  owner    'root'
  group    'root'
  mode     00644
end

bash 'extract_http_develkit_module' do
  cwd ::File.dirname(develkit_src_filepath)
  code <<-EOH
    mkdir -p #{develkit_extract_path}
    tar xzf #{develkit_src_filename} -C #{develkit_extract_path}
    mv #{develkit_extract_path}/*/* #{develkit_extract_path}/
  EOH

  not_if { ::File.exists?(develkit_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{develkit_extract_path}"]

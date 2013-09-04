#
# Cookbook Name:: nginx
# Recipe:: http_setmisc_module
#
# Author:: Carlos Martin (<inean.es@gmail.com>)
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

include_recipe "nginx::develkit_module"

setmisc_src_filename = "setmisc-nginx-module-v#{node['nginx']['setmisc']['version']}.tar.gz"
setmisc_src_filepath = "#{Chef::Config['file_cache_path']}/#{setmisc_src_filename}"
setmisc_extract_path = "#{Chef::Config['file_cache_path']}/nginx_setmisc_module/#{node['nginx']['setmisc']['checksum']}"

remote_file setmisc_src_filepath do
  source   node['nginx']['setmisc']['url']
  checksum node['nginx']['setmisc']['checksum']
  owner    'root'
  group    'root'
  mode     00644
end

bash 'extract_http_setmisc_module' do
  cwd ::File.dirname(setmisc_src_filepath)
  code <<-EOH
    mkdir -p #{setmisc_extract_path}
    tar xzf #{setmisc_src_filename} -C #{setmisc_extract_path}
    mv #{setmisc_extract_path}/*/* #{setmisc_extract_path}/
  EOH

  not_if { ::File.exists?(setmisc_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{setmisc_extract_path}"]

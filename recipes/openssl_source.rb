#
# Cookbook Name:: nginx
# Recipe:: openssl_source
#
# Author:: David Radcliffe (<radcliffe.david@gmail.com>)
#
# Copyright 2013, David Radcliffe
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

src_filename = ::File.basename(node['nginx']['openssl_source']['url'])
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"
extract_path = "#{Chef::Config['file_cache_path']}/openssl-#{node['nginx']['openssl_source']['version']}"

remote_file src_filepath do
  source node['nginx']['openssl_source']['url']
  owner  'root'
  group  'root'
  mode   '0644'
  not_if { ::File.exists?(src_filepath) }
end

bash 'extract_openssl' do
  cwd  ::File.dirname(src_filepath)
  code <<-EOH
    mkdir -p #{extract_path}
    tar xzf #{src_filename} -C #{extract_path}
    mv #{extract_path}/*/* #{extract_path}/
  EOH
  not_if { ::File.exists?(extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--with-openssl=#{extract_path}"]

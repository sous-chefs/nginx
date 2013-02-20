#
# Cookbook Name:: nginx
# Recipe:: redis2_module
#
# Author:: Leif Gensert (<leif@proeprtybase.com>)
#
# Copyright 2013, Propertybase GmbH
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

redis2_src_filename = "redis2-nginx-module-v#{node['nginx']['redis2']['version']}.tar.gz"
redis2_src_filepath = "#{Chef::Config['file_cache_path']}/#{redis2_src_filename}"
redis2_extract_path = "#{Chef::Config['file_cache_path']}/nginx_redis2_module/#{node['nginx']['redis2']['checksum']}"

remote_file redis2_src_filepath do
  source   node['nginx']['redis2']['url']
  checksum node['nginx']['redis2']['checksum']
  owner    'root'
  group    'root'
  mode     00644
end

bash 'extract_redis2_module' do
  cwd ::File.dirname(redis2_src_filepath)
  code <<-EOH
    mkdir -p #{redis2_extract_path}
    tar xzf #{redis2_src_filename} -C #{redis2_extract_path}
    mv #{redis2_extract_path}/*/* #{redis2_extract_path}/
  EOH

  not_if { ::File.exists?(redis2_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{redis2_extract_path}"]
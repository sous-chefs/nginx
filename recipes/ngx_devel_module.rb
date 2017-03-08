#
# Cookbook:: nginx
# Recipes:: devel
#
# Author:: Arthur Freyman (<afreyman@riotgames.com>)
#
# Copyright:: 2013-2017, Riot Games
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

devel_src_filename = ::File.basename(node['nginx']['devel']['url'])
devel_src_filepath = "#{Chef::Config['file_cache_path']}/#{devel_src_filename}"
devel_extract_path = "#{Chef::Config['file_cache_path']}/nginx-devel-#{node['nginx']['devel']['version']}"

remote_file devel_src_filepath do
  source   node['nginx']['devel']['url']
  checksum node['nginx']['devel']['checksum']
end

bash 'extract_devel_module' do
  cwd  ::File.dirname(devel_src_filepath)
  code <<-EOH
    mkdir -p #{devel_extract_path}
    tar xzf #{devel_src_filename} -C #{devel_extract_path}
  EOH
  not_if { ::File.exist?(devel_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{devel_extract_path}/ngx_devel_kit-#{node['nginx']['devel']['version']}"]

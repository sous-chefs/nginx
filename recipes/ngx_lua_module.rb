#
# Cookbook:: nginx
# Recipes:: nginx_lua_module
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

lua_src_filename = ::File.basename(node['nginx']['lua']['url'])
lua_src_filepath = "#{Chef::Config['file_cache_path']}/#{lua_src_filename}"
lua_extract_path = "#{Chef::Config['file_cache_path']}/nginx-lua-#{node['nginx']['lua']['version']}"

remote_file lua_src_filepath do
  source   node['nginx']['lua']['url']
  checksum node['nginx']['lua']['checksum']
end

bash 'extract_lua_module' do
  cwd  ::File.dirname(lua_src_filepath)
  code <<-EOH
    mkdir -p #{lua_extract_path}
    tar xzf #{lua_src_filename} -C #{lua_extract_path}
  EOH
  not_if { ::File.exist?(lua_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{lua_extract_path}/lua-nginx-module-#{node['nginx']['lua']['version']}"]

include_recipe 'chef_nginx::lua'
include_recipe 'chef_nginx::ngx_devel_module'

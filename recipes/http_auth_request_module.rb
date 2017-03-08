#
# Cookbook:: nginx
# Recipe:: http_auth_request_module
#
# Author:: David Radcliffe (<radcliffe.david@gmail.com>)
#
# Copyright:: 2013-2017, David Radcliffe
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

# Documentation:
#   http://nginx.org/en/docs/http/ngx_http_auth_request_module.html
if node['nginx']['source']['version'] >= '1.5.4'
  node.run_state['nginx_configure_flags'] =
    node.run_state['nginx_configure_flags'] | ['--with-http_auth_request_module']
else
  arm_src_filename = ::File.basename(node['nginx']['auth_request']['url'])
  arm_src_filepath = "#{Chef::Config['file_cache_path']}/#{arm_src_filename}"
  arm_extract_path = "#{Chef::Config['file_cache_path']}/nginx_auth_request/#{node['nginx']['auth_request']['checksum']}"

  remote_file arm_src_filepath do
    source   node['nginx']['auth_request']['url']
    checksum node['nginx']['auth_request']['checksum']
  end

  bash 'extract_auth_request_module' do
    cwd ::File.dirname(arm_src_filepath)
    code <<-EOH
      mkdir -p #{arm_extract_path}
      tar xzf #{arm_src_filename} -C #{arm_extract_path}
      mv #{arm_extract_path}/*/* #{arm_extract_path}/
    EOH
    not_if { ::File.exist?(arm_extract_path) }
  end

  node.run_state['nginx_configure_flags'] =
    node.run_state['nginx_configure_flags'] | ["--add-module=#{arm_extract_path}"]
end

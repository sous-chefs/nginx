#
# Cookbook Name:: nginx
# Recipe:: push_stream_module
#
# Author:: Tom Taylor (<tom@newspaperclub.com>)
#
# Copyright 2012, Newspaper Club
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

push_stream_src_filename = ::File.basename(node['nginx']['push_stream']['url'])
push_stream_src_filepath = "#{Chef::Config['file_cache_path']}/#{push_stream_src_filename}"
push_stream_extract_path = "#{Chef::Config['file_cache_path']}/nginx-push-stream-module/#{node['nginx']['push_stream']['checksum']}"

remote_file push_stream_src_filepath do
  source node['nginx']['push_stream']['url']
  checksum node['nginx']['push_stream']['checksum']
  owner "root"
  group "root"
  mode 0644
end

bash "extract_push_stream_module" do
  cwd ::File.dirname(push_stream_src_filepath)
  code <<-EOH
    mkdir -p #{push_stream_extract_path}
    tar xzf #{push_stream_src_filename} -C #{push_stream_extract_path}
    mv #{push_stream_extract_path}/*/* #{push_stream_extract_path}/
  EOH

  not_if { ::File.exists?(push_stream_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{push_stream_extract_path}/wandenberg-nginx-push-stream-module-28d9df7"]

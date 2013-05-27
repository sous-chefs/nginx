#
# Cookbook Name:: nginx
# Recipe:: http_ngx_pagespeed_module
#
# Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)
#
# Copyright 2013, Achim Rosenhagen
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

package "build-essential"
package "zlib1g-dev"
package "libpcre3"
package "libpcre3-dev"

directory node['nginx']['ngx_pagespeed']['FileCachePath'] do
  owner node['nginx']['user']
  group node['nginx']['user']
  action :create
end

ngx_pagespeed_src_filename = ::File.basename(node['nginx']['ngx_pagespeed']['url'])
ngx_pagespeed_src_filepath = "#{Chef::Config['file_cache_path']}/#{ngx_pagespeed_src_filename}"
ngx_pagespeed_extract_path = "#{Chef::Config['file_cache_path']}"

remote_file ngx_pagespeed_src_filepath do
  source node['nginx']['ngx_pagespeed']['url']
  owner "root"
  group "root"
  mode 00644
  not_if { node['nginx']['ngx_pagespeed']['src']['file'] }
end

cookbook_file ngx_pagespeed_src_filepath do
  cookbook node['nginx']['ngx_pagespeed']['src']['cookbook']
  owner "root"
  group "root"
  mode 00644
  only_if { node['nginx']['ngx_pagespeed']['src']['file'] }
end

bash "extract_ngx_pagespeed" do
  cwd ::File.dirname(ngx_pagespeed_src_filepath)
  code <<-EOH
    mkdir -p #{ngx_pagespeed_extract_path}
    tar xzf #{ngx_pagespeed_src_filename} -C #{ngx_pagespeed_extract_path}
  EOH
end

ngx_psol_src_filename = ::File.basename(node['nginx']['ngx_pagespeed']['psol']['url'])
ngx_psol_src_filepath = "#{Chef::Config['file_cache_path']}/#{ngx_psol_src_filename}"
ngx_psol_extract_path = "#{ngx_pagespeed_extract_path}/ngx_pagespeed-#{node['nginx']['ngx_pagespeed']['version']}"

remote_file ngx_psol_src_filepath do
  source node['nginx']['ngx_pagespeed']['psol']['url']
  owner "root"
  group "root"
  mode 00644
  not_if { node['nginx']['ngx_pagespeed']['psol']['src']['file'] }
end

cookbook_file ngx_psol_src_filepath do
  cookbook node['nginx']['ngx_pagespeed']['psol']['src']['cookbook']
  owner "root"
  group "root"
  mode 00644
  only_if { node['nginx']['ngx_pagespeed']['psol']['src']['file'] }
end

bash "extract_psol" do
  cwd ::File.dirname(ngx_psol_src_filepath)
  code <<-EOH
    tar xzf #{ngx_psol_src_filename} -C #{ngx_psol_extract_path}
  EOH
end

template "#{node['nginx']['dir']}/conf.d/ngx_pagespeed.conf" do
  source "modules/ngx_pagespeed.conf.erb"
  owner "root"
  group "root"
  mode 00644
  variables(
    :params => node['nginx']['ngx_pagespeed']
  )
  notifies :reload, "service[nginx]"
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{ngx_pagespeed_extract_path}/ngx_pagespeed-#{node['nginx']['ngx_pagespeed']['version']}"]
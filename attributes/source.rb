#
# Cookbook:: chef_nginx
# Attributes:: source
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright:: 2012-2017, Riot Games
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

include_attribute 'chef_nginx::default'

default['nginx']['init_style'] = if node['platform'] == 'ubuntu' && node['platform_version'].to_f <= 14.04
                                   # init_package identifies 12.04/14.04 as init, but we should be using upstart here
                                   'upstart'
                                 else
                                   node['init_package']
                                 end

default['nginx']['source']['version']                 = node['nginx']['version']
default['nginx']['source']['prefix']                  = "/opt/nginx-#{node['nginx']['source']['version']}"
default['nginx']['source']['conf_path']               = "#{node['nginx']['dir']}/nginx.conf"
default['nginx']['source']['sbin_path']               = "#{node['nginx']['source']['prefix']}/sbin/nginx"
default['nginx']['source']['default_configure_flags'] = %W(
  --prefix=#{node['nginx']['source']['prefix']}
  --conf-path=#{node['nginx']['dir']}/nginx.conf
  --sbin-path=#{node['nginx']['source']['sbin_path']}
)

default['nginx']['configure_flags']    = []
default['nginx']['source']['version']  = node['nginx']['version']
default['nginx']['source']['url']      = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"
default['nginx']['source']['checksum'] = '75020f1364cac459cb733c4e1caed2d00376e40ea05588fb8793076a4c69dd90'
default['nginx']['source']['modules']  = %w(
  chef_nginx::http_ssl_module
  chef_nginx::http_gzip_static_module
)
default['nginx']['source']['use_existing_user'] = false

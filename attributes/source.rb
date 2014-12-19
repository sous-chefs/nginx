#
# Cookbook Name:: nginx
# Attributes:: source
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright 2012-2013, Riot Games
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

include_attribute 'nginx::default'

default['nginx']['source']['version']                 = node['nginx']['version']
default['nginx']['source']['prefix']                  = "/opt/nginx-#{node['nginx']['source']['version']}"
default['nginx']['source']['conf_path']               = "#{node['nginx']['dir']}/nginx.conf"
default['nginx']['source']['sbin_path']               = "#{node['nginx']['source']['prefix']}/sbin/nginx"
default['nginx']['source']['default_configure_flags'] = %W(
  --prefix=#{node['nginx']['source']['prefix']}
  --conf-path=#{node['nginx']['dir']}/nginx.conf
  --sbin-path=#{node['nginx']['source']['sbin_path']}
  --with-http_ssl_module
  --error-log-path=/var/log/nginx/error.log 
  --http-client-body-temp-path=/var/lib/nginx/body 
  --http-fastcgi-temp-path=/var/lib/nginx/fastcgi 
  --http-log-path=/var/log/nginx/access.log 
  --http-proxy-temp-path=/var/lib/nginx/proxy 
  --http-scgi-temp-path=/var/lib/nginx/scgi 
  --http-uwsgi-temp-path=/var/lib/nginx/uwsgi 
  --lock-path=/var/lock/nginx.lock
  --pid-path=/var/run/nginx.pid 
  --with-debug 
  --with-http_addition_module 
  --with-http_dav_module 
  --with-http_gzip_static_module 
  --with-http_image_filter_module 
  --with-http_realip_module 
  --with-http_stub_status_module 
  --with-http_ssl_module 
  --with-http_sub_module 
  --with-http_xslt_module 
  --with-ipv6 
  --with-sha1=/usr/include/openssl 
  --with-md5=/usr/include/openssl 
  --with-mail 
  --with-mail_ssl_module
 
)

default['nginx']['configure_flags']    = []
default['nginx']['source']['version']  = node['nginx']['version']
default['nginx']['source']['url']      = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"
default['nginx']['source']['checksum'] = '7c989a58e5408c9593da0bebcd0e4ffc3d892d1316ba5042ddb0be5b0b4102b9'
default['nginx']['source']['modules']  = %w(
  nginx::ajp_module
  nginx::jvm_module
  nginx::upstream_check_module
  nginx::upload_progress_module
  nginx::sticky_module
)
default['nginx']['source']['use_existing_user'] = false

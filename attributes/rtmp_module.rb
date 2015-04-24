#
# Cookbook Name:: nginx
# Recipe:: rtmp_module
#
# Author:: Shaun Keenan (<skeenan@gmail.com>)
#
# Copyright 2015, Shaun Keenan
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

default['nginx']['rtmp']['version']         = '1.1.7'
default['nginx']['rtmp']['source_url']      = "https://github.com/arut/nginx-rtmp-module/archive/v#{node['nginx']['rtmp']['version']}.tar.gz"
default['nginx']['rtmp']['source_checksum'] = '7922b0e3d5f3d9c4b275e4908cfb8f5fb1bfb3ac2df77f4c262cda56df21aab3'

default['nginx']['rtmp']['rtmp_server'] = true
default['nginx']['rtmp']['rtmp_port'] = '1935'
default['nginx']['rtmp']['hls_port'] = '8080'
default['nginx']['rtmp']['stat_port'] = '8081'
default['nginx']['rtmp']['hls'] = false
default['nginx']['rtmp']['stat'] = false
case node['platform_family']
when 'freebsd'
  default['nginx']['rtmp']['stat_root'] = '/usr/local/www/nginx-rtmp'
else
  default['nginx']['rtmp']['stat_root'] = '/var/www/nginx-rtmp'
end

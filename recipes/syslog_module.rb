#
# Cookbook Name:: nginx
# Recipe:: syslog_module
#
# Author:: Bob Ziuchkovski (<bob@bz-technology.com>)
#
# Copyright 2014, UserTesting
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

nginx_src = "#{Chef::Config['file_cache_path']}/nginx-#{node['nginx']['source']['version']}"
nginx_syslog_src = "#{Chef::Config['file_cache_path']}/nginx_syslog_module"

major, minor, patch = node['nginx']['source']['version'].split('.').map { |s| Integer(s) }
fail 'Unsupported nginx version' if major != 1
case minor
when 2
  case patch
  when 0..6
    syslog_patch = 'syslog_1.2.0.patch'
  else
    syslog_patch = 'syslog_1.2.7.patch'
  end
when 3
  case patch
  when 0..9
    syslog_patch = 'syslog_1.2.0.patch'
  when 10..13
    syslog_patch = 'syslog_1.3.11.patch'
  else
    syslog_patch = 'syslog_1.3.14.patch'
  end
when 4
  syslog_patch = 'syslog_1.4.0.patch'
when 5..6
  syslog_patch = 'syslog_1.5.6.patch'
when 7
  syslog_patch = 'syslog_1.7.0.patch'
else
  fail 'Unsupported nginx version'
end

git nginx_syslog_src do
  repository node['nginx']['syslog']['git_repo']
  revision node['nginx']['syslog']['git_revision']
  action :sync
  user 'root'
  group 'root'
end

execute 'apply_nginx_syslog_patch' do
  cwd  nginx_src
  command "patch -p1 < #{nginx_syslog_src}/#{syslog_patch}"
  not_if "patch -p1 --dry-run --reverse --silent < #{nginx_syslog_src}/#{syslog_patch}", :cwd => nginx_src
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{nginx_syslog_src}"]

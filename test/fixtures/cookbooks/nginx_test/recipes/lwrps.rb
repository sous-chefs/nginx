#
# Cookbook Name:: nginx_test
# Recipe:: lwrps
#
# Copyright 2014, James Cuzella
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
include_recipe 'nginx::default'

directory '/var/www/' do
  owner 'root'
  action :create
end

directory '/var/www/test-site' do
  owner node['nginx']['user']
  action :create
end

cookbook_file 'index.html' do
  owner node['nginx']['user']
  path '/var/www/test-site/index.html'
  action :create
end

nginx_site 'test-site' do
  cookbook 'nginx'
  default_server true
  docroot '/var/www/test-site'
  directory_index 'index.html index.htm'
end
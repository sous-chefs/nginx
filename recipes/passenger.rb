#
# Cookbook Name:: nginx
# Recipe:: Passenger
#
# Copyright 2013, Opscode, Inc.
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

packages = value_for_platform_family(
  %w(rhel)   => node['nginx']['passenger']['packages']['rhel'],
  %w(debian) => node['nginx']['passenger']['packages']['debian']
)

unless packages.empty?
  packages.each do |name|
    package name
  end
end

gem_package 'rake'

gem_package 'passenger' do
  action     :install
  version    node['nginx']['passenger']['version']
  gem_binary node['nginx']['passenger']['gem_binary'] if node['nginx']['passenger']['gem_binary']
end

template "#{node["nginx"]["dir"]}/conf.d/passenger.conf" do
  source 'modules/passenger.conf.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[nginx]'
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{node["nginx"]["passenger"]["root"]}/ext/nginx"]

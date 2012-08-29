#
# Cookbook Name:: nginx
# Recipe:: Passenger
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

#package 'libcurl4-openssl-dev' do
package 'ruby-devel' do
  action :install
end

gem_package 'passenger' do
  action :install
  version node["nginx"]["passenger"]["version"]
end

node.default["nginx"]["passenger"]["version"] = "3.0.12"
node.default["nginx"]["passenger"]["root"] = "/usr/lib/ruby/gems/1.8/gems/passenger-3.0.12"
node.default["nginx"]["passenger"]["ruby"] = %x{which ruby}.chomp
node.default["nginx"]["passenger"]["max_pool_size"] = 10

service "nginx" do
  supports :status => true, :restart => true, :reload => true
end

template "#{node["nginx"]["dir"]}/conf.d/passenger.conf" do
  source "modules/passenger.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :passenger_root => node["nginx"]["passenger"]["root"],
    :passenger_ruby => node["nginx"]["passenger"]["ruby"],
    :passenger_max_pool_size => node["nginx"]["passenger"]["max_pool_size"]
  )
  notifies :reload, resources(:service => "nginx")
end

node.run_state[:nginx_configure_flags] =
  node.run_state[:nginx_configure_flags] | ["--add-module=#{node["nginx"]["passenger"]["root"]}/ext/nginx"]

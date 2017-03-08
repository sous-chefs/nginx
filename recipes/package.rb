#
# Cookbook:: nginx
# Recipe:: package
# Author:: AJ Christensen <aj@junglist.gen.nz>
#
# Copyright:: 2008-2017, Chef Software, Inc.
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

include_recipe 'chef_nginx::ohai_plugin'

case node['nginx']['repo_source']
when 'epel'
  if platform_family?('rhel')
    include_recipe 'yum-epel'
  else
    Chef::Log.warn("node['nginx']['repo_source'] set to EPEL, but not running on a RHEL platform so skipping EPEL setup")
  end
when 'nginx'
  include_recipe 'chef_nginx::repo'
  package_install_opts = '--disablerepo=* --enablerepo=nginx' if platform_family?('rhel')
when 'passenger'
  if platform_family?('debian')
    include_recipe 'chef_nginx::repo_passenger'
  else
    Chef::Log.warn("node['nginx']['repo_source'] set to passenger, but not running on a Debian based platform so skipping repo setup")
  end
else
  Chef::Log.warn('Unrecognized distro value set, or no value set. Using distro provided packages instead.')
end

package node['nginx']['package_name'] do
  options package_install_opts
  notifies :reload, 'ohai[reload_nginx]', :immediately
end

service 'nginx' do
  supports status: true, restart: true, reload: true
  action   [:start, :enable]
end

include_recipe 'chef_nginx::commons'

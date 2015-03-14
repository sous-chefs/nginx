# Cookbook Name:: nginx
# Recipe:: repo_passenger
# Author:: Jose Alberto Suarez Lopez <ja@josealberto.org>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'rhel', 'fedora'

  log 'There is not official phusion passenger repo for redhat based systems.' do
    level :info
  end

when 'debian'
  include_recipe 'apt::default'
  package 'apt-transport-https'

  apt_repository 'phusionpassenger' do
    uri 'https://oss-binaries.phusionpassenger.com/apt/passenger'
    distribution node['lsb']['codename']
    components %w(main)
    deb_src true
    keyserver 'keyserver.ubuntu.com'
    key '561F9B9CAC40B2F7'
  end

  include_recipe 'nginx::passenger'
end

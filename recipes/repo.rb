#
# Cookbook Name:: nginx
# Recipe:: repo
# Author:: Nick Rycar <nrycar@bluebox.net>
#
# Copyright 2008-2013, Opscode, Inc.
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

case node['platform_family']
when 'rhel', 'fedora'
  case node['nginx']['repo_source']
  when 'nginx'
    yum_repository 'nginx' do
      description 'Nginx.org Repository'
      baseurl         node['nginx']['upstream_repository']
      gpgkey      'http://nginx.org/keys/nginx_signing.key'
      action :create
    end
  when 'phusionpassenger'
    yum_repository 'passenger' do
      description 'Phusion Passenger'
      baseurl         node['nginx']['passenger_repository']
      gpgkey      'http://passenger.stealthymonkeys.com/RPM-GPG-KEY-stealthymonkeys.asc'
      gpgkey      'http://nginx.org/keys/nginx_signing.key'
      action :create
    end
  end
when 'debian'
  include_recipe 'apt::default'

  case node['nginx']['repo_source']
  when 'nginx'
    apt_repository 'nginx' do
      uri          node['nginx']['upstream_repository']
      distribution node['lsb']['codename']
      components   %w(nginx)
      deb_src      true
      key          'http://nginx.org/keys/nginx_signing.key'
    end
  when 'phusionpassenger'
    apt_repository 'passenger' do
      uri          node['nginx']['passenger_repository']
      distribution node['lsb']['codename']
      components   %w(main)
      deb_src      true
      keyserver    'keyserver.ubuntu.com'
      key          '561F9B9CAC40B2F7'
    end
  end
end

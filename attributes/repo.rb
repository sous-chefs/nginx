#
# Cookbook:: nginx
# Recipe:: repo
#
# Author:: Nick Rycar <nrycar@bluebox.net>
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

default['nginx']['upstream_repository'] =
  case node['platform_family']
  when 'rhel', 'fedora', 'amazon'
    case node['platform']
    when 'centos'
      # See http://wiki.nginx.org/Install
      "https://nginx.org/packages/centos/#{node['platform_version'].to_i}/$basearch/"
    when 'amazon' # Chef < 13 on Amazon
      'https://nginx.org/packages/rhel/6/$basearch/'
    else
      "https://nginx.org/packages/rhel/#{node['platform_version'].to_i}/$basearch/"
    end
  when 'debian'
    "https://nginx.org/packages/#{node['platform']}"
  when 'suse'
    'https://nginx.org/packages/sles/12'
  end

default['nginx']['repo_signing_key'] = 'https://nginx.org/keys/nginx_signing.key'

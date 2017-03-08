#
# Cookbook:: nginx
# Recipe:: common/dir
#
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

directory node['nginx']['dir'] do
  mode      '0755'
  recursive true
end

directory node['nginx']['log_dir'] do
  mode      node['nginx']['log_dir_perm']
  owner     node['nginx']['user']
  action    :create
  recursive true
end

directory 'pid file directory' do
  path       lazy { File.dirname(pidfile_location) }
  mode      '0755'
  recursive true
end

%w(sites-available sites-enabled conf.d).each do |leaf|
  directory File.join(node['nginx']['dir'], leaf) do
    mode  '0755'
  end
end

if !node['nginx']['default_site_enabled'] && platform_family?('rhel', 'fedora')
  %w(default.conf example_ssl.conf).each do |config|
    file "/etc/nginx/conf.d/#{config}" do
      action :delete
    end
  end
end

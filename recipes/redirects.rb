#
# Cookbook Name:: nginx
# Recipe:: redirects
# Author:: ali.sade@gmail.com
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
redirects = node['nginx']['redirects_data_bag']

redirects.each do |redirect|
  r = data_bag_item('redirects', redirect)
  template "#{node['nginx']['dir']}/sites-available/#{r['id']}" do
    source 'redirect.erb'
    owner 'root'
    group 'root'
    mode 00644
    variables(:r => r
    )
    notifies :reload, 'service[nginx]'
  end

  nginx_site r['id'] do
    enable r['enable']
  end
end

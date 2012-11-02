#
# Cookbook Name:: nginx
# Recipe:: cloudflare
#
# Author:: Carl Mercier (<carl@carlmercier.com>)
#
# Copyright 2012, Carl Mercier
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

cookbook_file "#{node['nginx']['dir']}/conf.d/cloudflare" do
  source "cloudflare"
  owner "root"
  group "root"
  mode 00644
  notifies :reload, 'service[nginx]'
end
#
# Cookbook:: nginx
# Recipe:: Passenger
#
# Copyright:: 2013-2017, Chef Software, Inc.
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
  %w(rhel amazon) => node['nginx']['passenger']['packages']['rhel'],
  %w(fedora) => node['nginx']['passenger']['packages']['fedora'],
  %w(debian) => node['nginx']['passenger']['packages']['debian']
)

package packages unless packages.empty?

gem_package 'rake' if node['nginx']['passenger']['install_rake']

if node['nginx']['passenger']['install_method'] == 'package'
  package node['nginx']['package_name']
  package 'passenger'
elsif node['nginx']['passenger']['install_method'] == 'source'

  gem_package 'passenger' do
    action     :install
    version    node['nginx']['passenger']['version']
    gem_binary node['nginx']['passenger']['gem_binary'] if node['nginx']['passenger']['gem_binary']
  end

  passenger_module = node['nginx']['passenger']['root']

  passenger_module += if Chef::VersionConstraint.new('>= 5.0.19').include?(node['nginx']['passenger']['version'])
                        '/src/nginx_module'
                      else
                        '/ext/nginx'
                      end

  node.run_state['nginx_configure_flags'] =
    node.run_state['nginx_configure_flags'] | ["--add-module=#{passenger_module}"]

end

template "#{node['nginx']['dir']}/conf.d/passenger.conf" do
  source 'modules/passenger.conf.erb'
  notifies :reload, 'service[nginx]', :delayed
end

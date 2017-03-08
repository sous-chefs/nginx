#
# Cookbook:: chef_nginx
# Library:: helpers
#
# Author:: Tim Smith (<tsmith@chef.io>)
#
# Copyright:: 2016-2017, Chef Software, Inc.
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

# simple helper module for the nginx cookbook
module NginxRecipeHelpers
  # pidfile is hard to determine on Debian systems.
  # Upstream packages and older distro releases use '/var/run/nginx.pid'
  # systemd based distros and Ubuntu 14.04 use '/run/nginx.pid' for their
  # packages
  def pidfile_location
    if (node['nginx']['repo_source'].nil? || node['nginx']['repo_source'] == 'distro') &&
       (node['init_package'] == 'systemd' || node['platform_version'].to_f == 14.04)
      '/run/nginx.pid'
    else
      '/var/run/nginx.pid'
    end
  end
end

Chef::Resource.send(:include, NginxRecipeHelpers)

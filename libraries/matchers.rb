#
# Cookbook:: nginx
# Library:: matchers
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

if defined?(ChefSpec)
  #############
  # nginx_site
  #############
  ChefSpec.define_matcher :nginx_site

  def enable_nginx_site(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:nginx_site, :enable, resource_name)
  end

  def disable_nginx_site(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:nginx_site, :disable, resource_name)
  end
end

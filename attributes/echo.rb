#
# Cookbook:: nginx
# Attributes:: echo
#
# Author:: Danial Pearce (<github@tigris.id.au>)
#
# Copyright:: 2013-2017, Danial Pearce
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

default['nginx']['echo']['version']        = '0.61'
default['nginx']['echo']['url']            = "https://github.com/openresty/echo-nginx-module/archive/v#{node['nginx']['echo']['version']}.tar.gz"
default['nginx']['echo']['checksum']       = '2e6a03032555f5da1bdff2ae96c96486f447da3da37c117e0f964ae0753d22aa'

#
# Cookbook:: nginx
# Attributes:: devel
#
# Author:: Arthur Freyman (<afreyman@riotgames.com>)
#
# Copyright:: 2013-2017, Riot Games
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

default['nginx']['devel']['version']  = '0.3.0'
default['nginx']['devel']['url']      = "https://github.com/simpl/ngx_devel_kit/archive/v#{node['nginx']['devel']['version']}.tar.gz"
default['nginx']['devel']['checksum'] = '88e05a99a8a7419066f5ae75966fb1efc409bad4522d14986da074554ae61619'

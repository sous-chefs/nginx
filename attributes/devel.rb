#
# Cookbook Name:: nginx
# Attributes:: devel
#
# Author:: Arthur Freyman (<afreyman@riotgames.com>)
#
# Copyright 2013, Riot Games
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

default['nginx']['devel']['version']  = '0.2.18'
default['nginx']['devel']['url']      = "https://github.com/simpl/ngx_devel_kit/archive/v#{node['nginx']['devel']['version']}.tar.gz"
default['nginx']['devel']['checksum'] = 'c9c9f0a1b068d38c6c45b15d9605f1b2344dbcd45abf0764cd8e2ba92d6a3d2c'

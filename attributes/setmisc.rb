#
# Cookbook Name:: nginx
# Attributes:: setmisc
#
# Author:: Carlos Martin (<inean.es@gmail.com>)
#
# Copyright 2013 Carlos Martin
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


default['nginx']['setmisc']['version']        = '0.22rc8'
default['nginx']['setmisc']['url']            = "https://github.com/agentzh/set-misc-nginx-module/tarball/v#{node['nginx']['setmisc']['version']}"
default['nginx']['setmisc']['checksum']       = '06b77c88caeac76ac784781bea8514ef25b7f643df113ea83fc4ac5202ca9efd'

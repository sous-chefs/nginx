#
# Cookbook Name:: nginx
# Attributes:: develkit
#
# Author:: Carlos Martin (<inean.es@gmail.com>)
#
# Copyright 2013, Carlos Martin
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

default['nginx']['develkit']['version']  = "0.2.17"
default['nginx']['develkit']['url']      = "https://github.com/simpl/ngx_devel_kit/tarball/v#{node['nginx']['develkit']['version']}"
default['nginx']['develkit']['checksum'] = "564c827237e123709eb8f30ec4e2ff981752fe7b1ea0798fdf1a68c66dc99165"

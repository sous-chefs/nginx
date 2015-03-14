#
# Cookbook Name:: nginx
# Attributes:: naxsi
#
# Author:: Artiom Lunev (<artiom.lunev@gmail.com>)
#
# Copyright 2012-2013, Artiom Lunev
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

default['nginx']['naxsi']['version'] = '0.53-2'
default['nginx']['naxsi']['url'] = "https://github.com/nbs-system/naxsi/archive/#{node['nginx']['naxsi']['version']}.tar.gz"
default['nginx']['naxsi']['checksum'] = 'ada592f5e7f80a6d549cc435ee8720df01a788dc88cf27a7d55521bb7e4c66fa11b9ec28216aff7e13c70a5faf12cb745bd398b8a782ed4dea1eecd04b07e24c'

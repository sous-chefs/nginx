#
# Cookbook Name:: nginx
# Attributes:: lua
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

default['nginx']['lua']['version']  = '0.8.7'
default['nginx']['lua']['url']      = "https://github.com/chaoslawful/lua-nginx-module/archive/v#{node['nginx']['lua']['version']}.tar.gz"
default['nginx']['lua']['checksum'] = '4b9be3c159b9c884a38e044e07aaf4d06bd2893977d0b0dae02c124d8e907f93'

default['nginx']['luajit']['version']  = '2.0.2'
default['nginx']['luajit']['url']	     = "http://luajit.org/download/LuaJIT-#{node['nginx']['luajit']['version']}.tar.gz"
default['nginx']['luajit']['checksum'] = 'c05202974a5890e777b181908ac237625b499aece026654d7cc33607e3f46c38'

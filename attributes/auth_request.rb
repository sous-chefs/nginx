#
# Cookbook Name:: nginx
# Attributes:: auth_request
#
# Author:: David Radcliffe (<radcliffe.david@gmail.com>)
#
# Copyright 2013, David Radcliffe
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

default['nginx']['auth_request']['url']      = 'http://mdounin.ru/hg/ngx_http_auth_request_module/archive/ee8ff54f9b66.tar.gz'
default['nginx']['auth_request']['checksum'] = '7ab85e1c350c5a9c60ed1319c45fed144cc3c3e1'

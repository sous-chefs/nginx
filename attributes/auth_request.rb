#
# Cookbook:: nginx
# Attributes:: auth_request
#
# Author:: David Radcliffe (<radcliffe.david@gmail.com>)
#
# Copyright:: 2013-2017, David Radcliffe
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

default['nginx']['auth_request']['url']      = 'http://mdounin.ru/hg/ngx_http_auth_request_module/archive/662785733552.tar.gz'
default['nginx']['auth_request']['checksum'] = '2057bdefd2137a5000d9dbdbfca049d1ba7832ad2b9f8855a88ea5dfa70bd8c1'

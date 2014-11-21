#
# Cookbook Name:: nginx
# Attributes:: geoip
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright 2012-2013, Riot Games
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

default['nginx']['geoip']['path']                 = '/srv/geoip'
default['nginx']['geoip']['enable_city']          = true
default['nginx']['geoip']['country_dat_url']      = 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz'
default['nginx']['geoip']['country_dat_checksum'] = '9b2fea3cb76a5eb30cb61c5a393ebd034e7c5869af2fa34368b64791f46cd775'
default['nginx']['geoip']['city_dat_url']         = 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'
default['nginx']['geoip']['city_dat_checksum']    = 'c7ccef1502c7906d98932a6b7c9106ff5e4c650534d74859a19227a6bae08390'
default['nginx']['geoip']['lib_version']          = '1.6.3'
lib_version = node['nginx']['geoip']['lib_version'] # convenience variable for line length
default['nginx']['geoip']['lib_url']              = "https://github.com/maxmind/geoip-api-c/releases/download/v#{lib_version}/GeoIP-#{lib_version}.tar.gz"
default['nginx']['geoip']['lib_checksum']         = 'e483839a81a91c3c85df89ef409fc7b526c489e0355d537861cfd1ea9534a8f2'

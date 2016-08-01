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
default['nginx']['geoip']['country_dat_checksum'] = '87ea7255887af3bf12adecaf9f8d4abc6d7065155f8923feed9748ab8541370f'
default['nginx']['geoip']['city_dat_url']         = 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'
default['nginx']['geoip']['city_dat_checksum']    = 'de873ffe7a8b3aa47fc5fedbbfd861360d020cd3c78c446e033177a872da35ce'
default['nginx']['geoip']['lib_version']          = '1.6.3'
lib_version = node['nginx']['geoip']['lib_version'] # convenience variable for line length
default['nginx']['geoip']['lib_url']              = "https://github.com/maxmind/geoip-api-c/releases/download/v#{lib_version}/GeoIP-#{lib_version}.tar.gz"
default['nginx']['geoip']['lib_checksum']         = 'e483839a81a91c3c85df89ef409fc7b526c489e0355d537861cfd1ea9534a8f2'

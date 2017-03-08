#
# Cookbook:: chef_nginx
# Attributes:: geoip
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright:: 2012-2017, Riot Games
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

# NOTE: The GeoIP database checksums are nil by default as these files change
# continuously and are not versioned.
# If you self host these files you should create a checksum and set these attributes

default['nginx']['geoip']['path']                 = '/srv/geoip'
default['nginx']['geoip']['enable_city']          = true
default['nginx']['geoip']['country_dat_url']      = 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz'
default['nginx']['geoip']['country_dat_checksum'] = nil
default['nginx']['geoip']['city_dat_url']         = 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'
default['nginx']['geoip']['city_dat_checksum']    = nil
default['nginx']['geoip']['lib_version']          = '1.6.9'
lib_version = node['nginx']['geoip']['lib_version'] # convenience variable for line length
default['nginx']['geoip']['lib_url']              = "https://github.com/maxmind/geoip-api-c/releases/download/v#{lib_version}/GeoIP-#{lib_version}.tar.gz"
default['nginx']['geoip']['lib_checksum']         = '4b446491843de67c1af9b887da17a3e5939e0aeed4826923a5f4bf09d845096f'

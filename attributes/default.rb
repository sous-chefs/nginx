#
# Cookbook Name:: nginx
# Attributes:: default
#
# Author:: Adam Jacob (<adam@chef.io>)
# Author:: Joshua Timberman (<joshua@chef.io>)
#
# Copyright 2009-2013, Chef Software, Inc.
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

# In order to update the version, the checksum attribute must be changed too.
# This attribute is in the source.rb file, though we recommend overriding
# attributes by modifying a role, or the node itself.
default['nginx']['version']      = '1.6.2'
default['nginx']['package_name'] = 'nginx'
default['nginx']['port']         = '80'
default['nginx']['dir']          = '/etc/nginx'
default['nginx']['script_dir']   = '/usr/sbin'
default['nginx']['log_dir']      = '/var/log/nginx'
default['nginx']['log_dir_perm'] = '0750'
default['nginx']['binary']       = '/usr/sbin/nginx'
default['nginx']['default_root'] = '/var/www/nginx-default'
default['nginx']['ulimit']       = '1024'

default['nginx']['pid'] = '/var/run/nginx.pid'

case node['platform_family']
when 'debian'
  default['nginx']['user']       = 'www-data'
  default['nginx']['init_style'] = 'runit'
  if platform == 'ubuntu' && platform_version == '14.04'
    default['nginx']['pid'] = '/run/nginx.pid'
  end
when 'rhel', 'fedora'
  default['nginx']['user']        = 'nginx'
  default['nginx']['init_style']  = 'init'
  default['nginx']['repo_source'] = 'epel'
when 'gentoo'
  default['nginx']['user']       = 'nginx'
  default['nginx']['init_style'] = 'init'
when 'freebsd'
  default['nginx']['package_name'] = 'www/nginx'
  default['nginx']['user']         = 'www'
  default['nginx']['dir']          = '/usr/local/etc/nginx'
  default['nginx']['script_dir']   = '/usr/local/sbin'
  default['nginx']['binary']       = '/usr/local/sbin/nginx'
  default['nginx']['default_root'] = '/usr/local/www/nginx-dist'
when 'suse'
  default['nginx']['user']       = 'wwwrun'
  default['nginx']['init_style'] = 'init'
  default['nginx']['group']      = 'www'
else
  default['nginx']['user']       = 'www-data'
  default['nginx']['init_style'] = 'init'
end

default['nginx']['upstart']['runlevels']     = '2345'
default['nginx']['upstart']['respawn_limit'] = nil
default['nginx']['upstart']['foreground']    = true

default['nginx']['group'] = node['nginx']['group'] || node['nginx']['user']

default['nginx']['gzip']              = 'on'
default['nginx']['gzip_static']       = 'off'
default['nginx']['gzip_http_version'] = '1.0'
default['nginx']['gzip_comp_level']   = '2'
default['nginx']['gzip_proxied']      = 'any'
default['nginx']['gzip_vary']         = 'off'
default['nginx']['gzip_buffers']      = nil
default['nginx']['gzip_types'] = %w(
  text/plain
  text/css
  application/x-javascript
  text/xml
  application/xml
  application/rss+xml
  application/atom+xml
  text/javascript
  application/javascript
  application/json
  text/mathml
)
default['nginx']['gzip_min_length']   = 1_000
default['nginx']['gzip_disable']      = 'MSIE [1-6]\.'

default['nginx']['keepalive']            = 'on'
default['nginx']['keepalive_requests']   = 100
default['nginx']['keepalive_timeout']    = 65
default['nginx']['worker_processes']     = node['cpu'] && node['cpu']['total'] ? node['cpu']['total'] : 1
default['nginx']['worker_connections']   = 1_024
default['nginx']['worker_rlimit_nofile'] = nil
default['nginx']['multi_accept']         = false
default['nginx']['event']                = nil
default['nginx']['accept_mutex_delay']   = nil
default['nginx']['server_tokens']        = nil
default['nginx']['server_names_hash_bucket_size'] = 64
default['nginx']['variables_hash_max_size']       = 1024
default['nginx']['variables_hash_bucket_size']    = 64
default['nginx']['sendfile'] = 'on'
default['nginx']['underscores_in_headers'] = nil
default['nginx']['tcp_nodelay'] = 'on'
default['nginx']['tcp_nopush'] = 'on'

default['nginx']['access_log_options']     = nil
default['nginx']['error_log_options']      = nil
default['nginx']['disable_access_log']     = false
default['nginx']['log_formats']            = {}
default['nginx']['install_method']         = 'package'
default['nginx']['default_site_enabled']   = true
default['nginx']['types_hash_max_size']    = 2_048
default['nginx']['types_hash_bucket_size'] = 64

default['nginx']['proxy_read_timeout']          = nil
default['nginx']['client_body_buffer_size']     = nil
default['nginx']['client_max_body_size']        = nil
default['nginx']['large_client_header_buffers'] = nil
default['nginx']['default']['modules']          = []

default['nginx']['extra_configs'] = {}

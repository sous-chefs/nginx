#
# Cookbook Name:: nginx
# Attributes:: set_misc
#

default['nginx']['set_misc']['version']  = '0.24'
default['nginx']['set_misc']['url']      = "https://github.com/agentzh/set-misc-nginx-module/archive/v#{node['nginx']['set_misc']['version']}.tar.gz"
default['nginx']['set_misc']['checksum'] = 'da404a7dac5fa4a0a86f42b4ec7648b607f4cd66'

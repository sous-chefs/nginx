#
# Cookbook:: chef_nginx
# Attributes:: set_misc
#

default['nginx']['set_misc']['version']  = '0.30'
default['nginx']['set_misc']['url']      = "https://github.com/agentzh/set-misc-nginx-module/archive/v#{node['nginx']['set_misc']['version']}.tar.gz"
default['nginx']['set_misc']['checksum'] = '59920dd3f92c2be32627121605751b52eae32b5884be09f2e4c53fb2fae8aabc'

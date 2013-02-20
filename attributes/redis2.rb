#
# Cookbook Name:: nginx
# Attributes:: redis2
#
# Author:: Leif Gensert (<leif@propertybase.com>)
#

default['nginx']['redis2']['version']        = '0.09'
default['nginx']['redis2']['url']            = "https://github.com/agentzh/redis2-nginx-module/tarball/v#{node['nginx']['redis2']['version']}"
default['nginx']['redis2']['checksum']       = '3e4312d3b2b271e315c8af268ff6595578b526cd1f5d11631aaa336873cf35b3'
default['nginx']['lua']['version']  = '0.10.10'
default['nginx']['lua']['url']      = "https://github.com/chaoslawful/lua-nginx-module/archive/v#{node['nginx']['lua']['version']}.tar.gz"
default['nginx']['lua']['checksum'] = 'b4acb84e2d631035a516d61830c910ef6e6485aba86096221ec745e0dbb3fbc9'

default['nginx']['luajit']['version']  = '2.0.4'
default['nginx']['luajit']['url']	     = "http://luajit.org/download/LuaJIT-#{node['nginx']['luajit']['version']}.tar.gz"
default['nginx']['luajit']['checksum'] = '620fa4eb12375021bef6e4f237cbd2dd5d49e56beb414bee052c746beef1807d'

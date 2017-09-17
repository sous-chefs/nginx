#
# Cookbook:: nginx
# Attributes:: socketproxy.rb
#

default['nginx']['socketproxy']['root'] = '/usr/share/nginx/apps'
default['nginx']['socketproxy']['app_owner'] = 'root'
default['nginx']['socketproxy']['logname'] = 'socketproxy'
default['nginx']['socketproxy']['log_level'] = 'error'
# default['nginx']['socketproxy']['default_app'] = 'default'
# default['nginx']['socketproxy']['apps'] = {
#   'default' => {
#     'prepend_slash' => false,
#     'context_name' => '',
#     'subdir' => 'current',
#     'socket_path' => 'shared/sockets/unicorn.sock'
#   }
# }

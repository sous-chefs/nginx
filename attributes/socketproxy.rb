default['nginx']['socketproxy']['root'] = '/usr/share/nginx/apps'
default['nginx']['socketproxy']['app_owner'] = 'root'
default['nginx']['socketproxy']['logname'] = 'socketproxy'
default['nginx']['socketproxy']['app_defaults'] = {
  'prepend_slash' => false,
  'subdir' => 'current',
  'socket' => {
    'type' => 'tcp',
    'port' => '9090'
  }
}

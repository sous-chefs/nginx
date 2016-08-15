node.default['nginx']['repo_source'] = 'nginx'

apt_update 'update' if platform_family?('debian')

include_recipe 'chef_nginx::repo'
include_recipe 'chef_nginx::default'

node.default['nginx']['repo_source'] = 'nginx'
apt_update 'update'
include_recipe 'chef_nginx::repo'

include_recipe 'test::_base'
include_recipe 'test::_test_site'

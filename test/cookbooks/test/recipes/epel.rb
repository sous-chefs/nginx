node.default['nginx']['repo_source'] = 'epel'

include_recipe 'test::_base'
include_recipe 'test::_test_site'

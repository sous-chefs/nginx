node.default['nginx']['repo_source'] = 'distro'

include_recipe 'test::_base'
include_recipe 'test::_test_site'

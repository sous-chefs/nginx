node.default['nginx']['install_method'] = 'source'

include_recipe 'test::_base'
include_recipe 'test::_test_site'

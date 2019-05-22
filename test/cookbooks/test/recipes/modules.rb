node.default['nginx']['install_method'] = 'source'
node.default['nginx']['source']['modules'] = %w(
  nginx::openssl_source
  nginx::upload_progress_module)

include_recipe 'test::_base'
include_recipe 'test::_test_site'

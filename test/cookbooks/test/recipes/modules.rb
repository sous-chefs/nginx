node.default['nginx']['install_method'] = 'source'
node.default['nginx']['source']['modules'] = %w(
  nginx::http_echo_module
  nginx::http_geoip_module
  nginx::http_gzip_static_module
  nginx::http_realip_module
  nginx::http_v2_module
  nginx::http_ssl_module
  nginx::http_stub_status_module
  nginx::naxsi_module
  nginx::ngx_devel_module
  nginx::ngx_lua_module
  nginx::openssl_source
  nginx::upload_progress_module)

include_recipe 'test::_base'
include_recipe 'test::_test_site'

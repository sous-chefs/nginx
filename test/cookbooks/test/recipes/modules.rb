node.default['nginx']['install_method'] = 'source'
node.default['nginx']['source']['modules'] = %w(
  chef_nginx::headers_more_module
  chef_nginx::http_auth_request_module
  chef_nginx::http_echo_module
  chef_nginx::http_geoip_module
  chef_nginx::http_gzip_static_module
  chef_nginx::http_realip_module
  chef_nginx::http_v2_module
  chef_nginx::http_ssl_module
  chef_nginx::http_stub_status_module
  chef_nginx::naxsi_module
  chef_nginx::ngx_devel_module
  chef_nginx::ngx_lua_module
  chef_nginx::openssl_source
  chef_nginx::upload_progress_module)

include_recipe 'test::_base'
include_recipe 'test::_test_site'

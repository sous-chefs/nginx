node.default['nginx']['install_method'] = 'source'
node.default['nginx']['configure_flags'] = ['--with-stream']
node.default['nginx']['default_site_enabled'] = false

include_recipe 'test::_base'

nginx_stream 'Enable the test_stream' do
  template 'stream.erb'
  name 'test_stream'
  action :enable # modern action
  notifies :restart, 'service[nginx]', :delayed
end

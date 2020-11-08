include_recipe '::repo'
include_recipe '::test_site'

nginx_site 'test_invalid_site' do
  template 'default-site.erb'
  variables(
    'port': 'im not a port',
    'server_name': 'test_site',
    'default_root': '/var/www/html',
    'nginx_log_dir': '/var/log/nginx'
  )
  action :create
  notifies :reload, 'nginx_service[nginx]', :delayed
end

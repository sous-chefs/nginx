template 'nginx_status' do
  path "#{node['nginx']['dir']}/sites-available/nginx_status"
  source 'modules/nginx_status.erb'
  notifies :reload, 'service[nginx]', :delayed
end

nginx_site 'nginx_status'

node.run_state['nginx_configure_flags'] = node.run_state['nginx_configure_flags'] | ['--with-http_stub_status_module']

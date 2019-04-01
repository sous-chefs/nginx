# Documentation: http://wiki.nginx.org/HttpRealIpModule

template "#{node['nginx']['dir']}/conf.d/http_realip.conf" do
  source 'modules/http_realip.conf.erb'
  notifies :reload, 'service[nginx]', :delayed
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ['--with-http_realip_module']

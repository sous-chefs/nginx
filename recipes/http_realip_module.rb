# Documentation: http://wiki.nginx.org/HttpRealIpModule

# Currently only accepts X-Forwarded-For or X-Real-IP
node.default['nginx']['realip']['header']            = 'X-Forwarded-For'
node.default['nginx']['realip']['addresses']         = ['127.0.0.1']
node.default['nginx']['realip']['real_ip_recursive'] = 'off'

template "#{node['nginx']['dir']}/conf.d/http_realip.conf" do
  source 'modules/http_realip.conf.erb'
  notifies :reload, 'service[nginx]', :delayed
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ['--with-http_realip_module']

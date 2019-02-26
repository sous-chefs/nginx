node.default['nginx']['remote_ip_var']  = 'remote_addr'
node.default['nginx']['authorized_ips'] = ['127.0.0.1/32']

template 'authorized_ip' do
  path   "#{node['nginx']['dir']}/authorized_ip"
  source 'modules/authorized_ip.erb'
  notifies :reload, 'service[nginx]', :delayed
end

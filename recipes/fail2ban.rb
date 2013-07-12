include_recipe 'fail2ban'

template '/etc/fail2ban/jail.local' do
  source 'fail2ban/jail.local.erb'
  notifies :restart, 'service[fail2ban]'
end

template '/etc/fail2ban/filter.d/nginx-auth.conf' do
  source 'fail2ban/nginx-auth.conf.erb'
  notifies :restart, 'service[fail2ban]'
end

template '/etc/fail2ban/filter.d/nginx-ipban.conf' do
  source 'fail2ban/nginx-ipban.conf.erb'
  notifies :restart, 'service[fail2ban]'
end

template '/etc/fail2ban/filter.d/nginx-login.conf' do
  source 'fail2ban/nginx-login.conf.erb'
  notifies :restart, 'service[fail2ban]'
end

template '/etc/fail2ban/filter.d/nginx-noscript.conf' do
  source 'fail2ban/nginx-noscript.conf.erb'
  notifies :restart, 'service[fail2ban]'
end

template '/etc/fail2ban/filter.d/nginx-proxy.conf' do
  source 'fail2ban/nginx-proxy.conf.erb'
  notifies :restart, 'service[fail2ban]'
end

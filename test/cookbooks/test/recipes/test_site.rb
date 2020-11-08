# Hosts file entry for test_site
bash 'test_site_hosts_entry' do
  code 'echo "127.0.0.1  test_site" >> /etc/hosts'
  not_if { !::File.readlines('/etc/hosts').grep(/test_site/).empty? }
  user 'root'
end

nginx_config 'nginx' do
  types_hash_max_size 2_048

  action :create
  notifies :restart, 'nginx_service[nginx]', :delayed
end

# Setup a test site
nginx_site 'test_site' do
  template 'default-site.erb'
  variables(
    'port': 80,
    'server_name': 'test_site',
    'default_root': '/var/www/nginx-default',
    'nginx_log_dir': '/var/log/nginx'
  )
  action :create
  notifies :reload, 'nginx_service[nginx]', :delayed
end

nginx_service 'nginx' do
  action :enable
  delayed_action :start
end

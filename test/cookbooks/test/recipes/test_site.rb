# Hosts file entry for test_site
bash 'test_site_hosts_entry' do
  code 'echo "127.0.0.1  test_site" >> /etc/hosts'
  not_if { !::File.readlines('/etc/hosts').grep(/test_site/).empty? }
  user 'root'
end

nginx_config 'nginx' do
  types_hash_max_size 2_048
  folder_mode '0755'

  action :create
  notifies :restart, 'nginx_service[nginx]', :delayed
end

# Setup a test site
nginx_site 'test_site' do
  mode '0644'

  variables(
    'server' => {
      'listen' => [ '*:80' ],
      'server_name' => [ 'test_site' ],
      'access_log' => '/var/log/nginx/test_site.access.log',
      'locations' => {
        '/' => {
          'root' => '/var/www/nginx-default',
          'index' => 'index.html index.htm',
        },
      },
    }
  )

  action :create
  notifies :reload, 'nginx_service[nginx]', :delayed
end

nginx_site 'test_site_disabled' do
  template 'default-site.erb'

  variables(
    'port': 80,
    'server_name': 'test_site',
    'default_root': '/var/www/nginx-default',
    'nginx_log_dir': '/var/log/nginx'
  )
  action [:create, :disable]
  notifies :reload, 'nginx_service[nginx]', :delayed
end

nginx_site 'foo' do
  mode '0644'
  cookbook 'test'
  template 'override-site-template.erb'
  variables(
    'upstream' => {
      'bar' => {
        'server' => 'localhost:1234',
      },
    }
  )
  action :create
end

nginx_service 'nginx' do
  action :enable
  delayed_action :start
end

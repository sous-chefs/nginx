# Hosts file entry for test_site
bash 'test_site_hosts_entry' do
  code 'echo "127.0.0.1  test_site" >> /etc/hosts'
  not_if { ::File.readlines("/etc/hosts").grep(/test_site/).size > 0 }
  user 'root'
end

# This could be in distro.rb and it would work just fine
service 'nginx' do
  extend Nginx::Cookbook::Helpers
  #service_name 'nginx'
  supports restart: true, status: true, reload: true
  action :nothing
end

#setup another a test site
siteconfig = {'port':80,
              'server_name':'test_site',
              'default_root': '/var/www/nginx-default',
              'nginx_log_dir': '/var/log/nginx'
}
nginx_site 'test_site' do
  site_name 'test_site'
  template 'default-site.erb'
  variables siteconfig
  action :enable
end
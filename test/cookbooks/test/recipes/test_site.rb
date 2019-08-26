# This could be in distro.rb and it would work just fine
service 'nginx' do
  extend Nginx::Cookbook::Helpers
  #service_name 'nginx'
  supports restart: true, status: true, reload: true
  action :nothing
end

#setup another a test site
siteconfig = {'port':80,
              'server_name':'test_site.local',
              'default_root': '/var/www/nginx-default',
              'nginx_log_dir': '/var/log/nginx'
}
nginx_site 'test_site' do
  site_name 'test_site'
  template 'default-site.erb'
  variables siteconfig
  action :enable
end
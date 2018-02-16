nginx_site 'Disable default site' do
  site_name 'default'
  enable false # legacy "action"
end

nginx_site 'Enable the test_site' do
  template 'site.erb'
  site_name 'test_site'
  action :enable # modern action
end

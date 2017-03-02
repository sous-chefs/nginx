nginx_site 'default' do
  enable false # legacy "action"
end

nginx_site 'Enable the test_site' do
  template 'site.erb'
  name 'test_site'
  action :enable # modern action
end

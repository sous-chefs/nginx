nginx_site 'default' do
  enable false # legacy "action"
end

template "#{node['nginx']['dir']}/sites-available/test_site" do
  source 'site.erb'
  mode '0644'
  owner node['nginx']['user']
end

nginx_site 'Enable the test_site' do
  name 'test_site'
  action :enable # modern action
end

nginx_site 'default' do
  enable false
end

template "#{node['nginx']['dir']}/sites-available/test_site" do
  source 'site.erb'
  mode '0644'
  owner node['nginx']['user']
  group node['nginx']['user']
end

nginx_site 'test_site' do
  enable true
end

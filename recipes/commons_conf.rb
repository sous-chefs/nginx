template 'nginx.conf' do
  path   "#{node['nginx']['dir']}/nginx.conf"
  source node['nginx']['conf_template']
  cookbook node['nginx']['conf_cookbook']
  notifies :reload, 'service[nginx]', :delayed
  variables(lazy { { pid_file: pidfile_location } })
end

template "#{node['nginx']['dir']}/sites-available/default" do
  source 'default-site.erb'
  notifies :reload, 'service[nginx]', :delayed
end

nginx_site 'default' do
  action node['nginx']['default_site_enabled'] ? :enable : :disable
end

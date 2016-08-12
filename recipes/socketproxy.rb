include_recipe 'chef_nginx::commons_dir'

directory node['nginx']['socketproxy']['root'] do
  owner node['nginx']['socketproxy']['app_owner']
  group node['nginx']['socketproxy']['app_owner']
  mode '0755'
  action :create
end

context_names = node['nginx']['socketproxy']['apps'].map do |_app, app_conf|
  app_conf['context_name']
end

raise 'More than one app has the same context_name configured.' if context_names.uniq.length != context_names.length

template node['nginx']['dir'] + '/sites-available/socketproxy.conf' do
  source 'modules/socketproxy.conf.erb'
  notifies :reload, 'service[nginx]', :delayed
end

link node['nginx']['dir'] + '/sites-enabled/socketproxy.conf' do
  to node['nginx']['dir'] + '/sites-available/socketproxy.conf'
end

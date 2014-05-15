include_recipe 'nginx::commons_dir'

directory node['nginx']['socketproxy']['root'] do
  owner node['nginx']['socketproxy']['app_owner']
  group node['nginx']['socketproxy']['app_owner']
  mode 00755
  action :create
end

context_names = node['nginx']['socketproxy']['apps'].map do |app, app_conf|
  app_conf['context_name']
end

fail 'More than one app has the same context_name configured.' if context_names.uniq.length != context_names.length

template node['nginx']['dir'] + '/sites-available/socketproxy.conf' do
  source 'modules/socketproxy.conf.erb'
  owner 'root'
  group 'root'
  mode 00644
  notifies :reload, 'service[nginx]'
end

link node['nginx']['dir'] + '/sites-enabled/socketproxy.conf' do
  to node['nginx']['dir'] + '/sites-available/socketproxy.conf'
end

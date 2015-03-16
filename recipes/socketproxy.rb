include_recipe 'nginx::commons_dir'

directory node['nginx']['socketproxy']['root'] do
  owner node['nginx']['socketproxy']['app_owner']
  group node['nginx']['socketproxy']['app_owner']
  mode 00755
  action :create
end

if !node['nginx']['socketproxy']['apps'] ||
   node['nginx']['socketproxy']['apps'] == {}
  fail 'nginx::socketproxy requires that at least one applicatinon be defined'
elsif node['nginx']['socketproxy']['apps'].count < 2
  node.set['nginx']['socketproxy']['default_app'] =
    node['nginx']['socketproxy']['apps'].keys.first
else
  fail "Multiple apps defined but node['nginx']['socketproxy']['default_app']" \
    ' not defined.' unless node['nginx']['socketproxy']['default_app']
end

context_names = node['nginx']['socketproxy']['apps'].map do |_app, app_conf|
  app_conf['context_name']
end

fail 'More than one app has the same context_name configured.' if context_names.uniq.length != context_names.length

node['nginx']['socketproxy']['apps'].each do |app, app_conf|
  node.set['nginx']['socketproxy']['apps'][app] =
    node['nginx']['socketproxy']['app_defaults'].merge(
      app_conf
    )
end

Chef::Log.debug "Socketproxy Apps: #{node['nginx']['socketproxy']['apps'].inspect}"
Chef::Log.debug "Default App: #{node['nginx']['socketproxy']['default_app']}"

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

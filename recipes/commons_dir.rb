directory node['nginx']['dir'] do
  mode      '0755'
  recursive true
end

directory node['nginx']['log_dir'] do
  mode      node['nginx']['log_dir_perm']
  owner     node['nginx']['user']
  action    :create
  recursive true
end

directory 'pid file directory' do
  path lazy { File.dirname(pidfile_location) }
  mode      '0755'
  recursive true
end

%w(sites-available sites-enabled conf.d streams-available streams-enabled).each do |leaf|
  directory File.join(node['nginx']['dir'], leaf) do
    mode '0755'
  end
end

if !node['nginx']['default_site_enabled'] && platform_family?('rhel', 'fedora', 'amazon')
  %w(default.conf example_ssl.conf).each do |config|
    file "/etc/nginx/conf.d/#{config}" do
      action :delete
    end
  end
end

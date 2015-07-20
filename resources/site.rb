actions  :enable, :disable, :delete
default_action [:enable]

attribute :template, :kind_of => String, :default => nil
attribute :cookbook, :kind_of => String, :default => nil
attribute :variables, :kind_of => Hash, :default => {}
attribute :available_dir, :kind_of => String, :default => ::File.join(node['nginx']['dir'], 'sites-available')
attribute :enabled_dir, :kind_of => String, :default => ::File.join(node['nginx']['dir'], 'sites-enabled')

# legacy method
def enable(enable = true)
  Chef::Log.info('Method enable deprecated for nginx_site! Use action :enable!')
  action enable ? :enable : :disable
end

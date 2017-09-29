node.default['nginx']['repo_source'] = 'passenger'
node.default['nginx']['package_name'] = 'nginx-extras'
node.default['nginx']['install_method'] = 'package'

package 'apt-transport-https' # needed for force apt-get update

include_recipe 'test::_base'

nginx_site 'default_disable' do
  name 'default'
  enable false # legacy "action"
end

nginx_site 'Enable the test_site' do
  template 'site_with_passenger.erb'
  name 'test_site'
  action :enable # modern action
  notifies :restart, 'service[nginx]', :delayed
end

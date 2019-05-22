include_recipe 'nginx::ohai_plugin' if node['nginx']['ohai_plugin_enabled']

case node['nginx']['repo_source']
when 'epel'
  if platform_family?('rhel')
    include_recipe 'yum-epel'
  else
    Chef::Log.warn("node['nginx']['repo_source'] set to EPEL, but not running on a RHEL platform so skipping EPEL setup")
  end
when 'nginx'
  include_recipe 'nginx::repo'
  package_install_opts = '--disablerepo=* --enablerepo=nginx' if platform_family?('rhel')
when 'passenger'
  if platform_family?('debian')
    include_recipe 'nginx::repo_passenger'
  else
    Chef::Log.warn("node['nginx']['repo_source'] set to passenger, but not running on a Debian based platform so skipping repo setup")
  end
else
  Chef::Log.warn('Unrecognized distro value set, or no value set. Using distro provided packages instead.')
end

package node['nginx']['package_name'] do
  options package_install_opts
  notifies :reload, 'ohai[reload_nginx]', :immediately if node['nginx']['ohai_plugin_enabled']
end

include_recipe 'nginx::passenger' if node['nginx']['repo_source'] == 'passenger'

service 'nginx' do
  supports status: true, restart: true, reload: true
  action   [:start, :enable]
end

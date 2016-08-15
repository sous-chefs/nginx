node.default['nginx']['install_method'] = 'source'

apt_update 'update' if platform_family?('debian')

include_recipe 'chef_nginx::default'

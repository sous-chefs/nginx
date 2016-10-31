apt_update 'update'

# needed for the specs
package 'curl'

include_recipe 'chef_nginx::default'

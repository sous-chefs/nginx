include_recipe 'apt' if platform_family? 'debian' # needed for `apt-get update`
include_recipe 'yum-epel' if platform_family? 'rhel' # nginx package is part of EPEL

# Any utilities expected to be available for verifcation purposes
package 'curl' do
  action :install
end

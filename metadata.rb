name 'chef_nginx'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs and configures nginx'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '6.2.0'

recipe 'chef_nginx', 'Installs nginx package and sets up configuration with Debian apache style with sites-enabled/sites-available'
recipe 'chef_nginx::source', 'Installs nginx from source and sets up configuration with Debian apache style with sites-enabled/sites-available'

depends 'build-essential'
depends 'ohai', '>= 4.1.0'
depends 'yum-epel'
depends 'compat_resource', '>= 12.16.3'
depends 'zypper'

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'oracle'
supports 'redhat'
supports 'scientific'
supports 'ubuntu'
supports 'suse'
supports 'opensuse'
supports 'opensuseleap'

source_url 'https://github.com/chef-cookbooks/chef_nginx'
issues_url 'https://github.com/chef-cookbooks/chef_nginx/issues'
chef_version '>= 12.1' if respond_to?(:chef_version)

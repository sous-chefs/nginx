name 'nginx'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs and configures nginx'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '8.1.3'

recipe 'nginx', 'Installs nginx package and sets up configuration with Debian apache style with sites-enabled/sites-available'
recipe 'nginx::source', 'Installs nginx from source and sets up configuration with Debian apache style with sites-enabled/sites-available'

depends 'build-essential'
depends 'ohai', '>= 4.1.0'
depends 'yum-epel'
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

source_url 'https://github.com/chef-cookbooks/nginx'
issues_url 'https://github.com/chef-cookbooks/nginx/issues'
chef_version '>= 12.14' if respond_to?(:chef_version)

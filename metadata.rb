name              'chef_nginx'
maintainer        'Chef Software, Inc.'
maintainer_email  'cookbooks@chef.io'
license           'Apache 2.0'
description       'Installs and configures nginx'
version           '2.8.0'

recipe 'nginx',         'Installs nginx package and sets up configuration with Debian apache style with sites-enabled/sites-available'
recipe 'nginx::source', 'Installs nginx from source and sets up configuration with Debian apache style with sites-enabled/sites-available'

depends 'apt'
depends 'bluepill'
depends 'build-essential'
depends 'ohai', '< 4.0'
depends 'runit', '>= 1.6.0'
depends 'yum'
depends 'yum-epel'

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'oracle'
supports 'redhat'
supports 'scientific'
supports 'ubuntu'

source_url 'https://github.com/miketheman/nginx' if respond_to?(:source_url)
issues_url 'https://github.com/miketheman/nginx/issues' if respond_to?(:issues_url)

chef_version '>= 11' if respond_to?(:chef_version)

name 'nginx'
maintainer       'Sous Chefs'
maintainer_email 'help@sous-chefs.org'

license 'Apache-2.0'
description 'Installs and configures nginx'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '9.0.0'

recipe 'nginx', 'Installs nginx package and sets up configuration with Debian apache style with sites-enabled/sites-available'
recipe 'nginx::source', 'Installs nginx from source and sets up configuration with Debian apache style with sites-enabled/sites-available'

depends 'build-essential', '>= 5.0'
depends 'ohai', '>= 4.1.0'
depends 'yum-epel'

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

source_url 'https://github.com/sous-chefs/nginx'
issues_url 'https://github.com/sous-chefs/nginx/issues'
chef_version '>= 13.3'

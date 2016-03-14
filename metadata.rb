name              'nginx'
maintainer        'Mike Fiedler'
maintainer_email  'miketheman@gmail.com'
license           'Apache 2.0'
description       'Installs and configures nginx'
version           '2.99.0'

issues_url 'https://github.com/miketheman/nginx/issues'
source_url 'https://github.com/miketheman/nginx'

depends 'apt',      '~> 2.6.1'
depends 'yum',      '~> 3.5.2'
depends 'yum-epel', '~> 0.6.3'

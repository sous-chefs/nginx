def repo_url
  case chefspec_platform
  when 'amazon', 'fedora', 'redhat'
    'https://nginx.org/packages/rhel/7/$basearch'
  when 'centos'
    'https://nginx.org/packages/centos/7/$basearch'
  when 'debian'
    'https://nginx.org/packages/debian'
  when 'opensuse'
    'https://nginx.org/packages/sles/12'
  when 'ubuntu'
    'https://nginx.org/packages/ubuntu'
  end
end

def repo_signing_key
  'https://nginx.org/keys/nginx_signing.key'
end

def platform_distribution
  case chefspec_platform
  when 'debian'
    'stretch'
  when 'ubuntu'
    'bionic'
  end
end

def nginx_user
  case chefspec_platform
  when 'debian', 'ubuntu'
    'www-data'
  else
    'nginx'
  end
end

def debian_9?
  chefspec_platform == 'debian' && chefspec_platform_version.to_i == 9
end

def ubuntu_18?
  chefspec_platform == 'ubuntu' && chefspec_platform_version.to_f == 18.04
end

def passenger_packages
  packages = %w(ruby-dev libcurl4-gnutls-dev)
  packages << if debian_9? || ubuntu_18?
                'libnginx-mod-http-passenger'
              else
                'passenger'
              end

  packages
end

def passenger_conf_file
  if debian_9? || ubuntu_18?
    '/etc/nginx/conf.d/mod-http-passenger.conf'
  else
    '/etc/nginx/conf.d/passenger.conf'
  end
end

def passenger_nginx_package
  debian_9? || ubuntu_18? ? 'nginx' : 'nginx-extras'
end

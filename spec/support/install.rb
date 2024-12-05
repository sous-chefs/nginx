def platform_repo_url
  case chefspec_platform
  when 'fedora', 'redhat'
    'https://nginx.org/packages/rhel/8/$basearch'
  when 'amazon'
    'https://nginx.org/packages/amzn/2023/$basearch'
  when 'centos-stream'
    'https://nginx.org/packages/centos/9/$basearch'
  when 'debian'
    'https://nginx.org/packages/debian'
  when 'opensuse'
    'https://nginx.org/packages/sles/15'
  when 'ubuntu'
    'https://nginx.org/packages/ubuntu'
  end
end

def repo_signing_key
  'https://nginx.org/keys/nginx_signing.key'
end

def platform_distribution_nginx
  case chefspec_platform
  when 'debian'
    'bookworm'
  when 'ubuntu'
    'noble'
  end
end

def platform_distribution_passenger
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

# def debian_9?
#   chefspec_platform == 'debian' && chefspec_platform_version.to_i == 9
# end

# def ubuntu_18?
#   chefspec_platform == 'ubuntu' && chefspec_platform_version.to_f == 18.04
# end

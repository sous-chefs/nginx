def repo_url
  case chefspec_platform
  when 'amazon', 'fedora'
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

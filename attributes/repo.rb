default['nginx']['upstream_repository'] =
  case node['platform_family']
  when 'rhel', 'fedora', 'amazon'
    case node['platform']
    when 'centos'
      # See http://wiki.nginx.org/Install
      "https://nginx.org/packages/centos/#{node['platform_version'].to_i}/$basearch/"
    when 'amazon' # Chef < 13 on Amazon
      'https://nginx.org/packages/rhel/6/$basearch/'
    else
      "https://nginx.org/packages/rhel/#{node['platform_version'].to_i}/$basearch/"
    end
  when 'debian'
    "https://nginx.org/packages/#{node['platform']}"
  when 'suse'
    'https://nginx.org/packages/sles/12'
  end

default['nginx']['repo_signing_key'] = 'https://nginx.org/keys/nginx_signing.key'

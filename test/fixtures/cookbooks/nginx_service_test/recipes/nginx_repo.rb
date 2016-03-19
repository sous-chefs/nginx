case node['platform_family']
when 'debian'
  apt_repository 'nginx.org' do
    uri          "http://nginx.org/packages/#{node['platform']}"
    distribution node['lsb']['codename']
    components   ['nginx']
    key          'http://nginx.org/keys/nginx_signing.key'
  end
when 'rhel'
  yum_repository 'nginx.org' do
    description 'nginx repo'
    baseurl "http://nginx.org/packages/#{node['platform']}/$releasever/$basearch/"
    gpgcheck false
  end
end

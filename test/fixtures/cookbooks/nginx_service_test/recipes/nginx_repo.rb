# apt_repository 'nginx' do
#   uri          'ppa:nginx/stable'
#   distribution node['lsb']['codename']
# end

case node['platform']
when 'ubuntu', 'debian'
  apt_repository 'nginx.org' do
    uri          "http://nginx.org/packages/#{node['platform']}"
    distribution node['lsb']['codename']
    components   ['nginx']
    key          'http://nginx.org/keys/nginx_signing.key'
    only_if      { node['platform_family'] == 'debian' }
  end
when 'centos'
  yum_repository 'nginx repo' do
    description 'Official Red Hat/CentOS packages'
    mirrorlist 'http://nginx.org/packages/centos/$releasever/$basearch/'
    gpgcheck false
    enabled true
    action :create
  end
end

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
  centos_version = node['platform_version'].to_i
  yum_repository 'epel' do
    description 'Extra Packages for Enterprise Linux'
    mirrorlist "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-#{centos_version}&arch=$basearch"
    gpgkey "http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-#{centos_version}"
    action :create
  end
end

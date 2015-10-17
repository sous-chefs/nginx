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
  include_recipe 'yum-epel::default'
end

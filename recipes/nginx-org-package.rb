include_recipe 'apt'

case node['platform']
when 'ubuntu'
  apt_repository 'nginx.org' do
    uri 'http://nginx.org/packages/ubuntu'
    distribution node['lsb']['codename']
    components ['nginx']
    key 'http://nginx.org/keys/nginx_signing.key'
  end

  include_recipe 'nginx'

  file '/etc/nginx/conf.d/default.conf' do
    action :delete
  end
else
  Chef::Log.error "Nginx.org package not implmented for platform: #{node['platform']}"
end

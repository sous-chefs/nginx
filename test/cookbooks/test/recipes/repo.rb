apt_update 'update' if platform_family?('debian')

nginx_install 'nginx' do
  source 'repo'
end

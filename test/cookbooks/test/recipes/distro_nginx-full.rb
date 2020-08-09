apt_update 'update' if platform_family?('debian')

nginx_install 'distro' do
  override_package_name 'nginx-full'
end

apt_update 'update'

nginx_install 'distro' do
  override_package_name 'nginx-full'
end

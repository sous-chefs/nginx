apt_update 'update'

nginx_install 'distro' do
  packages 'nginx-full'
end

include_recipe 'test::test_site'

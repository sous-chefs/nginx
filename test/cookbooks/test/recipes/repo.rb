apt_update 'update'

nginx_install 'nginx' do
  source 'repo'
end

include_recipe 'test::test_site'

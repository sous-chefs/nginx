nginx_install 'nginx' do
  source 'epel'
end

include_recipe 'test::test_site'

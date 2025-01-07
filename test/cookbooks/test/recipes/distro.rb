apt_update 'update'

nginx_install 'distro'

include_recipe 'test::test_site'

apt_update 'update' if platform_family?('debian')

nginx_install 'distro'

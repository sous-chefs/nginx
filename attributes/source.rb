include_attribute 'nginx::default'

default['nginx']['init_style'] = if node['platform'] == 'ubuntu' && node['platform_version'].to_f <= 14.04
                                   # init_package identifies 12.04/14.04 as init, but we should be using upstart here
                                   'upstart'
                                 else
                                   node['init_package']
                                 end

default['nginx']['source']['version']                 = node['nginx']['version']
default['nginx']['source']['prefix']                  = "/opt/nginx-#{node['nginx']['source']['version']}"
default['nginx']['source']['conf_path']               = "#{node['nginx']['dir']}/nginx.conf"
default['nginx']['source']['sbin_path']               = "#{node['nginx']['source']['prefix']}/sbin/nginx"

# Wno-error can be removed when nginx compiles on GCC7: https://trac.nginx.org/nginx/ticket/1259
default['nginx']['source']['default_configure_flags'] = %W(
  --prefix=#{node['nginx']['source']['prefix']}
  --conf-path=#{node['nginx']['dir']}/nginx.conf
  --sbin-path=#{node['nginx']['source']['sbin_path']}
  --with-cc-opt=-Wno-error
)

default['nginx']['configure_flags']    = []
default['nginx']['source']['version']  = node['nginx']['version']
default['nginx']['source']['url']      = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"
default['nginx']['source']['checksum'] = '8793bf426485a30f91021b6b945a9fd8a84d87d17b566562c3797aba8fac76fb'
default['nginx']['source']['use_existing_user'] = false

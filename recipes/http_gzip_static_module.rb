template "#{node['nginx']['dir']}/conf.d/http_gzip_static.conf" do
  source 'modules/http_gzip_static.conf.erb'
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ['--with-http_gzip_static_module']

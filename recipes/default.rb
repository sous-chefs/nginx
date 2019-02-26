nginx_cleanup_runit 'cleanup' if node['nginx']['cleanup_runit']

include_recipe "nginx::#{node['nginx']['install_method']}"

node['nginx']['default']['modules'].each do |ngx_module|
  include_recipe "nginx::#{ngx_module}"
end

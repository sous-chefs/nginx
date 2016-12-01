#
# Cookbook:: nginx
# Recipes:: set_misc
#

set_misc_src_filename = ::File.basename(node['nginx']['set_misc']['url'])
set_misc_src_filepath = "#{Chef::Config['file_cache_path']}/#{set_misc_src_filename}"
set_misc_extract_path = "#{Chef::Config['file_cache_path']}/nginx-set_misc-#{node['nginx']['set_misc']['version']}"

remote_file set_misc_src_filepath do
  source   node['nginx']['set_misc']['url']
  checksum node['nginx']['set_misc']['checksum']
end

bash 'extract_set_misc_module' do
  cwd  ::File.dirname(set_misc_src_filepath)
  code <<-EOH
    mkdir -p #{set_misc_extract_path}
    tar xzf #{set_misc_src_filename} -C #{set_misc_extract_path}
  EOH
  not_if { ::File.exist?(set_misc_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{set_misc_extract_path}/set-misc-nginx-module-#{node['nginx']['set_misc']['version']}"]

include_recipe 'chef_nginx::ngx_devel_module'

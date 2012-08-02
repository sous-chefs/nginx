echo_module_filename       = "echo-nginx-module-v#{node['nginx']['echo']['version']}.tar.gz"
echo_module_filepath       = "#{Chef::Config['file_cache_path']}/#{echo_module_filename}"
echo_module_extracted_path = "#{Chef::Config['file_cache_path']}/#{node['nginx']['echo']['extract_folder']}"

remote_file echo_module_filepath do
  source node['nginx']['echo']['url']
  checksum node['nginx']['echo']['checksum']
  owner "root"
  group "root"
  mode 0644
end

execute 'extract echo_module' do
  cwd     ::File.dirname(echo_module_filepath)
  command "tar xzvf #{echo_module_filename}"
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{echo_module_extracted_path}"]

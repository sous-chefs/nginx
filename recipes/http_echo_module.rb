echo_src_filename = "echo-nginx-module-v#{node['nginx']['echo']['version']}.tar.gz"
echo_src_filepath = "#{Chef::Config['file_cache_path']}/#{echo_src_filename}"
echo_extract_path = "#{Chef::Config['file_cache_path']}/nginx_echo_module/#{node['nginx']['echo']['checksum']}"

remote_file echo_src_filepath do
  source   node['nginx']['echo']['url']
  checksum node['nginx']['echo']['checksum']
end

bash 'extract_http_echo_module' do
  cwd ::File.dirname(echo_src_filepath)
  code <<-EOH
    mkdir -p #{echo_extract_path}
    tar xzf #{echo_src_filename} -C #{echo_extract_path}
    mv #{echo_extract_path}/*/* #{echo_extract_path}/
  EOH

  not_if { ::File.exist?(echo_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{echo_extract_path}"]

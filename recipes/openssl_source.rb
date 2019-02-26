src_filename = ::File.basename(node['nginx']['openssl_source']['url'])
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"
extract_path = "#{Chef::Config['file_cache_path']}/openssl-#{node['nginx']['openssl_source']['version']}"

remote_file src_filepath do
  source node['nginx']['openssl_source']['url']
  not_if { ::File.exist?(src_filepath) }
end

bash 'extract_openssl' do
  cwd  ::File.dirname(src_filepath)
  code <<-EOH
    mkdir -p #{extract_path}
    tar xzf #{src_filename} -C #{extract_path}
    mv #{extract_path}/*/* #{extract_path}/
  EOH
  not_if { ::File.exist?(extract_path) }
end

node.run_state['nginx_configure_flags'] = node.run_state['nginx_configure_flags'] | ["--with-openssl=#{extract_path}"]

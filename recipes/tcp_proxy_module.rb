
tcp_src_filename = ::File.basename(node['nginx']['tcp_proxy_module']['url'])
tcp_src_filepath = "#{Chef::Config['file_cache_path']}/#{tcp_src_filename}"
tcp_extract_path = "#{Chef::Config['file_cache_path']}/tcp_proxy_module"
nginx_src_filepath = "#{Chef::Config['file_cache_path']}/nginx-#{node['nginx']['source']['version']}"
remote_file tcp_src_filepath do
  source   node['nginx']['tcp_proxy_module']['url']
  owner    'root'
  group    node['root_group']
  mode     '0644'
end

bash 'extract_tcp_proxy_module' do
  cwd  ::File.dirname(tcp_src_filepath)
  code <<-EOH
    mkdir -p #{tcp_extract_path}
    unzip #{tcp_src_filename} -d #{tcp_extract_path}
    mv #{tcp_extract_path}/*/* #{tcp_extract_path}
    cd #{nginx_src_filepath}
    patch -p1 < #{tcp_extract_path}/tcp.patch
  EOH
  not_if { ::File.exists?(tcp_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{tcp_extract_path}"]

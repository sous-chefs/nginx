luajit_src_filename = ::File.basename(node['nginx']['luajit']['url'])
luajit_src_filepath = "#{Chef::Config['file_cache_path']}/#{luajit_src_filename}"
luajit_extract_path = "#{Chef::Config['file_cache_path']}/luajit-#{node['nginx']['luajit']['version']}"

remote_file luajit_src_filepath do
  source   node['nginx']['luajit']['url']
  checksum node['nginx']['luajit']['checksum']
end

bash 'extract_luajit' do
  cwd  ::File.dirname(luajit_src_filepath)
  code <<-EOH
    mkdir -p #{luajit_extract_path}
    tar xzf #{luajit_src_filename} -C #{luajit_extract_path}
    cd luajit-#{node['nginx']['luajit']['version']}/LuaJIT-#{node['nginx']['luajit']['version']}
    make && make install
  EOH
  not_if { ::File.exist?(luajit_extract_path) }
end

node.run_state['nginx_source_env'].merge!(
  'LUAJIT_INC' => '/usr/local/include/luajit-2.0',
  'LUAJIT_LIB' => '/usr/local/lib'
)

node.run_state['nginx_configure_flags'] = node.run_state['nginx_configure_flags'] | ['--with-ld-opt=-Wl,-rpath,/usr/local/lib']

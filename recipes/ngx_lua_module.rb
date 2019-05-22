lua_src_filename = ::File.basename(node['nginx']['lua']['url'])
lua_src_filepath = "#{Chef::Config['file_cache_path']}/#{lua_src_filename}"
lua_extract_path = "#{Chef::Config['file_cache_path']}/nginx-lua-#{node['nginx']['lua']['version']}"

remote_file lua_src_filepath do
  source   node['nginx']['lua']['url']
  checksum node['nginx']['lua']['checksum']
end

bash 'extract_lua_module' do
  cwd  ::File.dirname(lua_src_filepath)
  code <<-EOH
    mkdir -p #{lua_extract_path}
    tar xzf #{lua_src_filename} -C #{lua_extract_path}
  EOH
  not_if { ::File.exist?(lua_extract_path) }
end

node.run_state['nginx_configure_flags'] = node.run_state['nginx_configure_flags'] | ["--add-module=#{lua_extract_path}/lua-nginx-module-#{node['nginx']['lua']['version']}"]

include_recipe 'nginx::lua'

ajp_src_filename = ::File.basename(node['nginx']['ajp_module']['url'])
ajp_src_filepath = "#{Chef::Config['file_cache_path']}/#{ajp_src_filename}"
ajp_extract_path = "#{Chef::Config['file_cache_path']}/ajp_module"

remote_file ajp_src_filepath do
  source   node['nginx']['ajp_module']['url']
  owner    'root'
  group    node['root_group']
  mode     '0644'
end

bash 'extract_ajp_module' do
  cwd  ::File.dirname(ajp_src_filepath)
  code <<-EOH
    mkdir -p #{ajp_extract_path}
    unzip #{ajp_src_filename} -d #{ajp_extract_path}
    mv #{ajp_extract_path}/*/* #{ajp_extract_path}
  EOH
  not_if { ::File.exists?(ajp_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{ajp_extract_path}"]

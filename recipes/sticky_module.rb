sticky_src_filename = ::File.basename(node['nginx']['sticky_module']['url'])
sticky_src_filepath = "#{Chef::Config['file_cache_path']}/#{sticky_src_filename}"
sticky_extract_path = "#{Chef::Config['file_cache_path']}/sticky_module"

remote_file sticky_src_filepath do
  source   node['nginx']['sticky_module']['url']
  owner    'root'
  group    node['root_group']
  mode     '0644'
end

bash 'extract_sticky_module' do
  cwd  ::File.dirname(sticky_src_filepath)
  code <<-EOH
    mkdir -p #{sticky_extract_path}
    unzip #{sticky_src_filename} -d #{sticky_extract_path}
    mv #{sticky_extract_path}/*/* #{sticky_extract_path}
  EOH
  not_if { ::File.exists?(sticky_extract_path) }
end

node.run_state['nginx_configure_flags'] =
node.run_state['nginx_configure_flags'] | ["--add-module=#{sticky_extract_path}"]
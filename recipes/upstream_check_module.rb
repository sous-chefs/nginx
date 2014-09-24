upch_src_filename = ::File.basename(node['nginx']['upstream_check_module']['url'])
upch_src_filepath = "#{Chef::Config['file_cache_path']}/#{upch_src_filename}"
upch_extract_path = "#{Chef::Config['file_cache_path']}/upch_module"

remote_file upch_src_filepath do
  source   node['nginx']['upstream_check_module']['url']
  owner    'root'
  group    node['root_group']
  mode     '0644'
end

bash 'extract_upch_module' do
  cwd  ::File.dirname(upch_src_filepath)
  code <<-EOH
    mkdir -p #{upch_extract_path}
    unzip #{upch_src_filename} -d #{upch_extract_path}
    mv #{upch_extract_path}/*/* #{upch_extract_path}
  EOH
  not_if { ::File.exists?(upch_extract_path) }
end

node.run_state['nginx_configure_flags'] =
node.run_state['nginx_configure_flags'] | ["--add-module=#{upch_extract_path}"]
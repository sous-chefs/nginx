jvm_src_filename = ::File.basename(node['nginx']['jvm_module']['url'])
jvm_src_filepath = "#{Chef::Config['file_cache_path']}/#{jvm_src_filename}"
jvm_extract_path = "#{Chef::Config['file_cache_path']}/jvm_module"
nginx_src_filepath = "#{Chef::Config['file_cache_path']}/nginx-#{node['nginx']['source']['version']}"

remote_file jvm_src_filepath do
  source   node['nginx']['jvm_module']['url']
  owner    'root'
  group    node['root_group']
  mode     '0644'
end

bash 'extract_jvm_module' do
  cwd  ::File.dirname(jvm_src_filepath)
  code <<-EOH
    mkdir -p #{jvm_extract_path}
    unzip #{jvm_src_filename} -d #{jvm_extract_path}
    mv #{jvm_extract_path}/*/* #{jvm_extract_path}
    cd #{nginx_src_filepath}
  EOH
  not_if { ::File.exists?(jvm_extract_path) }
end

node.run_state['nginx_configure_flags'] =
node.run_state['nginx_configure_flags'] | ["--add-module=#{jvm_extract_path}"]

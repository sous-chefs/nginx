ajp_version = node['nginx']['ajp_module']['version']
ajp_url = node['nginx']['ajp_module']['url'].gsub('{version}', ajp_version)
ajp_src_name = "ajp_module_#{ajp_version}"
ajp_archive = "#{ajp_src_name}#{::File.extname(ajp_url)}"
ajp_archive_path = ::File.join(Chef::Config['file_cache_path'], ajp_archive)
ajp_src_path = ::File.join(Chef::Config['file_cache_path'], ajp_src_name)

module_downloader = remote_file ajp_archive_path do
  source ajp_url
  owner 'root'
  group node['root_group']
  mode '0644'
end

bash 'extract_ajp_module' do
  cwd  ::File.dirname(ajp_archive_path)
  code <<-EOH
    mkdir -p #{ajp_src_path}
    unzip #{ajp_archive_path} -d #{ajp_src_path}
    mv #{ajp_src_path}/*/* #{ajp_src_path}
  EOH
  subscribes :run, module_downloader, :immediately
  only_if "test -f #{ajp_archive_path}"
  not_if "test -d #{ajp_src_path}"
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{ajp_src_path}"]
node.run_state['ajp_module_path'] = ajp_src_path

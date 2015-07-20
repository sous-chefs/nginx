ajp_version = node['nginx']['ajp_module']['version']
ajp_url = node['nginx']['ajp_module']['url'].gsub('{version}', ajp_version)
ajp_src_name = "ajp_module_#{ajp_version}"
ajp_archive = "#{ajp_src_name}#{::File.extname(ajp_url)}"
ajp_archive_path = ::File.join(Chef::Config['file_cache_path'], ajp_archive)
ajp_src_path = ::File.join(Chef::Config['file_cache_path'], ajp_src_name)
ajp_patch_path = ::File.join(ajp_src_path, 'ajp.patch')

nginx_src_path = ::File.join(Chef::Config['file_cache_path'], "/nginx-#{node['nginx']['source']['version']}")

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

execute 'apply_ajp_patch' do
  cwd  nginx_src_path
  command "patch -p1 < #{ajp_patch_path}"
  subscribes :run, 'bash[extract_ajp_module]', :immediately
  not_if "patch -p1 --dry-run --reverse --silent < #{ajp_patch_path}"
  only_if "test -f #{ajp_patch_path}"
end

if node.run_state['upstream_check_module_path'] && node['nginx']['ajp_module']['patch_jvm_route']
  patch_file_path = ::File.join(node.run_state['upstream_check_module_path'], 'ngx_http_upstream_jvm_route_module.patch')
  execute 'apply_jvm_route_upstream_check_patch' do
    cwd ajp_src_path
    command "patch -p1 #{patch_file_path}"
    not_if "patch -p1 --dry-run --reverse --silent #{patch_file_path}"
    only_if "test -f #{patch_file_path}"
  end
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{ajp_src_path}"]
node.run_state['ajp_module_path'] = ajp_src_path

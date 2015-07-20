jvm_route_archive_filename = 'nginx_jvm_route_module_' + ::File.basename(node['nginx']['jvm_route_module']['url'])
jvm_route_archive_path = ::File.join(Chef::Config['file_cache_path'], jvm_route_archive_filename)
jvm_route_src_path = ::File.join(Chef::Config['file_cache_path'], 'jvm_route_module')
jvm_route_patch_path = ::File.join(jvm_route_src_path, 'jvm_route.patch')
nginx_src_path = ::File.join(Chef::Config['file_cache_path'], "/nginx-#{node['nginx']['source']['version']}")

jvm_route_loader = remote_file jvm_route_archive_path do
  source node['nginx']['jvm_route_module']['url']
  owner 'root'
  group node['root_group']
  mode '0644'
end

bash 'extract_jvm_route_module' do
  cwd ::File.dirname(jvm_route_archive_path)
  code <<-EOH
    mkdir -p #{jvm_route_src_path}
    unzip #{jvm_route_archive_filename} -d #{jvm_route_src_path}
    mv #{jvm_route_src_path}/*/* #{jvm_route_src_path}
  EOH
  subscribes :run, jvm_route_loader
  only_if "test -f #{jvm_route_archive_path}"
  not_if "test -d #{jvm_route_src_path}"
end

execute 'apply_jvm_route_patch' do
  cwd  nginx_src_path
  command "patch -p0 < #{jvm_route_patch_path}"
  subscribes :run, 'bash[extract_jvm_route_module]'
  not_if "patch -p0 --dry-run --reverse --silent < #{jvm_route_patch_path}"
  only_if "test -f #{jvm_route_patch_path}"
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{jvm_route_src_path}"]

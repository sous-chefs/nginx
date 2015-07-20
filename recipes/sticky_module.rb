sticky_module_version = node['nginx']['sticky_module']['version']
sticky_module_url = node['nginx']['sticky_module']['url'].gsub('{version}', sticky_module_version)
sticky_module_src_name = "sticky_module_#{sticky_module_version}"
sticky_module_archive = "#{sticky_module_src_name}#{::File.extname(sticky_module_url)}"
sticky_module_archive_path = ::File.join(Chef::Config['file_cache_path'], sticky_module_archive)
sticky_module_src_path = ::File.join(Chef::Config['file_cache_path'], sticky_module_src_name)

module_downloader = remote_file sticky_module_archive_path do
  source sticky_module_url
  owner 'root'
  group node['root_group']
  mode '0644'
end

bash 'extract_sticky_module' do
  cwd  ::File.dirname(sticky_module_archive_path)
  code <<-EOH
    mkdir -p #{sticky_module_src_path}
    unzip #{sticky_module_archive_path} -d #{sticky_module_src_path}
    mv #{sticky_module_src_path}/*/* #{sticky_module_src_path}
  EOH
  subscribes :run, module_downloader, :immediately
  only_if "test -f #{sticky_module_archive_path}"
  not_if "test -d #{sticky_module_src_path}"
end

if node.run_state['upstream_check_module_path'] && node['nginx']['sticky_module']['use_upstream_check_patch']
  patch_file_path = ::File.join(node.run_state['upstream_check_module_path'], 'nginx-sticky-module.patch')
  execute 'apply_sticky_upstream_check_patch' do
    cwd  sticky_module_src_path
    command "patch -p0 < #{patch_file_path}"
    subscribes :run, 'bash[extract_sticky_module]', :immediately
    not_if "patch -p0 --dry-run --reverse --silent < #{patch_file_path}"
    only_if "test -f #{patch_file_path} && test -d #{sticky_module_src_path}"
  end
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{sticky_module_src_path}"]
node.run_state['sticky_module_path'] = sticky_module_src_path

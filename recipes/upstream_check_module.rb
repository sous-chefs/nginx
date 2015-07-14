upstream_check_version = node['nginx']['upstream_check_module']['version']
upstream_check_url = node['nginx']['upstream_check_module']['url'].gsub('{version}', upstream_check_version)
upstream_check_src_name = "upstream_check_module_#{upstream_check_version}"
upstream_check_archive = "#{upstream_check_src_name}#{::File.extname(upstream_check_url)}"
upstream_check_archive_path = ::File.join(Chef::Config['file_cache_path'], upstream_check_archive)
upstream_check_src_path = ::File.join(Chef::Config['file_cache_path'], upstream_check_src_name)

module_downloader = remote_file upstream_check_archive_path do
  source upstream_check_url
  owner 'root'
  group node['root_group']
  mode '0644'
end

bash 'extract_upstream_check_module' do
  cwd  ::File.dirname(upstream_check_archive_path)
  code <<-EOH
    mkdir -p #{upstream_check_src_path}
    unzip #{upstream_check_archive_path} -d #{upstream_check_src_path}
    mv #{upstream_check_src_path}/*/* #{upstream_check_src_path}
  EOH
  subscribes :run, module_downloader
  only_if "test -f #{upstream_check_archive_path}"
  not_if "test -d #{upstream_check_src_path}"
end

nginx_version = Gem::Version.new(node['nginx']['source']['version'])
patch_version = node['nginx']['upstream_check_module']['patches'].keys.select { |v| nginx_version >= v }.max

if patch_version
  nginx_src_path = "#{Chef::Config['file_cache_path']}/nginx-#{nginx_version}"
  upstream_check_patch = ::File.join(upstream_check_src_path, node['nginx']['upstream_check_module']['patches'][patch_version])

  execute 'apply_upstream_check_module_patch' do
    cwd  nginx_src_path
    command "patch -p1 < #{upstream_check_patch}"
    subscribes :run, 'bash[extract_upstream_check_module]'
    not_if "patch -p1 --dry-run --reverse --silent < #{upstream_check_patch}"
    only_if "test -f #{upstream_check_patch}"
  end
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{upstream_check_src_path}"]
node.run_state['upstream_check_module_path'] = upstream_check_src_path

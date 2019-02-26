upm_src_filename = ::File.basename(node['nginx']['upload_progress']['url'])
upm_src_filepath = "#{Chef::Config['file_cache_path']}/#{upm_src_filename}"
upm_extract_path = "#{Chef::Config['file_cache_path']}/nginx_upload_progress/#{node['nginx']['upload_progress']['checksum']}"

remote_file upm_src_filepath do
  source   node['nginx']['upload_progress']['url']
  checksum node['nginx']['upload_progress']['checksum']
end

template "#{node['nginx']['dir']}/conf.d/upload_progress.conf" do
  source 'modules/upload_progress.erb'
  notifies :reload, 'service[nginx]', :delayed
end

bash 'extract_upload_progress_module' do
  cwd  ::File.dirname(upm_src_filepath)
  code <<-EOH
    mkdir -p #{upm_extract_path}
    tar xzf #{upm_src_filename} -C #{upm_extract_path}
    mv #{upm_extract_path}/*/* #{upm_extract_path}/
  EOH
  not_if { ::File.exist?(upm_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{upm_extract_path}"]

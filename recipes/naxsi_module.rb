cookbook_file "#{node['nginx']['dir']}/naxsi_core.rules" do
  source 'naxsi_core.rules'
  notifies :reload, 'service[nginx]', :delayed
end

naxsi_src_filename = ::File.basename(node['nginx']['naxsi']['url'])
naxsi_src_filepath = "#{Chef::Config['file_cache_path']}/#{naxsi_src_filename}"
naxsi_extract_path = "#{Chef::Config['file_cache_path']}/nginx-naxsi-#{node['nginx']['naxsi']['version']}"

remote_file naxsi_src_filepath do
  source   node['nginx']['naxsi']['url']
  checksum node['nginx']['naxsi']['checksum']
end

bash 'extract_naxsi_module' do
  cwd  ::File.dirname(naxsi_src_filepath)
  code <<-EOH
    mkdir -p #{naxsi_extract_path}
    tar xzf #{naxsi_src_filename} -C #{naxsi_extract_path}
  EOH
  not_if { ::File.exist?(naxsi_extract_path) }
end

node.run_state['nginx_configure_flags'] = node.run_state['nginx_configure_flags'] | ["--add-module=#{naxsi_extract_path}/naxsi-#{node['nginx']['naxsi']['version']}/naxsi_src"]

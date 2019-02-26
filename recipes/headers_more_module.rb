tar_location = "#{Chef::Config['file_cache_path']}/headers_more.tar.gz"
module_location = "#{Chef::Config['file_cache_path']}/headers_more/#{node['nginx']['headers_more']['source_checksum']}"

remote_file tar_location do
  source   node['nginx']['headers_more']['source_url']
  checksum node['nginx']['headers_more']['source_checksum']
end

directory module_location do
  mode      '0755'
  recursive true
  action    :create
end

bash 'extract_headers_more' do
  cwd  ::File.dirname(tar_location)
  user 'root'
  code <<-EOH
    tar -zxf #{tar_location} -C #{module_location}
  EOH
  not_if { ::File.exist?("#{module_location}/headers-more-nginx-module-#{node['nginx']['headers_more']['version']}/config") }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{module_location}/headers-more-nginx-module-#{node['nginx']['headers_more']['version']}/"]

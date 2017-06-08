#
# Cookbook:: nginx
# Recipe:: pagespeed_module
#

src_filename = ::File.basename(node['nginx']['pagespeed']['url'])
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"
extract_path = "#{Chef::Config['file_cache_path']}/nginx_pagespeed-#{node['nginx']['pagespeed']['version']}"

remote_file src_filepath do
  source   node['nginx']['pagespeed']['url']
  not_if { ::File.exist?(src_filepath) }
end

psol_src_filename = "psol-#{::File.basename(node['nginx']['psol']['url'])}"
psol_src_filepath = "#{Chef::Config['file_cache_path']}/#{psol_src_filename}"
psol_extract_path = "#{Chef::Config['file_cache_path']}/nginx_pagespeed-#{node['nginx']['pagespeed']['version']}/psol"

remote_file psol_src_filepath do
  source   node['nginx']['psol']['url']
  not_if { ::File.exist?(psol_src_filepath) }
end

package_array = value_for_platform_family(
  %w(rhel amazon) => node['nginx']['pagespeed']['packages']['rhel'],
  %w(debian) => node['nginx']['pagespeed']['packages']['debian']
)

package package_array unless package_array.empty?

bash 'extract_pagespeed' do
  cwd  ::File.dirname(src_filepath)
  code <<-EOH
    mkdir -p #{extract_path}
    tar xzf #{src_filename} -C #{extract_path}
    mv #{extract_path}/*/* #{extract_path}/
  EOH
  not_if { ::File.exist?(extract_path) }
end

bash 'extract_psol' do
  cwd  ::File.dirname(psol_src_filepath)
  code <<-EOH
    mkdir -p #{psol_extract_path}
    tar xzf #{psol_src_filename} -C #{psol_extract_path}
    mv #{psol_extract_path}/*/* #{psol_extract_path}/
  EOH
  not_if { ::File.exist?(psol_extract_path) }
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{extract_path}"]

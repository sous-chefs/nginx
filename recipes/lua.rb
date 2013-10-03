luajit_src_filename = ::File.basename(node['nginx']['luajit']['url'])
luajit_src_filepath = "#{Chef::Config['file_cache_path']}/#{luajit_src_filename}"
luajit_extract_path = "#{Chef::Config['file_cache_path']}/luajit-#{node['nginx']['luajit']['version']}"

remote_file luajit_src_filepath do
  source node['nginx']['luajit']['url']
  checksum node['nginx']['luajit']['checksum']
  owner "root"
  group "root"
  mode 00644
end

bash 'extract_luajit' do
  cwd ::File.dirname(luajit_src_filepath)
  code <<-EOH
    mkdir -p #{luajit_extract_path}
    tar xzf #{luajit_src_filename} -C #{luajit_extract_path}
    cd luajit-#{node['nginx']['luajit']['version']}/LuaJIT-#{node['nginx']['luajit']['version']}
    make && make install
    EXPORT LUAJIT_INC="/usr/local/include/luajit-2.0"
    EXPORT LUAJIT_LIB="usr/local/lib"
  EOH
  not_if { ::File.exists?(luajit_extract_path) }
end

package "lua-devel" do
  action :install
end
nginx_version_obj = Gem::Version.new(node['nginx']['version'])
src_filepath = "#{Chef::Config['file_cache_path']}" \
               "/nginx-#{node['nginx']['source']['version']}"
module_extract_path = "#{Chef::Config['file_cache_path']}" \
                      '/nginx_upstream_check_module'

package 'zip'

ark 'nginx_upstream_check_module' do
  url 'https://github.com/yaoweibin/nginx_upstream_check_module/archive/' \
      "#{node['nginx']['upstream_check_module']['git_revision']}.zip"
  path Chef::Config['file_cache_path']
  action :put
end

if nginx_version_obj >= Gem::Version.new('1.2.1')
  patch_version =
    if %w(1.2.1 1.3.0).include? node['nginx']['version']
      '1.2.1'
    elsif (nginx_version_obj >= Gem::Version.new('1.2.2') &&
           nginx_version_obj < Gem::Version.new('1.2.6')) ||
          (nginx_version_obj >= Gem::Version.new('1.3.1') &&
           nginx_version_obj < Gem::Version.new('1.3.9'))
      '1.2.2+'
    elsif (nginx_version_obj >= Gem::Version.new('1.2.6') &&
           nginx_version_obj < Gem::Version.new('1.3.0')) ||
          (nginx_version_obj >= Gem::Version.new('1.3.9') &&
           nginx_version_obj < Gem::Version.new('1.5.12'))
      '1.2.6+'
    elsif nginx_version_obj >= Gem::Version.new('1.5.12') &&
          nginx_version_obj < Gem::Version.new('1.7.2')
      '1.5.12+'
    else
      '1.7.2+'
    end

  execute 'apply_nginx_upstream_check_patch' do
    cwd src_filepath
    command "patch -p1 < #{module_extract_path}/check_#{patch_version}.patch"
    not_if 'patch -p1 --dry-run --reverse --silent < ' \
           "#{module_extract_path}/check_#{patch_version}.patch", :cwd => src_filepath
  end
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{module_extract_path}"]

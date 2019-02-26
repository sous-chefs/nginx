nginx_src = "#{Chef::Config['file_cache_path']}/nginx-#{node['nginx']['source']['version']}"
nginx_syslog_src = "#{Chef::Config['file_cache_path']}/nginx_syslog_module"

major, minor, patch = node['nginx']['source']['version'].split('.').map { |s| Integer(s) }
raise 'Unsupported nginx version' if major != 1
case minor
when 2
  syslog_patch = case patch
                 when 0..6
                   'syslog_1.2.0.patch'
                 else
                   'syslog_1.2.7.patch'
                 end
when 3
  syslog_patch = case patch
                 when 0..9
                   'syslog_1.2.0.patch'
                 when 10..13
                   'syslog_1.3.11.patch'
                 else
                   'syslog_1.3.14.patch'
                 end
when 4
  syslog_patch = 'syslog_1.4.0.patch'
when 5..6
  syslog_patch = 'syslog_1.5.6.patch'
when 7
  syslog_patch = 'syslog_1.7.0.patch'
else
  raise 'Unsupported nginx version'
end

git nginx_syslog_src do
  repository node['nginx']['syslog']['git_repo']
  revision node['nginx']['syslog']['git_revision']
  action :sync
end

execute 'apply_nginx_syslog_patch' do
  cwd  nginx_src
  command "patch -p1 < #{nginx_syslog_src}/#{syslog_patch}"
  not_if "patch -p1 --dry-run --reverse --silent < #{nginx_syslog_src}/#{syslog_patch}", cwd: nginx_src
end

node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{nginx_syslog_src}"]

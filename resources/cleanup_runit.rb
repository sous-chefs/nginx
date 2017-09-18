resource_name :nginx_cleanup_runit

action :cleanup do
  # remove old init script link
  file 'remove symlinked runit init script' do
    path '/etc/init.d/nginx'
    manage_symlink_source false # nuke the link not the runit binary
    action :delete
    only_if { ::File.exist?('/etc/init.d/nginx') && ::File.symlink?('/etc/init.d/nginx') && ::File.realpath('/etc/init.d/nginx') == '/usr/bin/sv' }
  end

  execute 'kill old nginx process' do
    command 'pkill nginx'
    returns [0, 1] # ignores failures
    not_if { !::File.exist?('/etc/sv/nginx/supervise/pid') || ::File.zero?('/etc/sv/nginx/supervise/pid') }
  end

  # remove the old service configs
  directory '/etc/sv/nginx' do
    recursive true
    action :delete
  end
end

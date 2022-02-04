apt_update 'update' if platform_family?('debian')

ver = case node['platform']
      when 'debian'
        '1.21.6-1~bullseye'
      when 'ubuntu'
        '1.21.6-1~focal'
      else
        '1.21.6'
      end

nginx_install 'nginx' do
  source 'repo'
  repo_train 'mainline'
  packages_versions ver
end

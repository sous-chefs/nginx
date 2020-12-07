apt_update 'update' if platform_family?('debian')

ver = case node['platform']
      when 'debian'
        '1.19.4-1~buster'
      when 'ubuntu'
        '1.19.4-1~focal'
      else
        '1.19.4'
      end

nginx_install 'nginx' do
  source 'repo'
  repo_train 'mainline'
  packages_versions ver
end

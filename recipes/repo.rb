case node['platform_family']
when 'rhel', 'amazon'

  yum_repository 'nginx' do
    description  'Nginx.org Repository'
    baseurl      node['nginx']['upstream_repository']
    gpgkey       node['nginx']['repo_signing_key']
    action       :create
  end

when 'suse'

  zypper_repo 'nginx' do
    repo_name 'Nginx.org Repository'
    uri node['nginx']['upstream_repository']
    key node['nginx']['repo_signing_key']
  end

when 'debian'

  apt_package 'apt-transport-https'

  apt_repository 'nginx' do
    uri          node['nginx']['upstream_repository']
    distribution node['lsb']['codename']
    components   %w(nginx)
    deb_src      true
    key          node['nginx']['repo_signing_key']
  end

else
  log "nginx.org does not maintain packages for platform #{node['platform']}. Cannot setup the upstream repo!" do
    level :warn
  end
end

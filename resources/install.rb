property :ohai_plugin_enabled, [true, false],
         description: 'Whether or not ohai_plugin is enabled.',
         equal_to: [true, false],
         default: true

property :source, String,
         description: 'Source for installation.',
         equal_to: %w(distro repo),
         name_property: true

action :install do
  if ohai_plugin_enabled?
    ohai 'reload_nginx' do
      plugin 'nginx'
      action :nothing
    end

    ohai_plugin 'nginx' do
      cookbook    'nginx'
      source_file 'plugins/ohai-nginx.rb.erb'
      resource    :template
      variables(
        binary: nginx_binary
      )
    end
  end

  case new_resource.source
  when 'distro'
    log 'Using distro provided packages.'
  when 'repo'
    case node['platform_family']
    when 'amazon', 'fedora', 'rhel'
      yum_repository 'nginx' do
        description  'Nginx.org Repository'
        baseurl      repo_url
        gpgkey       repo_signing_key
      end
    when 'debian'
      apt_repository 'nginx' do
        uri          repo_url
        distribution node['lsb']['codename']
        components   %w(nginx)
        deb_src      true
        key          repo_signing_key
      end
    when 'suse'
      zypper_repository 'nginx' do
        description 'Nginx.org Repository'
        baseurl     repo_url
        gpgkey      repo_signing_key
      end
    else
      log "nginx.org does not maintain packages for platform #{node['platform']}. Cannot setup the repo!" do
        level :warn
      end
    end

    package_install_opts = '--disablerepo=* --enablerepo=nginx' if platform_family?('amazon', 'rhel')
  end

  package 'nginx' do
    options package_install_opts
    notifies :reload, 'ohai[reload_nginx]', :immediately if ohai_plugin_enabled?
  end

  service 'nginx' do
    supports status: true, restart: true, reload: true
    action   [:start, :enable]
  end
end

action_class do
  def ohai_plugin_enabled?
    new_resource.ohai_plugin_enabled
  end
end

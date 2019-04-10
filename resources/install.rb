property :ohai_plugin_enabled, [true, false],
         description: 'Whether or not ohai_plugin is enabled.',
         equal_to: [true, false],
         default: true

property :source, String,
         description: 'Source for installation.',
         equal_to: %w(distro repo epel),
         name_property: true

property :default_site_enabled, [true, false],
         description: 'Whether or not the default site is enabled.',
         equal_to: [true, false],
         default: true

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
  when 'epel'
    case node['platform_family']
    when 'amazon'
      execute 'amazon-linux-extras install epel'
    when 'rhel'
      package 'epel-release'
    else
      log 'nginx_install `source` property set to epel, but not running on a RHEL platform so skipping epel setup' do
        level :warn
      end
    end
  end

  package 'nginx' do
    options package_install_opts
    notifies :reload, 'ohai[reload_nginx]', :immediately if ohai_plugin_enabled?
  end

  directory nginx_dir do
    mode      '0755'
    recursive true
  end

  directory nginx_log_dir do
    mode      '0750'
    owner     nginx_user
    recursive true
  end

  directory ::File.dirname(nginx_pid_file) do
    mode      '0755'
    recursive true
  end

  %w(
    sites-available
    sites-enabled
    conf.d
    streams-available
    streams-enabled
  ).each do |leaf|
    directory ::File.join(nginx_dir, leaf) do
      mode '0755'
    end
  end

  if default_site_enabled? && platform_family?('amazon', 'fedora', 'rhel')
    %w(
      default.conf
      example_ssl.conf
    ).each do |config|
      file ::File.join(nginx_dir, "conf.d/#{config}") do
        action :delete
      end
    end
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

  def default_site_enabled?
    new_resource.default_site_enabled
  end
end

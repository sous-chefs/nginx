property :ohai_plugin_enabled, [true, false],
         description: 'Whether or not ohai_plugin is enabled.',
         equal_to: [true, false],
         default: true

property :source, String,
         description: 'Source for installation.',
         equal_to: %w(distro repo epel passenger),
         name_property: true

property :default_site_enabled, [true, false],
         description: 'Whether or not the default site is enabled.',
         equal_to: [true, false],
         default: true

property :conf_cookbook, String,
         description: 'Which cookbook to use for the conf template.',
         default: 'nginx'

property :conf_template, String,
         description: 'Which template to use for the conf.',
         default: 'nginx.conf.erb'

property :conf_variables, Hash,
         description: 'Additional variables to include in conf template.',
         default: {}

property :group, String,
         description: 'Nginx group, if different than user.',
         default: lazy { nginx_user }

property :worker_processes, [Integer, String],
         description: 'The number of worker processes.',
         coerce: proc { |v| v.is_a?(Integer) ? v.to_s : v },
         default: 'auto'

property :worker_connections, [Integer, String],
         description: 'The maximum number of simultaneous connections that can be opened by a worker process.',
         coerce: proc { |v| v.is_a?(Integer) ? v.to_s : v },
         default: 1_024

property :sendfile, String,
         description: 'Enables or disables the use of sendfile().',
         equal_to: %w(on off),
         default: 'on'

property :tcp_nopush, String,
         description: 'Enables or disables the use of the TCP_CORK socket option on Linux.',
         equal_to: %w(on off),
         default: 'on'

property :tcp_nodelay, String,
         description: 'Enables or disables the use of the TCP_NODELAY option.',
         equal_to: %w(on off),
         default: 'on'

property :keepalive_timeout, [Integer, String],
         description: 'Timeout during which a keep-alive client connection will stay open on the server side.',
         coerce: proc { |v| v.is_a?(Integer) ? v.to_s : v },
         default: 65

property :types_hash_max_size, [Integer, String],
         description: 'Sets the maximum size of the types hash tables.',
         coerce: proc { |v| v.is_a?(Integer) ? v.to_s : v },
         default: 2_048

property :default_site_cookbook, String,
         description: 'Which cookbook to use for the default site template.',
         default: 'nginx'

property :default_site_template, String,
         description: 'Which template to use for the default site.',
         default: 'default-site.erb'

property :default_site_variables, Hash,
         description: 'Additional variables to include in default site template.',
         default: {}

property :port, [Integer, String],
         description: 'Port to listen on.',
         coerce: proc { |v| v.is_a?(Integer) ? v.to_s : v },
         default: 80

property :server_name, String,
         description: 'Sets the server_name directive.',
         default: lazy { node['hostname'] }

property :install_rake, [true, false],
         description: 'Whether or not to install rake.',
         equal_to: [true, false],
         default: true

property :passenger_root, String,
         description: 'Passenger root.',
         default: '/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini'

property :passenger_ruby, String,
         description: 'Passenger ruby.',
         default: '/usr/bin/ruby'

property :passenger_max_pool_size, [Integer, String],
         description: 'Passenger max pool size.',
         coerce: proc { |v| v.is_a?(Integer) ? v.to_s : v },
         default: 6

property :passenger_spawn_method, String,
         description: 'Passenger spawn method.',
         default: 'smart-lv2'

property :passenger_buffer_response, String,
         description: 'Passenger buffer response.',
         equal_to: %w(on off),
         default: 'on'

property :passenger_min_instances, [Integer, String],
         description: 'Passenger minimum instances.',
         coerce: proc { |v| v.is_a?(Integer) ? v.to_s : v },
         default: 1

property :passenger_max_instances_per_app, [Integer, String],
         description: 'Passenger maximum instances per app.',
         coerce: proc { |v| v.is_a?(Integer) ? v.to_s : v },
         default: 0

property :passenger_pool_idle_time, [Integer, String],
         description: 'Passenger pool idle time.',
         coerce: proc { |v| v.is_a?(Integer) ? v.to_s : v },
         default: 300

property :passenger_max_requests, [Integer, String],
         description: 'Passenger maximum requests.',
         coerce: proc { |v| v.is_a?(Integer) ? v.to_s : v },
         default: 0

property :passenger_show_version_in_header, String,
         description: 'Passenger show version in header.',
         equal_to: %w(on off),
         default: 'on'

property :passenger_log_file, String,
         description: 'Passenger log file.'

property :passenger_disable_anonymous_telemetry, String,
         description: 'Passenger turn disabling of anonymous telemetry on or off.',
         equal_to: %w(on off),
         default: 'off'

property :passenger_anonymous_telemetry_proxy, String,
         description: 'Passenger set an intermediate proxy for anonymous telemetry.'

property :passenger_nodejs, String,
         description: 'Passenger nodejs.'

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
  when 'passenger'
    if platform_family?('debian')
      apt_repository 'phusionpassenger' do
        uri 'https://oss-binaries.phusionpassenger.com/apt/passenger'
        distribution node['lsb']['codename']
        components %w(main)
        deb_src true
        keyserver 'keyserver.ubuntu.com'
        key '561F9B9CAC40B2F7'
      end

      package %w(apt-transport-https ca-certificates)
      apt_update 'update'
    else
      log 'nginx_install `source` property set to passenger, but not running on a Debian based platform so skipping passenger setup' do
        level :warn
      end
    end
  end

  if source?('distro') && platform?('amazon')
    execute 'install nginx from amazon extras library' do
      command 'amazon-linux-extras install nginx1.12'
      notifies :reload, 'ohai[reload_nginx]', :immediately if ohai_plugin_enabled?
    end
  else
    package nginx_package do
      options package_install_opts
      notifies :reload, 'ohai[reload_nginx]', :immediately if ohai_plugin_enabled?
    end
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

  %w(
    nxensite
    nxdissite
    nxenstream
    nxdisstream
  ).each do |nxscript|
    template ::File.join(nginx_script_dir, nxscript) do
      cookbook 'nginx'
      source   "#{nxscript}.erb"
      mode     '0755'
      variables(
        lazy { { nginx_dir: nginx_dir } }
      )
    end
  end

  nginx_config ::File.join(nginx_dir, 'nginx.conf') do
    conf_cookbook       new_resource.conf_cookbook
    conf_template       new_resource.conf_template
    conf_variables      new_resource.conf_variables
    group               new_resource.group
    worker_processes    new_resource.worker_processes
    worker_connections  new_resource.worker_connections
    sendfile            new_resource.sendfile
    tcp_nopush          new_resource.tcp_nopush
    tcp_nodelay         new_resource.tcp_nodelay
    keepalive_timeout   new_resource.keepalive_timeout
    types_hash_max_size new_resource.types_hash_max_size
  end

  template ::File.join(nginx_dir, 'sites-available/default') do
    cookbook new_resource.default_site_cookbook
    source   new_resource.default_site_template
    notifies :reload, 'service[nginx]', :delayed
    variables(
      nginx_log_dir: nginx_log_dir,
      port: new_resource.port,
      server_name: new_resource.server_name,
      default_root: default_root
    ).merge!(new_resource.default_site_variables)
  end

  nginx_site 'default' do
    action default_site_enabled? ? :enable : :disable
  end

  if source?('passenger') && platform_family?('debian')
    gem_package 'rake' if install_rake?
    package     passenger_packages

    template passenger_conf_file do
      cookbook 'nginx'
      source   'modules/passenger.conf.erb'
      notifies :reload, 'service[nginx]', :delayed
      variables(
        passenger_root: new_resource.passenger_root,
        passenger_ruby: new_resource.passenger_ruby,
        passenger_max_pool_size: new_resource.passenger_max_pool_size,
        passenger_spawn_method: new_resource.passenger_spawn_method,
        passenger_buffer_response: new_resource.passenger_buffer_response,
        passenger_min_instances: new_resource.passenger_min_instances,
        passenger_max_instances_per_app: new_resource.passenger_max_instances_per_app,
        passenger_pool_idle_time: new_resource.passenger_pool_idle_time,
        passenger_max_requests: new_resource.passenger_max_requests,
        passenger_show_version_in_header: new_resource.passenger_show_version_in_header,
        passenger_log_file: new_resource.passenger_log_file,
        passenger_disable_anonymous_telemetry: new_resource.passenger_disable_anonymous_telemetry,
        passenger_anonymous_telemetry_proxy: new_resource.passenger_anonymous_telemetry_proxy,
        passenger_nodejs: new_resource.passenger_nodejs
      )
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

  def source?(source)
    new_resource.source == source
  end

  def nginx_package
    if source?('passenger') && !(debian_9? || ubuntu_18?)
      'nginx-extras'
    else
      'nginx'
    end
  end

  def install_rake?
    new_resource.install_rake
  end
end

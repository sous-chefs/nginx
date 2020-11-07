#
# Cookbook:: nginx
# Resource:: install
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

property :ohai_plugin_enabled, [true, false],
          description: 'Whether or not ohai_plugin is enabled.',
          default: true

property :source, String,
          description: 'Source for installation.',
          equal_to: %w(distro repo epel passenger),
          default: 'distro'

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

property :packages, [String, Array],
          description: 'Override the default installation packages for the platform.',
          default: lazy { nginx_default_packages },
          coerce: proc { |p| p.is_a?(Array) ? p : [p] }

action_class do
  def ohai_plugin_enabled?
    new_resource.ohai_plugin_enabled
  end

  def source?(source)
    new_resource.source == source
  end

  def install_rake?
    new_resource.install_rake
  end
end

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
    Chef::Log.info 'Using distro provided packages.'
  when 'repo'
    case node['platform_family']
    when 'amazon', 'fedora', 'rhel'
      yum_repository 'nginx' do
        description  'Nginx.org Repository'
        baseurl      repo_url
        gpgkey       repo_signing_key
      end
      execute 'dnf -qy module disable nginx' do
        only_if { node['platform_version'].to_i >= 8 && platform_family?('rhel') || platform_family?('fedora') }
        not_if 'dnf module list nginx | grep -q "^nginx.*\[x\]"'
      end
    when 'debian'
      apt_repository 'nginx' do
        uri          repo_url
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
      Chef::Log.warn "nginx.org does not maintain packages for platform #{node['platform']}. Cannot setup the repo!"
    end

    package_install_opts = '--disablerepo=* --enablerepo=nginx' if platform_family?('amazon', 'rhel')
  when 'epel'
    case node['platform_family']
    when 'amazon'
      execute 'amazon-linux-extras install epel'
    when 'rhel'
      package 'epel-release'
    else
      Chef::Log.warn 'nginx_install `source` property set to epel, but not running on a RHEL platform so skipping epel setup'
    end
  when 'passenger'
    if platform_family?('debian')
      apt_update 'update'

      package %w(apt-transport-https ca-certificates)

      apt_repository 'phusionpassenger' do
        uri 'https://oss-binaries.phusionpassenger.com/apt/passenger'
        components %w(main)
        deb_src true
        keyserver 'keyserver.ubuntu.com'
        key '561F9B9CAC40B2F7'
      end
    else
      Chef::Log.warn 'nginx_install `source` property set to passenger, but not running on a Debian based platform so skipping passenger setup'
    end
  end

  if source?('distro') && platform?('amazon')
    execute 'install nginx from amazon extras library' do
      command 'amazon-linux-extras install nginx1.12'
      notifies :reload, 'ohai[reload_nginx]', :immediately if ohai_plugin_enabled?
    end
  else
    new_resource.packages.each do |pkg|
      package pkg do
        options package_install_opts
        notifies :reload, 'ohai[reload_nginx]', :immediately if ohai_plugin_enabled?
      end
    end
  end

  directory nginx_log_dir do
    owner nginx_user
    group nginx_user
    mode '0750'
    action :create
  end

  if source?('passenger') && platform_family?('debian')
    gem_package 'rake' if install_rake?
    package     passenger_packages

    template passenger_conf_file do
      cookbook 'nginx'
      source   'modules/passenger.conf.erb'
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
end

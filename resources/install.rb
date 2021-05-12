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

unified_mode true

include Nginx::Cookbook::Helpers

property :ohai_plugin_enabled, [true, false],
          description: 'Whether or not ohai_plugin is enabled.',
          default: true

property :source, String,
          description: 'Source for installation.',
          equal_to: %w(distro repo epel),
          default: 'distro'

property :repo_train, String,
          description: 'Train to use for installation from nginx repoistory',
          equal_to: %w(stable mainline),
          default: 'stable'

property :packages, [String, Array],
          description: 'Override the default installation packages for the platform.',
          default: lazy { nginx_default_packages(source) },
          coerce: proc { |p| p.is_a?(Array) ? p : [p] }

property :packages_versions, [String, Array],
          description: 'Override the package versions to be installed.',
          coerce: proc { |p| p.is_a?(Array) ? p : [p] }

action_class do
  include Nginx::Cookbook::Helpers

  def ohai_plugin_enabled?
    new_resource.ohai_plugin_enabled
  end

  def source?(source)
    new_resource.source == source
  end

  def chef_config_path
    return '/etc/chef' unless Chef::Config['config_file']

    ::File.dirname(Chef::Config['config_file'])
  end
end

action :install do
  if ohai_plugin_enabled?
    directory ::File.join(chef_config_path, 'ohai', 'plugins') do
      recursive true
    end

    template ::File.join(chef_config_path, 'ohai', 'plugins', 'nginx.rb') do
      cookbook 'nginx'
      source 'plugins/ohai-nginx.rb.erb'
      variables(
        binary: nginx_binary
      )
    end

    ohai 'nginx' do
      action :nothing
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
        baseurl      repo_url(new_resource.repo_train)
        gpgkey       repo_signing_key
      end
      execute 'dnf -qy module disable nginx' do
        only_if { node['platform_version'].to_i >= 8 && platform_family?('rhel') || platform_family?('fedora') }
        not_if 'dnf module list nginx | grep -q "^nginx.*\[x\]"'
      end
    when 'debian'
      apt_repository 'nginx' do
        uri          repo_url(new_resource.repo_train)
        components   %w(nginx)
        deb_src      true
        key          repo_signing_key
      end
    when 'suse'
      zypper_repository 'nginx' do
        description 'Nginx.org Repository'
        baseurl     repo_url(new_resource.repo_train)
        gpgkey      repo_signing_key
      end
    else
      Chef::Log.warn "nginx.org does not maintain packages for platform #{node['platform']}. Cannot setup the repo!"
    end

    package_install_opts = '--disablerepo=* --enablerepo=nginx' if platform_family?('amazon', 'fedora', 'rhel')
  when 'epel'
    case node['platform_family']
    when 'amazon'
      execute 'amazon-linux-extras install epel'
    when 'rhel'
      package 'epel-release'
    else
      Chef::Log.warn 'nginx_install `source` property set to epel, but not running on a RHEL platform so skipping epel setup'
    end
  end

  if source?('distro') && platform?('amazon')
    execute 'install nginx from amazon extras library' do
      command 'amazon-linux-extras install nginx1.12'
      notifies :reload, 'ohai[nginx]', :immediately if ohai_plugin_enabled?
    end
  else
    package new_resource.packages do
      version new_resource.packages_versions
      options package_install_opts
      notifies :reload, 'ohai[nginx]', :immediately if ohai_plugin_enabled?
    end
  end
end

action :remove do
  package new_resource.packages do
    version new_resource.packages_versions
    options package_install_opts
    action :remove
  end

  file ::File.join(chef_config_path, 'ohai', 'plugins', 'nginx.rb') { action :delete }
end

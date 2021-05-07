#
# Cookbook:: nginx
# Resource:: config
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

deprecated_property_alias 'user',
                          'process_user',
                          'The user property was renamed process_user in the 11.3 release of this cookbook. Please update your cookbooks to use the new property name. This alias will be removed in the next major version.'

property :config_file, String,
          description: 'The full path to the Nginx server configuration on disk.',
          default: lazy { nginx_config_file }

property :conf_cookbook, String,
          description: 'Which cookbook to use for the conf template.',
          default: 'nginx'

property :conf_template, String,
          description: 'Which template to use for the conf.',
          default: 'nginx.conf.erb'

property :conf_variables, Hash,
          description: 'Additional variables to include in conf template.',
          default: {}

property :port, [Integer, String],
          description: 'Port to listen on.',
          coerce: proc { |v| v.is_a?(Integer) ? v.to_s : v },
          default: 80

property :server_name, String,
          description: 'Sets the server_name directive.',
          default: lazy { node['hostname'] }

property :owner, String,
          description: 'File/folder group',
          default: lazy { nginx_user }

property :group, String,
          description: 'File/folder group',
          default: lazy { nginx_group }

property :mode, String,
          description: 'File mode',
          default: '0640'

property :folder_mode, String,
          description: 'Folder mode',
          default: '0750'

property :process_user, String,
          description: 'Nginx process user',
          default: lazy { nginx_user }

property :process_group, String,
          description: 'Nginx process group',
          default: lazy { nginx_group }

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

property :default_site_enabled, [true, false],
          description: 'Whether or not the default site is enabled.',
          equal_to: [true, false],
          default: true

property :default_site_cookbook, String,
          description: 'Which cookbook to use for the default site template.',
          default: 'nginx'

property :default_site_template, String,
          description: 'Which template to use for the default site.',
          default: 'default-site.erb'

property :default_site_variables, Hash,
          description: 'Additional variables to include in default site template.',
          default: {}

property :template_helpers, [String, Array],
          description: 'Additional helper modules to include in the default site and config template',
          coerce: proc { |p| p.is_a?(Array) ? p : [p] }

action_class do
  include Nginx::Cookbook::ResourceHelpers

  def default_site_enabled?
    new_resource.default_site_enabled
  end
end

action :create do
  %w(conf.d conf.http.d).each do |leaf|
    directory ::File.join(nginx_dir, leaf) do
      owner new_resource.owner
      group new_resource.group
      mode new_resource.folder_mode
    end
  end

  directory nginx_log_dir do
    owner new_resource.owner
    group new_resource.group
    mode new_resource.folder_mode
  end

  %w(default.conf example_ssl.conf).each do |config|
    file ::File.join(nginx_dir, "conf.d/#{config}") do
      action :delete
    end
  end

  nginx_site 'default-site' do
    cookbook new_resource.default_site_cookbook
    template new_resource.default_site_template
    conf_dir nginx_config_site_dir

    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
    folder_mode new_resource.folder_mode

    template_helpers new_resource.template_helpers

    variables(
      nginx_log_dir: nginx_log_dir,
      port: new_resource.port,
      server_name: new_resource.server_name,
      default_root: default_root
    ).merge!(new_resource.default_site_variables)
  end if default_site_enabled?

  template new_resource.config_file do
    cookbook new_resource.conf_cookbook
    source   new_resource.conf_template

    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode

    helpers(Nginx::Cookbook::TemplateHelpers)
    new_resource.template_helpers.each { |th| helpers(::Object.const_get(th)) } unless new_resource.template_helpers.nil?

    variables(
      nginx_dir: nginx_dir,
      nginx_log_dir: nginx_log_dir,
      process_user: new_resource.process_user,
      process_group: new_resource.process_group,
      worker_processes: new_resource.worker_processes,
      pid: nginx_pid_file,
      worker_connections: new_resource.worker_connections,
      sendfile: new_resource.sendfile,
      tcp_nopush: new_resource.tcp_nopush,
      tcp_nodelay: new_resource.tcp_nodelay,
      keepalive_timeout: new_resource.keepalive_timeout,
      types_hash_max_size: new_resource.types_hash_max_size
    ).merge!(new_resource.conf_variables)
  end
end

action :delete do
  file ::File.join(nginx_dir, 'nginx.conf') do
    action :delete
  end
end

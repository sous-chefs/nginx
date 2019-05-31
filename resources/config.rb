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

action :create do
  template ::File.join(nginx_dir, 'nginx.conf') do
    cookbook new_resource.conf_cookbook
    source   new_resource.conf_template
    notifies :reload, 'service[nginx]', :delayed
    variables(
      nginx_dir: nginx_dir,
      nginx_log_dir: nginx_log_dir,
      nginx_user: nginx_user,
      group: new_resource.group,
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

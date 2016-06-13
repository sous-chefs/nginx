class Chef
  class Resource
    # Resource interface, minimum to get a running nginx binary
    #
    # @since 3.0.0
    # @author Mike Fiedler <miketheman@gmail.com>
    class NginxService < Chef::Resource::LWRPBase
      self.resource_name = :nginx_service
      actions :create, :delete, :start, :stop, :restart, :reload
      default_action [:create, :start]

      provides :nginx_service

      attribute :error_log_level, kind_of: String, default: 'warn'
      attribute :run_group, kind_of: String, default: nil
      # @todo Determine what user is correct per-platform
      attribute :run_user, kind_of: String, default: lazy { user_for_node(node) }
      attribute :worker_connections, kind_of: Integer, default: 1024
      attribute :worker_processes, kind_of: Integer, default: 1

      # @note Prefer using inherited files over adding hash data to a resource.
      attribute :xtra_main_http_conf, kind_of: Hash, default: nil
    end
  end
end

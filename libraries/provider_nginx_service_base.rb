require_relative './helpers'

class Chef
  class Provider
    # Base Provider interface
    #
    # Global actions here. Service control actions to be subclassed per-platform
    # @since 3.0.0
    # @author Mike Fiedler <miketheman@gmail.com>
    class NginxServiceBase < Chef::Provider::LWRPBase
      # Chef 11 LWRP DSL Methods
      use_inline_resources if defined?(use_inline_resources)

      # @return [TrueClass] true
      def whyrun_supported?
        true
      end

      action :create do
        # Install nginx using system package resource
        #
        # Requires a pacakge to be available via distro packaging.
        # @todo skip this if using a source install
        package "#{res_name} :create nginx" do
          package_name 'nginx'
          action :install
        end

        create_stop_package_service

        ## Create instance directories
        directory "#{res_name} :create /var/log/#{nginx_instance_name}" do
          path "/var/log/#{nginx_instance_name}"
          owner new_resource.run_user
          group 'adm'
          mode 00755
          action :create
        end

        %W(
          /etc/#{nginx_instance_name}
          /etc/#{nginx_instance_name}/conf.d
          /etc/#{nginx_instance_name}/sites-available
          /etc/#{nginx_instance_name}/sites-enabled
        ).each do |instance_dir|
          directory "#{res_name} :create #{instance_dir}" do
            path instance_dir
            owner 'root'
            group 'root'
            mode 00755
            action :create
          end
        end

        # Minimal nginx config, based on resource attributes
        template "#{res_name} :create /etc/#{nginx_instance_name}/nginx.conf" do
          path "/etc/#{nginx_instance_name}/nginx.conf"
          cookbook 'nginx'
          owner 'root'
          group 'root'
          mode 00644
          variables(
            nginx_instance_name: nginx_instance_name,
            error_log_level: new_resource.error_log_level,
            run_group: new_resource.run_group,
            run_user: new_resource.run_user,
            worker_connections: new_resource.worker_connections,
            worker_processes: new_resource.worker_processes,
            xtra_main_http_conf: new_resource.xtra_main_http_conf
          )
          action :create
          # @todo Figure out how to notify the service to restart when changed.
          # Some oddity on how the service is resolved and doesn't work right now.
          # notifies :restart, "service[#{res_name} :restart #{nginx_instance_name}]"
        end

        # Ensure logrotate is set up for this instance
        template "#{res_name} :create /etc/logrotate.d/#{nginx_instance_name}" do
          path "/etc/logrotate.d/#{nginx_instance_name}"
          cookbook 'nginx'
          source 'nginx.logrotate.erb'
          owner 'root'
          group 'root'
          mode 00644
          variables(
            nginx_instance_name: nginx_instance_name,
            run_group: new_resource.run_group,
            run_user: new_resource.run_user
          )
          action :create
        end
      end

      private

      # Stop the default service defined by the package provider
      #
      # We create named scripts for each instance of `nginx_service`, and the
      # default site also uses port 80. Stopping and disabling this service allows
      # any number of instances to be created and run on a single system.
      # @note This may be redefined in subclasses as needed per platform.
      def create_stop_package_service
        service 'nginx' do
          supports status: true
          action [:stop, :disable]
        end
      end
    end
  end
end

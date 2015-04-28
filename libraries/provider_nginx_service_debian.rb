class Chef
  class Provider
    class NginxService
      # Provider actions for Debian-based platforms
      #
      # @since 3.0.0
      # @author Mike Fiedler <miketheman@gmail.com>
      class Debian < Chef::Provider::NginxService
        provides :nginx_service, platform_family: 'debian' if respond_to?(:provides)

        action :start do
          template "#{res_name} :create /etc/init.d/#{nginx_instance_name}" do
            path "/etc/init.d/#{nginx_instance_name}"
            cookbook 'nginx'
            source 'nginx.init.d.erb'
            owner 'root'
            group 'root'
            mode 00744
            variables(nginx_instance_name: nginx_instance_name)
            action :create
          end

          # Start up the service
          service "#{nginx_instance_name} :start" do
            service_name nginx_instance_name
            provider Chef::Provider::Service::Debian
            supports status: true, restart: true
            action [:start, :enable]
          end
        end

        action :stop do
          service "#{nginx_instance_name} :stop" do
            service_name nginx_instance_name
            provider Chef::Provider::Service::Debian
            supports status: true, restart: true
            action [:stop, :disable]
          end
        end

        action :delete do
          # @todo create recipes and tests for this
          file "#{res_name} :delete /etc/init.d/#{nginx_instance_name}" do
            path "/etc/init.d/#{nginx_instance_name}"
            action :delete
          end

          service "#{res_name} :delete #{nginx_instance_name}" do
            service_name nginx_instance_name
            provider Chef::Provider::Service::Debian
            supports status: true
            action [:stop, :disable]
          end
        end

        action :restart do
          # @todo create recipes and tests for this
          service "#{res_name} :restart #{nginx_instance_name}" do
            service_name nginx_instance_name
            supports status: true, restart: true
            provider Chef::Provider::Service::Init::Debian
            action :restart
          end
        end

        action :reload do
          # @todo create recipes and tests for this
          service "#{res_name} :reload #{nginx_instance_name}" do
            service_name nginx_instance_name
            provider Chef::Provider::Service::Debian
            supports status: true, reload: true
            action :reload
          end
        end
      end
    end
  end
end

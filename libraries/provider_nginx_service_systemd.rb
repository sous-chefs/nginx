class Chef
  class Provider
    class NginxService
      # Provider actions for platforms using Systemd
      #
      # @since 3.0.0
      # @author Miguel Ferreira <mferreira@schubergphilis.com>
      class NginxServiceSystemd < Chef::Provider::NginxServiceBase
        provides :nginx_service, os: 'linux' do
          Chef::Platform::ServiceHelpers.service_resource_providers.include?(:systemd)
        end if defined?(provides)

        action :start do
          template "#{res_name} :create /etc/systemd/system/#{nginx_instance_name}" do
            path "/etc/systemd/system/#{nginx_instance_name}.service"
            cookbook 'nginx'
            source 'systemd/nginx.erb'
            owner 'root'
            group 'root'
            mode 00744
            variables(nginx_instance_name: nginx_instance_name)
            action :create
            notifies :run, 'execute[systemctl daemon-reload]', :immediately
          end

          execute 'systemctl daemon-reload' do
            action :nothing
          end

          service "#{nginx_instance_name} :start" do
            service_name nginx_instance_name
            provider Chef::Provider::Service::Systemd
            supports status: true, restart: true
            action [:start, :enable]
          end
        end

        action :stop do
          service "#{nginx_instance_name} :stop" do
            service_name nginx_instance_name
            provider Chef::Provider::Service::Systemd
            supports status: true, restart: true
            action [:stop, :disable]
          end
        end

        action :delete do
          file "#{res_name} :delete /etc/systemd/system/#{nginx_instance_name}" do
            path "/etc/systemd/system/#{nginx_instance_name}.service"
            action :delete
          end

          service "#{res_name} :delete #{nginx_instance_name}" do
            service_name nginx_instance_name
            provider Chef::Provider::Service::Systemd
            supports status: true
            action [:stop, :disable]
            notifies :run, 'execute[systemctl daemon-reload]', :immediately
          end

          execute 'systemctl daemon-reload' do
            action :nothing
          end
        end

        action :restart do
          # @todo create recipes and tests for this
          service "#{res_name} :restart #{nginx_instance_name}" do
            service_name nginx_instance_name
            supports status: true, restart: true
            provider Chef::Provider::Service::Systemd
            action :restart
          end
        end

        action :reload do
          # @todo create recipes and tests for this
          service "#{res_name} :reload #{nginx_instance_name}" do
            service_name nginx_instance_name
            provider Chef::Provider::Service::Systemd
            supports status: true, reload: true
            action :reload
          end
        end
      end
    end
  end
end

module Nginx
  module Cookbook
    module Helpers
      # pidfile is hard to determine on Debian systems.
      # Upstream packages and older distro releases use '/var/run/nginx.pid'
      # systemd based distros and Ubuntu 14.04 use '/run/nginx.pid' for their
      # packages
      def pidfile_location
        if (node['nginx']['repo_source'].nil? || %w(distro passenger).include?(node['nginx']['repo_source'])) && (node['init_package'] == 'systemd' || node['platform_version'].to_f == 14.04)
          '/run/nginx.pid'
        else
          '/var/run/nginx.pid'
        end
      end

      def nginx_binary
        '/usr/sbin/nginx'
      end

      def repo_url
        case node['platform_family']
        when 'amazon', 'fedora', 'rhel'
          case node['platform']
          when 'amazon', 'fedora'
            'https://nginx.org/packages/rhel/7/$basearch'
          when 'centos'
            "https://nginx.org/packages/centos/#{node['platform_version'].to_i}/$basearch"
          else
            "https://nginx.org/packages/rhel/#{node['platform_version'].to_i}/$basearch"
          end
        when 'debian'
          "https://nginx.org/packages/#{node['platform']}"
        when 'suse'
          'https://nginx.org/packages/sles/12'
        end
      end

      def repo_signing_key
        'https://nginx.org/keys/nginx_signing.key'
      end

      def nginx_dir
        '/etc/nginx'
      end

      def nginx_log_dir
        '/var/log/nginx'
      end

      def nginx_user
        platform_family?('debian') ? 'www-data' : 'nginx'
      end

      def nginx_pid_file
        '/run/nginx.pid'
      end

      def nginx_script_dir
        '/usr/sbin'
      end

      def default_root
        '/var/www/nginx-default'
      end

      def site_enabled?(site_name)
        ::File.symlink?("#{nginx_dir}/sites-enabled/#{site_name}") || ::File.symlink?("#{nginx_dir}/sites-enabled/000-#{site_name}")
      end

      def site_available?(site_name)
        ::File.exist?("#{nginx_dir}/sites-available/#{site_name}")
      end

      def debian_9?
        platform?('debian') && node['platform_version'].to_i == 9
      end

      def ubuntu_18?
        platform?('ubuntu') && node['platform_version'].to_f == 18.04
      end

      def passenger_packages
        if platform_family?('debian')
          packages = %w(ruby-dev libcurl4-gnutls-dev)
          packages << if debian_9? || ubuntu_18?
                        'libnginx-mod-http-passenger'
                      else
                        'passenger'
                      end

          packages
        end
      end

      def passenger_conf_file
        if platform_family?('debian')
          if debian_9? || ubuntu_18?
            ::File.join(nginx_dir, 'conf.d/mod-http-passenger.conf')
          else
            ::File.join(nginx_dir, 'conf.d/passenger.conf')
          end
        end
      end
    end
  end
end

Chef::Provider.send(:include, Nginx::Cookbook::Helpers)
Chef::Resource.send(:include, Nginx::Cookbook::Helpers)

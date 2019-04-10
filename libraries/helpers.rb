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
    end
  end
end

Chef::Provider.send(:include, Nginx::Cookbook::Helpers)
Chef::Resource.send(:include, Nginx::Cookbook::Helpers)

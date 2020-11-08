module Nginx
  module Cookbook
    module Helpers
      def nginx_binary
        '/usr/sbin/nginx'
      end

      def repo_url
        case node['platform_family']
        when 'amazon', 'fedora', 'rhel'
          case node['platform']
          when 'amazon'
            'https://nginx.org/packages/rhel/7/$basearch'
          when 'centos'
            "https://nginx.org/packages/centos/#{node['platform_version'].to_i}/$basearch"
          when 'fedora'
            'https://nginx.org/packages/rhel/8/$basearch'
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

      def nginx_group
        platform_family?('debian') ? 'www-data' : 'nginx'
      end

      def nginx_pid_file
        '/run/nginx.pid'
      end

      def nginx_script_dir
        '/usr/sbin'
      end

      def nginx_config_file
        "#{nginx_dir}/nginx.conf"
      end

      def nginx_config_site_dir
        "#{nginx_dir}/conf.site.d"
      end

      def nginx_default_packages
        case node['platform_family']
        when 'rhel', 'fedora'
          %w(nginx)
        when 'debian'
          %w(nginx-full)
        else
          %w(nginx)
        end
      end

      def default_nginx_service_name
        'nginx'
      end

      def default_root
        case node['platform_family']
        when 'rhel', 'fedora', 'amazon'
          '/usr/share/nginx/html'
        when 'debian'
          '/var/www/html'
        when 'suse'
          '/srv/www/htdocs'
        else
          raise "default_root: Unsupported platform #{node['platform']}."
        end
      end

      def debian_9?
        platform?('debian') && node['platform_version'].to_i == 9
      end

      def ubuntu_18?
        platform?('ubuntu') && node['platform_version'].to_f == 18.04
      end
    end
  end
end

Chef::DSL::Universal.include(Nginx::Cookbook::Helpers)

module Nginx
  module Cookbook
    module Helpers
      def nginx_binary
        '/usr/sbin/nginx'
      end

      def repo_url(train = 'stable')
        repo_base_url = train.eql?('mainline') ? 'https://nginx.org/packages/mainline' : 'https://nginx.org/packages'

        case node['platform_family']
        when 'amazon', 'fedora', 'rhel'
          case node['platform']
          when 'amazon'
            "#{repo_base_url}/rhel/7/$basearch"
          when 'centos'
            "#{repo_base_url}/centos/#{node['platform_version'].to_i}/$basearch"
          when 'fedora'
            "#{repo_base_url}/rhel/8/$basearch"
          else
            "#{repo_base_url}/rhel/#{node['platform_version'].to_i}/$basearch"
          end
        when 'debian'
          "#{repo_base_url}/#{node['platform']}"
        when 'suse'
          "#{repo_base_url}/sles/#{node['platform_version'].to_i}"
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
        platform_family?('debian') ? 'root' : 'nginx'
      end

      def nginx_group
        platform_family?('debian') ? 'root' : 'nginx'
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
        "#{nginx_dir}/conf.http.d"
      end

      def nginx_default_packages(source)
        return 'nginx' if source.eql?('repo')

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

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
    end
  end
end

Chef::Resource.send(:include, Nginx::Cookbook::Helpers)

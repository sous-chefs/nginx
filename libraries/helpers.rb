module NginxCookbook
  # A generalized module to provide methods that help every other cookbook
  #
  # @since 3.0.0
  # @author Mike Fiedler <miketheman@gmail.com>
  module Helpers
    # @return [String] Name used in templates, resource definitions.
    def nginx_instance_name
      "nginx-#{res_name}"
    end

    # @return [String] Name of the current resource
    def res_name
      new_resource.name
    end

    # @param [Chef::Node] An Object that responds to a `['platform_family']` call
    # @return [String] Name of the user that runs nginx
    def user_for_node(node)
      case node['platform_family']
      when 'rhel'
        'nginx'
      when 'debian'
        'www-data'
      else
        raise "Unexpected platform family '#{node['platform_family']}'."
      end
    end
  end
end

Chef::Resource.send(:include, NginxCookbook::Helpers)
Chef::Provider.send(:include, NginxCookbook::Helpers)

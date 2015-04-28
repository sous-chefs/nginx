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
  end
end

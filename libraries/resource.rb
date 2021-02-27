module Nginx
  module Cookbook
    module ResourceHelpers
      def create_list_resource
        with_run_context(:root) do
          edit_resource(:directory, new_resource.conf_dir) do |new_resource|
            owner new_resource.owner
            group new_resource.group
            mode new_resource.folder_mode

            action :create
          end

          edit_resource(:template, "#{new_resource.conf_dir}/list.conf") do |new_resource|
            cookbook 'nginx'
            source 'list.conf.erb'

            owner new_resource.owner
            group new_resource.group
            mode new_resource.mode

            helpers(Nginx::Cookbook::TemplateHelpers)

            variables['files'] ||= []

            action :nothing
            delayed_action :create
          end
        end
      end

      def add_to_list_resource
        manage_list_resource(:add)
      end

      def remove_from_list_resource
        manage_list_resource(:remove)
      end

      private

      def manage_list_resource(action)
        raise ArgumentError, "manage_list_resource: Invalid action #{action}." unless %i(add remove).include?(action)

        list = begin
                 find_resource!(:template, "#{new_resource.conf_dir}/list.conf")
               rescue Chef::Exceptions::ResourceNotFound
                 create_list_resource
               end

        files = list.variables['files']

        case action
        when :add
          files.push(config_file) unless files.include?(config_file)
        when :remove
          files.delete(config_file) if files.include?(config_file)
        end
      end
    end
  end
end

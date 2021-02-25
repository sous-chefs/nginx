module Nginx
  module Cookbook
    module TemplateHelpers
      def nil_or_empty?(v)
        v.nil? || (v.respond_to?(:empty?) && v.empty?)
      end
    end
  end
end

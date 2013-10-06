actions :create, :delete
default_action :create

attribute :cookbook, :kind_of => String, :default => nil
attribute :variables, :kind_of => Hash, :default => nil
attribute :source, :kind_of => String, :default => nil
attribute :enable, :kind_of => [TrueClass, FalseClass], :default => true

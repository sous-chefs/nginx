require 'rspec/core'
require 'rspec/expectations'
require 'rspec/mocks'

# Custom ChefSpec matchers
module ChefSpec::Matchers
  RSpec::Matchers.define :enable_nginx_site do |site|
    match do |chef_run|
      chef_run.find_resources(:nginx_site) do |resource|
        resource.resource_name == :execute && resource.name =~ /.*nxensite.*#{site}/
      end
    end
  end

  RSpec::Matchers.define :disable_nginx_site do |site|
    match do |chef_run|
      chef_run.find_resources(:nginx_site) do |resource|
        resource.resource_name == :execute && resource.name =~ /.*nxdissite.*#{site}/
      end
    end
  end
end

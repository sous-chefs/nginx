require 'chefspec'
require 'chefspec/berkshelf'
require 'support/matchers/nginx_site'

at_exit { ChefSpec::Coverage.report! }

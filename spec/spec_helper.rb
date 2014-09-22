# encoding: utf-8
require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  # prevent any WARN messages during testing
  config.log_level = :error
end

ChefSpec::Coverage.start!

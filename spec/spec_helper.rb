require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  # prevent any WARN messages during testing
  config.log_level = :error

  # colors are nice
  config.color = true

  # run all specs when using a filter, but no spec match
  config.run_all_when_everything_filtered = true

  Ohai::Config[:log_level] = :error
end

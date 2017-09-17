require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.color = true               # Use color in STDOUT
  config.formatter = :documentation # Use the specified formatter
  config.log_level = :error         # Avoid deprecation notice SPAM

  # run all specs when using a filter, but no spec match
  config.run_all_when_everything_filtered = true

  Ohai::Config[:log_level] = :error
end

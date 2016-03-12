if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

require 'chefspec'
require 'chefspec/berkshelf'
ChefSpec::Coverage.start!

RSpec.configure do |config|
  # Uncomment to prevent any WARN messages during testing
  # config.log_level = :error

  # run all specs when using a filter, but no spec match
  config.run_all_when_everything_filtered = true
end

# Load all shared example groups
Dir[File.join(File.dirname(__FILE__), 'shared_examples', '**.rb')].sort.each { |f| require f }

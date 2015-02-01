#!/usr/bin/env rake

require 'foodcritic'
require 'kitchen'
require 'rake/clean'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

CLEAN.include %w(.kitchen/ coverage)
CLOBBER.include %w(Berksfile.lock Gemfile.lock)

# Default tasks to run when executing `rake`
task default: %w(style spec)

# Style tests. Rubocop and Foodcritic
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = { fail_tags: ['any'] }
  end
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

# Rspec and ChefSpec
desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
end

# Integration tests. Kitchen.ci
namespace :integration do
  # TBD
end

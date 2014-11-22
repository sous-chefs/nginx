# Guardfile for automated testing

# guard 'kitchen', cli: ['-c 2'] do
#   watch(%r{.kitchen.*/.+})
#   watch(%r{test/.+})
#   watch(%r{^recipes/(.+)\.rb$})
#   watch(%r{^attributes/(.+)\.rb$})
#   watch(%r{^files/(.+)})
#   watch(%r{^templates/(.+)})
#   watch(%r{^providers/(.+)\.rb})
#   watch(%r{^resources/(.+)\.rb})
# end

guard :foodcritic, cookbook_paths: '.', cli: ['--epic-fail', 'any'] do
  watch(%r{attributes/.+\.rb$})
  watch(%r{providers/.+\.rb$})
  watch(%r{recipes/.+\.rb$})
  watch(%r{resources/.+\.rb$})
  watch('metadata.rb')
end

# ChefSpec tests
guard :rspec, cmd: 'bundle exec rspec', all_on_start: true do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^(recipes)/(.+)\.rb$})   { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')      { 'spec' }
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

require 'berkshelf'
require 'chefspec'
require_relative 'support/matchers/nginx_site'

Berkshelf.ui.mute do
  Berkshelf::Berksfile.from_file('Berksfile').install(path: 'vendor/cookbooks')
end

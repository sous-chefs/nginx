require 'serverspec'

set :backend, :exec

RSpec.shared_examples_for 'nginx package' do
  describe package('nginx') do
    it { should be_installed }
  end
end

RSpec.shared_examples_for 'nginx service' do |resource_name|
  describe service("nginx-#{resource_name}") do
    it { should be_running }
    it { should be_enabled }
  end
end

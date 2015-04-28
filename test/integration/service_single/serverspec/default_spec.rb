require 'serverspec'

set :backend, :exec

describe 'single service' do
  it 'installs nginx package' do
    expect(package 'nginx').to be_installed
  end

  it 'starts & enables nginx service' do
    expect(service 'nginx-single').to be_running
    expect(service 'nginx-single').to be_enabled
  end
end

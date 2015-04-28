require 'serverspec'

set :backend, :exec

describe 'multi service' do
  it 'installs nginx package' do
    expect(package 'nginx').to be_installed
  end

  it 'starts & enables nginx multi1 service' do
    expect(service 'nginx-multi1').to be_running
    expect(service 'nginx-multi1').to be_enabled
  end

  it 'starts & enables nginx multi2 service' do
    expect(service 'nginx-multi2').to be_running
    expect(service 'nginx-multi2').to be_enabled
  end
end

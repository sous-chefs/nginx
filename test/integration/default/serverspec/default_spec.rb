require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'nginx::default' do
  it 'installed nginx' do
    expect(package('nginx')).to be_installed
  end

  it 'has the service up and running' do
    expect(service('nginx')).to be_enabled
    expect(service('nginx')).to be_running
  end
end

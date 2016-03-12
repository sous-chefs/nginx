require 'serverspec'

set :backend, :exec

describe 'single service, upstream repo' do
  it 'creates the apt repo file' do
    listfile = '/etc/apt/sources.list.d/nginx.org.list'
    expect(file(listfile)).to be_a_file
    expect(file(listfile).content).to match(%r{http://nginx.org/packages/})
  end

  it 'installs nginx package' do
    expect(package('nginx')).to be_installed
    expect(command('grep -q nginx.org /var/lib/dpkg/status').exit_status).to eq 0
  end

  it 'starts & enables nginx service' do
    expect(service('nginx-single')).to be_running
    expect(service('nginx-single')).to be_enabled
  end
end

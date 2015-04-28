require 'serverspec'

set :backend, :exec

describe 'example service' do
  it 'installs nginx package' do
    expect(package 'nginx').to be_installed
  end

  it 'stops the default nginx service' do
    expect(service 'nginx').to_not be_running
    # @todo Bug exists in service detection when names are similar.
    # @see https://github.com/serverspec/specinfra/pull/373
    expect(service 'nginx').to_not be_enabled
  end

  it 'creates an nginx-example config file' do
    nginx_example_conf = file '/etc/nginx-example/nginx.conf'

    expect(nginx_example_conf).to be_a_file
    expect(nginx_example_conf.content).to match(/user www-data;/)
  end

  it 'starts & enables the example nginx service' do
    expect(service 'nginx-example').to be_running
    expect(service 'nginx-example').to be_enabled
  end
end

describe 'test page' do
  before do
    ENV.delete('http_proxy')
  end

  it 'serves back an example page' do
    # TODO: `netstat` (from deprecated net-tools package) is needed to test ports..
    # @see https://github.com/serverspec/specinfra/pull/375
    packager = os[:family] == 'redhat' ? 'yum' : 'apt-get'
    expect((command "#{packager} install net-tools").exit_status).to eq 0

    expect(port 80).to be_listening

    expect((command 'curl http://localhost').stdout).to match(/Hello, world./)
  end
end

describe 'resource_nginx_service :create on ubuntu 10.04' do
  before do
    allow(Chef::Platform::ServiceHelpers).to receive(:service_resource_providers).and_return([:debian])
  end

  cached(:chef_run) do
    ChefSpec::SoloRunner.new(
      step_into: 'nginx_service',
      platform: 'ubuntu',
      version: '10.04'
    ).converge('nginx::example')
  end

  it_behaves_like 'create a named nginx_service', 'example'

  it_behaves_like 'nginx_service :create', 'example', 'platform' => 'ubuntu'
  it_behaves_like 'nginx_service :start', 'example'
  it_behaves_like 'nginx_service #sysvinit', 'example'

  it_behaves_like 'nginx_config :create', 'example'
end

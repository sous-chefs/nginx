describe 'resource_nginx_service :create on debian 7' do
  before do
    allow(Chef::Platform::ServiceHelpers).to receive(:service_resource_providers).and_return([:upstart])
  end

  cached(:chef_run) do
    ChefSpec::SoloRunner.new(
      step_into: 'nginx_service',
      platform: 'debian',
      version: '7.0'
    ).converge('nginx::example')
  end

  it_behaves_like 'create a named nginx_service', 'example'

  it_behaves_like 'nginx_service :create', 'example'
  it_behaves_like 'nginx_service :start', 'example'
  it_behaves_like 'nginx_service #upstart', 'example'

  it_behaves_like 'nginx_config :create', 'example'
end

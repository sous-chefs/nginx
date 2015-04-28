describe 'resource_nginx_service :create on ubuntu 14.04' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(
      step_into: 'nginx_service',
      platform: 'ubuntu',
      version: '14.04'
    ).converge('nginx::example')
  end

  it_behaves_like 'create a named nginx_service', 'example'

  it_behaves_like 'nginx_service :create', 'example'
  it_behaves_like 'nginx_service :start', 'example'

  it_behaves_like 'nginx_config :create', 'example'
end

describe 'resource_nginx_service :delete on debian 7' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(
      step_into: 'nginx_service',
      platform: 'debian',
      version: '7.0'
    ).converge('nginx_service_test::single', 'nginx_service_test::delete')
  end

  it_behaves_like 'create a named nginx_service', 'single'

  it_behaves_like 'nginx_service :create', 'single'
  it_behaves_like 'nginx_service :start', 'single'

  xit 'stops the service' do
    expect(chef_run).to stop_service('nginx-single')
  end
end

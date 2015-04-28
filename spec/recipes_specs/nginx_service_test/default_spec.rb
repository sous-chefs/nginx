describe 'nginx_service_test::single' do
  cached(:chef_run) { ChefSpec::SoloRunner.converge described_recipe }

  it_behaves_like 'create a named nginx_service', 'single'
end

describe 'nginx_service_test::multi' do
  cached(:chef_run) { ChefSpec::SoloRunner.converge described_recipe }

  it_behaves_like 'create a named nginx_service', 'multi1'
  it_behaves_like 'create a named nginx_service', 'multi2'
end

describe 'nginx_service_test::nginx_repo' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'debian', version: '7.0'
    ).converge(described_recipe)
  end

  it 'adds the nginx.org apt repo' do
    expect(chef_run).to add_apt_repository('nginx.org')
  end
end

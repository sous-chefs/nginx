describe 'nginx_service_test::single' do
  cached(:chef_run) { ChefSpec::SoloRunner.converge described_recipe }

  it_behaves_like 'create a named nginx_service', 'single'
end

describe 'nginx_service_test::multi' do
  cached(:chef_run) { ChefSpec::SoloRunner.converge described_recipe }

  it_behaves_like 'create a named nginx_service', 'multi1'
  it_behaves_like 'create a named nginx_service', 'multi2'
end

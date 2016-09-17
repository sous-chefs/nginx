require 'spec_helper'

describe 'chef_nginx::default' do
  before do
    stub_command('which nginx').and_return(nil)
  end

  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe)
  end

  shared_examples_for 'default recipe' do
    it 'starts the service' do
      expect(chef_run).to start_service('nginx')
    end
  end

  context 'unmodified attributes' do
    it 'includes the package recipe' do
      expect(chef_run).to include_recipe('chef_nginx::package')
    end

    it 'does not include a module recipe' do
      expect(chef_run).to_not include_recipe('http_stub_status_module')
    end

    it_behaves_like 'default recipe'
  end

  context 'source install set' do
    it 'includes the source recipe' do
      chef_run.node.normal['nginx']['install_method'] = 'source'
      chef_run.converge(described_recipe)

      expect(chef_run).to include_recipe('chef_nginx::source')
    end

    it_behaves_like 'default recipe'
  end

  context 'installs modules based on attributes' do
    it 'includes a module recipe when specified' do
      chef_run.node.normal['nginx']['default']['modules'] = ['http_ssl_module']
      chef_run.converge(described_recipe)

      expect(chef_run).to include_recipe('chef_nginx::http_ssl_module')
    end
  end
end

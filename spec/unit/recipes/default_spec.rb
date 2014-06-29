require 'spec_helper'

describe 'nginx::default' do
  let(:chef_run) { ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0').converge(described_recipe) }

  it 'loads the ohai plugin' do
    expect(chef_run).to include_recipe('nginx::ohai_plugin')
  end

  it 'builds from source when specified' do
    chef_run.node.set['nginx']['install_method'] = 'source'
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('nginx::source')
  end

  context 'configured to install by package' do
    context 'in a redhat-based platform' do
      let(:chef_run) { ChefSpec::Runner.new(:platform => 'redhat', :version  => '6.3').converge(described_recipe) }

      it 'includes the yum-epel recipe if the source is epel' do
        chef_run.node.set['nginx']['repo_source'] = 'epel'
        chef_run.converge(described_recipe)
        expect(chef_run).to include_recipe('yum-epel')
      end

      it 'includes the nginx::repo recipe if the source is not epel' do
        chef_run.node.set['nginx']['repo_source'] = 'nginx'
        chef_run.converge(described_recipe)
        expect(chef_run).to include_recipe('nginx::repo')
      end
    end

    it 'installs the package' do
      expect(chef_run).to install_package('nginx')
    end

    it 'enables the service' do
      expect(chef_run).to enable_service('nginx')
    end

    it 'executes common nginx configuration' do
      expect(chef_run).to include_recipe('nginx::commons')
    end
  end

  it 'starts the service' do
    expect(chef_run).to start_service('nginx')
  end
end

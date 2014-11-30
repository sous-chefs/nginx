# encoding: utf-8
require 'spec_helper'

describe 'nginx::package' do
  before do
    stub_command('which nginx').and_return(nil)
  end

  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      :platform => 'debian',
      :version => '7.0'
    ).converge(described_recipe)
  end

  shared_examples_for 'all platforms' do
    it 'includes the ohai_plugin recipe' do
      expect(chef_run).to include_recipe('nginx::ohai_plugin')
    end

    it 'includes the commons recipe' do
      expect(chef_run).to include_recipe('nginx::commons')
    end

    it 'enables the nginx service' do
      expect(chef_run).to enable_service('nginx')
    end
  end

  shared_examples_for 'nginx repo' do
    it 'includes the nginx repo recipe' do
      expect(chef_run).to include_recipe('nginx::repo')
    end
  end

  shared_examples_for 'package resource' do
    it 'installs the nginx package' do
      expect(chef_run).to install_package('nginx')
    end
  end

  context 'default attributes' do
    it_behaves_like 'all platforms'
    it_behaves_like 'package resource'
  end

  context 'debian platform family' do
    context 'default attributes' do
      it_behaves_like 'all platforms'
      it_behaves_like 'package resource'
    end

    context 'modified attributes' do
      before do
        chef_run.node.set['nginx']['repo_source'] = 'nginx'
        chef_run.converge(described_recipe)
      end

      it_behaves_like 'all platforms'
      it_behaves_like 'nginx repo'
      it_behaves_like 'package resource'
    end
  end

  context 'rhel platform family' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        :platform => 'redhat',
        :version => '6.5'
      ).converge(described_recipe)
    end

    context 'default attributes' do
      it 'includes yum-epel recipe' do
        expect(chef_run).to include_recipe('yum-epel')
      end

      it_behaves_like 'all platforms'
      it_behaves_like 'package resource'
    end

    context 'modified attributes' do
      before do
        chef_run.node.set['nginx']['repo_source'] = 'nginx'
        chef_run.converge(described_recipe)
      end

      it 'installs the nginx package with modifiers' do
        expect(chef_run).to install_package('nginx').with(
          :options => '--disablerepo=* --enablerepo=nginx'
        )
      end

      it_behaves_like 'all platforms'
      it_behaves_like 'nginx repo'
    end

    context 'no extra repos added when empty' do
      before do
        chef_run.node.set['nginx']['repo_source'] = ''
        chef_run.converge(described_recipe)
      end

      it 'installs the nginx package with modifiers' do
        expect(chef_run).to install_package('nginx')
      end

      it 'logs a message about repo_source' do
        expect(chef_run).to write_log(
          "node['nginx']['repo_source'] was not set, no additional yum repositories will be installed."
        ).with(level: :debug)
      end

      it_behaves_like 'all platforms'
      it_behaves_like 'package resource'
    end
  end
end

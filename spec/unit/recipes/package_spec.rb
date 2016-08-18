require 'spec_helper'

describe 'chef_nginx::package' do
  before do
    stub_command('which nginx').and_return(nil)
  end

  cached(:chef_run) do
    ChefSpec::ServerRunner.new(
      platform: 'debian',
      version: '8.5'
    ).converge(described_recipe)
  end

  shared_examples_for 'all platforms' do
    it 'includes the ohai_plugin recipe' do
      expect(chef_run).to include_recipe('chef_nginx::ohai_plugin')
    end

    it 'includes the commons recipe' do
      expect(chef_run).to include_recipe('chef_nginx::commons')
    end

    it 'enables the nginx service' do
      expect(chef_run).to enable_service('nginx')
    end
  end

  shared_examples_for 'nginx repo' do
    it 'includes the nginx repo recipe' do
      expect(chef_run).to include_recipe('chef_nginx::repo')
    end
  end

  shared_examples_for 'package resource' do
    it 'installs the nginx package' do
      expect(chef_run).to install_package('nginx')
    end

    it 'reloads ohai' do
      expect(chef_run.package('nginx')).to notify('ohai[reload_nginx]').to(:reload).immediately
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
        chef_run.node.normal['nginx']['repo_source'] = 'nginx'
        chef_run.converge(described_recipe)
      end

      it_behaves_like 'all platforms'
      it_behaves_like 'nginx repo'
      it_behaves_like 'package resource'
    end
  end

  context 'fedora platform family' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(
        platform: 'fedora',
        version: '24'
      ).converge(described_recipe)
    end

    # epel should not be used on fedora since epel is basically fedora packages
    # backported to RHEL
    it 'does not include yum-epel recipe' do
      expect(chef_run).to_not include_recipe('yum-epel')
    end
  end

  context 'rhel platform family' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(
        platform: 'centos',
        version: '6.8'
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
        chef_run.node.normal['nginx']['repo_source'] = 'nginx'
        chef_run.converge(described_recipe)
      end

      it 'installs the nginx package with modifiers' do
        expect(chef_run).to install_package('nginx').with(
          options: '--disablerepo=* --enablerepo=nginx'
        )
      end

      it_behaves_like 'all platforms'
      it_behaves_like 'nginx repo'
    end

    context 'no extra repos added when empty' do
      before do
        chef_run.node.normal['nginx']['repo_source'] = ''
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

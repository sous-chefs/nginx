require 'spec_helper'

describe 'nginx::package' do
  let(:chef_run) do
    ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0').converge(described_recipe)
  end
  before do
    stub_command('which nginx').and_return(nil)
  end

  it 'includes the ohai plugin' do
    expect(chef_run).to include_recipe('nginx::ohai_plugin')
  end

  context 'not configured to use Nginx/Epel repo' do
    it 'doesn\'t includes the Nginx or Epel repo recipe' do
      expect(chef_run).to_not include_recipe('nginx::repo')
      expect(chef_run).to_not include_recipe('yum-epel')
    end
  end

  context 'Debian platform family' do
    context 'configured to use Nginx repo' do
      let(:chef_run) do
        ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do | node |
          node.set['nginx']['repo_source'] = 'nginx'
        end.converge(described_recipe)
      end
      it 'includes the Nginx repo recipe' do
        expect(chef_run).to include_recipe('nginx::repo')
      end
    end
  end
  context 'Red Hat platform family' do
    context 'configured to use Nginx repo' do
      let(:chef_run) do
        ChefSpec::Runner.new(:platform => 'centos', :version  => '6.5') do | node |
          node.set['nginx']['repo_source'] = 'nginx'
        end.converge(described_recipe)
      end
      it 'includes the Nginx repo recipe' do
        expect(chef_run).to include_recipe('nginx::repo')
      end
      it 'configures package resource to exclude default repo and install it' do
        expect(chef_run).to install_package('nginx').with(:options => '--disablerepo=* --enablerepo=nginx')
      end
    end
    context 'configured to use Epel repo' do
      let(:chef_run) do
        ChefSpec::Runner.new(:platform => 'centos', :version  => '6.5') do | node |
          node.set['nginx']['repo_source'] = 'epel'
        end.converge(described_recipe)
      end
      it 'includes the yum-epel recipe' do
        expect(chef_run).to include_recipe('yum-epel')
      end
    end
  end

  it 'installs nginx package' do
    expect(chef_run).to install_package('nginx')
  end

  it 'enables the nginx service' do
    expect(chef_run).to enable_service('nginx')
  end

  it 'includes the nginx common recipe' do
    expect(chef_run).to include_recipe('nginx::commons')
  end

end

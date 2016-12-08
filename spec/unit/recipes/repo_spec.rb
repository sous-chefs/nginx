require 'spec_helper'

describe 'chef_nginx::repo' do
  context 'Ubuntu' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe)
    end

    it 'adds apt repository' do
      expect(chef_run).to add_apt_repository('nginx')
    end
  end

  context 'Debian' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'debian', version: '8.6').converge(described_recipe)
    end

    it 'adds apt repository' do
      expect(chef_run).to add_apt_repository('nginx')
    end
  end

  context 'SUSE' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'opensuse', version: '13.2').converge(described_recipe)
    end

    it 'adds zypper repository' do
      expect(chef_run).to add_zypper_repo('nginx')
    end
  end

  context 'RHEL' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '6.8').converge(described_recipe)
    end

    it 'adds yum repository' do
      expect(chef_run).to create_yum_repository('nginx')
    end
  end

  context 'Fedora' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'fedora', version: '24').converge(described_recipe)
    end

    it "logs a message that the repo doesn't support Fedora" do
      expect(chef_run).to write_log(
        'nginx.org does not maintain packages for platform fedora. Cannot setup the upstream repo!'
      ).with(level: :warn)
    end
  end
end

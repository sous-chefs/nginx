require 'spec_helper'

describe 'nginx::repo' do
  context 'Ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'ubuntu', version: '16.04'
      ).converge(described_recipe)
    end

    it 'adds apt repository' do
      expect(chef_run).to add_apt_repository('nginx').with(
        uri: 'https://nginx.org/packages/ubuntu',
        key: ['https://nginx.org/keys/nginx_signing.key']
      )
    end
  end

  context 'Debian' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'debian', version: '8.9'
      ).converge(described_recipe)
    end

    it 'adds apt repository' do
      expect(chef_run).to add_apt_repository('nginx').with(
        uri: 'https://nginx.org/packages/debian',
        key: ['https://nginx.org/keys/nginx_signing.key']
      )
    end
  end

  # disable until chefspec generation handles the double provides in the resource
  # context 'SUSE' do
  #   let(:chef_run) do
  #     ChefSpec::SoloRunner.new(
  #       platform: 'opensuse', version: '42.3'
  #     ).converge(described_recipe)
  #   end
  #
  #   it 'adds zypper repository' do
  #     expect(chef_run).to add_zypper_repository('nginx').with(
  #       baseurl: 'http://nginx.org/packages/sles/12',
  #       gpgkey: 'http://nginx.org/keys/nginx_signing.key'
  #     )
  #   end
  # end

  context 'RHEL' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos', version: '6.9'
      ).converge(described_recipe)
    end

    it 'adds yum repository' do
      expect(chef_run).to create_yum_repository('nginx')
    end
  end

  context 'Fedora' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'fedora', version: '26'
      ).converge(described_recipe)
    end

    it "logs a message that the repo doesn't support Fedora" do
      expect(chef_run).to write_log(
        'nginx.org does not maintain packages for platform fedora. Cannot setup the upstream repo!'
      ).with(level: :warn)
    end
  end
end

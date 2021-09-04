require 'spec_helper'

RSpec.describe Nginx::Cookbook::Helpers do
  class DummyClass < Chef::Node
    include Nginx::Cookbook::Helpers
  end

  subject { DummyClass.new }

  describe '#nginx_binary' do
    it { expect(subject.nginx_binary).to eq '/usr/sbin/nginx' }
  end

  describe '#repo_url' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
    end

    context 'with amazon family stable' do
      before do
        allow(subject).to receive(:[]).with('platform').and_return(platform)
      end

      let(:platform_family) { 'amazon' }
      let(:platform) { 'amazon' }

      it { expect(subject.repo_url).to eq 'https://nginx.org/packages/rhel/7/$basearch' }
    end

    context 'with rhel family stable' do
      before do
        allow(subject).to receive(:[]).with('platform').and_return(platform)
        allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
      end

      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }

      context 'with centos platform stable' do
        let(:platform) { 'centos' }

        it { expect(subject.repo_url).to eq 'https://nginx.org/packages/centos/7/$basearch' }
      end

      context 'with redhat platform stable' do
        let(:platform) { 'redhat' }

        it { expect(subject.repo_url).to eq 'https://nginx.org/packages/rhel/7/$basearch' }
      end
    end

    context 'with fedora family stable' do
      before do
        allow(subject).to receive(:[]).with('platform').and_return(platform)
      end

      let(:platform_family) { 'fedora' }
      let(:platform) { 'fedora' }

      it { expect(subject.repo_url).to eq 'https://nginx.org/packages/rhel/8/$basearch' }
    end

    context 'with debian family stable' do
      before do
        allow(subject).to receive(:[]).with('platform').and_return(platform)
      end

      let(:platform_family) { 'debian' }

      context 'with debian platform stable' do
        let(:platform) { 'debian' }

        it { expect(subject.repo_url).to eq 'https://nginx.org/packages/debian' }
      end

      context 'with ubuntu platform stable' do
        let(:platform) { 'ubuntu' }

        it { expect(subject.repo_url).to eq 'https://nginx.org/packages/ubuntu' }
      end
    end

    context 'with suse family stable' do
      before do
        allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
      end

      context 'with suse 12 family stable' do
        let(:platform_family) { 'suse' }
        let(:platform_version) { '12' }

        it { expect(subject.repo_url).to eq 'https://nginx.org/packages/sles/12' }
      end

      context 'with suse 15 family stable' do
        let(:platform_family) { 'suse' }
        let(:platform_version) { '15' }

        it { expect(subject.repo_url).to eq 'https://nginx.org/packages/sles/15' }
      end
    end

    context 'with amazon family stable' do
      before do
        allow(subject).to receive(:[]).with('platform').and_return(platform)
      end

      let(:platform_family) { 'amazon' }
      let(:platform) { 'amazon' }

      it { expect(subject.repo_url).to eq 'https://nginx.org/packages/rhel/7/$basearch' }
    end

    context 'with rhel family mainline' do
      before do
        allow(subject).to receive(:[]).with('platform').and_return(platform)
        allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
      end

      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }

      context 'with centos platform mainline' do
        let(:platform) { 'centos' }

        it { expect(subject.repo_url('mainline')).to eq 'https://nginx.org/packages/mainline/centos/7/$basearch' }
      end

      context 'with redhat platform mainline' do
        let(:platform) { 'redhat' }

        it { expect(subject.repo_url('mainline')).to eq 'https://nginx.org/packages/mainline/rhel/7/$basearch' }
      end
    end

    context 'with fedora family mainline' do
      before do
        allow(subject).to receive(:[]).with('platform').and_return(platform)
      end

      let(:platform_family) { 'fedora' }
      let(:platform) { 'fedora' }

      it { expect(subject.repo_url('mainline')).to eq 'https://nginx.org/packages/mainline/rhel/8/$basearch' }
    end

    context 'with debian family mainline' do
      before do
        allow(subject).to receive(:[]).with('platform').and_return(platform)
      end

      let(:platform_family) { 'debian' }

      context 'with debian platform mainline' do
        let(:platform) { 'debian' }

        it { expect(subject.repo_url('mainline')).to eq 'https://nginx.org/packages/mainline/debian' }
      end

      context 'with ubuntu platform mainline' do
        let(:platform) { 'ubuntu' }

        it { expect(subject.repo_url('mainline')).to eq 'https://nginx.org/packages/mainline/ubuntu' }
      end
    end

    context 'with suse family mainline' do
      before do
        allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
      end

      context 'with suse 12 family mainline' do
        let(:platform_family) { 'suse' }
        let(:platform_version) { '12' }

        it { expect(subject.repo_url('mainline')).to eq 'https://nginx.org/packages/mainline/sles/12' }
      end

      context 'with suse 15 family mainline' do
        let(:platform_family) { 'suse' }
        let(:platform_version) { '15' }

        it { expect(subject.repo_url('mainline')).to eq 'https://nginx.org/packages/mainline/sles/15' }
      end
    end
  end

  describe '#repo_signing_key' do
    it { expect(subject.repo_signing_key).to eq 'https://nginx.org/keys/nginx_signing.key' }
  end

  describe '#nginx_dir' do
    it { expect(subject.nginx_dir).to eq '/etc/nginx' }
  end

  describe '#nginx_log_dir' do
    it { expect(subject.nginx_log_dir).to eq '/var/log/nginx' }
  end

  describe '#nginx_user' do
    before do
      allow(subject).to receive(:[]).with(:platform_family).and_return(platform_family)
    end

    context 'with amazon family' do
      let(:platform_family) { 'amazon' }

      it { expect(subject.nginx_user).to eq 'nginx' }
    end

    context 'with debian family' do
      let(:platform_family) { 'debian' }

      it { expect(subject.nginx_user).to eq 'root' }
    end

    context 'with fedora family' do
      let(:platform_family) { 'fedora' }

      it { expect(subject.nginx_user).to eq 'nginx' }
    end

    context 'with rhel family' do
      let(:platform_family) { 'rhel' }

      it { expect(subject.nginx_user).to eq 'nginx' }
    end

    context 'with suse family' do
      let(:platform_family) { 'suse' }

      it { expect(subject.nginx_user).to eq 'nginx' }
    end
  end

  describe '#nginx_group' do
    before do
      allow(subject).to receive(:[]).with(:platform_family).and_return(platform_family)
    end

    context 'with amazon family' do
      let(:platform_family) { 'amazon' }

      it { expect(subject.nginx_group).to eq 'nginx' }
    end

    context 'with debian family' do
      let(:platform_family) { 'debian' }

      it { expect(subject.nginx_group).to eq 'root' }
    end

    context 'with fedora family' do
      let(:platform_family) { 'fedora' }

      it { expect(subject.nginx_group).to eq 'nginx' }
    end

    context 'with rhel family' do
      let(:platform_family) { 'rhel' }

      it { expect(subject.nginx_group).to eq 'nginx' }
    end

    context 'with suse family' do
      let(:platform_family) { 'suse' }

      it { expect(subject.nginx_group).to eq 'nginx' }
    end
  end

  describe '#nginx_pid_file' do
    it { expect(subject.nginx_pid_file).to eq '/run/nginx.pid' }
  end

  describe '#nginx_script_dir' do
    it { expect(subject.nginx_script_dir).to eq '/usr/sbin' }
  end

  describe '#default_root' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
    end

    context 'with debian family' do
      let(:platform_family) { 'debian' }

      it { expect(subject.default_root).to eq '/var/www/html' }
    end

    context 'with redhat family' do
      let(:platform_family) { 'rhel' }

      it { expect(subject.default_root).to eq '/usr/share/nginx/html' }
    end
  end
end

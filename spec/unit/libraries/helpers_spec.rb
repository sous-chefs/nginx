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

    context 'with amazon family' do
      before do
        allow(subject).to receive(:[]).with('platform').and_return(platform)
      end

      let(:platform_family) { 'amazon' }
      let(:platform) { 'amazon' }

      it { expect(subject.repo_url).to eq 'https://nginx.org/packages/rhel/7/$basearch' }
    end

    context 'with rhel family' do
      before do
        allow(subject).to receive(:[]).with('platform').and_return(platform)
        allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
      end

      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }

      context 'with centos platform' do
        let(:platform) { 'centos' }

        it { expect(subject.repo_url).to eq 'https://nginx.org/packages/centos/7/$basearch' }
      end

      context 'with redhat platform' do
        let(:platform) { 'redhat' }

        it { expect(subject.repo_url).to eq 'https://nginx.org/packages/rhel/7/$basearch' }
      end
    end

    context 'with fedora family' do
      before do
        allow(subject).to receive(:[]).with('platform').and_return(platform)
      end

      let(:platform_family) { 'fedora' }
      let(:platform) { 'fedora' }

      it { expect(subject.repo_url).to eq 'https://nginx.org/packages/rhel/7/$basearch' }
    end

    context 'with debian family' do
      before do
        allow(subject).to receive(:[]).with('platform').and_return(platform)
      end

      let(:platform_family) { 'debian' }

      context 'with debian platform' do
        let(:platform) { 'debian' }

        it { expect(subject.repo_url).to eq 'https://nginx.org/packages/debian' }
      end

      context 'with ubuntu platform' do
        let(:platform) { 'ubuntu' }

        it { expect(subject.repo_url).to eq 'https://nginx.org/packages/ubuntu' }
      end
    end

    context 'with suse family' do
      let(:platform_family) { 'suse' }

      it { expect(subject.repo_url).to eq 'https://nginx.org/packages/sles/12' }
    end
  end

  describe '#repo_signing_key' do
    it { expect(subject.repo_signing_key).to eq 'https://nginx.org/keys/nginx_signing.key' }
  end
end

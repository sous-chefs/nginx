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

      it { expect(subject.nginx_user).to eq 'www-data' }
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

  describe '#nginx_pid_file' do
    it { expect(subject.nginx_pid_file).to eq '/run/nginx.pid' }
  end

  describe '#nginx_script_dir' do
    it { expect(subject.nginx_script_dir).to eq '/usr/sbin' }
  end

  describe '#default_root' do
    it { expect(subject.default_root).to eq '/var/www/nginx-default' }
  end

  describe '#site_enabled?' do
    it do
      allow(File).to receive(:symlink?).and_call_original
      allow(File).to receive(:symlink?).with('/etc/nginx/sites-enabled/000-default').and_return(true)

      expect(subject.site_enabled?('default')).to eq true
    end
  end

  describe '#site_available?' do
    it do
      allow(File).to receive(:exist?).and_call_original
      allow(File).to receive(:exist?).with('/etc/nginx/sites-available/default').and_return(true)

      expect(subject.site_available?('default')).to eq true
    end
  end

  describe '#passenger_packages' do
    context 'with debian family' do
      before do
        allow(subject).to receive(:[]).with(:platform_family).and_return(platform_family)
        allow(subject).to receive(:[]).with(:platform).and_return(platform)
        allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
      end

      let(:platform_family) { 'debian' }

      context 'with debian platform' do
        let(:platform) { 'debian' }

        context 'with version 8' do
          let(:platform_version) { '8' }

          it { expect(subject.passenger_packages).to eq %w(ruby-dev libcurl4-gnutls-dev passenger) }
        end

        context 'with version 9' do
          let(:platform_version) { '9' }

          it { expect(subject.passenger_packages).to eq %w(ruby-dev libcurl4-gnutls-dev libnginx-mod-http-passenger) }
        end
      end

      context 'with ubuntu platform' do
        let(:platform) { 'ubuntu' }

        context 'with version 16.04' do
          let(:platform_version) { '16.04' }

          it { expect(subject.passenger_packages).to eq %w(ruby-dev libcurl4-gnutls-dev passenger) }
        end

        context 'with version 18.04' do
          let(:platform_version) { '18.04' }

          it { expect(subject.passenger_packages).to eq %w(ruby-dev libcurl4-gnutls-dev libnginx-mod-http-passenger) }
        end
      end
    end
  end

  describe '#passenger_conf_file' do
    context 'with debian family' do
      before do
        allow(subject).to receive(:[]).with(:platform_family).and_return(platform_family)
        allow(subject).to receive(:[]).with(:platform).and_return(platform)
        allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
      end

      let(:platform_family) { 'debian' }

      context 'with debian platform' do
        let(:platform) { 'debian' }

        context 'with version 8' do
          let(:platform_version) { '8' }

          it { expect(subject.passenger_conf_file).to eq '/etc/nginx/conf.d/passenger.conf' }
        end

        context 'with version 9' do
          let(:platform_version) { '9' }

          it { expect(subject.passenger_conf_file).to eq '/etc/nginx/conf.d/mod-http-passenger.conf' }
        end
      end

      context 'with ubuntu platform' do
        let(:platform) { 'ubuntu' }

        context 'with version 16.04' do
          let(:platform_version) { '16.04' }

          it { expect(subject.passenger_conf_file).to eq '/etc/nginx/conf.d/passenger.conf' }
        end

        context 'with version 18.04' do
          let(:platform_version) { '18.04' }

          it { expect(subject.passenger_conf_file).to eq '/etc/nginx/conf.d/mod-http-passenger.conf' }
        end
      end
    end
  end
end

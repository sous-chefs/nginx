require 'spec_helper'

describe 'nginx_install' do
  step_into :nginx_install

  context 'with default properties' do
    shared_examples_for 'ohai is enabled' do
      it { is_expected.to nothing_ohai('reload_nginx').with_plugin('nginx') }
      it { is_expected.to create_ohai_plugin('nginx').with_variables(binary: '/usr/sbin/nginx') }
    end

    let(:package_install_options) { nil }

    shared_examples_for 'nginx package is installed' do
      it { is_expected.to install_package('nginx').with_options(package_install_options) }
      it { expect(chef_run.package('nginx')).to notify('ohai[reload_nginx]').to(:reload).immediately }
    end

    context 'with distro source' do
      recipe do
        nginx_install 'distro'
      end

      context 'with debian platform' do
        platform 'debian'

        include_examples 'ohai is enabled'
        include_examples 'nginx package is installed'
      end

      context 'with fedora platform' do
        platform 'fedora'

        include_examples 'ohai is enabled'
        include_examples 'nginx package is installed'
      end

      context 'with opensuse platform' do
        platform 'opensuse'

        include_examples 'ohai is enabled'
        include_examples 'nginx package is installed'
      end

      context 'with ubuntu platform' do
        platform 'ubuntu'

        include_examples 'ohai is enabled'
        include_examples 'nginx package is installed'
      end
    end

    context 'with repo source' do
      recipe do
        nginx_install 'repo'
      end

      shared_examples_for 'yum repository is created' do
        it do
          is_expected.to create_yum_repository('nginx')
            .with_baseurl(repo_url)
            .with_gpgkey(repo_signing_key)
        end
      end

      shared_examples_for 'apt repository is added' do
        it do
          is_expected.to add_apt_repository('nginx')
            .with_uri(repo_url)
            .with_distribution(platform_distribution)
            .with_components(%w(nginx))
            .with_deb_src(true)
            .with_key([repo_signing_key])
        end
      end

      context 'with amazon platform' do
        platform 'amazon'

        let(:package_install_options) { ['--disablerepo=*', '--enablerepo=nginx'] }

        include_examples 'ohai is enabled'
        include_examples 'yum repository is created'
        include_examples 'nginx package is installed'
      end

      context 'with centos platform' do
        platform 'centos'

        let(:package_install_options) { ['--disablerepo=*', '--enablerepo=nginx'] }

        include_examples 'ohai is enabled'
        include_examples 'yum repository is created'
        include_examples 'nginx package is installed'
      end

      context 'with debian platform' do
        platform 'debian'

        include_examples 'ohai is enabled'
        include_examples 'apt repository is added'
        include_examples 'nginx package is installed'
      end

      context 'with fedora platform' do
        platform 'fedora'

        include_examples 'ohai is enabled'
        include_examples 'yum repository is created'
        include_examples 'nginx package is installed'
      end

      context 'with opensuse platform' do
        platform 'opensuse'

        include_examples 'ohai is enabled'
        include_examples 'nginx package is installed'

        it do
          is_expected.to create_zypper_repository('nginx')
            .with_baseurl(repo_url)
            .with_gpgkey(repo_signing_key)
        end
      end

      context 'with ubuntu platform' do
        platform 'ubuntu'

        include_examples 'ohai is enabled'
        include_examples 'apt repository is added'
        include_examples 'nginx package is installed'
      end
    end

    context 'with epel source' do
      recipe do
        nginx_install 'epel'
      end

      context 'with amazon platform' do
        platform 'amazon'

        include_examples 'ohai is enabled'
        include_examples 'nginx package is installed'

        it { is_expected.to run_execute('amazon-linux-extras install epel') }
      end

      context 'with centos platform' do
        platform 'centos'

        include_examples 'ohai is enabled'
        include_examples 'nginx package is installed'

        it { is_expected.to install_package('epel-release') }
      end
    end
  end
end

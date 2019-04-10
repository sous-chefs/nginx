require 'spec_helper'

describe 'nginx_install' do
  step_into :nginx_install

  context 'with default properties' do
    shared_examples_for 'ohai is enabled' do
      it { is_expected.to nothing_ohai('reload_nginx').with_plugin('nginx') }
      it { is_expected.to create_ohai_plugin('nginx').with_variables(binary: '/usr/sbin/nginx') }
    end

    shared_examples_for 'nginx package is installed' do
      it { is_expected.to install_package('nginx') }
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
  end
end

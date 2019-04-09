require 'spec_helper'

describe 'nginx_install' do
  step_into :nginx_install

  context 'with default properties' do
    recipe do
      nginx_install 'default'
    end

    shared_examples_for 'ohai is enabled' do
      it { is_expected.to nothing_ohai('reload_nginx').with_plugin('nginx') }
      it { is_expected.to create_ohai_plugin('nginx').with_variables(binary: '/usr/sbin/nginx') }
    end

    context 'with amazon platform' do
      platform 'amazon'

      include_examples 'ohai is enabled'
    end

    context 'with centos platform' do
      platform 'centos'

      include_examples 'ohai is enabled'
    end

    context 'with debian platform' do
      platform 'debian'

      include_examples 'ohai is enabled'
    end

    context 'with fedora platform' do
      platform 'fedora'

      include_examples 'ohai is enabled'
    end

    context 'with opensuse platform' do
      platform 'opensuse'

      include_examples 'ohai is enabled'
    end

    context 'with ubuntu platform' do
      platform 'ubuntu'

      include_examples 'ohai is enabled'
    end
  end
end

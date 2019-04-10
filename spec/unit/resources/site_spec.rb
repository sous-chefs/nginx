require 'spec_helper'

describe 'nginx_site' do
  step_into :nginx_site, :nginx_install
  platform  'ubuntu'

  before do
    allow(File).to receive(:exist?).and_call_original
    allow(File).to receive(:exist?).with('/etc/nginx/sites-available/default').and_return(true)
  end

  shared_examples_for 'enable default site' do
    it { is_expected.to run_execute('nxensite default') }
    it { expect(chef_run.execute('nxensite default')).to notify('service[nginx]').to(:reload).delayed }
  end

  context 'with default properties' do
    recipe do
      nginx_install 'distro'
      nginx_site    'default'
    end

    include_examples 'enable default site'
  end

  context 'with template' do
    recipe do
      nginx_install 'distro'

      nginx_site 'default' do
        template 'default-site.erb'
      end
    end

    it { is_expected.to create_template('/etc/nginx/sites-available/default').with_source('default-site.erb') }
    include_examples 'enable default site'
  end

  context 'disable site' do
    before do
      allow(File).to receive(:symlink?).and_call_original
      allow(File).to receive(:symlink?).with('/etc/nginx/sites-enabled/default').and_return(true)
    end

    recipe do
      nginx_install 'distro'

      nginx_site 'default' do
        action :disable
      end
    end

    it { is_expected.to run_execute('nxdissite default') }
    it { expect(chef_run.execute('nxdissite default')).to notify('service[nginx]').to(:reload).delayed }
  end
end

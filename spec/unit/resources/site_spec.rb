require 'spec_helper'

describe 'nginx_site' do
  step_into :nginx_site, :nginx_install
  platform  'ubuntu'

  before do
    stub_command('/usr/sbin/nginx -t').and_return(true)
  end

  context 'with default properties' do
    recipe do
      nginx_install 'distro'
      nginx_site    'default'
    end
  end

  context 'with template' do
    recipe do
      nginx_install 'distro'

      nginx_site 'default' do
        template 'default-site.erb'
      end

      nginx_site 'disabled' do
        template 'default-site.erb'
        action [:create, :disable]
      end
    end

    it { is_expected.to create_template('/etc/nginx/conf.http.d/default.conf').with_source('default-site.erb') }
    it { is_expected.to create_template('/etc/nginx/conf.http.d/disabled.conf').with_source('default-site.erb') }
    it { is_expected.to nothing_ruby_block('Disable site disabled') }
    it { is_expected.to create_template('/etc/nginx/conf.http.d/list.conf').with_source('list.conf.erb') }
  end

  context 'delete site' do
    recipe do
      nginx_install 'distro'

      nginx_site 'default' do
        action :delete
      end
    end

    it { is_expected.to delete_file('/etc/nginx/conf.http.d/default.conf') }
  end

  context 'config_file method accessibility' do
    recipe do
      nginx_install 'distro'

      site = nginx_site 'test-site' do
        conf_dir '/etc/nginx/sites-available'
        action :create
      end

      # This tests the new functionality - accessing config_file on the resource instance
      ruby_block 'test_config_file_access' do
        block do
          expected_path = '/etc/nginx/sites-available/test-site.conf'
          actual_path = site.config_file
          raise "Expected #{expected_path}, got #{actual_path}" unless actual_path == expected_path
        end
        action :run
      end
    end

    it { is_expected.to create_template('/etc/nginx/sites-available/test-site.conf') }
    it { is_expected.to run_ruby_block('test_config_file_access') }
  end
end

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
    end

    it { is_expected.to create_template('/etc/nginx/conf.http.d/default.conf').with_source('default-site.erb') }
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
end

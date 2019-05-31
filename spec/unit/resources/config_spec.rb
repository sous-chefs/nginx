require 'spec_helper'

describe 'nginx_config' do
  step_into :nginx_config, :nginx_install
  platform  'ubuntu'

  context 'with default properties' do
    recipe do
      nginx_install 'distro'
      nginx_config 'default'
    end

    it do
      is_expected.to create_template('/etc/nginx/nginx.conf')
        .with_cookbook('nginx')
        .with_source('nginx.conf.erb')
        .with_variables(
          nginx_dir: '/etc/nginx',
          nginx_log_dir: '/var/log/nginx',
          nginx_user: 'www-data',
          group: 'www-data',
          worker_processes: 'auto',
          pid: '/run/nginx.pid',
          worker_connections: '1024',
          sendfile: 'on',
          tcp_nopush: 'on',
          tcp_nodelay: 'on',
          keepalive_timeout: '65',
          types_hash_max_size: '2048'
        )
    end

    it { expect(chef_run.template('/etc/nginx/nginx.conf')).to notify('service[nginx]').to(:reload).delayed }
  end
end

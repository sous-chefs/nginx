require 'spec_helper'

describe 'nginx_config' do
  step_into :nginx_config, :nginx_install, :nginx_site
  platform 'centos'

  before do
    stub_command('/usr/sbin/nginx -t').and_return(true)
  end

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
          process_user: 'nginx',
          process_group: 'nginx',
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

    it do
      is_expected.to create_template('/etc/nginx/conf.http.d/default-site.conf')
        .with_cookbook('nginx')
        .with_source('default-site.erb')
        .with_variables(
          name: 'default-site',
          nginx_log_dir: '/var/log/nginx',
          port: '80',
          server_name: 'Fauxhai',
          default_root: '/usr/share/nginx/html'
        )
    end

    it { is_expected.to create_directory('/var/log/nginx').with_mode('0750').with_owner('nginx') }
    it { is_expected.to create_directory('/etc/nginx/conf.d').with_mode('0750') }
    it { is_expected.to create_directory('/etc/nginx/conf.http.d').with_mode('0750') }
  end
end

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

    shared_examples_for 'common directories are created' do
      it { is_expected.to create_directory('/etc/nginx').with_mode('0755') }
      it { is_expected.to create_directory('/var/log/nginx').with_mode('0750').with_owner(nginx_user) }
      it { is_expected.to create_directory('/etc/nginx/sites-available').with_mode('0755') }
      it { is_expected.to create_directory('/etc/nginx/sites-enabled').with_mode('0755') }
      it { is_expected.to create_directory('/etc/nginx/conf.d').with_mode('0755') }
      it { is_expected.to create_directory('/etc/nginx/streams-available').with_mode('0755') }
      it { is_expected.to create_directory('/etc/nginx/streams-enabled').with_mode('0755') }
    end

    shared_examples_for 'delete conf.d files' do
      it { is_expected.to delete_file('/etc/nginx/conf.d/default.conf') }
      it { is_expected.to delete_file('/etc/nginx/conf.d/example_ssl.conf') }
    end

    shared_examples_for 'common scripts are created' do
      it { is_expected.to create_template('/usr/sbin/nxensite').with_mode('0755').with_variables(nginx_dir: '/etc/nginx') }
      it { is_expected.to create_template('/usr/sbin/nxdissite').with_mode('0755').with_variables(nginx_dir: '/etc/nginx') }
      it { is_expected.to create_template('/usr/sbin/nxenstream').with_mode('0755').with_variables(nginx_dir: '/etc/nginx') }
      it { is_expected.to create_template('/usr/sbin/nxdisstream').with_mode('0755').with_variables(nginx_dir: '/etc/nginx') }
    end

    shared_examples_for 'common conf is created' do
      it do
        is_expected.to create_nginx_config('/etc/nginx/nginx.conf')
          .with_conf_cookbook('nginx')
          .with_conf_template('nginx.conf.erb')
          .with_conf_variables({})
          .with_group(nginx_user)
          .with_worker_processes('auto')
          .with_worker_connections('1024')
          .with_sendfile('on')
          .with_tcp_nopush('on')
          .with_tcp_nodelay('on')
          .with_keepalive_timeout('65')
          .with_types_hash_max_size('2048')
      end

      it do
        is_expected.to create_template('/etc/nginx/sites-available/default')
          .with_cookbook('nginx')
          .with_source('default-site.erb')
          .with_variables(
            nginx_log_dir: '/var/log/nginx',
            port:          '80',
            server_name:   'Fauxhai',
            default_root:  '/var/www/nginx-default'
          )
      end

      it { expect(chef_run.template('/etc/nginx/sites-available/default')).to notify('service[nginx]').to(:reload).delayed }
      it { is_expected.to enable_nginx_site('default') }
    end

    context 'with distro source' do
      recipe do
        nginx_install 'distro'
      end

      context 'with amazon platform' do
        platform 'amazon'

        include_examples 'ohai is enabled'
        include_examples 'common directories are created'
        include_examples 'common scripts are created'
        include_examples 'common conf is created'

        it { is_expected.to run_execute('amazon-linux-extras install nginx1.12') }
        it { expect(chef_run.execute('amazon-linux-extras install nginx1.12')).to notify('ohai[reload_nginx]').to(:reload).immediately }
        it { is_expected.to delete_file('/etc/nginx/conf.d/default.conf') }
        it { is_expected.to delete_file('/etc/nginx/conf.d/example_ssl.conf') }
      end

      context 'with debian platform' do
        platform 'debian'

        include_examples 'ohai is enabled'
        include_examples 'nginx package is installed'
        include_examples 'common directories are created'
        include_examples 'common scripts are created'
        include_examples 'common conf is created'
      end

      context 'with opensuse platform' do
        platform 'opensuse'

        include_examples 'ohai is enabled'
        include_examples 'nginx package is installed'
        include_examples 'common directories are created'
        include_examples 'common scripts are created'
        include_examples 'common conf is created'
      end

      context 'with ubuntu platform' do
        platform 'ubuntu'

        include_examples 'ohai is enabled'
        include_examples 'nginx package is installed'
        include_examples 'common directories are created'
        include_examples 'common scripts are created'
        include_examples 'common conf is created'
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
        include_examples 'common directories are created'
        include_examples 'delete conf.d files'
        include_examples 'common scripts are created'
        include_examples 'common conf is created'
      end

      context 'with centos platform' do
        platform 'centos'

        let(:package_install_options) { ['--disablerepo=*', '--enablerepo=nginx'] }

        include_examples 'ohai is enabled'
        include_examples 'yum repository is created'
        include_examples 'nginx package is installed'
        include_examples 'common directories are created'
        include_examples 'delete conf.d files'
        include_examples 'common scripts are created'
        include_examples 'common conf is created'
      end

      context 'with debian platform' do
        platform 'debian'

        include_examples 'ohai is enabled'
        include_examples 'apt repository is added'
        include_examples 'nginx package is installed'
        include_examples 'common directories are created'
        include_examples 'common scripts are created'
        include_examples 'common conf is created'
      end

      context 'with opensuse platform' do
        platform 'opensuse'

        include_examples 'ohai is enabled'
        include_examples 'nginx package is installed'
        include_examples 'common directories are created'
        include_examples 'common scripts are created'
        include_examples 'common conf is created'

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
        include_examples 'common directories are created'
        include_examples 'common scripts are created'
        include_examples 'common conf is created'
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
        include_examples 'common directories are created'
        include_examples 'delete conf.d files'
        include_examples 'common scripts are created'
        include_examples 'common conf is created'

        it { is_expected.to run_execute('amazon-linux-extras install epel') }
      end

      context 'with centos platform' do
        platform 'centos'

        include_examples 'ohai is enabled'
        include_examples 'nginx package is installed'
        include_examples 'common directories are created'
        include_examples 'delete conf.d files'
        include_examples 'common scripts are created'
        include_examples 'common conf is created'

        it { is_expected.to install_package('epel-release') }
      end
    end

    context 'with passenger source' do
      recipe do
        nginx_install 'passenger'
      end

      shared_examples_for 'passenger is installed' do
        it do
          is_expected.to add_apt_repository('phusionpassenger')
            .with_uri('https://oss-binaries.phusionpassenger.com/apt/passenger')
            .with_distribution(platform_distribution)
            .with_components(%w(main))
            .with_deb_src(true)
            .with_keyserver('keyserver.ubuntu.com')
            .with_key(%w(561F9B9CAC40B2F7))
        end

        it { is_expected.to install_package(%w(apt-transport-https ca-certificates)) }
        it { is_expected.to install_gem_package('rake') }
        it { is_expected.to install_package(passenger_packages) }
        it { is_expected.to install_package(passenger_nginx_package) }
        it { expect(chef_run.package(passenger_nginx_package)).to notify('ohai[reload_nginx]').to(:reload).immediately }

        it do
          is_expected.to create_template(passenger_conf_file)
            .with_source('modules/passenger.conf.erb')
            .with_variables(
              passenger_root:                   '/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini',
              passenger_ruby:                   '/usr/bin/ruby',
              passenger_max_pool_size:          '6',
              passenger_spawn_method:           'smart-lv2',
              passenger_buffer_response:        'on',
              passenger_min_instances:          '1',
              passenger_max_instances_per_app:  '0',
              passenger_pool_idle_time:         '300',
              passenger_max_requests:           '0',
              passenger_show_version_in_header: 'on',
              passenger_log_file:               nil,
              passenger_nodejs:                 nil
            )
        end

        it { expect(chef_run.template(passenger_conf_file)).to notify('service[nginx]').to(:reload).delayed }
      end

      context 'with debian platform' do
        platform 'debian', '9'

        include_examples 'ohai is enabled'
        include_examples 'common directories are created'
        include_examples 'common scripts are created'
        include_examples 'common conf is created'
        include_examples 'passenger is installed'
      end

      context 'with ubuntu platform' do
        platform 'ubuntu', '18.04'

        include_examples 'ohai is enabled'
        include_examples 'common directories are created'
        include_examples 'common scripts are created'
        include_examples 'common conf is created'
        include_examples 'passenger is installed'
      end
    end
  end
end

require 'spec_helper'

describe 'chef_nginx::source' do
  shared_examples_for 'all platforms' do
    it 'creates nginx user' do
      expect(chef_run).to create_user('www-data').with(
        system: true,
        shell: '/bin/false',
        home: '/var/www'
      )
    end

    %w(
      ohai_plugin
      commons_dir
      commons_script
      commons_conf
    ).each do |recipe|
      it "includes the #{recipe} recipe" do
        expect(chef_run).to include_recipe("chef_nginx::#{recipe}")
      end
    end

    it 'includes build-essential recipe' do
      expect(chef_run).to include_recipe('build-essential::default')
    end

    it 'downloads nginx sources' do
      src_file = "#{Chef::Config['file_cache_path']}/nginx-#{@ngx_version}.tar.gz"
      expect(chef_run).to create_remote_file(src_file).with(
        backup: false
      )
    end

    it 'creates mime.types file' do
      expect(chef_run).to create_cookbook_file('/etc/nginx/mime.types')
    end

    it 'marks nginx to be reloaded when we change the mime.types file' do
      expect(chef_run.cookbook_file("#{chef_run.node['nginx']['dir']}/mime.types")).to notify('service[nginx]').to(:reload).delayed
    end

    it 'unarchives source' do
      expect(chef_run).to run_bash('unarchive_source')
    end

    it 'includes all the source modules recipes' do
      expect(chef_run).to include_recipe('chef_nginx::http_gzip_static_module')
      expect(chef_run).to include_recipe('chef_nginx::http_ssl_module')
    end

    it 'compiles nginx source' do
      expect(chef_run).to run_bash('compile_nginx_source')
    end

    it 'marks nginx to be reloaded when we compile nginx source' do
      expect(chef_run.bash('compile_nginx_source')).to notify('service[nginx]').to(:restart).delayed
    end

    it 'marks ohai nginx to be reloaded when we compile nginx source' do
      expect(chef_run.bash('compile_nginx_source')).to notify('ohai[reload_nginx]').to(:reload).immediately
    end

    it 'enables nginx service' do
      expect(chef_run).to enable_service('nginx')
    end
  end

  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'debian', version: '7.10').converge(described_recipe)
  end

  before do
    stub_command('which nginx').and_return(nil)

    @ngx_version = chef_run.node['nginx']['source']['version']
  end

  it 'enables daemon mode in nginx' do
    expect(chef_run.node['nginx']['daemon_disable']).to be(false)
  end

  it 'creates init script' do
    expect(chef_run).to render_file('/etc/init.d/nginx')
  end

  it 'generates defaults configuration' do
    expect(chef_run).to render_file('/etc/default/nginx')
  end

  it 'installs packages dependencies' do
    expect(chef_run).to install_package(['libpcre3', 'libpcre3-dev', 'libssl-dev', 'tar'])
  end

  context 'On Debian 8' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'debian', version: '8.5').converge('chef_nginx::source')
    end

    it 'creates systemd unit file' do
      expect(chef_run).to render_file('/lib/systemd/system/nginx.service')
    end
  end

  context 'On RHEL 6' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '6.8').converge('chef_nginx::source')
    end

    it 'creates init script' do
      expect(chef_run).to render_file('/etc/init.d/nginx')
    end

    it 'generates defaults configuration' do
      expect(chef_run).to render_file('/etc/sysconfig/nginx')
    end
  end

  context 'On RHEL 7' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '7.2.1511').converge('chef_nginx::source')
    end

    it 'creates systemd unit file' do
      expect(chef_run).to render_file('/lib/systemd/system/nginx.service')
    end
  end

  context 'On openSUSE 13.2' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'opensuse', version: '13.2').converge('chef_nginx::source')
    end

    it 'creates systemd unit file' do
      expect(chef_run).to render_file('/usr/lib/systemd/system/nginx.service')
    end
  end
end

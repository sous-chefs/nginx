# encoding: utf-8

describe 'nginx::source' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(:platform => 'debian', :version  => '7.0').converge(described_recipe)
  end

  before do
    stub_command('which nginx').and_return(nil)

    @ngx_version = chef_run.node['nginx']['source']['version']
  end

  it 'creates nginx user' do
    expect(chef_run).to create_user('www-data').with(
      :system => true,
      :shell => '/bin/false',
      :home => '/var/www'
    )
  end

  %w(
    ohai_plugin
    commons_dir
    commons_script
    commons_conf
  ).each do |recipe|
    it "includes the #{recipe} recipe" do
      expect(chef_run).to include_recipe("nginx::#{recipe}")
    end
  end

  it 'includes build-essential recipe' do
    expect(chef_run).to include_recipe('build-essential::default')
  end

  describe 'installs packages dependencies' do
    %w(
      libpcre3
      libpcre3-dev
      libssl-dev
    ).each do |pkg|
      it "installs #{pkg}" do
        expect(chef_run).to install_package(pkg)
      end
    end
  end

  context 'Rhel familly' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:platform => 'centos', :version  => '6.5').converge(described_recipe)
    end

    describe 'installs packages dependencies' do
      %w(
        openssl-devel
        pcre-devel
      ).each do |pkg|
        it "installs #{pkg}" do
          expect(chef_run).to install_package(pkg)
        end
      end
    end
  end

  context 'Gentoo familly' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:platform => 'gentoo', :version  => '2.1').converge(described_recipe)
    end

    describe 'does not need packages dependencies' do
      %w(
        libpcre3
        libpcre3-dev
        libssl-dev
        pcre-devel
        openssl-devel
      ).each do |pkg|
        it "does not install #{pkg}" do
          expect(chef_run).to_not install_package(pkg)
        end
      end
    end
  end

  it 'downloads nginx sources' do
    src_file = "#{Chef::Config['file_cache_path']}/nginx-#{@ngx_version}.tar.gz"
    expect(chef_run).to create_remote_file(src_file).with(
      :backup => false
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
    expect(chef_run).to include_recipe('nginx::http_gzip_static_module')
    expect(chef_run).to include_recipe('nginx::http_ssl_module')
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

  context 'set up the init style' do
    context 'without runit/bluepill/upstart' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(:platform => 'debian', :version  => '7.0') do |node|
          node.set['nginx']['init_style'] = 'other'
        end.converge(described_recipe)
      end
      it 'enables daemon mode in nginx' do
        expect(chef_run.node['nginx']['daemon_disable']).to be(false)
      end
      it 'defines nginx service' do
        expect(chef_run).to enable_service('nginx')
      end
      context 'Gentoo familly' do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(:platform => 'gentoo', :version  => '2.1') do |node|
            node.set['nginx']['init_style'] = 'other'
          end.converge(described_recipe)
        end
        it 'creates init script' do
          expect(chef_run).to render_file('/etc/init.d/nginx')
        end
        it 'doesn\'t generate defaults configuration' do
          expect(chef_run).to_not render_file('/etc/default/nginx')
          expect(chef_run).to_not render_file('/etc/sysconfig/nginx')
        end
      end
      context 'Debian familly' do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(:platform => 'debian', :version  => '7.0') do |node|
            node.set['nginx']['init_style'] = 'other'
          end.converge(described_recipe)
        end
        it 'creates init script' do
          expect(chef_run).to render_file('/etc/init.d/nginx')
        end
        it 'generates defaults configuration' do
          expect(chef_run).to render_file('/etc/default/nginx')
        end
      end
      context 'Freebsd familly' do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(:platform => 'freebsd', :version  => '10.0') do |node|
            node.set['nginx']['init_style'] = 'other'
          end.converge(described_recipe)
        end
        it 'doesn\'t create the init script' do
          expect(chef_run).to_not render_file('/etc/init.d/nginx')
        end
        it 'doesn\'t generate defaults configuration' do
          expect(chef_run).to_not render_file('/etc/default/nginx')
          expect(chef_run).to_not render_file('/etc/sysconfig/nginx')
        end
      end
      context 'Other OS familly(Rhel y example)' do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(:platform => 'centos', :version  => '6.5') do |node|
            node.set['nginx']['init_style'] = 'other'
          end.converge(described_recipe)
        end
        it 'creates init script' do
          expect(chef_run).to render_file('/etc/init.d/nginx')
        end
        it 'generates defaults configuration' do
          expect(chef_run).to render_file('/etc/sysconfig/nginx')
        end
      end
    end
  end
  context 'with runit' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:platform => 'debian', :version  => '7.0') do |node|
        node.set['nginx']['init_style'] = 'runit'
      end.converge(described_recipe)
    end

    it 'includes runit recipe' do
      expect(chef_run).to include_recipe('runit::default')
    end

    it 'defines nginx service' do
      expect(chef_run.service('nginx')).to do_nothing
    end
  end

  context 'with bluepill' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:platform => 'debian', :version  => '7.0') do |node|
        node.set['nginx']['init_style'] = 'bluepill'
      end.converge(described_recipe)
    end

    it 'includes bluepill recipe' do
      expect(chef_run).to include_recipe('bluepill::default')
    end

    it 'configures bluepill' do
      expect(chef_run).to render_file("#{chef_run.node['bluepill']['conf_dir']}/nginx.pill")
    end

    it 'defines nginx service' do
      expect(chef_run.service('nginx')).to do_nothing
    end
  end

  context 'with upstart' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(:platform => 'debian', :version  => '7.0') do |node|
        node.set['nginx']['init_style'] = 'upstart'
      end.converge(described_recipe)
    end

    it 'disables daemon mode in nginx' do
      expect(chef_run.node['nginx']['daemon_disable']).to be(true)
    end

    it 'creates the upstart script' do
      expect(chef_run).to render_file('/etc/init/nginx.conf')
    end

    it 'defines nginx service' do
      expect(chef_run.service('nginx')).to do_nothing
    end
  end
end

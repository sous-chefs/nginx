require 'spec_helper'

describe 'nginx::source' do
  let(:chef_run) do
    ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0').converge(described_recipe)
  end

  before do
    stub_command('which nginx').and_return(nil)
  end

  it 'creates nginx user' do
    expect(chef_run).to create_user(chef_run.node['nginx']['user']).with(
      :system => true,
      :shell => '/bin/false',
      :home => '/var/www'
    )
  end

  it 'includes ohai_plugin' do
    expect(chef_run).to include_recipe('nginx::ohai_plugin')
  end

  it 'includes nginx common directories recipe' do
    expect(chef_run).to include_recipe('nginx::commons_dir')
  end

  it 'includes nginx common scripts recipe' do
    expect(chef_run).to include_recipe('nginx::commons_script')
  end

  it 'includes build-essential recipe' do
    expect(chef_run).to include_recipe('build-essential::default')
  end

  describe 'installs packages dependencies' do
    it 'installs libpcre3' do
      expect(chef_run).to install_package('libpcre3')
    end
    it 'installs libpcre3-dev' do
      expect(chef_run).to install_package('libpcre3-dev')
    end
    it 'installs libssl-dev' do
      expect(chef_run).to install_package('libssl-dev')
    end
  end

  context 'Rhel familly' do
    let(:chef_run) do
      ChefSpec::Runner.new(:platform => 'centos', :version  => '6.5').converge(described_recipe)
    end

    describe 'installs packages dependencies' do
      it 'installs pcre-devel' do
        expect(chef_run).to install_package('pcre-devel')
      end
      it 'installs openssl-devel' do
        expect(chef_run).to install_package('openssl-devel')
      end
    end
  end

  context 'Gentoo familly' do
    let(:chef_run) do
      ChefSpec::Runner.new(:platform => 'gentoo', :version  => '2.1').converge(described_recipe)
    end
    it 'doesn\'t need packages dependencies' do
      expect(chef_run).to_not install_package('pcre-devel')
      expect(chef_run).to_not install_package('openssl-devel')
      expect(chef_run).to_not install_package('libpcre3')
      expect(chef_run).to_not install_package('libpcre3-dev')
      expect(chef_run).to_not install_package('libssl-dev')
    end
  end

  it 'downloads nginx sources' do
    create_remote_file(chef_run.node['nginx']['source']['url']).with(
      :backup => false,
      :checksum => chef_run.node['nginx']['source']['checksum']
    )
  end

  it 'includes nginx common configurations' do
    expect(chef_run).to include_recipe('nginx::commons_conf')
  end

  it 'creates mime.types file' do
    expect(chef_run).to create_cookbook_file("#{chef_run.node['nginx']['dir']}/mime.types").with(
      :source => 'mime.types',
      :owner => 'root',
      :group => chef_run.node['root_group'],
      :mode => '0644'
    )
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
        ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
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
          ChefSpec::Runner.new(:platform => 'gentoo', :version  => '2.1') do |node|
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
          ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
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
          ChefSpec::Runner.new(:platform => 'freebsd', :version  => '10.0') do |node|
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
          ChefSpec::Runner.new(:platform => 'centos', :version  => '6.5') do |node|
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
      ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
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
      ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
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
      ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
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

require 'spec_helper'

# running nginx::default as we need service[nginx] to be defined
describe 'nginx::commons' do
  let(:chef_run) do
    ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0').converge('nginx::default')
  end

  before do
    stub_command('which nginx').and_return(nil)
  end

  describe 'common recipes' do
    it 'includes the common directories' do
      expect(chef_run).to include_recipe('nginx::commons_dir')
    end

    it 'includes the common scripts' do
      expect(chef_run).to include_recipe('nginx::commons_script')
    end

    it 'includes the common configuration' do
      expect(chef_run).to include_recipe('nginx::commons_conf')
    end
  end

  describe 'common configurations' do
    it 'configures nginx' do
      expect(chef_run).to render_file("#{chef_run.node['nginx']['dir']}/nginx.conf")
    end

    it 'marks nginx to be reloaded when changing nginx.con' do
      expect(chef_run.template('nginx.conf')).to notify('service[nginx]').to(:reload).delayed
    end

    it 'configures the default nginx site' do
      expect(chef_run).to render_file("#{chef_run.node['nginx']['dir']}/sites-available/default")
    end

    it 'marks nginx to be reloaded when changing the default site' do
      expect(chef_run.template("#{chef_run.node['nginx']['dir']}/sites-available/default")).to notify('service[nginx]').to(:reload).delayed
    end

    it 'enables default site' do
      expect(chef_run).to run_execute('nxensite default')
    end

    context 'When the default website is disabled' do
      let(:chef_run) do
        ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
          node.set['nginx']['default_site_enabled'] = false
        end.converge('nginx::default')
      end

      it 'disables default site' do
        expect(chef_run).to_not run_execute('nxensite default')
      end

    end
  end

  describe 'common directories' do
    it 'creates nginx dir' do
      expect(chef_run).to create_directory("#{chef_run.node['nginx']['dir']}")
    end

    it 'creates nginx log dir' do
      expect(chef_run).to create_directory("#{chef_run.node['nginx']['log_dir']}")
    end

    it 'creates nginx pid dir' do
      expect(chef_run).to create_directory("#{File.dirname(chef_run.node['nginx']['pid'])}")
    end

    it 'creates nginx available dir' do
      expect(chef_run).to create_directory("#{File.join(chef_run.node['nginx']['dir'], 'sites-available')}")
    end

    it 'creates nginx enabled dir' do
      expect(chef_run).to create_directory("#{File.join(chef_run.node['nginx']['dir'], 'sites-enabled')}")
    end

    it 'creates nginx conf.d dir' do
      expect(chef_run).to create_directory("#{File.join(chef_run.node['nginx']['dir'], 'conf.d')}")
    end

  end

  describe 'common scripts' do
    it 'creates nxensite script' do
      expect(chef_run).to render_file("#{chef_run.node['nginx']['script_dir']}/nxensite")
    end

    it 'creates nxdissite script' do
      expect(chef_run).to render_file("#{chef_run.node['nginx']['script_dir']}/nxdissite")
    end
  end

end

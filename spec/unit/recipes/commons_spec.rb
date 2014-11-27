require 'spec_helper'

# running nginx::default as we need service[nginx] to be defined
describe 'nginx::commons' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge('nginx::default', described_recipe)
  end

  before do
    stub_command('which nginx').and_return(nil)
  end

  describe 'common recipes' do
    %w(
      commons_dir
      commons_script
      commons_conf
    ).each do |recipe|
      it "includes the #{recipe} recipe" do
        expect(chef_run).to include_recipe("nginx::#{recipe}")
      end
    end
  end

  # Describe individual recipes here instead of adding more files
  describe 'commons_dir recipe' do
    %W(
      /etc/nginx
      /var/log/nginx
      #{File.dirname('/var/run/nginx.pid')}
      /etc/nginx/sites-available
      /etc/nginx/sites-enabled
      /etc/nginx/conf.d
    ).each do |dir|
      it 'creates nginx dir' do
        expect(chef_run).to create_directory(dir)
      end
    end
  end

  describe 'commons_script recipe' do
    %w(
      nxensite
      nxdissite
    ).each do |script|
      it "creates #{script} script" do
        expect(chef_run).to render_file("/usr/sbin/#{script}")
      end
    end
  end

  describe 'common configurations' do
    it 'configures nginx' do
      expect(chef_run).to render_file('/etc/nginx/nginx.conf')
    end

    it 'marks nginx to be reloaded when changing nginx.conf' do
      expect(chef_run.template('nginx.conf')).to notify('service[nginx]').to(:reload).delayed
    end

    it 'configures the default nginx site' do
      expect(chef_run).to render_file('/etc/nginx/sites-available/default')
    end

    it 'marks nginx to be reloaded when changing the default site' do
      expect(chef_run.template('/etc/nginx/sites-available/default')).to notify('service[nginx]').to(:reload).delayed
    end

    it 'enables default site' do
      expect(chef_run).to run_execute('nxensite default')
    end

    context 'When the default website is disabled' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new do |node|
          node.set['nginx']['default_site_enabled'] = false
        end.converge('nginx::default', described_recipe)
      end

      it 'disables default site' do
        expect(chef_run).to_not run_execute('nxensite default')
      end
    end
  end
end

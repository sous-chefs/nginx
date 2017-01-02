require 'spec_helper'

# running chef_nginx::default as we need service[nginx] to be defined
describe 'chef_nginx::commons' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04').converge('chef_nginx::default', described_recipe)
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
        expect(chef_run).to include_recipe("chef_nginx::#{recipe}")
      end
    end
  end

  # Describe individual recipes here instead of adding more files
  describe 'commons_dir recipe' do
    %w(
      /etc/nginx
      /var/log/nginx
      /etc/nginx/sites-available
      /etc/nginx/sites-enabled
      /etc/nginx/conf.d
    ).each do |dir|
      it "creates directory #{dir}" do
        expect(chef_run).to create_directory(dir)
      end
    end

    it 'creates pid file directory' do
      expect(chef_run).to create_directory('pid file directory').with(path: '/var/run')
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
      expect(chef_run).to enable_nginx_site('default')
    end

    context 'When the default website is disabled' do
      let(:chef_run) do
        ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
          node.normal['nginx']['default_site_enabled'] = false
        end.converge('chef_nginx::default', described_recipe)
      end

      it 'disables default site' do
        expect(chef_run).to_not run_execute('nxensite default')
      end
    end
  end
end

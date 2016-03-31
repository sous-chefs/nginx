# encoding: utf-8

describe 'nginx::ohai_plugin' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  xit 'defines ohai reload resource' do
    # submit PR on ohai cookbook and fix it
    pending('ohai cookbook does not provide a matcher or ohai resource')
  end

  context 'ohai 8' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.automatic['chef_packages']['ohai']['version'] = '8.1.4'
      end.converge(described_recipe)
    end
    it 'select nginx ohai7 configuration' do
      expect(chef_run).to create_template('/etc/chef/ohai_plugins/nginx.rb').with(
        source: 'plugins/ohai7-nginx.rb.erb'
      )
    end
  end

  context 'ohai 6' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.automatic['chef_packages']['ohai']['version'] = '6.1.3'
      end.converge(described_recipe)
    end
    it 'select nginx ohai7 configuration' do
      expect(chef_run).to create_template('/etc/chef/ohai_plugins/nginx.rb').with(
        source: 'plugins/ohai6-nginx.rb.erb'
      )
    end
  end

  it 'create nginx ohai configuration' do
    expect(chef_run).to render_file('/etc/chef/ohai_plugins/nginx.rb')
  end

  it 'reloads ohai' do
    expect(chef_run.template('/etc/chef/ohai_plugins/nginx.rb')).to notify('ohai[reload_nginx]').to(:reload).immediately
  end

  it 'includes the ohai default recipe' do
    expect(chef_run).to include_recipe('ohai::default')
  end
end

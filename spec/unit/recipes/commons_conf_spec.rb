require 'spec_helper'

describe 'nginx::commons_conf' do
  let(:chef_run) do
    ChefSpec::Runner.new().converge('nginx::default', described_recipe)
  end

  it 'creates nginx.conf' do
    expected_conf_file = "#{chef_run.node['nginx']['dir']}/nginx.conf"
    expect(chef_run).to render_file(expected_conf_file)
  end

  it 'enables default site' do
    expected_site_file = "#{chef_run.node['nginx']['dir']}/sites-available/default"
    expect(chef_run).to render_file(expected_site_file)
  end

  context "default_site_enabled = false" do
    let(:chef_run) do 
      runner = ChefSpec::Runner.new()
      runner.node.set['nginx']['default_site_enabled'] = false
      runner.converge('nginx::default', described_recipe)
    end

    it 'disables default site' do
      expected_site_file = "#{chef_run.node['nginx']['dir']}/sites-available/default"
      expect(chef_run).not_to render_file(expected_site_file)
    end
  end
end

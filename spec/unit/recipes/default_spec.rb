require 'spec_helper'

describe 'nginx::default' do
  let(:chef_run) do
    ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do | node |
      node.set['nginx']['default']['modules'] = ['http_gzip_static_module']
    end.converge(described_recipe)
  end

  before do
    stub_command('which nginx').and_return(nil)
  end

  it 'includes the nginx recipe for the desired install method' do
    expect(chef_run).to include_recipe("nginx::#{chef_run.node['nginx']['install_method']}")
  end

  it 'starts the nginx service' do
    expect(chef_run).to start_service('nginx')
  end

  it 'includes all the default modules recipes' do
    expect(chef_run).to include_recipe('nginx::http_gzip_static_module')
  end

end

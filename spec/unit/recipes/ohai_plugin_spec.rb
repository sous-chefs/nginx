require 'spec_helper'

describe 'nginx::ohai_plugin' do
  let(:chef_run) do
    ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0').converge(described_recipe)
  end

  # it 'defines ohai reload resource' do
  #   pending('ohai cookbook doesn\'t provide a matcher or ohai resource')
  #  # submit PR on ohai cookbook and fix it
  # end

  it 'create nginx ohai configuration' do
    expect(chef_run).to render_file("#{chef_run.node['ohai']['plugin_path']}/nginx.rb")
  end

  it 'reloads ohai' do
    expect(chef_run.template("#{chef_run.node['ohai']['plugin_path']}/nginx.rb")).to notify('ohai[reload_nginx]').to(:reload).immediately
  end

  it 'includes the ohai default recipe' do
    expect(chef_run).to include_recipe('ohai::default')
  end

end

require 'spec_helper'

# Note that we actually end up converging the chef_nginx::default recipe because
# the commons_* recipes require the service definition and are included/ran
# from that recipe.
describe 'chef_nginx::commons_conf with default attributes' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04').converge('chef_nginx::default')
  end

  before do
    stub_command('which nginx').and_return(nil)
  end

  it 'creates an nginx.conf' do
    expect(chef_run).to render_file("#{chef_run.node['nginx']['dir']}/nginx.conf")
  end

  it 'creates a default site' do
    expect(chef_run).to render_file("#{chef_run.node['nginx']['dir']}/sites-available/default")
  end

  it 'enables the default site by default' do
    expect(chef_run).to enable_nginx_site('default')
  end
end

describe 'chef_nginx::commons_conf with non-default attributes' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04').converge('chef_nginx::default')
  end

  before do
    stub_command('which nginx').and_return(nil)
  end

  it 'allows alternative template sources' do
    chef_run.node.normal['nginx']['conf_template'] = 'mytemplate.conf.erb'
    chef_run.node.normal['nginx']['conf_cookbook'] = 'somecookbook'
    chef_run.converge('chef_nginx::default')
    template_file = "#{chef_run.node['nginx']['dir']}/nginx.conf"
    expect(chef_run).to create_template(template_file).with(
      source: 'mytemplate.conf.erb',
      cookbook: 'somecookbook'
    )
  end

  it 'disables the default site when default_site_enabled = false' do
    chef_run.node.normal['nginx']['default_site_enabled'] = false
    chef_run.converge('chef_nginx::default')
    expect(chef_run).not_to enable_nginx_site('default')
  end
end

require 'spec_helper'

describe 'nginx::http_realip_module' do
  let(:nginx_version) { '1.12.1' }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.normal['nginx']['source']['modules'] = ['nginx::http_realip_module']
      node.normal['nginx']['version'] = nginx_version
      node.normal['nginx']['realip']['real_ip_recursive'] = 'off'
    end.converge('nginx::package', described_recipe)
  end

  it 'creates config file' do
    expect(chef_run).to create_template('/etc/nginx/conf.d/http_realip.conf')
  end

  it 'includes the real_ip_recursive configuration directive' do
    expect(chef_run).to render_file('/etc/nginx/conf.d/http_realip.conf').with_content(
      'real_ip_recursive off'
    )
  end
end

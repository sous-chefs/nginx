require 'spec_helper'

describe 'chef_nginx::http_realip_module' do
  let(:nginx_version) { '1.12.1' }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.normal['nginx']['source']['modules'] = ['chef_nginx::http_realip_module']
      node.normal['nginx']['version'] = nginx_version
      node.normal['nginx']['realip']['real_ip_recursive'] = 'off'
    end.converge('chef_nginx::package', described_recipe)
  end

  it 'creates config file' do
    expect(chef_run).to create_template('/etc/nginx/conf.d/http_realip.conf')
  end

  it 'includes the real_ip_recursive configuration directive' do
    expect(chef_run).to render_file('/etc/nginx/conf.d/http_realip.conf').with_content(
      'real_ip_recursive off'
    )
  end

  context 'when the nginx version is < 1.2' do
    let(:nginx_version) { '1.1' }

    it 'does not include the real_ip_recursive configuration directive' do
      expect(chef_run).to render_file('/etc/nginx/conf.d/http_realip.conf').with_content { |content|
        expect(content).not_to include('real_ip_recursive')
      }
    end
  end
end

require 'spec_helper'

describe 'chef_nginx::headers_more_module' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.normal['nginx']['source']['modules'] = ['chef_nginx::headers_more_module']
    end.converge(described_recipe)
  end

  it 'retrieves remote files to cache' do
    expect(chef_run).to create_remote_file("#{Chef::Config['file_cache_path']}/headers_more.tar.gz")
  end

  it 'creates extracted directory' do
    headers_more_checksum = chef_run.node.attributes['nginx']['headers_more']['source_checksum']

    expect(chef_run).to create_directory("#{Chef::Config['file_cache_path']}/headers_more/#{headers_more_checksum}")
  end

  it 'expands the retrieved files' do
    expect(chef_run).to run_bash('extract_headers_more')
  end
end

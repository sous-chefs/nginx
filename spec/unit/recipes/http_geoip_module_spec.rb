# Encoding: utf-8
require 'spec_helper'

describe 'nginx::http_geoip_module', :focus do
  let(:chef_run) do
    ChefSpec::ServerRunner.new do |node|
      node.set['nginx']['source']['modules'] = ['nginx::http_geoip_module']
    end.converge(described_recipe)
  end

  # TODO: additional resources are cloned during ChefSpec runs,
  # leading to inaccurate counts.
  it 'retrieves remote files to cache' do
    expect(chef_run).to create_remote_file("#{Chef::Config['file_cache_path']}/GeoIP-1.6.3.tar.gz")
    expect(chef_run).to create_remote_file("#{Chef::Config['file_cache_path']}/GeoIP.dat.gz")
    expect(chef_run).to create_remote_file("#{Chef::Config['file_cache_path']}/GeoLiteCity.dat.gz")
  end

  it 'creates lib directory' do
    expect(chef_run).to create_directory('/srv/geoip')
  end

  it 'expands the retrieved files' do
    expect(chef_run).to run_bash('extract_geolib')
    expect(chef_run).to run_bash('gunzip_geo_lite_country_dat')
    expect(chef_run).to run_bash('gunzip_geo_lite_city_dat')
  end

  it 'creates config file' do
    expect(chef_run).to create_template('/etc/nginx/conf.d/http_geoip.conf')
  end
end

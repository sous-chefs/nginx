require 'spec_helper'

describe 'chef_nginx::http_geoip_module' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.normal['nginx']['source']['modules'] = ['chef_nginx::http_geoip_module']
    end.converge(described_recipe)
  end

  it 'retrieves remote files to cache' do
    geoip_version = chef_run.node.attributes['nginx']['geoip']['lib_version']

    expect(chef_run).to create_remote_file("#{Chef::Config['file_cache_path']}/GeoIP-#{geoip_version}.tar.gz")
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

# encoding: utf-8

describe 'nginx::rtmp_module' do
  
  before do
    stub_command('which nginx').and_return(nil)
  end
  
  cached(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['nginx']['source']['modules'] = ['nginx::rtmp_module']
    end.converge(described_recipe)
  end

  it 'retrieves remote files to cache' do
    expect(chef_run).to create_remote_file("#{Chef::Config['file_cache_path']}/rtmp_module.tar.gz")
  end

  it 'creates extracted directory' do
    rtmp_module_checksum = chef_run.node.attributes['nginx']['rtmp']['source_checksum']

    expect(chef_run).to create_directory("#{Chef::Config['file_cache_path']}/rtmp_module/#{rtmp_module_checksum}")
  end

  it 'expands the retrieved files' do
    expect(chef_run).to run_bash('extract_rtmp')
  end
end

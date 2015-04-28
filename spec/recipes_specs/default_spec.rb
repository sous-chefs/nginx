describe 'nginx::default' do
  cached(:chef_run) { ChefSpec::SoloRunner.converge described_recipe }

  it 'does nothing' do
    expect(chef_run.resource_collection.resources.count).to eq 0
  end
end

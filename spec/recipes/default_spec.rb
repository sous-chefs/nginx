describe 'nginx::default' do
  context 'when converging this recipe' do
    let(:chef_run) { ChefSpec::SoloRunner.converge described_recipe }

    it 'should do nothing' do
      expect(chef_run.resource_collection.resources.count).to eq 0
    end
  end
end

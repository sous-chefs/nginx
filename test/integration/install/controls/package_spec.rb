control 'package' do
  desc   'Ensure nginx package is installed.'
  impact 1.0

  describe package('nginx') do
    it { should be_installed }
  end
end

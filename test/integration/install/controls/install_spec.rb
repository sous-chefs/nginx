control 'install' do
  desc   'Ensure nginx is installed.'
  impact 1.0

  describe service('nginx') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe package('nginx') do
    it { should be_installed }
  end
end

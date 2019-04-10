control 'epel' do
  desc   'Ensure epel-release package is installed.'
  impact 1.0

  describe package('epel-release') do
    it { should be_installed }
  end
end

include_controls 'install'

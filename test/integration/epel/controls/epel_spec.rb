control 'nginx-epel-01' do
  impact 1.0
  title 'EPEL Repository'
  desc 'Ensure EPEL repository is installed for RHEL 7'

  only_if('RHEL 7 only') do
    os.redhat? && os.release.to_i.eql?(7)
  end

  describe package('epel-release') do
    it { should be_installed }
  end
end

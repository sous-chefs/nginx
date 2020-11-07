describe package('epel-release') do
  it { should be_installed }
end if os.redhat? && os.release.to_i.eql?(7)

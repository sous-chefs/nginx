describe service('nginx') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/yum.repos.d/epel.repo') do
  it { should be_a_file }
end

describe package('nginx') do
  it { should be_installed }
end

describe command('curl http://localhost/') do
  its('exit_status') { should eq 0 }
end

repo_path = if os.debian?
              '/etc/apt/sources.list.d/nginx.list'
            elsif os.redhat?
              '/etc/yum.repos.d/nginx.repo'
            elsif os.suse?
              '/etc/zypp/repos.d/Nginx.org Repository.repo'
            end

describe service('nginx') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file(repo_path) do
  it { should be_a_file }
end

describe package('nginx') do
  it { should be_installed }
end

describe command('curl http://localhost/') do
  its('exit_status') { should eq 0 }
end

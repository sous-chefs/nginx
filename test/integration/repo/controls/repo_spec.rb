control 'nginx-repo-01' do
  impact 1.0
  title 'Nginx Repository Configuration'
  desc 'Verify that the Nginx repository is properly configured for the current platform'

  case os[:family]
  when 'debian'
    if os[:name] == 'ubuntu'
      describe apt('https://nginx.org/packages/ubuntu') do
        it { should exist }
        it { should be_enabled }
      end
    else
      describe apt('https://nginx.org/packages/debian') do
        it { should exist }
        it { should be_enabled }
      end
    end
  when 'suse'
    repo_file = '/etc/zypp/repos.d/nginx.repo'
    base_url = if os[:name] == 'opensuseleap'
                 'https://nginx.org/packages/sles/15'
               else
                 'https://nginx.org/packages/sles/12'
               end

    describe file(repo_file) do
      it { should exist }
      its('content') { should include('enabled=1') }
      its('content') { should include("baseurl=#{base_url}") }
      its('content') { should include('gpgkey=https://nginx.org/keys/nginx_signing.key') }
      its('content') { should include('name=Nginx.org Repository') }
    end
  else
    describe yum.repo('nginx') do
      it { should exist }
      it { should be_enabled }
    end
  end
end

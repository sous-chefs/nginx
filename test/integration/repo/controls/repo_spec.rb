control 'repo' do
  desc   'Ensure nginx repository is created.'
  impact 1.0

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
    if os[:name] == 'opensuseleap'
      describe file('/etc/zypp/repos.d/nginx.repo') do
        it { should exist }
        its('content') { should include('enabled=1') }
        its('content') { should include('baseurl=https://nginx.org/packages/sles/15') }
        its('content') { should include('gpgkey=https://nginx.org/keys/nginx_signing.key') }
        its('content') { should include('name=Nginx.org Repository') }
      end
    else
      describe file('/etc/zypp/repos.d/nginx.repo') do
        it { should exist }
        its('content') { should include('enabled=1') }
        its('content') { should include('baseurl=https://nginx.org/packages/sles/12') }
        its('content') { should include('gpgkey=https://nginx.org/keys/nginx_signing.key') }
        its('content') { should include('name=Nginx.org Repository') }
      end
    end
  else
    describe yum.repo('nginx') do
      it { should exist }
      it { should be_enabled }
    end
  end
end

include_controls 'install'

control 'nginx-service-01' do
  impact 1.0
  title 'Nginx Service'
  desc 'Verify that Nginx service is installed, enabled and running'

  describe service('nginx') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

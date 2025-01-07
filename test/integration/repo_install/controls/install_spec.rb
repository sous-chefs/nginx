control 'nginx-repo-install-01' do
  impact 1.0
  title 'Nginx Package Installation from Repository'
  desc 'Verify that Nginx package is installed from the configured repository'

  describe package('nginx') do
    it { should be_installed }
  end
end

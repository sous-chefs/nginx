control 'nginx-package-01' do
  impact 1.0
  title 'Nginx Package Installation'
  desc 'Ensure Nginx package is installed with the correct package name per platform'

  packages = case os.family
             when 'debian'
               'nginx-full'
             else
               'nginx'
             end

  describe package(packages) do
    it { should be_installed }
  end
end

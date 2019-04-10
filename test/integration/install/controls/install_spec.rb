control 'install' do
  desc   'Ensure nginx is installed.'
  impact 1.0

  describe package('nginx') do
    it { should be_installed }
  end

  describe directory('/etc/nginx') do
    it { should exist }
    it { should be_directory }
    its('mode') { should cmp '0755' }
  end

  describe directory('/var/log/nginx') do
    it { should exist }
    it { should be_directory }
    its('mode') { should cmp '0750' }
  end

  nginx_pid_dir = os[:family] == 'debian' ? '/run' : '/var/run'

  describe directory(nginx_pid_dir) do
    it { should exist }
    it { should be_directory }
    its('mode') { should cmp '0755' }
  end

  %w(
    sites-available
    sites-enabled
    conf.d
    streams-available
    streams-enabled
  ).each do |leaf|
    directory("/etc/nginx/#{leaf}") do
      it { should exist }
      it { should be_directory }
      its('mode') { should cmp '0755' }
    end
  end

  %w(
    default.conf
    example_ssl.conf
  ).each do |config|
    file("/etc/nginx/conf.d/#{config}") do
      it { should_not exist }
    end
  end

  describe service('nginx') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

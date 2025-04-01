control 'nginx-config-01' do
  impact 1.0
  title 'Nginx Configuration Directories'
  desc 'Ensure Nginx configuration directories exist with proper permissions'

  describe directory('/etc/nginx') do
    it { should exist }
  end

  %w(conf.d conf.http.d).each do |dir|
    describe directory("/etc/nginx/#{dir}") do
      it { should exist }
      it { should be_directory }
      its('mode') { should cmp '0755' }
    end
  end

  describe directory('/var/log/nginx') do
    it { should exist }
    it { should be_directory }
    its('mode') { should cmp '0755' }
  end
end

control 'nginx-config-02' do
  impact 1.0
  title 'Nginx Default Configuration Files'
  desc 'Ensure default configuration files are not present'

  %w(default.conf example_ssl.conf).each do |config|
    describe file("/etc/nginx/conf.d/#{config}") do
      it { should_not exist }
    end
  end
end

control 'nginx-config-03' do
  impact 1.0
  title 'Nginx Main Configuration'
  desc 'Verify the main nginx.conf configuration'

  process_owner = case os.family
                  when 'debian'
                    'www-data'
                  else
                    'nginx'
                  end

  describe file('/etc/nginx/nginx.conf') do
    it { should exist }
    it { should be_file }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('content') { should match(/user\s+#{process_owner};/) }
    its('content') { should include 'worker_processes      auto;' }
    its('content') { should include 'pid                   /run/nginx.pid;' }
    its('content') { should include 'worker_connections  1024;' }
    its('content') { should include 'sendfile            on;' }
    its('content') { should include 'tcp_nopush          on;' }
    its('content') { should include 'tcp_nodelay         on;' }
    its('content') { should include 'keepalive_timeout   65;' }
    its('content') { should include 'types_hash_max_size 2048;' }
  end
end

control 'nginx-config-04' do
  impact 1.0
  title 'Nginx Site Configurations'
  desc 'Verify various site configuration files'

  describe file('/etc/nginx/conf.http.d/default-site.conf') do
    it { should exist }
    it { should be_file }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('content') { should include 'listen       80;' }
    its('content') { should include 'access_log   /var/log/nginx/localhost.access.log;' }
    case os.family
    when 'redhat'
      its('content') { should include 'root       /usr/share/nginx/html;' }
    when 'debian'
      its('content') { should include 'root       /var/www/html;' }
    end
  end

  describe file('/etc/nginx/conf.http.d/test_site.conf') do
    it { should exist }
    it { should be_file }
    its('mode') { should cmp '0644' }
    its('content') { should include 'proxy_set_header X-My-Real-IP $remote_addr;' }
    its('content') { should include 'proxy_set_header X-My-Real-Port $remote_port;' }
    its('content') { should include 'limit_except GET POST { deny all; }' }
  end

  describe file('/etc/nginx/conf.http.d/test_site_disabled.conf.disabled') do
    it { should exist }
    it { should be_file }
  end

  describe file('/etc/nginx/conf.http.d/foo.conf') do
    it { should exist }
    it { should be_file }
    its('content') { should include '## OVERRIDE FROM TEST COOKBOOK' }
    its('content') { should include 'upstream bar {' }
    its('content') { should include '  server localhost:1234;' }
  end
end

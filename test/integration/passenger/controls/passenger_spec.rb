control 'passenger' do
  desc   'Ensure nginx passenger is installed.'
  impact 1.0

  describe package('ca-certificates') do
    it { should be_installed }
  end

  describe apt('https://oss-binaries.phusionpassenger.com/apt/passenger') do
    it { should exist }
    it { should be_enabled }
  end

  if os.debian? && (os[:name ] == 'debian' && os[:release].to_i < 9) || (os[:name] == 'ubuntu' && os[:release].to_f < 18.04)
    describe package('nginx-extras') do
      it { should be_installed }
    end
  end

  # describe gem('rake') do
  #   it { should be_installed }
  # end

  describe package('passenger') do
    it { should be_installed }
  end

  passenger_conf_file = if (os[:name] == 'debian' && os[:release].to_i >= 9) || (os[:name] == 'ubuntu' && os[:release].to_f >= 18.04)
                          '/etc/nginx/conf.d/mod-http-passenger.conf'
                        else
                          '/etc/nginx/conf.d/passenger.conf'
                        end

  describe file(passenger_conf_file) do
    it { should exist }
    it { should be_file }
    its('content') { should include 'passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini' }
    its('content') { should include 'passenger_ruby /usr/bin/ruby' }
    its('content') { should include 'passenger_max_pool_size 6' }
    its('content') { should include 'passenger_spawn_method smart-lv2' }
    its('content') { should include 'passenger_buffer_response on' }
    its('content') { should include 'passenger_min_instances 1' }
    its('content') { should include 'passenger_max_instances_per_app 0' }
    its('content') { should include 'passenger_pool_idle_time 300' }
    its('content') { should include 'passenger_max_requests 0' }
    its('content') { should include 'passenger_show_version_in_header on' }
    its('content') { should_not include 'passenger_log_file' }
    its('content') { should_not include 'passenger_nodejs' }
  end

  describe command('passenger-config validate-install --auto') do
    its('exit_status') { should eq 0 }
  end
end

include_controls 'install' do
  if (os[:name ] == 'debian' && os[:release].to_i < 9) || (os[:name] == 'ubuntu' && os[:release].to_f < 18.04)
    skip_control 'package'
  end
end

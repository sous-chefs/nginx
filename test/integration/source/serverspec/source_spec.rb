# Encoding: utf-8
require_relative 'spec_helper'

describe file('/etc/nginx/nginx.conf') do
  it { should be_a_file }
  its(:content) { should match(/ssl_protocols TLSv1 TLSv1.1 TLSv1.2;/) }
end

describe service('nginx') do
  it { should be_running }
end

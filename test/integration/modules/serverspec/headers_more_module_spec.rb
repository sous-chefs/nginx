# Encoding: utf-8
require_relative 'spec_helper'

# FIXME: This will not sustain a version update
describe command('/opt/nginx-1.4.4/sbin/nginx -V') do
  its(:stdout) { should match(/headers_more/) }
end

describe service('nginx') do
  it { should be_running }
end

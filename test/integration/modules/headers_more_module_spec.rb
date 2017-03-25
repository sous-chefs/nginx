# FIXME: This will not sustain a version update
describe command('/opt/nginx-1.10.3/sbin/nginx -V') do
  its(:stderr) { should match(/headers_more/) }
end

describe service('nginx') do
  it { should be_running }
end

describe file('/etc/nginx/conf.d/http_geoip.conf') do
  it { should be_a_file }
  its(:content) { should match(%r{/srv/geoip/GeoIP.dat}) }
end

describe file('/usr/local/lib/libGeoIP.so') do
  it { should be_a_file }
end

# FIXME: This will not sustain a version update
describe command('/opt/nginx-1.10.3/sbin/nginx -V') do
  its(:stderr) { should match(/--with-http_geoip_module/) }
end

describe service('nginx') do
  it { should be_running }
end

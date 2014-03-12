require 'spec_helper'

describe port(80) do
  it { should be_listening }
end

# Check that the demo app is functioning properly
# This was setup by the test fixture cookbook: nginx_test::lwrps
# Site defined in test/fixtures/cookbooks/nginx_test/files/default/index.html
describe command('wget -O- http://127.0.0.1/') do
  it { should return_stdout /Nginx Works!/ }
  it { should return_stderr /200 OK/ }
end
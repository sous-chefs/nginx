describe service('nginx') do
  it { should be_running }
end

describe file('/etc/nginx/streams-enabled/test_stream') do
  it { should be_a_file }
end

describe file('/etc/nginx/streams-available/test_stream') do
  it { should be_a_file }
end

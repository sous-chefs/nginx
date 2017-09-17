describe command('ps -ef | grep ngin[x]') do
  its('exit_status') { should eq 0 }
end

describe command('curl http://localhost/') do
  its('exit_status') { should eq 0 }
end

require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'nginx::source' do
  it 'creates the nginx conf' do
    expect(file('/etc/nginx/nginx.conf')).to be_a_file
  end

  it 'has nginx running' do
    # Because the output of the binary compiled does not include the word
    # "running", we can't use ServerSpec's native `service` method.
    if backend(Serverspec::Commands::Base).check_os == 'Debian'
      expect(command('service nginx status')).to return_stdout(/^run: nginx/)
    else
      expect(command('/sbin/service nginx status')).to return_stdout(/running/)
    end
  end
end

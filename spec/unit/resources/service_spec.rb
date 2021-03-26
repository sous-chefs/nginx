require 'spec_helper'

describe 'nginx_service' do
  step_into :nginx_service
  platform 'centos'

  context 'configure nginx service' do
    recipe do
      nginx_service 'nginx' do
        action %i(enable start)
      end
    end

    before do
      dbl = double(run_command: double(error!: nil), stdout: 'expected output')
      allow(Mixlib::ShellOut).to receive(:new).with('/usr/sbin/nginx -t -c /etc/nginx/nginx.conf').and_return(dbl)
    end

    describe 'enables and starts service' do
      it { is_expected.to enable_service('nginx') }
      it { is_expected.to start_service('nginx') }
    end
  end
end

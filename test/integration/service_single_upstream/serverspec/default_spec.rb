require 'spec_helper'

describe 'single service, upstream repo' do
  case os[:family]
  when 'debian', 'ubuntu'
    repo_file = '/etc/apt/sources.list.d/nginx.org.list'
    repo_installed_command = 'grep -q nginx.org /var/lib/dpkg/status'
  when 'redhat'
    repo_file = '/etc/yum.repos.d/nginx.org.repo'
    repo_installed_command = 'yum info nginx | grep -q "From repo\s.*nginx.org$"'
  end

  describe file(repo_file) do
    it { should be_file }
    its(:content) { should match(%r{http://nginx.org/packages/}) }
  end

  describe command(repo_installed_command) do
    its(:exit_status) { should eq 0 }
  end

  it_behaves_like 'nginx package'
  it_behaves_like 'nginx service', 'single'
end

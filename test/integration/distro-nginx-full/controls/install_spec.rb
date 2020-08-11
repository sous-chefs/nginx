include_controls 'install'

describe package('nginx-full') do
  it { should be_installed }
end

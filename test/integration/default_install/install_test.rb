packages = case os.family
           when 'debian'
             'nginx-full'
           else
             'nginx'
           end

describe package(packages) do
  it { should be_installed }
end

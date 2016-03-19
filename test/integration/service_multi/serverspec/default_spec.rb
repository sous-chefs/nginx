require 'spec_helper'

describe 'multi service' do
  it_behaves_like 'nginx package'

  it_behaves_like 'nginx service', 'multi1'
  it_behaves_like 'nginx service', 'multi2'
end

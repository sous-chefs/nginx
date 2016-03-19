require 'spec_helper'

describe 'single service' do
  it_behaves_like 'nginx package'
  it_behaves_like 'nginx service', 'single'
end

require 'spec_helper'

RSpec.describe Nginx::Cookbook::Helpers do
  class DummyClass < Chef::Node
    include Nginx::Cookbook::Helpers
  end

  subject { DummyClass.new }

  describe '#nginx_binary' do
    it { expect(subject.nginx_binary).to eq '/usr/sbin/nginx' }
  end
end

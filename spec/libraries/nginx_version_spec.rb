require 'spec_helper'
require_relative '../../libraries/nginx_version'

describe NginxVersion do
  let(:version) { '1.10.3' }

  subject { described_class.new(version) }

  RSpec::Matchers.define :be_greater_than do |expected|
    match do |actual|
      actual > expected
    end
  end

  RSpec::Matchers.define :be_less_than do |expected|
    match do |actual|
      actual < expected
    end
  end

  describe 'comparison' do
    it 'compares versions differing in major part' do
      other = described_class.new('0.10.3')

      expect(subject).to be_greater_than(other)
      expect(other).to be_less_than(subject)
    end

    it 'compares versions differing in minor part' do
      other = described_class.new('1.2.3')

      expect(subject).to be_greater_than(other)
      expect(other).to be_less_than(subject)
    end

    it 'compares versions differing in patch part' do
      other = described_class.new('1.10.1')

      expect(subject).to be_greater_than(other)
      expect(other).to be_less_than(subject)
    end

    it 'compares versions with different numbers of segments' do
      other = described_class.new('1.10')

      expect(subject).to be_greater_than(other)
      expect(other).to be_less_than(subject)
    end

    it 'reports equality when versions exactly match' do
      other = described_class.new(version)

      expect(subject).to eq(other)
    end
  end
end

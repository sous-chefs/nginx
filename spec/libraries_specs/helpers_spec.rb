require_relative '../../libraries/helpers'
require_relative '../../libraries/resource_nginx_service'

describe NginxCookbook::Helpers do
  class DummyClass
    attr_accessor :node

    def initialize
      @node = {}
    end
  end

  before(:all) do
    @dummy = DummyClass.new
    @dummy.extend NginxCookbook::Helpers
  end

  it 'returns www-data for debian platform' do
    @dummy.node['platform'] = 'debian'

    expect(@dummy.user_for_platform(@dummy.node)).to be == 'www-data'
  end

  it 'returns www-data for ubuntu platform' do
    @dummy.node['platform'] = 'ubuntu'

    expect(@dummy.user_for_platform(@dummy.node)).to be == 'www-data'
  end

  it 'returns nginx for centos platform' do
    @dummy.node['platform'] = 'centos'

    expect(@dummy.user_for_platform(@dummy.node)).to be == 'nginx'
  end

#   # let(:klass) { Class.new { extend NginxCookbook::Helpers } }
#
#   # let(:klass) do
#   #   klass = Class.new
#   #   klass.send(:include, described_class)
#   #   klass
#   #
#   #   # klass = Class.new do
#   #   #   self.send(:include, described_class)
#   #   # end
#   # end
#
#   # before do
#   #   include NginxCookbook::Helpers
#   # end
#
#   describe '#nginx_instance_name' do
#     let(:new_resource) do
#       Chef::Resource::NginxService.new 'foo'
#     end
#
#     it 'converts the resource name into a label' do
#       expect(new_resource.name).to eq 'foo'
#       require 'pry'; binding.pry
#       expect(@dummy.nginx_instance_name).to eq 'nginx-foo'
#     end
#   end
#
#   xdescribe '#parsed_run_group' do
#     let(:fake_resource) do
#       Chef::Resource::NginxService.new 'foo'
#     end
#
#     context 'when specified' do
#       it 'returns the specified group name' do
#         fakenode = Hash['platform_family' => 'debian']
#         fake_resource.run_group('rocket')
#         result = parsed_run_group(fake_resource, fakenode)
#         expect(result).to eq 'rocket'
#       end
#     end
#
#     context 'when unspecified' do
#       context 'on debianoids' do
#         it 'returns the default group name' do
#           fakenode = Hash['platform_family' => 'debian']
#           result = parsed_run_group(fake_resource, fakenode)
#           expect(result).to eq 'www-data'
#         end
#       end
#
#       context 'on rhellions' do
#         it 'returns the default group name' do
#           fakenode = Hash['platform_family' => 'rhel']
#           result = parsed_run_group(fake_resource, fakenode)
#           expect(result).to eq 'nginx'
#         end
#       end
#     end
#   end
#
#   xdescribe '#parsed_run_user' do
#     let(:fake_resource) do
#       Chef::Resource::NginxService.new 'bar'
#     end
#
#     context 'when specified' do
#       it 'returns the specified user name' do
#         fakenode = Hash['platform_family' => 'debian']
#         fake_resource.run_user('rocket')
#         result = parsed_run_user(fake_resource, fakenode)
#         expect(result).to eq 'rocket'
#       end
#     end
#
#     context 'when unspecified' do
#       context 'on debianoids' do
#         it 'returns the default user name' do
#           fakenode = Hash['platform_family' => 'debian']
#           result = parsed_run_user(fake_resource, fakenode)
#           expect(result).to eq 'www-data'
#         end
#       end
#
#       context 'on rhellions' do
#         it 'returns the default user name' do
#           fakenode = Hash['platform_family' => 'rhel']
#           result = parsed_run_user(fake_resource, fakenode)
#           expect(result).to eq 'nginx'
#         end
#       end
#     end
#   end
end

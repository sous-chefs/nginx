require 'chefspec'

describe 'nginx::default' do
  it "loads the ohai plugin"

  it "builds from source when specified"

  context "configured to install by package" do
    context "in a redhat-based platform" do
      it "includes the yum::epel recipe if the source is epel"
      it "includes the nginx::repo recipe if the source is not epel"
    end
    it "installs the package"
    it "enables the service"
    it "executes common nginx configuration"
  end

  it "starts the service"
end

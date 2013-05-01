require 'chefspec'

describe 'nginx::default' do
  it "loads the ohai plugin"

  it "builds from source when specified"

  context "install method is by package" do
    context "when the platform is redhat-based" do
      it "includes the yum::epel recipe if the source is epel"
      it "includes the nginx::repo recipe if the source is not epel"
    end
    it "installs the package"
    it "enables the service"
    it "includes common configurations"
  end

  it "starts the service"
end

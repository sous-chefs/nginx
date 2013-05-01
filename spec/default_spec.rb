require 'chefspec'

describe 'nginx::default' do
  before do
    # stub out ohai
    Chef::Config[:config_file] = '/dev/null'
  end
  let(:runner) do
    ChefSpec::ChefRunner.new(platform: 'debian')
  end
  let(:chef_run) do
    runner.converge 'nginx::default'
  end

  it "loads the ohai plugin" do
    expect(chef_run).to include_recipe 'nginx::ohai_plugin'
  end

  it "builds from source when specified" do
    # needed to converge nginx::source
    runner.node.set[:nginx][:init_style] = 'none'
    runner.node.set[:nginx][:install_method] = 'source'
    expect(chef_run).to include_recipe 'nginx::source'
  end

  context "configured to install by package" do
    context "in a redhat-based platform" do
      let(:redhat) do
        ChefSpec::ChefRunner.new(platform: 'redhat')
      end
      let(:redhat_run) do
        redhat.converge 'nginx::default'
      end
      it "includes the yum::epel recipe if the source is epel" do
        redhat.node.set[:nginx][:repo_source] = 'epel'
        expect(redhat_run).to include_recipe 'yum::epel'
      end
        
      it "includes the nginx::repo recipe if the source is not epel" do
        redhat.node.set[:nginx][:repo_source] = 'notepel'
        expect(redhat_run).to include_recipe 'nginx::repo'
      end
    end

    it "installs the package" do
      package_name = chef_run.node[:nginx][:package_name]
      expect(chef_run).to install_package package_name
    end

    it "enables the service" do
      expect(chef_run).to enable_service 'nginx'
    end

    it "executes common nginx configuration" do
      expect(chef_run).to include_recipe 'nginx::commons'
    end
  end

  it "starts the service" do
    expect(chef_run).to start_service 'nginx'
  end
end

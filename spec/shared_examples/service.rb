require_relative '../../libraries/helpers.rb'
include NginxCookbook::Helpers

RSpec.configure do
  shared_examples_for 'create a named nginx_service' do |servicename|
    it "creates nginx_service[#{servicename}]" do
      expect(chef_run).to create_nginx_service(servicename)
    end
  end

  shared_examples_for 'nginx_service :create' do |servicename|
    it 'installs the nginx package' do
      expect(chef_run).to install_package("#{servicename} :create nginx")
        .with(package_name: 'nginx')
    end

    it 'stops & disables the default service' do
      expect(chef_run).to stop_service('nginx')
      expect(chef_run).to disable_service('nginx')
    end

    it 'creates new directories for the named instance' do
      expect(chef_run).to create_directory("/var/log/nginx-#{servicename}")
        .with(user: user_for_node(chef_run.node), group: 'adm', mode: 00755)

      %W(
        /etc/nginx-#{servicename}
        /etc/nginx-#{servicename}/conf.d
        /etc/nginx-#{servicename}/sites-available
        /etc/nginx-#{servicename}/sites-enabled
      ).each do |instance_dir|
        expect(chef_run).to create_directory(instance_dir)
          .with(user: 'root', group: 'root', mode: 00755)
      end
    end

    it 'templates instance-specific files' do
      expect(chef_run).to create_template("/etc/nginx-#{servicename}/nginx.conf")
        .with(user: 'root', group: 'root', mode: 00644)

      expect(chef_run).to create_template("/etc/logrotate.d/nginx-#{servicename}")
        .with(user: 'root', group: 'root', mode: 00644)
    end
  end

  shared_examples_for 'nginx_service :start' do |servicename|
    it 'starts and enables the service' do
      expect(chef_run).to start_service("nginx-#{servicename} :start")
      expect(chef_run).to enable_service("nginx-#{servicename} :start")
    end
  end

  shared_examples_for 'nginx_service #sysvinit' do |servicename|
    it 'templates instance-specific files' do
      expect(chef_run).to create_template("/etc/init.d/nginx-#{servicename}")
        .with(user: 'root', group: 'root', mode: 00744)
    end
  end

  shared_examples_for 'nginx_service #upstart' do |servicename|
    it 'templates instance-specific files' do
      expect(chef_run).to create_template("/etc/init/nginx-#{servicename}.conf")
        .with(user: 'root', group: 'root', mode: 00744)
    end
  end

  shared_examples_for 'nginx_service #systemd' do |servicename|
    it 'templates instance-specific files' do
      expect(chef_run).to create_template("/etc/nginx-#{servicename}/nginx.conf")
        .with(user: 'root', group: 'root', mode: 00644)
    end
  end
end

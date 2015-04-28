RSpec.configure do
  shared_examples_for 'nginx_config :create' do |servicename|
    it 'templates an nginx config file' do
      expect(chef_run).to create_file("/etc/nginx-#{servicename}/sites-enabled/default")
    end
  end
end

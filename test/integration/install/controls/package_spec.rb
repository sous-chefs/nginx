control 'package' do
  desc   "Ensure #{input('nginx_package_name')} package is installed."
  impact 1.0

  # puts "nginx: #{input_object('nginx_package_name').diagnostic_string}"

  describe package(input('nginx_package_name')) do
    it { should be_installed }
  end
end

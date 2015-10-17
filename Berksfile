source 'https://supermarket.chef.io'

metadata

group :integration do
  cookbook 'apt', '~> 2.6.1'

  cookbook 'nginx_service_test', path: 'test/fixtures/cookbooks/nginx_service_test'

  cookbook 'yum-epel'

  # Or include an entire directory, once we have more test cookbooks:
  # Dir["test/fixtures/cookbooks/**/metadata.rb"].each do |metadata|
  #   cookbook File.basename(File.dirname(metadata)), path: File.dirname(metadata)
  # end
end

# This is an example recipe only, not meant to be used for production deployment.
# This should serve as a simple guide of how to use the resource to set up nginx.
# See more in the README.md and in test/fixtures/cookbooks for more examples.

nginx_service 'example'

file '/tmp/index.htm' do
  content <<-EOF.gsub(/^ {4}/, '')
    <html>
    <body>
    Hello, world!
    </body>
    </html
  EOF
end

# @todo convert this to a proper nginx_config resource
file '/etc/nginx-example/sites-enabled/default' do
  content <<-EOF.gsub(/^ {4}/, '')
    server {
      listen 80 default_server;
      listen [::]:80 default_server ipv6only=on;

      root /tmp;
      index index.html index.htm;

      # Make site accessible from http://localhost/
      server_name localhost;

      location / {
        # First attempt to serve request as file, then
        # as directory, then fall back to displaying a 404.
        try_files $uri $uri/ =404;
      }
    }
  EOF
  notifies :reload, 'nginx_service[example]'
end

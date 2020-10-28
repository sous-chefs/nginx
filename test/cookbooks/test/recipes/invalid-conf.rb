directory '/etc/nginx/sites-enabled/' do
  recursive true
end

file '/etc/nginx/sites-enabled/invalid' do
  content 'Invalid NGINX Config. Fails Validation'
end

include_recipe '::repo'

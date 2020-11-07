directory '/etc/nginx/conf.site.d' do
  recursive true
end

file '/etc/nginx/conf.site.d/invalid.conf' do
  content 'Invalid NGINX Config. Fails Validation'
end

include_recipe '::repo'
include_recipe '::test_site'

# for notification post install / change
ohai 'reload_nginx' do
  plugin 'nginx'
  action :nothing
end

ohai_plugin 'nginx' do
  source_file 'plugins/ohai-nginx.rb.erb'
  variables binary: node['nginx']['binary']
  resource :template
end

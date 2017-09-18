# create files that look similar to an old nginx install under runit
directory '/etc/sv/nginx/supervise' do
  recursive true
end

file '/etc/sv/nginx/supervise/pid' do
  content '1234'
end

file '/usr/bin/sv' do
  action :touch
end

link '/etc/init.d/nginx' do
  to '/usr/bin/sv'
end

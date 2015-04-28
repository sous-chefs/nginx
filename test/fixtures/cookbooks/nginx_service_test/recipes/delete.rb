nginx_service 'single :delete' do
  name 'single'
  action :delete
end

nginx_service 'multi1 :delete' do
  name 'multi1'
  action :delete
end

nginx_service 'multi2 :delete' do
  name 'multi2'
  action :delete
end

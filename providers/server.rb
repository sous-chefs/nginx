action :create do
  template "#{node['nginx']['dir']}/sites-available/#{new_resource.name}" do
    source new_resource.source
    cookbook new_resource.cookbook
    mode 00644
    owner 'root'
    group 'root'
    variables new_resource.variables
    notifies :reload, "service[nginx]"
  end

  if new_resource.enable
    nginx_site new_resource.name do
      enable true
    end
  end

  new_resource.updated_by_last_action(true)
end

action :delete do
  nginx_site new_resource.name do
    enable false
  end

  file "#{node['nginx']['dir']}/sites-available/#{new_resource.name}" do
    action :delete
  end
end

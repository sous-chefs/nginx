property :stream_name, String, name_property: true
property :variables, Hash, default: {}
property :cookbook, String
property :template, [String, Array]

action :enable do
  if new_resource.template
    # use declare_resource so we can have a property also named template
    declare_resource(:template, "#{node['nginx']['dir']}/streams-available/#{new_resource.stream_name}") do
      source new_resource.template
      cookbook new_resource.cookbook
      variables(new_resource.variables)
      notifies :reload, 'service[nginx]'
    end
  end

  execute "nxenstream #{new_resource.stream_name}" do
    command "#{node['nginx']['script_dir']}/nxenstream #{new_resource.stream_name}"
    notifies :reload, 'service[nginx]'
    not_if do
      ::File.symlink?("#{node['nginx']['dir']}/streams-enabled/#{new_resource.stream_name}") ||
        ::File.symlink?("#{node['nginx']['dir']}/streams-enabled/000-#{new_resource.stream_name}")
    end
  end
end

action :disable do
  execute "nxdisstream #{new_resource.stream_name}" do
    command "#{node['nginx']['script_dir']}/nxdisstream #{new_resource.stream_name}"
    notifies :reload, 'service[nginx]'
    only_if do
      ::File.symlink?("#{node['nginx']['dir']}/streams-enabled/#{new_resource.stream_name}") ||
        ::File.symlink?("#{node['nginx']['dir']}/streams-enabled/000-#{new_resource.stream_name}")
    end
  end

  # The nginx.org packages store the default stream at /etc/nginx/conf.d/default.conf and our
  # normal script doesn't disable these.
  if new_resource.stream_name == 'default' && ::File.exist?('/etc/nginx/conf.d/default.conf') # ~FC023
    execute 'Move nginx.org package default stream config to streams-available' do
      command "mv /etc/nginx/conf.d/default.conf #{node['nginx']['dir']}/streams-available/default"
      user 'root'
      notifies :reload, 'service[nginx]'
    end
  end
end

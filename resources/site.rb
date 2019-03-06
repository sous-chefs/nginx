property :site_name, String, name_property: true
property :variables, Hash, default: {}
property :cookbook, String
property :template, [String, Array]
property :nginx_dir, String, lazy { node['nginx']['dir'] }
property :nginx_script_dir, String, lazy { node['nginx']['script_dir'] }

action :enable do
  if new_resource.template
    # use declare_resource so we can have a property also named template
    declare_resource(:template, "#{new_resource.nginx_dir}/sites-available/#{new_resource.site_name}") do
      source new_resource.template
      cookbook new_resource.cookbook
      variables(new_resource.variables)
      notifies :reload, 'service[nginx]'
    end
  end

  execute "nxensite #{new_resource.site_name}" do
    command "#{new_resource.nginx_script_dir}/nxensite #{new_resource.site_name}"
    notifies :reload, 'service[nginx]'
    not_if do
      ::File.symlink?("#{new_resource.nginx_dir}/sites-enabled/#{new_resource.site_name}") ||
        ::File.symlink?("#{new_resource.nginx_dir}/sites-enabled/000-#{new_resource.site_name}")
    end
  end
end

action :disable do
  execute "nxdissite #{new_resource.site_name}" do
    command "#{new_resource.nginx_script_dir}/nxdissite #{new_resource.site_name}"
    notifies :reload, 'service[nginx]'
    only_if do
      ::File.symlink?("#{new_resource.nginx_dir}/sites-enabled/#{new_resource.site_name}") ||
        ::File.symlink?("#{new_resource.nginx_dir}/sites-enabled/000-#{new_resource.site_name}")
    end
  end

  # The nginx.org packages store the default site at /etc/nginx/conf.d/default.conf and our
  # normal script doesn't disable these.
  execute 'Move nginx.org package default site config to sites-available' do
    command "mv /etc/nginx/conf.d/default.conf #{new_resource.nginx_dir}/sites-available/default"
    user 'root'
    notifies :reload, 'service[nginx]'
    only_if { new_resource.site_name == 'default' && ::File.exist?('/etc/nginx/conf.d/default.conf') }
  end
end

property :site_name, String,
         description: 'Which site to enable or disable.',
         name_property: true

property :cookbook, String,
         description: 'Which cookbook to use for the template.',
         default: 'nginx'

property :template, String,
         description: 'Which template to use for the site.'

property :variables, Hash,
         description: 'Additional variables to include in site template.',
         default: {}

action :enable do
  if new_resource.template
    template ::File.join(nginx_dir, "/sites-available/#{new_resource.site_name}") do
      cookbook new_resource.cookbook
      source   new_resource.template
      notifies :reload, 'service[nginx]'
      variables(new_resource.variables)
    end
  end

  execute "nxensite #{new_resource.site_name}" do
    command  ::File.join(nginx_script_dir, "/nxensite #{new_resource.site_name}")
    notifies :reload, 'service[nginx]', :delayed
    not_if   { site_enabled?(new_resource.site_name) }
    only_if  { site_available?(new_resource.site_name) }
  end
end

action :disable do
  execute "nxdissite #{new_resource.site_name}" do
    command  ::File.join(nginx_script_dir, "/nxdissite #{new_resource.site_name}")
    notifies :reload, 'service[nginx]', :delayed
    only_if  { site_enabled?(new_resource.site_name) }
  end

  # The nginx.org packages store the default site at /etc/nginx/conf.d/default.conf and our
  # normal script doesn't disable these.
  if new_resource.site_name == 'default' && ::File.exist?("#{nginx_dir}/conf.d/default.conf")
    execute 'Move nginx.org package default site config to sites-available' do
      command "mv #{nginx_dir}/conf.d/default.conf #{nginx_dir}/sites-available/default"
      user 'root'
      notifies :reload, 'service[nginx]'
    end
  end
end

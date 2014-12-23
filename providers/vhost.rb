use_inline_resources

action :enable do
  execute "nxensite #{new_resource.name}" do
    command "#{node['nginx']['script_dir']}/nxensite #{new_resource.name}"
    not_if do
      ::File.symlink?("#{node['nginx']['dir']}/sites-enabled/#{new_resource.name}") ||
        ::File.symlink?("#{node['nginx']['dir']}/sites-enabled/000-#{new_resource.name}")
    end
  end
end

action :disable do
  execute "nxdissite #{new_resource.name}" do
    command "#{node['nginx']['script_dir']}/nxdissite #{new_resource.name}"
    only_if do
      ::File.symlink?("#{node['nginx']['dir']}/sites-enabled/#{new_resource.name}") ||
        ::File.symlink?("#{node['nginx']['dir']}/sites-enabled/000-#{new_resource.name}")
    end
  end
end

use_inline_resources

action :enable do
  site_template
  execute "nxensite #{new_resource.name}" do
    command "#{node['nginx']['script_dir']}/nxensite #{new_resource.name}"
    not_if "test -f #{new_resource.enabled_dir}/#{new_resource.name} || test -f #{new_resource.enabled_dir}/000-#{new_resource.name}"
    action :run
  end
end

action :disable do
  site_template
  execute "nxdissite #{new_resource.name}" do
    command "#{node['nginx']['script_dir']}/nxdissite #{new_resource.name}"
    only_if "test -f #{new_resource.enabled_dir}/#{new_resource.name} || test -f #{new_resource.enabled_dir}/000-#{new_resource.name}"
    action :run
  end
end

action :delete do
  run_action(:disable)
  site_template.run_action(:delete) if site_template
end

def site_template
  return unless new_resource.template
  @site_template ||= template "#{new_resource.available_dir}/#{new_resource.name}" do
    cookbook new_resource.cookbook
    source new_resource.template
    variables new_resource.variables
  end
end

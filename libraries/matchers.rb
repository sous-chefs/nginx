if defined?(ChefSpec)
  def create_nginx_config(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:nginx_config, :create, resource_name)
  end

  def delete_nginx_config(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:nginx_config, :delete, resource_name)
  end

  def create_nginx_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:nginx_service, :create, resource_name)
  end

  def delete_nginx_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:nginx_service, :delete, resource_name)
  end

  def reload_nginx_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:nginx_service, :reload, resource_name)
  end

  def restart_nginx_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:nginx_service, :restart, resource_name)
  end
end

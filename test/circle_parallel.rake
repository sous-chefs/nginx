require 'kitchen/rake_tasks'

desc 'Run Kitchen tests using CircleCI parallelism mode, split by platform'
task :circle do
  # Load environment-defined config
  def kitchen_loader
    Kitchen::Loader::YAML.new(local_config: ENV['KITCHEN_LOCAL_YAML'])
  end

  def kitchen_config
    Kitchen::Config.new(loader: kitchen_loader)
  end

  def total_workers
    ENV['CIRCLE_NODE_TOTAL'].to_i
  end

  def current_worker
    ENV['CIRCLE_NODE_INDEX'].to_i
  end

  def command
    commands = []

    kitchen_config.platforms.sort_by(&:name).each_with_index do |platform, index|
      next unless index % total_workers == current_worker
      # Escape the platform name to somehting the CLI will understand.
      # TODO: This could likely be pulled from kitchen_config.instances somehow
      name = platform.name.delete('.')

      commands.push "kitchen verify #{name}"
    end

    commands.join(' && ')
  end

  sh command unless command.empty?
end

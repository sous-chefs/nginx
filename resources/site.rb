#
# Cookbook:: nginx
# Resource:: site
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

unified_mode true

include Nginx::Cookbook::Helpers

property :conf_dir, String,
          description: 'The directory to create the site configuraiton file in.',
          default: lazy { nginx_config_site_dir }

property :cookbook, String,
          description: 'Which cookbook to use for the template.',
          default: 'nginx'

property :template, [String, Array],
          description: 'Which template to use for the site.',
          default: 'site-template.erb'

property :owner, String,
          description: 'File/folder user',
          default: lazy { nginx_user }

property :group, String,
          description: 'File/folder group',
          default: lazy { nginx_group }

property :mode, String,
          description: 'File mode',
          default: '0640'

property :folder_mode, String,
          description: 'Folder mode',
          default: '0750'

property :folder_mode, String,
          description: 'Folder mode',
          default: '0750'

property :variables, Hash,
          description: 'Additional variables to include in site template.',
          default: {}

property :list, [true, false],
          description: 'Include in list resource',
          default: true

property :template_helpers, [String, Array],
          description: 'Additional helper modules to include in the site template',
          coerce: proc { |p| p.is_a?(Array) ? p : [p] }

action_class do
  include Nginx::Cookbook::ResourceHelpers

  def config_file
    ::File.join(new_resource.conf_dir, "#{new_resource.name}.conf")
  end

  def config_file_disabled
    "#{config_file}.disabled"
  end
end

action :create do
  directory new_resource.conf_dir do
    owner new_resource.owner
    group new_resource.group
    mode new_resource.folder_mode

    action :create
  end unless ::Dir.exist?(new_resource.conf_dir)

  template config_file do
    cookbook new_resource.cookbook
    source   new_resource.template

    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode

    helpers(Nginx::Cookbook::TemplateHelpers)
    new_resource.template_helpers.each { |th| helpers(::Object.const_get(th)) } unless new_resource.template_helpers.nil?

    variables(
      new_resource.variables.merge({ name: new_resource.name })
    )

    action :create
  end

  add_to_list_resource if new_resource.list
end

action :delete do
  file config_file do
    action :delete
  end

  remove_from_list_resource if new_resource.list
end

action :enable do
  add_to_list_resource if new_resource.list

  ruby_block "Enable site #{new_resource.name}" do
    block { ::File.rename(config_file_disabled, config_file) }

    only_if { ::File.exist?(config_file_disabled) }

    action :nothing
    delayed_action :run
  end
end

action :disable do
  remove_from_list_resource if new_resource.list

  ruby_block "Disable site #{new_resource.name}" do
    block { ::File.rename(config_file, config_file_disabled) }

    only_if { ::File.exist?(config_file) }

    action :nothing
    delayed_action :run
  end
end

#
# Cookbook Name:: nginx
# Recipe:: source
#
# Author:: Adam Jacob (<adam@opscode.com>)
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright 2009-2013, Opscode, Inc.
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

# This is for Chef 10 and earlier where attributes aren't loaded
# deterministically (resolved in Chef 11).
node.load_attribute_by_short_filename('source', 'nginx') if node.respond_to?(:load_attribute_by_short_filename)

nginx_url = node['nginx']['source']['url'] ||
            "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"

node.set['nginx']['binary']          = node['nginx']['source']['sbin_path']
node.set['nginx']['daemon_disable']  = true

unless node['nginx']['source']['use_existing_user']
  user node['nginx']['user'] do
    system true
    shell  '/bin/false'
    home   '/var/www'
  end
end

recipes = [
  'nginx::ohai_plugin',
  'nginx::commons_dir',
  'nginx::commons_script',
  'build-essential::default'
  'bsw_gpg'
  ]

recipes.each { |r| include_recipe r }

src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/nginx-#{node['nginx']['source']['version']}.tar.gz"
packages = value_for_platform_family(
  %w(rhel fedora) => %w(pcre-devel openssl-devel),
  %w(gentoo)      => [],
  %w(default)     => %w(libpcre3 libpcre3-dev libssl-dev)
)

packages.each { |name| package name }

bsw_gpg_load_key_from_string 'a string key' do
    key_contents '
    -----BEGIN PGP PUBLIC KEY BLOCK-----
    Version: GnuPG v1.4.11 (FreeBSD)

    mQENBE7SKu8BCADQo6x4ZQfAcPlJMLmL8zBEBUS6GyKMMMDtrTh3Yaq481HB54oR
    0cpKL05Ff9upjrIzLD5TJUCzYYM9GQOhguDUP8+ZU9JpSz3yO2TvH7WBbUZ8FADf
    hblmmUBLNgOWgLo3W+FYhl3mz1GFS2Fvid6Tfn02L8CBAj7jxbjL1Qj/OA/WmLLc
    m6BMTqI7IBlYW2vyIOIHasISGiAwZfp0ucMeXXvTtt14LGa8qXVcFnJTdwbf03AS
    ljhYrQnKnpl3VpDAoQt8C68YCwjaNJW59hKqWB+XeIJ9CW98+EOAxLAFszSyGanp
    rCqPd0numj9TIddjcRkTA/ZbmCWK+xjpVBGXABEBAAG0IU1heGltIERvdW5pbiA8
    bWRvdW5pbkBtZG91bmluLnJ1PokBOAQTAQIAIgUCTtIq7wIbAwYLCQgHAwIGFQgC
    CQoLBBYCAwECHgECF4AACgkQUgqZk6HAUvj+iwf/b4FS6zVzJ5T0v1vcQGD4ZzXe
    D5xMC4BJW414wVMU15rfX7aCdtoCYBNiApPxEd7SwiyxWRhRA9bikUq87JEgmnyV
    0iYbHZvCvc1jOkx4WR7E45t1Mi29KBoPaFXA9X5adZkYcOQLDxa2Z8m6LGXnlF6N
    tJkxQ8APrjZsdrbDvo3HxU9muPcq49ydzhgwfLwpUs11LYkwB0An9WRPuv3jporZ
    /XgI6RfPMZ5NIx+FRRCjn6DnfHboY9rNF6NzrOReJRBhXCi6I+KkHHEnMoyg8XET
    9lVkfHTOl81aIZqrAloX3/00TkYWyM2zO9oYpOg6eUFCX/Lw4MJZsTcT5EKVxIhG
    BBARAgAGBQJO01Y/AAoJEOzw6QssFyCDVyQAn3qwTZlcZgyyzWu9Cs8gJ0CXREaS
    AJ92QjGLT9DijTcbB+q9OS/nl16Z/IhGBBARAgAGBQJO02JDAAoJEKk3YTmlJMU+
    P64AnjCKEXFelSVMtgefJk3+vpyt3QX1AKCH9M3MbTWPeDUL+MpULlfdyfvjj7kB
    DQRO0irvAQgA0LjCc8S6oZzjiap2MjRNhRFA5BYjXZRZBdKF2VP74avt2/RELq8G
    W0n7JWmKn6vvrXabEGLyfkCngAhTq9tJ/K7LPx/bmlO5+jboO/1inH2BTtLiHjAX
    vicXZk3oaZt2Sotx5mMI3yzpFQRVqZXsi0LpUTPJEh3oS8IdYRjslQh1A7P5hfCZ
    wtzwb/hKm8upODe/ITUMuXeWfLuQj/uEU6wMzmfMHb+jlYMWtb+v98aJa2FODeKP
    mWCXLa7bliXp1SSeBOEfIgEAmjM6QGlDx5sZhr2Ss2xSPRdZ8DqD7oiRVzmstX1Y
    oxEzC0yXfaefC7SgM0nMnaTvYEOYJ9CH3wARAQABiQEfBBgBAgAJBQJO0irvAhsM
    AAoJEFIKmZOhwFL4844H/jo8icCcS6eOWvnen7lg0FcCo1fIm4wW3tEmkQdchSHE
    CJDq7pgTloN65pwB5tBoT47cyYNZA9eTfJVgRc74q5cexKOYrMC3KuAqWbwqXhkV
    s0nkWxnOIidTHSXvBZfDFA4Idwte94Thrzf8Pn8UESudTiqrWoCBXk2UyVsl03gJ
    blSJAeJGYPPeo+Yj6m63OWe2+/S2VTgmbPS/RObn0Aeg7yuff0n5+ytEt2KL51gO
    QE2uIxTCawHr12PsllPkbqPk/PagIttfEJqn9b0CrqPC3HREePb2aMJ/Ctw/76CO
    wn0mtXeIXLCTvBmznXfaMKllsqbsy2nCJ2P2uJjOntw=
    =Tavt
    -----END PGP PUBLIC KEY BLOCK-----'
    for_user 'root'
end

# remove checksum
remote_file nginx_url do
  source   nginx_url
  path     src_filepath
  backup   false
end

node.run_state['nginx_force_recompile'] = false
node.run_state['nginx_configure_flags'] =
  node['nginx']['source']['default_configure_flags'] | node['nginx']['configure_flags']

include_recipe 'nginx::commons_conf'

cookbook_file "#{node['nginx']['dir']}/mime.types" do
  source 'mime.types'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  notifies :reload, 'service[nginx]'
end

# source install depends on the existence of the `tar` package
package 'tar'

# Unpack downloaded source so we could apply nginx patches
# in custom modules - example http://yaoweibin.github.io/nginx_tcp_proxy_module/
# patch -p1 < /path/to/nginx_tcp_proxy_module/tcp.patch
bash 'unarchive_source' do
  cwd  ::File.dirname(src_filepath)
  code <<-EOH
    tar zxf #{::File.basename(src_filepath)} -C #{::File.dirname(src_filepath)}
  EOH
  not_if { ::File.directory?("#{Chef::Config['file_cache_path'] || '/tmp'}/nginx-#{node['nginx']['source']['version']}") }
end

node['nginx']['source']['modules'].each do |ngx_module|
  include_recipe ngx_module
end

configure_flags       = node.run_state['nginx_configure_flags']
nginx_force_recompile = node.run_state['nginx_force_recompile']

bash 'compile_nginx_source' do
  cwd  ::File.dirname(src_filepath)
  code <<-EOH
    cd nginx-#{node['nginx']['source']['version']} &&
    ./configure #{node.run_state['nginx_configure_flags'].join(' ')} &&
    make && make install
  EOH

  not_if do
    nginx_force_recompile == false &&
      node.automatic_attrs['nginx'] &&
      node.automatic_attrs['nginx']['version'] == node['nginx']['source']['version'] &&
      node.automatic_attrs['nginx']['configure_arguments'].sort == configure_flags.sort
  end

  notifies :restart, 'service[nginx]'
  notifies :reload,  'ohai[reload_nginx]', :immediately
end

case node['nginx']['init_style']
when 'runit'
  node.set['nginx']['src_binary'] = node['nginx']['binary']
  include_recipe 'runit::default'

  runit_service 'nginx'

  service 'nginx' do
    supports       :status => true, :restart => true, :reload => true
    reload_command "#{node['runit']['sv_bin']} hup #{node['runit']['service_dir']}/nginx"
  end
when 'bluepill'
  include_recipe 'bluepill::default'

  template "#{node['bluepill']['conf_dir']}/nginx.pill" do
    source 'nginx.pill.erb'
    mode   '0644'
  end

  bluepill_service 'nginx' do
    action [:enable, :load]
  end

  service 'nginx' do
    supports       :status => true, :restart => true, :reload => true
    reload_command "[[ -f #{node['nginx']['pid']} ]] && kill -HUP `cat #{node['nginx']['pid']}` || true"
    action         :nothing
  end
when 'upstart'
  # we rely on this to set up nginx.conf with daemon disable instead of doing
  # it in the upstart init script.
  node.set['nginx']['daemon_disable']  = node['nginx']['upstart']['foreground']

  template '/etc/init/nginx.conf' do
    source 'nginx-upstart.conf.erb'
    owner  'root'
    group  node['root_group']
    mode   '0644'
  end

  service 'nginx' do
    provider Chef::Provider::Service::Upstart
    supports :status => true, :restart => true, :reload => true
    action   :nothing
  end
else
  node.set['nginx']['daemon_disable'] = false

  generate_init = true

  case node['platform']
  when 'gentoo'
    generate_template = false
  when 'debian', 'ubuntu'
    generate_template = true
    defaults_path    = '/etc/default/nginx'
  when 'freebsd'
    generate_init    = false
  else
    generate_template = true
    defaults_path    = '/etc/sysconfig/nginx'
  end

  template '/etc/init.d/nginx' do
    source 'nginx.init.erb'
    owner  'root'
    group  node['root_group']
    mode   '0755'
  end if generate_init

  if generate_template
    template defaults_path do
      source 'nginx.sysconfig.erb'
      owner  'root'
      group  node['root_group']
      mode   '0644'
    end
  end

  service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action   :enable
  end
end

node.run_state.delete('nginx_configure_flags')
node.run_state.delete('nginx_force_recompile')

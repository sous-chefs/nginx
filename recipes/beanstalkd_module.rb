#
# Cookbook Name:: nginx
# Recipe:: beanstalkd_module
#
# Author:: Jahn Bertsch
#
# Copyright 2012, Jahn Bertsch
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

beanstalkd_url = "https://github.com/calio/beanstalkd-nginx-module/tarball/master"
beanstalkd_src = "#{Chef::Config[:file_cache_path] || '/tmp'}/nginx-beanstalkd-module"

# download
remote_file beanstalkd_url do
  source beanstalkd_url
  path "#{beanstalkd_src}.tar.gz"
  backup false
end

# extract
bash "extract_beanstalkd_module_source" do
  cwd ::File.dirname(beanstalkd_src)
  code <<-EOH
    rm -rf #{beanstalkd_src}
    mkdir #{beanstalkd_src}
    tar zxf #{beanstalkd_src}.tar.gz --strip-components=1 -C #{beanstalkd_src}
  EOH
end

# add to nginx's configure command
node.run_state[:nginx_configure_flags] =
  node.run_state[:nginx_configure_flags] | ["--add-module=#{beanstalkd_src}"]

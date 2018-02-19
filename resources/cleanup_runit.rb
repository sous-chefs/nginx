#
# Copyright:: 20017-2018, Chef Software, Inc.
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
action :cleanup do
  # remove old init script link
  file 'remove symlinked runit init script' do
    path '/etc/init.d/nginx'
    manage_symlink_source false # nuke the link not the runit binary
    action :delete
    only_if { ::File.exist?('/etc/init.d/nginx') && ::File.symlink?('/etc/init.d/nginx') && ::File.realpath('/etc/init.d/nginx') == '/usr/bin/sv' }
  end

  execute 'kill old nginx process' do
    command 'pkill nginx'
    returns [0, 1] # ignores failures
    not_if { !::File.exist?('/etc/sv/nginx/supervise/pid') || ::File.zero?('/etc/sv/nginx/supervise/pid') }
  end

  # remove the old service configs
  directory '/etc/sv/nginx' do
    recursive true
    action :delete
  end
end

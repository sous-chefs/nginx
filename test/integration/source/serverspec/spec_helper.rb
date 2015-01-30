# Encoding: utf-8
require 'serverspec'
require 'pathname'
require 'json'

set :backend, :exec
set :path, '/sbin:/usr/local/sbin:$PATH'

set :env, :LANG => 'C', :LC_MESSAGES => 'C'

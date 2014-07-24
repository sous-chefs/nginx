#
# Cookbook Name:: nginx
# Recipe:: pagespeed_module
#
default['nginx']['pagespeed']['version'] = '1.8.31.4'
default['nginx']['pagespeed']['url']     = "https://github.com/pagespeed/ngx_pagespeed/archive/release-#{node['nginx']['pagespeed']['version']}-beta.tar.gz"
default['nginx']['psol']['url']          = "https://dl.google.com/dl/page-speed/psol/#{node['nginx']['pagespeed']['version']}.tar.gz"
default['nginx']['pagespeed']['packages']['rhel'] = %w(gcc-c++ pcre-dev pcre-devel zlib-devel make)
default['nginx']['pagespeed']['packages']['debian'] = %w(build-essential zlib1g-dev libpcre3 libpcre3-dev)

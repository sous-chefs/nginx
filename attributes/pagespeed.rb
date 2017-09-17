#
# Cookbook:: nginx
# Recipe:: pagespeed_module
#
default['nginx']['pagespeed']['version'] = '1.11.33.2'
default['nginx']['pagespeed']['url']     = "https://github.com/pagespeed/ngx_pagespeed/archive/release-#{node['nginx']['pagespeed']['version']}-beta.tar.gz"
default['nginx']['psol']['url']          = "https://dl.google.com/dl/page-speed/psol/#{node['nginx']['pagespeed']['version']}.tar.gz"
default['nginx']['pagespeed']['packages']['rhel'] = %w(pcre-devel zlib-devel)
default['nginx']['pagespeed']['packages']['debian'] = %w(zlib1g-dev libpcre3 libpcre3-dev)

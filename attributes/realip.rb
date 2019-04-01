# Currently only accepts X-Forwarded-For or X-Real-IP
default['nginx']['realip']['header']            = 'X-Forwarded-For'
default['nginx']['realip']['addresses']         = ['127.0.0.1']
default['nginx']['realip']['real_ip_recursive'] = 'off'

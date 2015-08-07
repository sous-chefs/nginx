default['nginx']['upstream_check_module']['version'] = '10782eaff51872a8f44e65eed89bbe286004bcb1'
default['nginx']['upstream_check_module']['url'] = 'https://github.com/yaoweibin/nginx_upstream_check_module/archive/{version}.zip'
default['nginx']['upstream_check_module']['patches'] = {
  Gem::Version.new('0.0.0') => 'check.patch',
  Gem::Version.new('1.2.1') => 'check_1.2.1.patch',
  Gem::Version.new('1.2.2') => 'check_1.2.2+.patch',
  Gem::Version.new('1.2.6') => 'check_1.2.6+.patch',
  Gem::Version.new('1.3.0') => 'check_1.2.1.patch',
  Gem::Version.new('1.3.1') => 'check_1.2.2+.patch',
  Gem::Version.new('1.3.9') => 'check_1.2.6+.patch',
  Gem::Version.new('1.5.12') => 'check_1.5.12+.patch',
  Gem::Version.new('1.7.2') => 'check_1.7.2+.patch',
  Gem::Version.new('1.7.5') => 'check_1.7.5+.patch',
  Gem::Version.new('1.9.2') => 'check_1.9.2+.patch'
}

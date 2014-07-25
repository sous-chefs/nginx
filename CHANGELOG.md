nginx Cookbook CHANGELOG
========================
This file is used to list changes made in each version of the nginx cookbook.


v2.7.4 (2014-06-06)
-------------------
* [COOK-4703] Default openssl version to 1.0.1h to address CVE-2014-0224


v2.7.2 (2014-05-27)
-------------------

- [COOK-4658] - Nginx::socketproxy if the context is blank or nonexistant, the location in the config file has a double slash at the beginning
- [COOK-4644] - add support to nginx::repo for Amazon Linux
- Allow .kitchen.cloud.yml to use an environment variable for the EC2 Availability Zone


v2.7.0 (2014-05-15)
-------------------
- [COOK-4643] - Update metadata lock on ohai
- [COOK-4588] - Give more love to FreeBSD
- [COOK-4601] - Add proxy type: Socket


v2.6.2 (2014-04-09)
-------------------
[COOK-4527] - set default openssl source version to 1.0.1g to address CVE-2014-0160 aka Heartbleed


v2.6.0 (2014-04-08)
-------------------
- Reverting COOK-4323


v2.5.0 (2014-03-27)
-------------------
- [COOK-4323] - Need a resource to easily configure available sites (vhosts)


v2.4.4 (2014-03-13)
-------------------
- Updating for build-essential 2.0


v2.4.2 (2014-02-28)
-------------------
Fixing bad commit from COOK-4330


v2.4.1 (2014-02-27)
-------------------
- [COOK-4345] - nginx default recipe include install type recipe directly


v2.4.0 (2014-02-27)
-------------------
- [COOK-4380] - kitchen.yml platform listings for ubuntu-10.04 and ubuntu-12.04 are missing the dot
- [COOK-4330] - Bump nginx version for security issues (CVE-2013-0337, CVE-2013-4547)


v2.3.0 (2014-02-25)
-------------------
- **[COOK-4293](https://tickets.opscode.com/browse/COOK-4293)** - Update testing Gems in nginx and fix a rubocop warnings
- **[COOK-4237] - Nginx version incorrectly parsed on Ubuntu 13
- **[COOK-3866] - Nginx default site folder


v2.2.2 (2014-01-23)
-------------------
[COOK-3672] - Add gzip_static option


v2.2.0
------
No changes. Version bump for toolchain


v2.1.0
------
[COOK-3923] - Enable the list of packages installed by nginx::passenger to be configurable
[COOK-3672] - Nginx should support the gzip_static option
Updating for yum ~> 3.0
Fixing up style for rubocop
Updating test-kitchen harness


v2.0.8
------
fixing metadata version error. locking to 3.0


v2.0.6
------
Locking yum dependency to '< 3'


v2.0.4
------
### Bug
- **[COOK-3808](https://tickets.opscode.com/browse/COOK-3808)** - nginx::passenger run fails because of broken installation of package dependencies
- **[COOK-3779](https://tickets.opscode.com/browse/COOK-3779)** - Build in master fails due to rubocop error


v2.0.2
------
### Bug
- **[COOK-3808](https://tickets.opscode.com/browse/COOK-3808)** - nginx::passenger run fails because of broken installation of package dependencies
- **[COOK-3779](https://tickets.opscode.com/browse/COOK-3779)** - Build in master fails due to rubocop error


v2.0.0
------
### Improvement
- **[COOK-3733](https://tickets.opscode.com/browse/COOK-3733)** - Add RPM key names and GPG checking
- **[COOK-3687](https://tickets.opscode.com/browse/COOK-3687)** - Add support for `http_perl`
- **[COOK-3603](https://tickets.opscode.com/browse/COOK-3603)** - Add a recipe for using custom openssl
- **[COOK-3602](https://tickets.opscode.com/browse/COOK-3602)** - Use an attribute for the status module port
- **[COOK-3549](https://tickets.opscode.com/browse/COOK-3549)** - Refactor custom modules support
- **[COOK-3521](https://tickets.opscode.com/browse/COOK-3521)** - Add support for `http_auth_request`
- **[COOK-3520](https://tickets.opscode.com/browse/COOK-3520)** - Add support for `spdy`
- **[COOK-3185](https://tickets.opscode.com/browse/COOK-3185)** - Add `gzip_*` attributes
- **[COOK-2712](https://tickets.opscode.com/browse/COOK-2712)** - Update `upload_progress` version to 0.9.0

### Bug
- **[COOK-3686](https://tickets.opscode.com/browse/COOK-3686)** - Remove deprecated 'passenger_use_global_queue' directive
- **[COOK-3626](https://tickets.opscode.com/browse/COOK-3626)** - Parameterize hardcoded path to helper scripts
- **[COOK-3571](https://tickets.opscode.com/browse/COOK-3571)** - Reloda ohai plugin after installation
- **[COOK-3428](https://tickets.opscode.com/browse/COOK-3428)** - Fix an issue where access logs are not disabled when the `disable_access_log` attribute is set to `true`
- **[COOK-3322](https://tickets.opscode.com/browse/COOK-3322)** - Fix an issue where `nginx::ohai_plugin` fails when using source recipe
- **[COOK-3241](https://tickets.opscode.com/browse/COOK-3241)** - Fix an issue where`nginx::ohai_plugin` fails unless using source recipe

### New Feature
- **[COOK-3605](https://tickets.opscode.com/browse/COOK-3605)** - Add Lua module


v1.8.0
------
### Bug
- **[COOK-3397](https://tickets.opscode.com/browse/COOK-3397)** - Fix user from nginx package on Gentoo
- **[COOK-2968](https://tickets.opscode.com/browse/COOK-2968)** - Fix foodcritic failure
- **[COOK-2723](https://tickets.opscode.com/browse/COOK-2723)** - Remove duplicate  passenger `max_pool_size`

### Improvement
- **[COOK-3186](https://tickets.opscode.com/browse/COOK-3186)** - Add `client_body_buffer_size` and `server_tokens attributes`
- **[COOK-3080](https://tickets.opscode.com/browse/COOK-3080)** - Add rate-limiting support
- **[COOK-2927](https://tickets.opscode.com/browse/COOK-2927)** - Add support for `real_ip_recursive` directive
- **[COOK-2925](https://tickets.opscode.com/browse/COOK-2925)** - Fix ChefSpec converge
- **[COOK-2724](https://tickets.opscode.com/browse/COOK-2724)** - Automatically create directory for PID file
- **[COOK-2472](https://tickets.opscode.com/browse/COOK-2472)** - Bump nginx version to 1.2.9
- **[COOK-2312](https://tickets.opscode.com/browse/COOK-2312)** - Add additional `mine_types` to the `gzip_types` value

### New Feature
- **[COOK-3183](https://tickets.opscode.com/browse/COOK-3183)** - Allow inclusion in extra-cookbook modules

v1.7.0
------
### Improvement
- [COOK-3030]: The repo_source attribute should allow you to not add any additional repositories to your node

### Sub-task
- [COOK-2738]: move nginx::passenger attributes to `nginx/attributes/passenger.rb`

v1.6.0
------
### Task
- [COOK-2409]: update nginx::source recipe for new `runit_service` resource
- [COOK-2877]: update nginx cookbook test-kitchen support to 1.0 (alpha)

### Improvement
- [COOK-1976]: nginx source should be able to configure binary path
- [COOK-2622]: nginx: add upstart support
- [COOK-2725]: add "configtest" subcommand in initscript

### Bug
- [COOK-2398]: nginx_site definition cannot be used to manage the default site
- [COOK-2493]: Resources in nginx::source recipe always use 1.2.6 version, even overriding version attribute
- [COOK-2531]: Remove usage of non-existant attribute "description" for `apt_repository`
- [COOK-2665]: nginx::source install with custom sbin_path breaks ohai data

v1.4.0
------
- [COOK-2183] - Install nginx package from nginxyum repo
- [COOK-2311] - headers-more should be updated to the latest version
- [COOK-2455] - Support sendfile option (nginx.conf)

v1.3.0
------
- [COOK-1979] - Passenger module requires curl-dev(el)
- [COOK-2219] - Support `proxy_read_timeout` (in nginx.conf)
- [COOK-2220] - Support `client_max_body_size` (in nginx.conf)
- [COOK-2280] - Allow custom timing of nginx_site's reload notification
- [COOK-2304] - nginx cookbook should install 1.2.6 not 1.2.3 for source installs
- [COOK-2309] - checksums for geoip files need to be updated in nginx
- [COOK-2310] - Checksum in the `nginx::upload_progress` recipe is not correct
- [COOK-2314] - nginx::passenger: Install the latest version of passenger
- [COOK-2327] - nginx: passenger recipe should find ruby via Ohai
- [COOK-2328] - nginx: Update mime.types file to the latest
- [COOK-2329] - nginx: Update naxsi rules to the current

v1.2.0
------
- [COOK-1752] - Add headers more module to the nginx cookbook
- [COOK-2209] - nginx source recipe should create web user before creating directories
- [COOK-2221] - make nginx::source compatible with gentoo
- [COOK-2267] - add version for runit recommends

v1.1.4
------
- [COOK-2168] - specify package name as an attribute

v1.1.2
------
- [COOK-1766] - Nginx Source Recipe Rebuilding Source at Every Run
- [COOK-1910] - Add IPv6 module
- [COOK-1966] - nginx cookbook should let you set `gzip_vary` and `gzip_buffers` in  nginx.conf
- [COOK-1969]- - nginx::passenger module not included due to use of symbolized `:nginx_configure_flags`
- [COOK-1971] - Template passenger.conf.erb configures key `passenger_max_pool_size` 2 times
- [COOK-1972] - nginx::source compile_nginx_source reports success in spite of failed compilation
- [COOK-1975] - nginx::passenger requires rake gem
- [COOK-1979] - Passenger module requires curl-dev(el)
- [COOK-2080] - Restart nginx on source compilation

v1.1.0
------
- [COOK-1263] - Nginx log (and possibly other) directory creations should be recursive
- [COOK-1515] - move creation of `node['nginx']['dir']` out of commons.rb
- [COOK-1523] - nginx `http_geoip_module` requires libtoolize
- [COOK-1524] - nginx checksums are md5
- [COOK-1641] - add "use", "`multi_accept`" and "`worker_rlimit_nofile`" to nginx cookbook
- [COOK-1683] - Nginx fails Windows nodes just by being required in metadata
- [COOK-1735] - Support Amazon Linux in nginx::source recipe
- [COOK-1753] - Add ability for nginx::passenger recipe to configure more Passenger global settings
- [COOK-1754] - Allow group to be set in nginx.conf file
- [COOK-1770] - nginx cookbook fails on servers that don't have a "cpu" attribute
- [COOK-1781] - Use 'sv' to reload nginx when using runit
- [COOK-1789] - stop depending on bluepill, runit and yum. they are not required by nginx cookbook
- [COOK-1791] - add name attribute to metadata
- [COOK-1837] - nginx::passenger doesn't work on debian family
- [COOK-1956] - update naxsi version due to incompatibility with newer nginx

v1.0.2
------
- [COOK-1636] - relax the version constraint on ohai

v1.0.0
------
- [COOK-913] - defaults for gzip cause warning on service restart
- [COOK-1020] - duplicate MIME type
- [COOK-1269] - add passenger module support through new recipe
- [COOK-1306] - increment nginx version to 1.2 (now 1.2.3)
- [COOK-1316] - default site should not always be enabled
- [COOK-1417] - resolve errors preventing build from source
- [COOK-1483] - source prefix attribute has no effect
- [COOK-1484] - source relies on /etc/sysconfig
- [COOK-1511] - add support for naxsi module
- [COOK-1525] - nginx source is downloaded every time
- [COOK-1526] - nginx_site does not remove sites
- [COOK-1527] - add `http_echo_module` recipe

v0.101.6
--------
Erroneous cookbook upload due to timeout.

Version #'s are cheap.

v0.101.4
--------
- [COOK-1280] - Improve RHEL family support and fix ohai_plugins recipe bug
- [COOK-1194] - allow installation method via attribute
- [COOK-458] - fix duplicate nginx processes

v0.101.2
--------
* [COOK-1211] - include the default attributes explicitly so version is available.

v0.101.0
--------
**Attribute Change**: `node['nginx']['url']` -> `node['nginx']['source']['url']`; see the README.md.

- [COOK-1115] - daemonize when using init script
- [COOK-477] - module compilation support in nginx::source

v0.100.4
--------
- [COOK-1126] - source version bump to 1.0.14

v0.100.2
--------
- [COOK-1053] - Add :url attribute to nginx cookbook

v0.100.0
--------
- [COOK-818] - add "application/json" per RFC.
- [COOK-870] - bluepill init style support
- [COOK-957] - Compress application/javascript.
- [COOK-981] - Add reload support to NGINX service

v0.99.2
-------
- [COOK-809] - attribute to disable access logging
- [COOK-772] - update nginx download source location

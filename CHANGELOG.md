# nginx Cookbook CHANGELOG

This file is used to list changes made in each version of the nginx cookbook.

## Unreleased

Standardise files with files in sous-chefs/repo-management

## 12.1.2 - *2023-02-15*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 12.1.1 - *2022-12-08*

Standardise files with files in sous-chefs/repo-management

## 12.1.0 - *2022-08-30*

- Security fixes
  - Fix nginx running as root on Debian family
  - Fix webserver able to overwrite/delete config files
  - Add Inspec tests

## 12.0.12 - *2022-04-20*

Standardise files with files in sous-chefs/repo-management

## 12.0.11 - *2022-02-04*

- Remove delivery and move to calling RSpec directly via a reusable workflow
- Update tested platforms

## 12.0.10 - *2021-11-26*

- Fix CI Badge Link in README

## 12.0.9 - *2021-11-24*

- Change the unit tested Debian platform to bullseye

## 12.0.8 - *2021-11-23*

- Rename `config_dir` to `conf_dir` in nginx_site.md

## 12.0.7 - *2021-10-08*

- Correct default value for `config_dir` in nginx_site.md

## 12.0.6 - *2021-09-04*

- Fix repo helper incorrect version for SLES
- Set default user/group to `root` for Debian/Ubuntu platforms

## 12.0.5 - *2021-08-30*

- Standardise files with files in sous-chefs/repo-management
- Fix ChefSpec test

## 12.0.4 - *2021-06-01*

- Standardise files with files in sous-chefs/repo-management

## 12.0.3 - *2021-05-12*

- Only trigger ohai refresh on plugin installation

## 12.0.2 - *2021-05-11*

- Standardise files with files in sous-chefs/repo-management

## 12.0.1 - *2021-05-10*

- Refactor the default site template
  - Cast to Array where possible to remove type check logic.
  - Make upstream options key optional.
  - Add test case for overriding template.

## 12.0.0 - *2021-05-07*

- Enable unified_mode resource for Chef 17
- Remove dependency on the deprecated ohai cookbook

## 11.5.3 - *2021-04-20*

- Fix site template: remove unmatching rbrace in options

## 11.5.2 - *2021-04-16*

## 11.5.1 - *2021-03-29*

- Fix start/restart/reload delayed actions - [@bmhughes](https://github.com/bmhughes)

## 11.5.0 - *2021-03-26*

- Fix generating multiple actions from the service resource - [@bmhughes](https://github.com/bmhughes)
- Kitchen test with CentOS 8 stream - [@bmhughes](https://github.com/bmhughes)
- Refactor helpers - [@bmhughes](https://github.com/bmhughes)

## 11.4.0 - *2021-02-27*

- Refactor `ResourceHelpers` library to inherit properties from the calling resource
- Allow for inclusion of arbitrary template helper modules

## 11.3.1 - *2021-02-25*

- Fixup the default site template and update nginx_site doc to match

## 11.3.0 - *2021-02-11*

- Add seperate `process_*` properties for nginx process use and group to `nginx_config` resource (Issue #572)
  - Deprecate and alias the `user` property as the `process_*` properties supercede it

## 11.2.0 - *2021-01-20*

- Add file and folder mode overrides to `nginx_config` and `nginx_site`

## 11.1.1 - *2020-12-08*

- Fix site containing directory creation when nginx_config is not used

## 11.1.0 - *2020-12-07*

- Add `repo_train` property to nginx_install to select stable/mainline when installing from the nginx repo.
- Add `packages_versions` property to nginx_install to specify specific package versions.

## 11.0.0 - *2020-12-02*

- Refactor cookbook to remove nxensite/nxdissite
- Remove all configuration resources from nginx_install.
- Move all general configuration to nginx_config.
- Refactor nginx_site to remove use of scripts.
- Create nginx_service resource to manage nginx service.
- Remove passenger install option.

## 10.6.1 (2020-11-16)

- Update log to display at end of run to be more visible

## 10.6.0 (2020-11-03)

- Allow multiple packages to be specified for install package name override.

## 10.5.0 (2020-10-28)

- Added a guard and log message to prevent starting/restarting/reloading the service when the config is invalid (#559)

## 10.4.0 (2020-10-26)

- Allow list of template source for site resource (template property)
- Allow list of template source for install and config resource (conf_template property)

## 10.3.2 (2020-10-02)

- Add nginx namespace for `site_available?` and `site_enabled?` helper methods

## 10.3.1 (2020-09-16)

- resolved cookstyle error: libraries/helpers.rb:108:1 refactor: `ChefCorrectness/IncorrectLibraryInjection`

## 10.3.0 (2020-08-22)

- added `override_package_name` to `nginx_install` to allow overriding the name of the package requesting to be installed.

## 10.2.0 (2020-08-20)

- Add centos 8 support to cookbook
- Disable nginx dnf module when installing from repo
- Added 'provides' to the resources

## 10.1.1 (2020-07-27)

- Change resource logging to use Chef::Log instead of the log resource. Resource update
 status reporting may change. The log resource always implies the surrounding resource
 was updated. #551
- Update the resource documentation to clarify extra variables properties #550
- Automated PR: Standardising Files #544 #547 #548

## 10.1.0 (2020-05-05)

- Log distro installation only on log level info
- Remove leftovers from nginx stream functions
- resolved cookstyle error: libraries/helpers.rb:108:16 warning: `Lint/SendWithMixinArgument`
- resolved cookstyle error: libraries/helpers.rb:109:16 warning: `Lint/SendWithMixinArgument`
- Remove CentOS 6 from the test matrix
- Update testing platforms
- Fix markdown for the install resource
- Install packages we need for https passenger repos before we set them up
- Remove redundant `apt_repository` distribution logic
- Migrate to Github actions

## 10.0.2 (2019-09-24)

- Bug Fix: Add missing service resource in `nginx_site` resource. [Issue #505](https://github.com/sous-chefs/nginx/issues/505))

## 10.0.1 (2019-08-04)

- Maintenance: Add contributing.md file for cookbook health metrics
- Feature: Add support for Fedora

## 10.0.0 (2019-08-04)

- *Breaking Change:* Remove all attributes
- *Breaking Change:* Remove all recipes
- *Breaking Change:* Remove source install
- *Breaking Change:* Remove modules
- *Breaking Change:* Remove community_cookbook_releaser gem
- *Breaking Change:* Support only Operating Systems with systemd
  - Remove support for Fedora, Amazon Linux, CentOS 6, openSUSE Leap 42
- *Breaking Change:* Cookbook now requires Chef >= 14
- Feature: Add resources for all recipes
- Feature: Add nginx_install custom resource with source properties distro, repo, epel and passenger
- Feature: Add nginx_config custom resource
- Feature: Add support for openSUSE Leap 15
- Feature: Add support for Amazon Linux 2
- Feature: Add support to deactivate anonymous telemetry reporting when using Passenger.
- Bug Fix: Ensure systemd unit file is reloaded (specifically for upgrade or downgrade) source complile install method.
- Bug Fix: Ensure apt-transport-https package is installed on Debian/Ubuntu for apt_repository resource
- Bug Fix: compiling nginx from source triggers systemd to reload services to avoid systemd run 'systemctl daemon-reload' related errors
- Maintenance: Move spec/libraries to spec/unit/libraries
- Maintenance: Bump ohai dependency to ~> 5.2
- CI: Update kitchen to use chef solo
- CI: Add CircleCI testing
- CI: Update circleci sous-chefs orb to version 2
- Tidy: Remove unused files from the repository

## 9.0.0 (2018-11-13)

- This cookbook now requires Chef 13.3 or later, but no longer requires the zypper cookbook. This cookbook was throwing deprecation warnings for users of current Chef 14 releases.

## 8.1.6 (2018-10-05)

- passenger: fixed install order
- passenger Ubuntu 18.04 support
- Evaluate ohai_plugin_enabled in the source recipe
- Abstract nginx users home path to attribute

## 8.1.5 (2018-07-23)

- Fixes cookbook fails when installing repo passenger because there is no service declaration inline
- Add proxy buffers options

## 8.1.4 (2018-07-18)

- Adds the ability to toggle Ohai Plugin
- Use build_essential resource instead of the cookbook so we can use the built in resource on Chef 14+

## 8.1.2 (2018-02-26)

- Add map_hash_max_size as configuration option

## 8.1.1 (2018-02-26)

- Use Chef::VersionConstraint in auth request module so we properly compare versions

## 8.1.0 (2018-02-19)

- Added a new nginx_stream resource for enabling/disable nginx stream blocks
- Make sure we install zlib for source installs. This gives us compression support and fixes compilation on Debian 9

## 8.0.1 (2018-02-16)

- Update the required Chef release to 12.14 since we're using yum/apt repository resources
- Add a new 'site_name' property to the nginx_site resource. This allows you to specify a site name if it differs from the resource name
- Removed the check for nginx < 1.2 in the realip module

## 8.0.0 (2018-02-16)

- Remove ChefSpec matchers since these are autogenerated now
- Remove compat_resource cookbook dependency and require Chef 12.7+ instead
- Expand testing and test on Amazon Linux

## 7.0.2 (2017-11-22)

- Fix a bug that led to nginx recompiling when it didn't need to

## 7.0.1 (2017-11-14)

- Move passenger test attributes into the cookbook
- Resolve FC108 warning

## 7.0.0 (2017-09-18)

### Breaking Changes

- This release of the nginx cookbook merges all changes that occurred within the chef_nginx fork from 2.8 - 6.2\. This includes multiple breaking changes along with a large number of improvements and bug fixes. If you're upgrading from 2.7 to current make sure to read the whole changelog to make sure you're ready.

### Other Changes

- Added a new resource nginx_runit_cleanup has been introduced which stops the existing nginx runit service and removes the init files. This is now called automatically from the default recipe to cleanup an existing installation. This should make it possible for users to migrate from the 2.X release to the current w/o manual steps.
- Fixed compile failures on Fedora and any other distros released in the future which use GCC 7
- Added the .m3u8 mimetype
- Moved all files out of the files/default directory since this isn't required with Chef 12 and later
- Added ulimit to the nginx sysconfig file for RHEL platforms

## 6.2.0 (2017-09-12)

- Install basic configuration before starting the nginx service
- Correct documentation for `rate_limiting_backoff` attribute
- Phusion Passenger distro has pid file location in /run/nginx.pid
- [GH-92] add a test suite for passenger install
- Swap the maintainer files for a readme section
- Update nginx version [1.12.1] and checksum attributes for source installs
- Update versions and checksums for lua-nginx-module and echo-nginx-module
- Simplify repo logic and use HTTPS repos

## 6.1.1 (2017-06-08)

- Use multipackage installs in the pagespeed recipe to speed things up
- Several fixes for Amazon Linux on Chef 13+

## 6.1.0 (2017-06-07)

- Add attributes for setting the repository URLs
- Fix support for Amazon Linux repos on Chef 13+

## 6.0.3 (2017-06-05)

- Correctly compare nginx versions with multiple digits so 1.10 is properly recognized as coming after 1.2.

## 6.0.2 (2017-04-27)

- Resolve name conflicts in the resource

## 6.0.1 (2017-04-04)

- double quotes are unnecessary in lua configure flags

## 6.0.0 (2017-03-25)

### Breaking change

- Support for Runit as an init system has been removed. If you require runit you will need to pin to the 5.X cookbook release. We highly recommend using either systemd or upstart instead of Runit.

### Other changes

- Install nginx 1.10.3 for source based installs
- Remove freebsd cookbook from testing as it's not necessary anymore
- Bump OpenSSL to 1.0.2k

## 5.1.3 (2017-03-24)

- Update apache2 license string
- Add image/svg+xml to gzip_files defaults
- support `worker_shutdown_timeout` released in 1.11.11

## 5.1.2 (2017-03-14)

- Setup LD options to include /usr/local/lib for libluajit in search path and bump the lua version

## 5.1.1 (2017-03-02)

- Add WantedBy to systemd service file so it starts at boot
- Avoid a warning in nginx_site by moving the template check outside the resource
- Allow nginx_site to specify template as an array of templates

## 5.1.0 (2017-03-01)

- Support the load_module directive
- Test with Local Delivery and not Rake
- Remove EOL platforms from the kitchen configs

## 5.0.7 (2017-02-12)

- Fix Opsworks compatibility
- Resolve a Chef 13 deprecation warning

## 5.0.6 (2017-01-16)

- Rebuild shared library cache after installing luajit

## 5.0.5 (2017-01-09)

- Fix typo in the pagespeed recipe

## 5.0.4 (2017-01-04)

- Avoid deprecation warnings by only defining nginx service once

## 5.0.3 (2017-01-03)

- Add ability to write passenger log to another location
- Properly disable the default site with nginx.org packages

## 5.0.2 (2016-12-22)

- Requite the latest compat_resource

## 5.0.1 (2016-12-13)

- Use multipackage in pagespeed module recipe to speed up installs
- Simplify the distro repo setup logic to ensure we're using the correct repos under all conditions. Previously the upstream repo was being missed on Suse systems
- Determine pidfile location correctly via a helper so we correctly set pidfiles when using Upstream packages on Ubuntu 14.04 / 16.04\. This involved removing the attribute for the pidfile location, which may cause issues if you relied on that attribute.
- Testing improvements to make sure all suites run and the suites are testing the correct conditions

## 5.0.0 (2016-12-07)

### Breaking changes

- Default to the upstream nginx.org repo for package installs. The official nginx repo gives an improved experience over outdated distro releases. This can be disabled via attribute if you'd like to remain on the distro packages.

### Other changes

- Add a deprecation warning when using runit
- Rewrite the readme usage section
- Better document how to compile modules

## 4.0.2 (2016-12-01)

- Default to openssl 1.0.2j with source installs
- Add cookbook property to the nginx_site resource to allow using templates defined in other cookbooks
- Prevent default docroot index.html on bad url in status
- Readme improvements

## 4.0.1 (2016-10-31)

- Fix a version check in the realip recipe
- Align the config with the default config a bit
- Fix the ChefSpec matchers now that nginx_site is a custom resource

## 4.0.0 (2016-10-31)

### Breaking changes

The nginx_site definition is now a custom_resource. This improves the overall experience and allows for notifications and reporting on resource updates. It does change the behavior in some circumstances however. Previously to disable a site you would set 'enable false' on your definition. This will still function, but will result in a deprecation warning. Instead you should use 'action :disable' since this is a real resource now.

### Other changes

- Avoid splitting on compile params in the ohai plugin, which resulted in some source installs attempting to install on every Chef run.
- Expanded testing and improved kitchen suite setup
- Improved documentation of attributes and cookbook usage

## 3.2.0 (2016-10-28)

- Reload nginx on site change

## 3.1.2 (2016-10-24)

- [GH-26] Remove guard on package[nginx] resource
- Fix pcre packages on RHEL that prevented pagespeed module compilation

## 3.1.1 (2016-09-21)

- Raise on error vs. Chef::Appliation.fatal
- Require compat_resource with notification fixes

## 3.1.0 (2016-09-14)

- Resolve FC023 warnings
- FreeBSD fixes
- Fail hard on unsupported platforms in the source recipe
- Install 'ca-certificates' packages with passenger
- Add `passenger_show_version_in_header` config
- Remove chef 11 compatibility
- Replace apt/yum deps with compat_resource
- Fix specs for freebsd source installs
- Remove apt recipe from the repo_passenger recipe
- Switch to += operator as << also incorrectly replaces text in root.

## 3.0.0 (2016-08-18)

### Breaking changes

Ideally we'd offer perfect backwards compatibility forever, but in order to maintain the cookbook going forward we've evaluated the current scope of the cookbook and removed lesser used functionality that added code complexity.

- The minimum chef-client version is now 12.1 or later, which will enables support for Ohai 7+ plugins, the ohai_plugin custom resource, and automatic init system discovery.
- Support for Gentoo has been removed. Gentoo lacks an official Chef package and there is no Bento image to use for Test Kitchen integration tests.
- Support for the bluepill init system has been removed. Usage of this init system has declined, and supporting it added a cookbook dependency as well as code complexity.
- Ubuntu source installs will no longer default to runit, and will instead use either Upstart or Systemd depending on the release of Ubuntu. You can still force the use of runit by setting default['nginx']['init_style'] to 'runit'. Runit was used historically before reliable init systems were shipped with Ubuntu. Both Upstart and Systemd have the concept of restarting on failure, which was the main reason for choosing Runit over sys-v init.

### Other changes

- Don't setup the YUM EPEL repo on Fedora as it's not needed
- Systemd based platforms will now use systemd by default for source installs
- Retry downloads of the nginx source file as the mirror sometimes fails to load
- Download the nginx source from the secure nginx.org site
- Updated the Ohai plugin to avoid deprecation notices and function better on non us-en locale systems
- Install source install pre-reqs using multi-package which speeds up Chef runs
- Add testing in Travis with Kitchen Dokken for full integration testing of each PR
- Add integration test on Chef 12.1 as well as the latest Chef to ensure compatibility with the oldest release we support
- Remove installation of apt-transport-https and instead increase the apt dependency to >= 2.9.1 which includes the installation of apt-transport-https
- Don't try to setup the nginx.org repo on Fedora as this will fail
- Better log when trying to setup repositories on unsupported platforms
- Fixed source_url and issue_url in the metadata to point to the correct URLs
- Removed Chef 10 compatibility code
- Chefspec platform updates and minor fixes
- Replace all usage of node.set with node.normal to avoid deprecation notices
- Remove the suse init script that isn't used anymore
- Speed up the specs with caching
- Move test attributes and runlists out the kitchen.yml files and into a test cookbook

## 2.9.0 (2016-08-12)

- Add support for Suse Nginx.org packages

## v2.8.0 (2016-08-12)

This is the first release of the nginx codebase under the chef_nginx namespace. We've chosen to bring this cookbook under the direction of the Community Cookbook Team, in order to ship a working 2.X release. The cookbook name has been changed, but all attributes are the same and compatibility has been maintained. After this 2.8.0 release we will release 3.0 as a Chef 12+ version of the cookbook and then work to add additional custom resources for managing nginx with wrapper cookbooks. Expect regular releases as we march towards a resource driven model.

- Removed the restrictive version constraints for cookbook dependencies that prevented users from utilizing new functionality. Ohai has been pinned to < 4.0 to allow for Chef 11 compatibility, but other cookbooks have no upper limit
- Updated all modules in the source install to their latest releases
- Removed the GeoIP database checksums as these files are constantly updates and this causes Chef run failures
- Updated OpenSSL for source installs to 1.0.1t
- Updated the source install of Nginx to version 1.10.1
- Updated the ohai recipe to install a Ohai 7+ compatible plugin on systems running Ohai 7+
- Fixed installation of Passenger version 5.X+
- Added a http_v2_module recipe
- Replaced node.set usage with node.normal to avoid deprecation warnings
- Removed the apt version pin in the Berkfile that wasn't necessary and constrained the apt version
- Removed the lua-devel package install from the lua recipe that failed chef runs and wasn't necessary
- Removed duplicate packages from the source module installs
- Added a dependency on the yum cookbook which was missing from the metadata
- Updated the mime.types file and added the charset_types configuration option to the nginx config
- Added source_url, issue_url, and chef_version metadata
- Fixed the pid file attribute logic for Ubuntu 16.04
- Removed the Contributing doc that was for contributing to Opscode cookbooks
- Updated all test dependencies in the Gemfile
- Removed default user/group/mode declarations from resources for simplicity
- Updated documentation for dependencies in the README
- Added a chefignore file to limit the cookbook files that are uploaded to the chef server and speed up cookbook syncs to nodes
- Added additional platforms to the Test Kitchen config and removed the .kitchen.cloud.yml file
- Switched integration tests to Inspec and fixed several non-functional tests
- Switched from Rubocop to Cookstyle and resolved all warnings
- Added the standard Chef Rakefile for simplified testing
- Updated Chefspecs to avoid constant deprecation warnings and converge using chef-zero on a newer Debian 8 system
- Switch Travis CI testing to use ChefDK instead of RVM/Gem installs
- Removed testing dependencies from the Gemfile as testing should be performed via ChefDK. Release gems are still in the Gemfile as they are not shipped with ChefDK
- Added a maintainers.md doc and updated the contributing/testing docs to point to the Chef docs
- Removed Guard as guard-foodcritic doesn't support the latest release which makes guard incompatible with ChefDK

## v2.7.6 (2015-03-17)

- Bugfix sites do not need a .conf suffix anymore, [#338][@runningman84]

## v2.7.5 (2015-03-17)

**NOTE** As of this release, this cookbook in its current format is deprecated, and only critical bugs and fixes will be added. A complete rewrite is in progress, so we appreciate your patience while we sort things out. The amount of change included here

- Fix nginx 1.4.4 archive checksum to prevent redownload, [#305][@irontoby]
- Allow setting an empty string to prevent additional repos, [#243][@miketheman]
- Use correct `mime.types` for javascript, [#259][@dwradcliffe]
- Fix `headers_more` module for source installs, [#279], [@josh-padnick] & [@miketheman]
- Remove `libtool` from `geoip` and update download paths & checksums, [@miketheman]
- Fix unquoted URL with params failing geoip module build (and tests!), [#294][@karsten-bruckmann] & [@miketheman]
- Fix typo in `source.rb`, [#205][@gregkare]
- Test updates: ChefSpec, test-kitchen. Lots of help by [@jujugrrr]
- Toolchain updates for testing
- Adds support for `tcp_nopush`, `tcp_nodelay` [@shtouff]

After merging a ton of pull requests, here's a brief changelog. Click each to read more.

- Merge pull request [#335] from [@stevenolen]
- Merge pull request [#332] from [@monsterstrike]
- Merge pull request [#331] from [@jalberto]
- Merge pull request [#327] from [@nkadel-skyhook]
- Merge pull request [#326] from [@bchrobot]
- Merge pull request [#325] from [@CanOfSpam3bug324]
- Merge pull request [#321] from [@jalberto]
- Merge pull request [#318] from [@evertrue]
- Merge pull request [#314] from [@bkw]
- Merge pull request [#312] from [@thomasmeeus]
- Merge pull request [#310] from [@morr]
- Merge pull request [#305] from [@irontoby]
- Merge pull request [#302] from [@auth0]
- Merge pull request [#298] from [@Mytho]
- Merge pull request [#269] from [@yveslaroche]
- Merge pull request [#259] from [@dwradcliffe]
- Merge pull request [#254] from [@evertrue]
- Merge pull request [#252] from [@gkra]
- Merge pull request [#249] from [@whatcould]
- Merge pull request [#240] from [@jcoleman]
- Merge pull request [#236] from [@adepue]
- Merge pull request [#230] from [@n1koo]
- Merge pull request [#225] from [@thommay]
- Merge pull request [#223] from [@firmhouse]
- Merge pull request [#220] from [@evertrue]
- Merge pull request [#219] from [@evertrue]
- Merge pull request [#204] from [@usertesting]
- Merge pull request [#200] from [@ffuenf]
- Merge pull request [#188] from [@larkin]
- Merge pull request [#184] from [@tvdinner]
- Merge pull request [#183] from [@jenssegers]
- Merge pull request [#174] from [@9minutesnooze]

<https://github.com/miketheman/nginx/compare/v2.7.4...v2.7.5>

## v2.7.4 (2014-06-06)

- [COOK-4703] Default openssl version to 1.0.1h to address CVE-2014-0224

## v2.7.2 (2014-05-27)

- [COOK-4658] - Nginx::socketproxy if the context is blank or nonexistent, the location in the config file has a double slash at the beginning
- [COOK-4644] - add support to nginx::repo for Amazon Linux
- Allow .kitchen.cloud.yml to use an environment variable for the EC2 Availability Zone

## v2.7.0 (2014-05-15)

- [COOK-4643] - Update metadata lock on ohai
- [COOK-4588] - Give more love to FreeBSD
- [COOK-4601] - Add proxy type: Socket

## v2.6.2 (2014-04-09)

[COOK-4527] - set default openssl source version to 1.0.1g to address CVE-2014-0160 aka Heartbleed

## v2.6.0 (2014-04-08)

- Reverting COOK-4323

## v2.5.0 (2014-03-27)

- [COOK-4323] - Need a resource to easily configure available sites (vhosts)

## v2.4.4 (2014-03-13)

- Updating for build-essential 2.0

## v2.4.2 (2014-02-28)

Fixing bad commit from COOK-4330

## v2.4.1 (2014-02-27)

- [COOK-4345] - nginx default recipe include install type recipe directly

## v2.4.0 (2014-02-27)

- [COOK-4380] - kitchen.yml platform listings for ubuntu-10.04 and ubuntu-12.04 are missing the dot
- [COOK-4330] - Bump nginx version for security issues (CVE-2013-0337, CVE-2013-4547)

## v2.3.0 (2014-02-25)

- **[COOK-4293](https://tickets.chef.io/browse/COOK-4293)** - Update testing Gems in nginx and fix a rubocop warnings
- **[COOK-4237] - Nginx version incorrectly parsed on Ubuntu 13
- **[COOK-3866] - Nginx default site folder

## v2.2.2 (2014-01-23)

[COOK-3672] - Add gzip_static option

## v2.2.0

No changes. Version bump for toolchain

## v2.1.0

[COOK-3923] - Enable the list of packages installed by nginx::passenger to be configurable [COOK-3672] - Nginx should support the gzip_static option Updating for yum ~> 3.0 Fixing up style for rubocop Updating test-kitchen harness

## v2.0.8

fixing metadata version error. locking to 3.0

## v2.0.6

Locking yum dependency to '< 3'

## v2.0.4

### Bug

- **[COOK-3808](https://tickets.chef.io/browse/COOK-3808)** - nginx::passenger run fails because of broken installation of package dependencies
- **[COOK-3779](https://tickets.chef.io/browse/COOK-3779)** - Build in master fails due to rubocop error

## v2.0.2

### Bug

- **[COOK-3808](https://tickets.chef.io/browse/COOK-3808)** - nginx::passenger run fails because of broken installation of package dependencies
- **[COOK-3779](https://tickets.chef.io/browse/COOK-3779)** - Build in master fails due to rubocop error

## v2.0.0

### Improvement

- **[COOK-3733](https://tickets.chef.io/browse/COOK-3733)** - Add RPM key names and GPG checking
- **[COOK-3687](https://tickets.chef.io/browse/COOK-3687)** - Add support for `http_perl`
- **[COOK-3603](https://tickets.chef.io/browse/COOK-3603)** - Add a recipe for using custom openssl
- **[COOK-3602](https://tickets.chef.io/browse/COOK-3602)** - Use an attribute for the status module port
- **[COOK-3549](https://tickets.chef.io/browse/COOK-3549)** - Refactor custom modules support
- **[COOK-3521](https://tickets.chef.io/browse/COOK-3521)** - Add support for `http_auth_request`
- **[COOK-3520](https://tickets.chef.io/browse/COOK-3520)** - Add support for `spdy`
- **[COOK-3185](https://tickets.chef.io/browse/COOK-3185)** - Add `gzip_*` attributes
- **[COOK-2712](https://tickets.chef.io/browse/COOK-2712)** - Update `upload_progress` version to 0.9.0

### Bug

- **[COOK-3686](https://tickets.chef.io/browse/COOK-3686)** - Remove deprecated 'passenger_use_global_queue' directive
- **[COOK-3626](https://tickets.chef.io/browse/COOK-3626)** - Parameterize hardcoded path to helper scripts
- **[COOK-3571](https://tickets.chef.io/browse/COOK-3571)** - Reloda ohai plugin after installation
- **[COOK-3428](https://tickets.chef.io/browse/COOK-3428)** - Fix an issue where access logs are not disabled when the `disable_access_log` attribute is set to `true`
- **[COOK-3322](https://tickets.chef.io/browse/COOK-3322)** - Fix an issue where `nginx::ohai_plugin` fails when using source recipe
- **[COOK-3241](https://tickets.chef.io/browse/COOK-3241)** - Fix an issue where`nginx::ohai_plugin` fails unless using source recipe

### New Feature

- **[COOK-3605](https://tickets.chef.io/browse/COOK-3605)** - Add Lua module

## v1.8.0

### Bug

- **[COOK-3397](https://tickets.chef.io/browse/COOK-3397)** - Fix user from nginx package on Gentoo
- **[COOK-2968](https://tickets.chef.io/browse/COOK-2968)** - Fix foodcritic failure
- **[COOK-2723](https://tickets.chef.io/browse/COOK-2723)** - Remove duplicate passenger `max_pool_size`

### Improvement

- **[COOK-3186](https://tickets.chef.io/browse/COOK-3186)** - Add `client_body_buffer_size` and `server_tokens attributes`
- **[COOK-3080](https://tickets.chef.io/browse/COOK-3080)** - Add rate-limiting support
- **[COOK-2927](https://tickets.chef.io/browse/COOK-2927)** - Add support for `real_ip_recursive` directive
- **[COOK-2925](https://tickets.chef.io/browse/COOK-2925)** - Fix ChefSpec converge
- **[COOK-2724](https://tickets.chef.io/browse/COOK-2724)** - Automatically create directory for PID file
- **[COOK-2472](https://tickets.chef.io/browse/COOK-2472)** - Bump nginx version to 1.2.9
- **[COOK-2312](https://tickets.chef.io/browse/COOK-2312)** - Add additional `mine_types` to the `gzip_types` value

### New Feature

- **[COOK-3183](https://tickets.chef.io/browse/COOK-3183)** - Allow inclusion in extra-cookbook modules

## v1.7.0

### Improvement

- [COOK-3030]: The repo_source attribute should allow you to not add any additional repositories to your node

### Sub-task

- [COOK-2738]: move nginx::passenger attributes to `nginx/attributes/passenger.rb`

## v1.6.0

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

## v1.4.0

- [COOK-2183] - Install nginx package from nginxyum repo
- [COOK-2311] - headers-more should be updated to the latest version
- [COOK-2455] - Support sendfile option (nginx.conf)

## v1.3.0

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

## v1.2.0

- [COOK-1752] - Add headers more module to the nginx cookbook
- [COOK-2209] - nginx source recipe should create web user before creating directories
- [COOK-2221] - make nginx::source compatible with gentoo
- [COOK-2267] - add version for runit recommends

## v1.1.4

- [COOK-2168] - specify package name as an attribute

## v1.1.2

- [COOK-1766] - Nginx Source Recipe Rebuilding Source at Every Run
- [COOK-1910] - Add IPv6 module
- [COOK-1966] - nginx cookbook should let you set `gzip_vary` and `gzip_buffers` in nginx.conf
- [COOK-1969]- - nginx::passenger module not included due to use of symbolized `:nginx_configure_flags`
- [COOK-1971] - Template passenger.conf.erb configures key `passenger_max_pool_size` 2 times
- [COOK-1972] - nginx::source compile_nginx_source reports success in spite of failed compilation
- [COOK-1975] - nginx::passenger requires rake gem
- [COOK-1979] - Passenger module requires curl-dev(el)
- [COOK-2080] - Restart nginx on source compilation

## v1.1.0

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

## v1.0.2

- [COOK-1636] - relax the version constraint on ohai

## v1.0.0

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

## v0.101.6

Erroneous cookbook upload due to timeout.

Version #'s are cheap.

## v0.101.4

- [COOK-1280] - Improve RHEL family support and fix ohai_plugins recipe bug
- [COOK-1194] - allow installation method via attribute
- [COOK-458] - fix duplicate nginx processes

## v0.101.2

- [COOK-1211] - include the default attributes explicitly so version is available.

## v0.101.0

**Attribute Change**: `node['nginx']['url']` -> `node['nginx']['source']['url']`; see the README.md.

- [COOK-1115] - daemonize when using init script
- [COOK-477] - module compilation support in nginx::source

## v0.100.4

- [COOK-1126] - source version bump to 1.0.14

## v0.100.2

- [COOK-1053] - Add :url attribute to nginx cookbook

## v0.100.0

- [COOK-818] - add "application/json" per RFC.
- [COOK-870] - bluepill init style support
- [COOK-957] - Compress application/javascript.
- [COOK-981] - Add reload support to NGINX service

## v0.99.2

- [COOK-809] - attribute to disable access logging
- [COOK-772] - update nginx download source location

<!-- - The following link definition list is generated by PimpMyChangelog - -->

[#174]: https://github.com/miketheman/nginx/issues/174
[#183]: https://github.com/miketheman/nginx/issues/183
[#184]: https://github.com/miketheman/nginx/issues/184
[#188]: https://github.com/miketheman/nginx/issues/188
[#200]: https://github.com/miketheman/nginx/issues/200
[#204]: https://github.com/miketheman/nginx/issues/204
[#205]: https://github.com/miketheman/nginx/issues/205
[#219]: https://github.com/miketheman/nginx/issues/219
[#220]: https://github.com/miketheman/nginx/issues/220
[#223]: https://github.com/miketheman/nginx/issues/223
[#225]: https://github.com/miketheman/nginx/issues/225
[#230]: https://github.com/miketheman/nginx/issues/230
[#236]: https://github.com/miketheman/nginx/issues/236
[#240]: https://github.com/miketheman/nginx/issues/240
[#243]: https://github.com/miketheman/nginx/issues/243
[#249]: https://github.com/miketheman/nginx/issues/249
[#252]: https://github.com/miketheman/nginx/issues/252
[#254]: https://github.com/miketheman/nginx/issues/254
[#259]: https://github.com/miketheman/nginx/issues/259
[#269]: https://github.com/miketheman/nginx/issues/269
[#279]: https://github.com/miketheman/nginx/issues/279
[#294]: https://github.com/miketheman/nginx/issues/294
[#298]: https://github.com/miketheman/nginx/issues/298
[#302]: https://github.com/miketheman/nginx/issues/302
[#305]: https://github.com/miketheman/nginx/issues/305
[#310]: https://github.com/miketheman/nginx/issues/310
[#312]: https://github.com/miketheman/nginx/issues/312
[#314]: https://github.com/miketheman/nginx/issues/314
[#318]: https://github.com/miketheman/nginx/issues/318
[#321]: https://github.com/miketheman/nginx/issues/321
[#325]: https://github.com/miketheman/nginx/issues/325
[#326]: https://github.com/miketheman/nginx/issues/326
[#327]: https://github.com/miketheman/nginx/issues/327
[#331]: https://github.com/miketheman/nginx/issues/331
[#332]: https://github.com/miketheman/nginx/issues/332
[#335]: https://github.com/miketheman/nginx/issues/335
[#338]: https://github.com/miketheman/nginx/issues/338
[@9minutesnooze]: https://github.com/9minutesnooze
[@adepue]: https://github.com/adepue
[@auth0]: https://github.com/auth0
[@bchrobot]: https://github.com/bchrobot
[@bkw]: https://github.com/bkw
[@canofspam3bug324]: https://github.com/CanOfSpam3bug324
[@dwradcliffe]: https://github.com/dwradcliffe
[@evertrue]: https://github.com/evertrue
[@ffuenf]: https://github.com/ffuenf
[@firmhouse]: https://github.com/firmhouse
[@gkra]: https://github.com/gkra
[@gregkare]: https://github.com/gregkare
[@irontoby]: https://github.com/irontoby
[@jalberto]: https://github.com/jalberto
[@jcoleman]: https://github.com/jcoleman
[@jenssegers]: https://github.com/jenssegers
[@josh-padnick]: https://github.com/josh-padnick
[@jujugrrr]: https://github.com/jujugrrr
[@karsten-bruckmann]: https://github.com/karsten-bruckmann
[@larkin]: https://github.com/larkin
[@miketheman]: https://github.com/miketheman
[@monsterstrike]: https://github.com/monsterstrike
[@morr]: https://github.com/morr
[@mytho]: https://github.com/Mytho
[@n1koo]: https://github.com/n1koo
[@nkadel-skyhook]: https://github.com/nkadel-skyhook
[@runningman84]: https://github.com/runningman84
[@shtouff]: https://github.com/shtouff
[@stevenolen]: https://github.com/stevenolen
[@thomasmeeus]: https://github.com/thomasmeeus
[@thommay]: https://github.com/thommay
[@tvdinner]: https://github.com/tvdinner
[@usertesting]: https://github.com/usertesting
[@whatcould]: https://github.com/whatcould
[@yveslaroche]: https://github.com/yveslaroche

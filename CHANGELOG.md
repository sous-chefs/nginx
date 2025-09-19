# nginx Cookbook CHANGELOG

This file is used to list changes made in each version of the nginx cookbook.

## Unreleased

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 12.3.1 - *2025-09-04*

## 12.3.0 - *2025-04-01*

- Correct trailing semicolon for blocks - [#643](https://github.com/sous-chefs/nginx/issues/643)
- Support multiple options - [#644](https://github.com/sous-chefs/nginx/issues/644)

## 12.2.13 - *2025-01-07*

- Convert all test files to proper InSpec format with controls and metadata
- Rename test files to use _spec.rb suffix
- Add inspec.yml files for all test suites
- Add dependencies between test suites where appropriate
- Update test structure for better organization and reporting

## 12.2.12 - *2025-01-07*

Fix Rspec issues
Update workflows

## 12.2.10 - *2024-07-10*

Standardise files with files in sous-chefs/repo-management

## 12.2.6 - *2023-12-27*

Remove Fedora Linux from test matrix

## 12.2.3 - *2023-08-20*

- Skip creation of the list directory resource if the directory already exists as it is managed elsewhere

## 12.2.0 - *2023-04-13*

- Fix installation on EL9 platforms
- Fix installation on newer Amazon Linux platforms

## 12.1.7 - *2023-04-04*

Standardise files with files in sous-chefs/repo-management

## 12.1.5 - *2023-04-01*

Standardise files with files in sous-chefs/repo-management

## 12.1.4 - *2023-03-15*

Standardise files with files in sous-chefs/repo-management

## 12.1.3 - *2023-02-18*

Standardise files with files in sous-chefs/repo-management

## 12.1.2 - *2023-02-15*

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

- Use multipackage installs in the pagespeed recipe to speed up installs
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

- Bug Fix: Add missing service resource in `nginx_site` resource. [Issue #505](https://github.com/sous-chefs/nginx/issues/505))

## 4.0.1 (2016-11-30)

- Maintenance: Add contributing.md file for cookbook health metrics
- Feature: Add support for Fedora

## 4.0.0 (2016-11-30)

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

- Use multipackage installs in the pagespeed recipe to speed up installs
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

- Bug Fix: Add missing service resource in `nginx_site` resource. [Issue #505](https://github.com/sous-chefs/nginx/issues/505))

## 4.0.1 (2016-11-30)

- Maintenance: Add contributing.md file for cookbook health metrics
- Feature: Add support for Fedora

## 4.0.0 (2016-11-30)

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

- Use multipackage installs in the pagespeed recipe to speed up installs
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

- Bug Fix: Add missing service resource in `nginx_site` resource. [Issue #505](https://github.com/sous-chefs/nginx/issues/505))

## 4.0.1 (2016-11-30)

- Maintenance: Add contributing.md file for cookbook health metrics
- Feature: Add support for Fedora

## 4.0.0 (2016-11-30)

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

- Use multipackage installs in the pagespeed recipe to speed up installs
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

- Bug Fix: Add missing service resource in `nginx_site` resource. [Issue #505](https://github.com/sous-chefs/nginx/issues/505))

## 4.0.1 (2016-11-30)

- Maintenance: Add contributing.md file for cookbook health metrics
- Feature: Add support for Fedora

## 4.0.0 (2016-11-30)

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

- Use multipackage installs in the pagespeed recipe to speed up installs
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

- Bug Fix: Add missing service resource in `nginx_site` resource. [Issue #505](https://github.com/sous-chefs/nginx/issues/505))

## 4.0.1 (2016-11-30)

- Maintenance: Add contributing.md file for cookbook health metrics
- Feature: Add support for Fedora

## 4.0.0 (2016-11-30)

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

- Use multipackage installs in the pagespeed recipe to speed up installs
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

- Bug Fix: Add missing service resource in `nginx_site` resource. [Issue #505](https://github.com/sous-chefs/nginx/issues/505))

## 4.0.1 (2016-11-30)

- Maintenance: Add contributing.md file for cookbook health metrics
- Feature: Add support for Fedora

## 4.0.0 (2016-11-30)

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

- Use multipackage installs in the pagespeed recipe to speed up installs
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

- Bug Fix: Add missing service resource in `nginx_site` resource. [Issue #505](https://github.com/sous-chefs/nginx/issues/505))

## 4.0.1 (2016-11-30)

- Maintenance: Add contributing.md file for cookbook health metrics
- Feature: Add support for Fedora

## 4.0.0 (2016-11-30)

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

- Use multipackage installs in the pagespeed recipe to speed up installs
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

- Bug Fix: Add missing service resource in `nginx_site` resource. [Issue #505](https://github.com/sous-chefs/nginx/issues/505))

## 4.0.1 (2016-11-30)

- Maintenance: Add contributing.md file for cookbook health metrics
- Feature: Add support for Fedora

## 4.0.0 (2016-11-30)

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

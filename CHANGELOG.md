## v1.0.2:

* [COOK-1636] - relax the version constraint on ohai

## v1.0.0:

* [COOK-913] - defaults for gzip cause warning on service restart
* [COOK-1020] - duplicate MIME type
* [COOK-1269] - add passenger module support through new recipe
* [COOK-1306] - increment nginx version to 1.2 (now 1.2.3)
* [COOK-1316] - default site should not always be enabled
* [COOK-1417] - resolve errors preventing build from source
* [COOK-1483] - source prefix attribute has no effect
* [COOK-1484] - source relies on /etc/sysconfig
* [COOK-1511] - add support for naxsi module
* [COOK-1525] - nginx source is downloaded every time
* [COOK-1526] - nginx_site does not remove sites
* [COOK-1527] - add `http_echo_module` recipe

## v0.101.6:

Erroneous cookbook upload due to timeout.

Version #'s are cheap.

## v0.101.4:

* [COOK-1280] - Improve RHEL family support and fix ohai_plugins
 recipe bug
* [COOK-1194] - allow installation method via attribute
* [COOK-458] - fix duplicate nginx processes

## v0.101.2:

* [COOK-1211] - include the default attributes explicitly so version
is available.

## v0.101.0:

**Attribute Change**: `node['nginx']['url']` -> `node['nginx']['source']['url']`; see the README.md.

* [COOK-1115] - daemonize when using init script
* [COOK-477] - module compilation support in nginx::source

## v0.100.4:

* [COOK-1126] - source version bump to 1.0.14

## v0.100.2:

* [COOK-1053] - Add :url attribute to nginx cookbook

## v0.100.0:

* [COOK-818] - add "application/json" per RFC.
* [COOK-870] - bluepill init style support
* [COOK-957] - Compress application/javascript.
* [COOK-981] - Add reload support to NGINX service

## v0.99.2:

* [COOK-809] - attribute to disable access logging
* [COOK-772] - update nginx download source location

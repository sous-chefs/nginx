## COOK-1280:

* Change nginx['user'] to `nginx` on redhat platform
* Change nginx['init_style'] to `init` on redhat platform
* Create non-existing `sites-enabled` and `sites-available` directories on redhat platform
* Add redhat family platforms to supported OS list
* Update README to note nginx is availabe only by EPEL on redhat platform
* Remove template notify for non-existent ohai[custom_plugins] resource, and move `include_recipe "ohai"` a general fix for all platforms.
* Change symbols to strings for *foodcritic*
* Remove unnecessary include_attribute "nginx", already in the same attribute scope

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

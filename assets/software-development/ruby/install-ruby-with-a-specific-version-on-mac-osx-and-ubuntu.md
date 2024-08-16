# Install Ruby with a Specific Version on Mac OSX and Ubuntu

The following script can be used to install Ruby with a specific verion on Mac OSX or Ubuntu.

This script has been tested on Mac OS only, and is used as part of the build for the [iamlynnmckay/iamlynnmckay.github.io-gem](https://github.com/iamlynnmckay/iamlynnmckay.github.io-gem/blob/main/make/setup.sh) repository, which is used to build and deploy this website.

Note that this script **WILL DELETE OTHER RUBY INSTALLATIONS AND CONFIGURATIONS**, it is intended to be used to reset the global Ruby environment rather than containerize installation or configuration of a specific version.

Change the `RUBY_VERSION` value to set a different Ruby version, and set `DEBUG=true` to remove all existing global Ruby installations and configurations before re-installing and re-configuring.

```bash
{% embed from='https://raw.githubusercontent.com/iamlynnmckay/iamlynnmckay.github.io-gem/main/make/setup.sh' raw=true %}
```
appload
=======

[![Twitter: @longboardcat13](https://img.shields.io/badge/contact-@longboardcat13-blue.svg?style=flat)](https://twitter.com/longboardcat13)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/longboardcat/appload/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/longboardcat/appload.svg?branch=master)](https://travis-ci.org/longboardcat/appload)
[![Gem Version](https://badge.fury.io/rb/appload.svg)](http://badge.fury.io/rb/appload)

appload is a gem that helps you double-check things you might have gotten wrong during an iTunes
Connect upload. It will display .ipa, info.plist, and provisioning profile information to verify
before uploading via [fastlane/deliver][1].

Things to check before uploading:
- Entitlements
- Provisioned devices
- Expiring provisioning profiles
- Expiring developer certificates
- Scheme

Usage
-----

`gem install appload`

`appload <path_to_ipa>`

[1]: https://github.com/fastlane/fastlane/tree/master/deliver

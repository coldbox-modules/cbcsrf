# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

* * *

## [Unreleased]

## [3.2.0] - 2025-02-19

### Added

- BoxLang certification
- Github Actions updates
- ColdBox 7 Testing

## [3.1.0] => 2023-FEB-17

### Added

- New versions on all github actions
- Updates for Adobe 2021 server installations

## [3.0.0] => 2022-OCT-10

### Added

- Updated to new module template updates

### Changed

- Dropped ACF 2016

## [2.3.1] => 2021-NOV-10

### Fixed

- Fixed cfformat locations on `box.json`

## [2.3.0] => 2021-SEP-02

### Added/Compatiblity

- New setting: `enableAuthTokenRotator` which defaults to **false**, unlike previously which was **true**. This allows for rotation of keys for csrf tokens on login and logout if you are using cbauth via the new interceptor: `AuthRotator`.  Make sure you turn this flag to **true** to keep the previous version functionality.

## [2.2.0] => 2021-JUL-21

### Added

- Github actions migration
- New setting to provide the ability to choose the storage interface for csrf tokens: `cacheStorage`
- Adobe 2021 support

### Fixed

- Build version replacement token
- ensure `actionMarkedToSkip()` returns `false` when the handler is empty

## [2.1.0] => 2020-SEP-09

### Added

- Github changelog publishing
- More cfformating goodness
- Changelog standards
- New `csrfField()` to generate a self linking field and JS but forces a new token and adds a block of javascript to the document, synchronized with the `rotateTimeout` setting, that will reload the page if the token expires.

### Fixed

- Null checks on `defaultValue` in case it's passed as an empty string

## [2.0.1] => 2020-APR-06

- Deactivate the verifier by default

## [2.0.0] => 2020-APR-02

### Features

- Migrated to all new ColdBox 5/6 standards
- Added an auto-verifier interceptor (see readme)
- Added `cbStorages` dependency to allow for distributed caching of tokens
- Ability to auto expire tokens
- Ability to rotate tokens
- Ability to generate input fields
- Ability to verify tokens from headers
- Ability to have an endpoint for csfr generation for authenticated users
- Automatic listeners for `cbauth` to rotate tokens via login/logout methods

### Compat

- All methods signatures have changed, please see the readme for the updated methods

## [1.1.0]

- Travis updates
- Build updates
- DocBox migration

## [1.0.1]

- production ignore lists
- Unloading of helpers

## [1.0.0]

- Create first module version

[unreleased]: https://github.com/coldbox-modules/cbcsrf/compare/v3.2.0...HEAD
[3.2.0]: https://github.com/coldbox-modules/cbcsrf/compare/8fe273b1fc4adc4c29062bb34aa040de9da63177...v3.2.0

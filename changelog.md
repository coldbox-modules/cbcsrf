# CHANGELOG

## 2.0.0

### Features

* Migrated to all new ColdBox 5/6 standards
* Added an auto-verifier interceptor (see readme)
* Added `cbStorages` dependency to allow for distributed caching of tokens
* Ability to auto expire tokens
* Ability to rotate tokens
* Ability to generate input fields
* Ability to verify tokens from headers
* Ability to have an endpoint for csfr generation for authenticated users 
* Automatic listeners for `cbauth` to rotate tokens via login/logout methods

### Compat

* All methods signatures have changed, please see the readme for the updated methods

---

## 1.1.0

* Travis updates
* Build updates
* DocBox migration

## 1.0.1

* production ignore lists
* Unloading of helpers

## 1.0.0

* Create first module version

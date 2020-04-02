[![Build Status](https://travis-ci.org/coldbox-modules/cbcsrf.svg?branch=master)](https://travis-ci.org/coldbox-modules/cbcsrf)

# ColdBox Anti Cross Site Request Forgery Module (cbcsrf)

A module that protects you against [CSRF](https://en.wikipedia.org/wiki/Cross-site_request_forgery) attacks by generating unique FORM/client tokens and providing your ColdBox application with new functions for protection.  Even though every CFML engine offers these functions, we have expanded them and have made them more flexible and more secure than the native CFML functions.

## Features

* 

## License

Apache License, Version 2.0.

## Links

- http://www.coldbox.org/forgebox/view/csrf
- https://github.com/coldbox-modules/cbcsrf
- https://en.wikipedia.org/wiki/Cross-site_request_forgery

## Requirements

- Lucee 5+
- ColdFusion 2016+

## Installation

Use CommandBox to install

`box install cbcsrf`

You can then continue to configure the module in your `config/Coldbox.cfc`.

## Settings

Below are the settings you can use for this module. Remember you must create the `cbcsrf` struct in your `ColdBox.cfc` under the `moduleSettings` structure:

```js
moduleSettings = {
	cbcsrf : {

	}
};
```


#INSTRUCTIONS

Just drop into your **modules** folder or use CommandBox to install

`box install cbcsrf`

## Mixins
This module will add the following UDFs into any framework files: 

- `generateCSRFToken()`
- `verifyCSRFToken()`

If the CF engine supports this natively, that functionality will be used.  Otherwise, a custom implementation will be used.  

## Mappings
The module also registers the following mapping in WireBox: `util@cbCSRF`

You can then use this mapping to use the `generateCSRFToken()` and `verifyCSRFToken()` functions in your models if you wish

## Example
Below is a simple example:

```js
/**
* My Event Handler Hint
*/
component {

    any function signUp( event, rc, prc ){
        // Store this in a hidden field in the form
        prc.token = generateCSRFToken();
    }

    any function signUpProcess( event, rc, prc ){
        // Verify CSFR token from form
        if( verifyCSRFToken( rc.token ) {
            // save form
        } else {
            // Something isn't right
            setNextEvent( 'handler.signup' );
        }
    }
}
```


********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************

### HONOR GOES TO GOD ABOVE ALL

Because of His grace, this project exists. If you don't like this, then don't read it, its not for you.

>"Therefore being justified by faith, we have peace with God through our Lord Jesus Christ:
By whom also we have access by faith into this grace wherein we stand, and rejoice in hope of the glory of God.
And not only so, but we glory in tribulations also: knowing that tribulation worketh patience;
And patience, experience; and experience, hope:
And hope maketh not ashamed; because the love of God is shed abroad in our hearts by the 
Holy Ghost which is given unto us. ." Romans 5:5

### THE DAILY BREAD

 > "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12

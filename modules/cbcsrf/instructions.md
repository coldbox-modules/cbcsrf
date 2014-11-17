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
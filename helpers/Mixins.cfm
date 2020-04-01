<cfscript>
	/**
	 * Provides a random token and stores it in the coldbox cache storages. You can also provide a specific key to store.
	 *
	 * @key A random token is generated for the key provided.
	 * @forceNew If set to true, a new token is generated every time the function is called. If false, in case a token exists for the key, the same key is returned.
	 *
	 * @return csrf token
	 */
	string function csrfToken( string key='', boolean forceNew=false ) {
		return getInstance( '@CbCsrf' ).generate( argumentCollection = arguments );
	}

	/**
	 * Validates the given token against the same stored in the session for a specific key.
	 *
	 * @token Token that to be validated against the token stored in the session.
	 * @key The key against which the token be searched.
	 *
	 * @return Valid or Invalid Token
	 */
	boolean function csrfVerify( required string token='', string key='' ) {
		return getInstance( '@CbCsrf' ).verify( argumentCollection = arguments );
	}

	/**
	 * Generate a random token and build a hidden form element so you can submit it with your form
	 *
	 * @key A random token is generated for the key provided.
	 * @forceNew If set to true, a new token is generated every time the function is called. If false, in case a token exists for the key, the same key is returned.
	 *
	 * @return HTML of the hidden field (csrf)
	 */
	function csrf( string key='', boolean forceNew=false ){
		return "<input type='hidden' name='csrf' id='csrf' value='#csrfToken( argumentCollection=arguments )#'>";
	}
</cfscript>
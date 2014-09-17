<cfscript>

	/**
	* Provides a random token and stores it in Flash RAM. You can also provide a specific key to store.
	* @key.hint A random token is generated for the key provided. 
	* @forceNew.hint If set to true, a new token is generated every time the function is called. If false, in case a token exists for the key, the same key is returned. 
	*/
	string function generateCSRFToken( string key='', boolean forceNew=false ) {
		return getModel( 'util@CSRF' ).generateCSRFToken( argumentCollection = arguments );
	}
	
	/**
	* Validates the given token against the same stored in the session for a specific key.
	* @token.hint Token that to be validated against the token stored in the session. 
	* @key.hint The key against which the token be searched. 
	*/
	boolean function verifyCSRFToken( required string token='', string key='' ) {
		return getModel( 'util@CSRF' ).verifyCSRFToken( argumentCollection = arguments );
	}

</cfscript>
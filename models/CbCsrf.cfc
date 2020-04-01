/**
 * Copyright since 2016 by Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 * Service that encapsulates token security against cross site request forgery (csrf)
 */
component accessors="true" singleton {

	/* *********************************************************************
	 **						DI
	 ********************************************************************* */

	property name="settings" inject="coldbox:moduleSettings:cbcsrf";
	property name="flash"   inject="coldbox:flash";
	property name="cacheStorage" inject="cacheStorage@cbstorages";

	/* *********************************************************************
	 **						Properties
	 ********************************************************************* */

	// key to store CSRF tokens
	property name="flashKey" default="$CSRFTokens";

	/**
	 * Constructor
	 */
	function init(){
		setFlashKey( "$CSRFTokens" );
	}

	/**
	 * Provides a random token and stores it in Flash RAM. You can also provide a specific key to store.
	 *
	 * @key A random token is generated for the key provided.
	 * @forceNew If set to true, a new token is generated every time the function is called. If false, in case a token exists for the key, the same key is returned.
	 */
	public string function generate( string key = "", boolean forceNew = false ){
		// A struct of tokens
		var CSRFTokens = flash.get( getFlashKey(), {} );

		// If a token for this key doesn't exist or we're forcing a new one to be created
		if ( !structKeyExists( CSRFTokens, arguments.key ) || arguments.forceNew ) {
			// generate new token
			CSRFTokens[ arguments.key ] = generateNewToken( arguments.key );
			// store the tokens
			flash.put(
				getFlashKey(),
				CSRFTokens,
				true,
				true,
				false,
				false,
				false
			);
		}

		// Return the token for this key
		return CSRFTokens[ arguments.key ];
	}

	/**
	 * Validates the given token against the same stored in the session for a specific key.
	 *
	 * @token Token that to be validated against the token stored in the session.
	 * @key The key against which the token be searched.
	 */
	public boolean function verify( required string token = "", string key = "" ){
		// A struct of tokens
		var CSRFTokens = flash.get( getFlashKey(), {} );

		// See if the token for that key exists and matches
		if ( structKeyExists( CSRFTokens, arguments.key ) && CSRFTokens[ arguments.key ] == arguments.token ) {
			// We're golden. As you were!
			return true;
		}
		// No token for you!
		return false;
	}

	// -------------------------------------- Private --------------------------------------

	private string function generateNewToken( required string key = "" ){
		// Ensure tokenBase is sufficiently random for this user and could never be guessed
		var tokenBase = arguments.key;
		tokenBase &= cgi.remote_addr;
		if ( isDefined( "client" ) and structKeyExists( client, "CFID" ) ) {
			tokenBase &= client.CFID;
		}
		if ( isDefined( "client" ) and structKeyExists( client, "CFTOKEN" ) ) {
			tokenBase &= client.CFTOKEN;
		}
		tokenBase &= randRange( 0, 65535, "SHA1PRNG" );
		tokenBase &= getTickCount();

		// Return a 40 character hash as the new token
		return uCase( left( hash( tokenBase, "SHA-256" ), 40 ) );
	}

}

component accessors=true {
	
	// DI
	property name="coldbox" inject="coldbox";
	property name="flash" inject="coldbox:flash";
	
	// Whether or not the CF engine in use supports native anity-CSRF tokens
	property name="isCSRF" default="false";
	// key to store CSRF tokens
	property name="flashKey" default="$CSRFTokens";
	
	function init() {
		// Property default not used on CF9
		setIsCSRF( false );
		setFlashKey( '$CSRFTokens' );		
	}
	
	function onDIComplete() {
		var CFMLEngine = coldbox.getCFMLEngine();
		var version = CFMLEngine.getVersion();
		var engine = CFMLEngine.getEngine();
	
		// Does this engine support CSRF?
		if ( ( engine eq CFMLEngine.ADOBE && version gte 10 ) 
			 || ( engine eq CFMLEngine.RAILO && version gte 4 ) ){
				setIsCSRF( true );
		}
		
	}
	
	/**
	* Provides a random token and stores it in Flash RAM. You can also provide a specific key to store.
	* @key.hint A random token is generated for the key provided. 
	* @forceNew.hint If set to true, a new token is generated every time the function is called. If false, in case a token exists for the key, the same key is returned. 
	*/
	public string function generateCSRFToken( string key='', boolean forceNew=false ) {
		if( getIsCSRF() ) {
			return CSRFGenerateToken( arguments.key, arguments.forceNew );
		} else {
			// A struct of tokens
			var CSRFTokens = flash.get( getFlashKey(), {} );
			
			// If a token for this key doesn't exist or we're forcing a new one to be created
			if( !structKeyExists( CSRFTokens, arguments.key ) || arguments.forceNew ) {
				// generate new token
				CSRFTokens[ arguments.key ] = generateNewToken( arguments.key );
				// store the tokens
				flash.put( getFlashKey(), CSRFTokens, true, true, false, false, false );
			}			
			
			// Return the token for this key
			return CSRFTokens[ arguments.key ];
		}
	}
	
	/**
	* Validates the given token against the same stored in the session for a specific key.
	* @token.hint Token that to be validated against the token stored in the session. 
	* @key.hint The key against which the token be searched. 
	*/
	public boolean function verifyCSRFToken( required string token='', string key='' ) {
		if( getIsCSRF() ) {
			return CSRFVerifyToken( arguments.token, arguments.key );
		} else {
			// A struct of tokens
			var CSRFTokens = flash.get( getFlashKey(), {} );
			
			// See if the token for that key exists and matches
			if( structKeyExists( CSRFTokens, arguments.key ) && CSRFTokens[ arguments.key ] == arguments.token ) {
				// We're golden. As you were!
				return true;
			}
			// No token for you!
			return false;
		}
	}
	
	// -------------------------------------- Private --------------------------------------
	private string function generateNewToken( required string key='' ) {
		// Ensure tokenBase is sufficiently random for this user and could never be guessed
		var tokenBase = arguments.key;
		tokenBase &= cgi.remote_addr;
		if( isDefined( 'client' ) and structKeyExists( client, 'CFID' ) ) {
			tokenBase &= client.CFID;
		}
		if( isDefined( 'client' ) and structKeyExists( client, 'CFTOKEN' ) ) {
			tokenBase &= client.CFTOKEN;
		}
		tokenBase &= RandRange(0, 65535, "SHA1PRNG");
		tokenBase &= getTickCount();
		
		// Return a 40 character hash as the new token
		return UCase( left( hash( tokenBase, "SHA-256" ), 40) );
	} 
}
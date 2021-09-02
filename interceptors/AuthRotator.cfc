/**
 * Rotates csrf keys when login and logout using cbauth or an authentication service that listens to
 * - postAuthentication()
 * - postLogout()
 */
component extends="coldbox.system.Interceptor" accessors="true" {

	/* *********************************************************************
	 **						DI
	 ********************************************************************* */

	property name="cbcsrf" inject="@cbcsrf";

	/* *********************************************************************
	 **						Properties
	 ********************************************************************* */


	/**
	 * Configure the interceptor
	 */
	function configure(){
	}

	/**
	 * Listen to cbauth events to auto-rotate tokens upon login
	 */
	function postAuthentication( event, interceptData, rc, prc ){
		variables.cbcsrf.rotate();
		variables.log.info( "CSRF token rotations issued by auth postAuthentication" );
	}

	/**
	 * Listen to cbauth events to auto-rotate tokens upon logout
	 */
	function postLogout( event, interceptData, rc, prc ){
		variables.cbcsrf.rotate();
		variables.log.info( "CSRF token rotations issued by auth postLogout" );
	}

}

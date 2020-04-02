/**
 * My Event Handler Hint
 */
component {

	// Index
	any function index( event, rc, prc ){
		event.setView( "main/index" );
	}

	/**
	* doSubmit
	*/
	function doSubmit( event, rc, prc ){
		return csrfVerify( rc.csrf );
	}

}
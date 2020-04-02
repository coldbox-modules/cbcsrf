/**
 * My Event Handler Hint
 */
component {

	// Index
	any function index( event, rc, prc ){
		writeDump( var=structKeyArray( wirebox.getBinder().getMappings() ), output="console" );
		event.setView( "main/index" );
	}

	/**
	* doSubmit
	*/
	function doSubmit( event, rc, prc ){
		return csrfVerify( rc.csrf );
	}

}
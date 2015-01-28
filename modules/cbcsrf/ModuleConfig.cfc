/**
*********************************************************************************
* Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
*/
component {

	// Module Properties
	this.title 				= "CSRF";
	this.author 			= "Brad Wood";
	this.webURL 			= "http://www.ortussolutions.com";
	this.description 		= "Provides anti-Cross Site Request Forgery tokens that also work on older versions of CF.";
	this.version			= "1.0.0+@build.number@";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "cbcsrf";
	// Model Namespace
	this.modelNamespace		= "cbcsrf";
	// Auto Map Models Directory
	this.autoMapModels		= true;
	// CF Mapping
	this.cfmapping			= "cbcsrf";

	function configure(){
		// Mixin our own methods on handlers, interceptors and views via the ColdBox UDF Library File setting
		arrayAppend( controller.getSetting( "ApplicationHelper" ), "#moduleMapping#/models/Mixins.cfm" );
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		var appHelperArray = controller.getSetting( "ApplicationHelper" );
		var mixinToRemove = "#moduleMapping#/models/Mixins.cfm";
		var mixinIndex = arrayFindNoCase( appHelperArray, mixinToRemove );
		
		// If the mixin is in the array
		if( mixinIndex ) {
			// Remove it
			arrayDeleteAt( appHelperArray, mixinIndex );
			// Arrays passed by value in Adobe CF
			controller.setSetting( "ApplicationHelper", appHelperArray );
		}
	}
}

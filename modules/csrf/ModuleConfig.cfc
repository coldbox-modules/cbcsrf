component {

	// Module Properties
	this.title 				= "CSRF";
	this.author 			= "Brad Wood";
	this.webURL 			= "http://www.ortussolutions.com";
	this.description 		= "Provides anti-Cross Site Request Forgery tokens that also work on older versions of CF.";
	this.version			= "1.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "CSRF";
	// Model Namespace
	this.modelNamespace		= "CSRF";
	// Auto Map Models Directory
	this.autoMapModels		= true;
	// CF Mapping
	this.cfmapping			= "CSRF";

	function configure(){
		// Mixin our own methods on handlers, interceptors and views via the ColdBox UDF Library File setting
		arrayAppend( controller.getSetting( "UDFLibraryFile" ), "#moduleMapping#/model/Mixins.cfm" );
	}

}
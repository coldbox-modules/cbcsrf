/**
* My BDD Test
*/
component extends="coldbox.system.testing.BaseTestCase" appMapping="/root"{

	function run(){
		// all your suites go here.
		describe( "CSRF Module", function(){

			beforeEach(function( currentSpec ){
				csrf = getInstance( "@cbcsrf" );
				setup();
			});

			it( "should register components", function(){
				expect(	csrf ).toBeComponent();
			});

			it( "should run all integration points", function(){
				var event = execute( event="main.index", renderResults=true );
				expect( event.getValue( "cbox_rendered_content" ) ).toMatch( "Verified: true" );
			});


			describe( "Verify Interceptor", function(){

				beforeEach(function( currentSpec ){
					event = prepareMock( getRequestContext() );
					verifier = prepareMock( getInstance( dsl="coldbox:interceptor:VerifyCsfr@cbcsrf" ) );
				});

				it( "should be loaded", function(){
					expect( verifier ).toBeComponent();
				});

				it( "should not verify if the method is in GET/OPTIONS/HEAD", function(){
					var logger = prepareMock( verifier.getLog() )
						.$( "canDebug", true )
						.$( "debug" );
					event
						.$( "getHTTPMethod", "OPTIONS" )
						.$( "getCurrentEvent", "hello.save" );
					verifier.preProcess( event, {}, event.getCollection(), event.getPrivateCollection() );
					expect( logger.$callLog().debug[ 1 ][ 1 ] ).toInclude( "cbcsrf Verify skipped due to HTTP method" );
				} );

				it( "should not verify if the method is in the excludes list", function(){
					var logger = prepareMock( verifier.getLog() )
						.$( "canDebug", true )
						.$( "debug" );
					event
						.$( "getHTTPMethod", "POST" )
						.$( "getCurrentEvent", "cbtest.index" );

					verifier.preProcess( event, {}, event.getCollection(), event.getPrivateCollection() );
					expect( logger.$callLog().debug[ 1 ][ 1 ] ).toInclude( "cbcsrf Verify skipped as event:" );
				} );

				it( "should not verify if the action is marked for skipping", function(){
					var logger = prepareMock( verifier.getLog() )
						.$( "canDebug", true )
						.$( "debug" );
					event
						.$( "getHTTPMethod", "POST" )
						.$( "getCurrentEvent", "verify.index" );
					verifier.$( "actionMarkedToSkip", true );

					verifier.preProcess( event, {}, event.getCollection(), event.getPrivateCollection() );
					expect( logger.$callLog().debug[ 1 ][ 1 ] ).toInclude( "cbcsrf Verify skipped as action has been annotated to skip" );
				} );

				it( "should throw an exception if the token is not passed", function(){
					event
						.$( "getHTTPMethod", "POST" )
						.$( "getCurrentEvent", "verify.index" );
					verifier.$( "actionMarkedToSkip", false );

					expect( function(){
						verifier.preProcess( event, {}, event.getCollection(), event.getPrivateCollection() );
					} ).toThrow( "TokenNotFoundException" );
				});

				it( "should invalidate if the token is invalid via the rc", function(){
					event
						.$( "getHTTPMethod", "POST" )
						.$( "getCurrentEvent", "verify.index" )
						.setValue( "csrf", "123" );
					verifier.$( "actionMarkedToSkip", false );

					expect( function(){
						verifier.preProcess( event, {}, event.getCollection(), event.getPrivateCollection() );
					} ).toThrow( "TokenMismatchException" );
				});

				it( "should invalidate if the token is invalid via the header", function(){
					event
						.$( "getHTTPMethod", "POST" )
						.$( "getCurrentEvent", "verify.index" )
						.$( "getHttpHeader" ).$args( "x-csrf-token", "" ).$results( "456" );
					verifier.$( "actionMarkedToSkip", false );

					expect( function(){
						verifier.preProcess( event, {}, event.getCollection(), event.getPrivateCollection() );
					} ).toThrow( "TokenMismatchException" );
				});

				it( "should validate if the token is valid via the rc", function(){
					var logger = prepareMock( verifier.getLog() )
						.$( "canDebug", true )
						.$( "debug" );
					event
						.$( "getHTTPMethod", "POST" )
						.$( "getCurrentEvent", "verify.index" )
						.setValue( "csrf", csrf.generate() );
					verifier.$( "actionMarkedToSkip", false );

					verifier.preProcess( event, {}, event.getCollection(), event.getPrivateCollection() );
					expect( logger.$callLog().debug[ 1 ][ 1 ] ).toInclude( "cbcsrf verified for" );
				});

				it( "should validate if the token is valid via the header", function(){
					var logger = prepareMock( verifier.getLog() )
						.$( "canDebug", true )
						.$( "debug" );
					event
						.$( "getHTTPMethod", "POST" )
						.$( "getCurrentEvent", "verify.index" )
						.$( "getHttpHeader" ).$args( "x-csrf-token", "" ).$results( csrf.generate() );
					verifier.$( "actionMarkedToSkip", false );

					verifier.preProcess( event, {}, event.getCollection(), event.getPrivateCollection() );
					expect( logger.$callLog().debug[ 1 ][ 1 ] ).toInclude( "cbcsrf verified for" );
				});

			});

		});
	}

}
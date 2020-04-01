/**
* My BDD Test
*/
component extends="coldbox.system.testing.BaseTestCase" appMapping="/root"{

	function run(){
		// all your suites go here.
		describe( "CSRF Module", function(){

			beforeEach(function( currentSpec ){
				csrf = getInstance( "@cbcsrf" );
				cacheStorage = getInstance( "cacheStorage@cbstorages" );
				cacheStorage.clearAll();
				setup();
			});

			it( "should register components", function(){
				expect(	csrf ).toBeComponent();
			});

			it( "should run all integration points", function(){
				var event = execute( event="main.index", renderResults=true );
				expect( event.getValue( "cbox_rendered_content" ) ).toMatch( "Verified: true" );
			});

			it( "can generate and verify different tokens for different keys", function(){
				var token1 = csrf.generate();
				var token2 = csrf.generate( "unitTest" );

				expect( token1 ).notToBe( token2 );
				expect( csrf.verify( token1 ) ).toBeTrue();
				expect( csrf.verify( token2, "unitTest" ) ).toBeTrue();
			});

		});
	}

}
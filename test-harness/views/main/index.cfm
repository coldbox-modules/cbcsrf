<cfoutput>
<h1>CSRF - Default</h1>
<cfset token = csrfToken()>
<p>CSRF says: #token#</p>
<p>Verified: #csrfVerify( token )#</p>

<h1>CSRF - Custom Key With Force</h1>
<!--- Built-in functions --->
<cfset token = csrfToken( 'key', true )>
<p>CSRF says: #token#</p>
<p>Verified: #csrfVerify( token, 'key' )#</p>

<hr>

<!-- Form --->
#html.startForm( action="main.doSubmit" )#
	<h1>CSRF Valid Form</h1>
	#csrf()#

	#html.submitButton( name="submit" )#
#html.endForm()#

<hr>

<!-- Invalid Form --->
#html.startForm( action="main.doSubmit" )#
	<h1>CSRF Invalid Form</h1>
	<input type='hidden' name='csrf' id='csrf' value='12312313212'>

	#html.submitButton( name="submit" )#
#html.endForm()#

<cfdump var="#getInstance( "CacheStorage@cbstorages" ).getStorage()#">
</cfoutput>
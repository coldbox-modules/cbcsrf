<cfoutput>
<h1>CSRF</h1>

<!--- Built-in functions --->
<cfset CSRFUtil = getModel( '@cbCSRF' )>
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
</cfoutput>
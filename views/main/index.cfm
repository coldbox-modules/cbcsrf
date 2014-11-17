<cfoutput>
<h1>CSRF</h1>

<!--- Built-in functions --->
<cfset token = generateCSRFtoken()>
<p>CSRF says: #token#</p>
<p>Verified: #verifyCSRFToken( token )#</p>


<!--- Use the mapped model directly --->
<cfset CSRFUtil = getModel( 'util@cbCSRF' )>

<cfset token = CSRFUtil.generateCSRFtoken( 'key', true )>
<p>CSRF says: #token#</p>
<p>Verified: #CSRFUtil.verifyCSRFToken( token, 'key' )#</p>

</cfoutput>
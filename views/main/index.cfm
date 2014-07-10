<cfoutput>
<h1>CSRF</h1>
<cfset token = generateCSRFtoken()>
<p>CSRF says: #token#</p>
<p>Verified: #verifyCSRFToken( token )#</p>

</cfoutput>
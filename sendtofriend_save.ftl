<@editor.page title="${site.name}" showheader=true showfooter=true>
<div class="spacer"><img src="images/spacer.gif" height="1" width="1" border="0"/></div>
<#attempt>
        <#assign mysendername=page.params.sendername/>
<#recover>
        <#assign mysendername=""/>
</#attempt>
<#attempt>
        <#assign myurl=page.params.url/>
<#recover>
        <#assign myurl="http://${site.domain}/${page.name}"/>
</#attempt>
<#attempt>
	<#assign franchise = page.params.franchise/>
<#recover>
	<#assign franchise = ""/>
</#attempt>
<!--
<@editor.paragraph text="myurl=${myurl}"/>
<@editor.paragraph text="franchise=${franchise}"/>
-->
<form method="post" action="sendtofriend_submit.ftl">

	<div class = "normal-text">Your Name:<br/></div>
	<div style="text-align:left;">
                <input type="text" name="sendername" value="${mysendername}" /></div>

	<div class = "normal-text">Your Friend's Number(e.g. 4085551212):</div>
	<div style="text-align:left;">
		<input type="text" name="msisdn" style='-wap-input-format: "*N"' value="" maxlength="10"/>
	</div>

	<div>&nbsp;</div>
	<input type="hidden" name="url" value="${myurl}"/>
	<input type="hidden" name="franchise" value="${franchise}"/>
	<input type="submit" name="submit" value="Submit"/>
	<div>&nbsp;</div>
</form>
</@editor.page>
<@editor.page title="${site.name}" showheader=true showfooter=true>

<#if page.params.sendermsisdn!="">

<#else>
	${page.response.sendRedirect("sendtofriend.ftl?url="+page.params.send_url)}
</#if>

</@editor.page>
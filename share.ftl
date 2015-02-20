<@editor.page title="${site.name}" showheader=false showfooter=false encoding="utf-8">
     <#attempt>
	<#if page.params.type == "FB">
           <#assign redirectUrl = 'http://m.facebook.com/sharer.php?t=${page.params.t}&u=${u.getBitly(page.params.u)?url}' />
	<#elseif page.params.type == "TW">
           <#assign redirectUrl = 'http://twitter.com/home?status=${page.params.t} ${u.getBitly(page.params.u)?url}' />
	<#elseif page.params.type == "MS">
           <#assign redirectUrl = 'http://www.myspace.com/Modules/PostTo/Pages/?t=${page.params.t} amp;u=${u.getBitly(page.params.u)?url}' />
	<#elseif page.params.type == "EM">
           <#assign fullbody = page.params.b + u.getBitly(page.params.u) />
           <#assign redirectUrl = 'mailto:?subject=${page.params.s?url}&body=${fullbody?url}' />
	</#if>
        ${page.response.sendRedirect('${redirectUrl}')}
    <#recover>
        <@p.error_message/>
    </#attempt>
</@editor.page>
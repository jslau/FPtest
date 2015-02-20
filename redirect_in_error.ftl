<#macro redirect parsefeed>
	<#list parsefeed.rss.channel.item as items>
		<#if items.guid == page.params.id>
			<#assign counter = 1/>
		</#if>
	</#list>

	<#attempt>
		<#assign cnt = counter/>
	<#recover>
		<#assign cnt = 0/>
	</#attempt>

	<#if cnt != 1>
		${page.response.sendRedirect("/index.ftl")}
	</#if>
</#macro>
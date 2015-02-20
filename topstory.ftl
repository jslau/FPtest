<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=true showfooter=true>
<#assign tag=page.params.tag!''/>
<#attempt>
	<#include "/includes/assign-cat.ftl">
	<#if tag!="">
		<#assign feed=tool.content.getRssFeed("${feedUrl}&categories=${tag}")/>
	<#else>
		<#include "/includes/assign-feed.ftl">
	</#if>
	<#include "/includes/article-main.ftl">
<#recover>
	<@p.error_message/>
</#attempt>
</@editor.page>
<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.code>
<#attempt>
  <#assign gid=page.params.gid/>

  <#-- Assign Category. -->
  <#attempt>
   <#assign category = page.params.category/>
  <#recover>
   <#assign category = "Photos"/>
  </#attempt>

  <#-- Assign appropriate feed to use -->
  <#include "/includes/assign-feed.ftl">

    <#-- if guid not passed, start at 1st photo -->
    <#attempt>
	<#assign id=page.params.id/>
    <#recover>
	<#assign id = feed.rss.channel.item[0].guid/>
	<#assign idNext = feed.rss.channel.item[1].guid/>
	<#assign idPrev = ""/>
    </#attempt>

    <#-- Initialize total number of photos -->
    <#attempt>
	<#assign totalCount = page.params.count?number/>
    <#recover>
	<#assign totalCount = feed.rss.channel.item?size />
    </#attempt>

<#-- Set next and prev photo id -->
<#attempt>
	<#assign i = 0 />
	<#assign idPrev = "" />
	<#assign idNext = ""/>
	<#list feed.rss.channel.item as item>
		<#if item.guid == id>
			<#if i &gt; 0>
				<#assign idPrev = feed.rss.channel.item[i-1].guid/>
			</#if>
			<#if (i + 1) &lt; totalCount>
				<#assign idNext = feed.rss.channel.item[i+1].guid/>
			</#if>
			<#break/>
		</#if>
		<#assign i=i+1 />
	</#list>
<#recover>
	${page.response.sendRedirect("/index.ftl")}
</#attempt>

<title>${feed.rss.channel.item[i].title?replace("&#38;","&")?replace("&amp;","&")}</title>
<link rel="image_src" href="${feed.rss.channel.item[i]['eonline:image_full/eonline:imgurl']}" />

<#recover>
<@p.error_message/>
</#attempt>
</@editor.code>
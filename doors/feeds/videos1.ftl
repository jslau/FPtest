<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<#assign pg=page.params.page!""/>
<#assign top=5/>
<#assign bottom=0/>
<#assign counter=0/>
<#assign feed=tool.content.parseXML("http://dev.eoldoors.mtiny.com/doors/feeds/parse0.ftl")/>
<#if pg!="">
    <#assign top=top+5*pg?number/>
    <#assign bottom=bottom+5*pg?number/>
<#else>
</#if>
<#assign feed=tool.content.parseXML(page.params.feed)/>
<#attempt>
	<#list feed.rss.channel.item as item>
		<#if counter&gt;=bottom && counter&lt;top>
			<item>
				<category>Videos</category>
				<title>${item.title?html}</title>
				<guid>${item.guid}</guid>
				<image>${item["eonline:image_small/eonline:imgurl"]}</image>
				<v_iphone>${item["eonline:iphone_videourl"]}</v_iphone>
				<v_and_mq>${item["eonline:android_mq_videourl"]}</v_and_mq>
			</item>
		</#if>
		<#assign counter=counter+1/>
	</#list>
<#--
	<#list bottom..top as x>
		<item>
				<category>Videos</category>
				<title>${feed.rss.channel.item[x].title?html}</title>
				<guid>${feed.rss.channel.item[x].guid}</guid>
				<image>${feed.rss.channel.item[x]["eonline:image_small/eonline:imgurl"]}</image>
				<v_iphone>${feed.rss.channel.item[x]["eonline:iphone_videourl"]}</v_iphone>
				<v_and_mq>${feed.rss.channel.item[x]["eonline:android_mq_videourl"]}</v_and_mq>
		</item>
	</#list>
-->
<#--
	<#list feed.rss.channel.item as item>
		<#if counter&gt;bottom && counter&lt;top>
			<item>
				<category>Videos</category>
				<title>${item.title?html}</title>
				<guid>${item.guid}</guid>
				<image>${item["eonline:image_small/eonline:imgurl"]}</image>
				<v_iphone>${item["eonline:iphone_videourl"]}</v_iphone>
				<v_and_mq>${item["eonline:android_mq_videourl"]}</v_and_mq>
			</item>
		</#if>
		<#if limiter&gt;top>
			<#break>
		<#else>
			<#assign limiter=limiter+1/>
		</#if>
		<#assign counter=counter+1/>
	</#list>
-->
<#recover>
		<item></item>
</#attempt>
<#if (page.id?starts_with("topstory.ftl"))>	
	<#assign cat="1" />
<#elseif (page.id?starts_with("watch_kristin.ftl"))>
	<#assign cat="6" />
<#elseif (page.id?starts_with("awful_truth.ftl"))>
	<#assign cat="7" />
<#elseif (page.id?starts_with("red_carpet.ftl"))>
	<#assign cat="8" />
<#elseif (page.id?starts_with("movies.ftl"))>
	<#assign cat="9" />
<#else>
	<#assign cat="1" />
</#if>

<#assign feedUrl="http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=${cat}" />
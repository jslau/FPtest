<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>

<#-- news, videos, photos, www, awful, eshows, red carpet, movies -->
   <#assign category = "Photo Galleries" />
   <#assign feedUrl = f.feeds[category] />
   <#assign feed = tool.content.getRssFeed(feedUrl) />
<#global servername = "http://" + page.request.getServerName() />
<section>
 <name>Photos</name>
 <listurl>${servername}/photo_list.ftl</listurl>
 <#list feed.rss.channel.item as item >
   <item>
    <guid>${item["eonline:guid"]}</guid>
    <title>${item["eonline:title"]?html}</title>
    <displayorder><#if (item["eonline:title"] =='Fashion Police')>2<#elseif (item["eonline:title"]?starts_with('The Big Picture'))>1<#else>99</#if></displayorder>
    <franchise></franchise>
     <imgurl>
      ${item["eonline:thumbnail_240/eonline:imgurl"]}
    </imgurl>
    <linkurl>${servername}/photo.ftl?gid=${item["eonline:guid"]}</linkurl>
   </item>
 </#list>
</section>
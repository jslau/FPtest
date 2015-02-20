<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<#-- news, videos, photos, www, awful, eshows, red carpet, movies -->
   <#assign category = "Photo Galleries All" />
   <#assign feedUrl = f.feeds[category] />
   <#assign feed = tool.content.getRssFeed(feedUrl) />
   <#global servername = "http://" + page.request.getServerName() />
<section>
 <name>Photos</name>
 <listurl>${servername}/photo_list.ftl?category=Photos</listurl>
 <#list feed.rss.channel.item as item >
   <item>
    <guid>${item.guid}</guid>
    <title>${item.title?html}</title>
    <displayorder><#if (item.title=='Fashion Police')>2<#elseif (item.title?starts_with('The Big Picture'))>1<#else>99</#if></displayorder>
    <franchise></franchise>
     <imgurl_74>
      ${item["eonline:image_small/eonline:imgurl"]}
    </imgurl_74>
     <imgurl_120>
      ${item["eonline:image_small/eonline:imgurl"]?replace("74/74","120/120")}
    </imgurl_120>
     <imgurl_148>
      ${item["eonline:image_small/eonline:imgurl"]?replace("74/74","148/148")}
    </imgurl_148>
     <imgurl_240>
      ${item["eonline:image_small/eonline:imgurl"]?replace("74/74","240/240")}
    </imgurl_240>
    <linkurl>${servername}/photo.ftl?gid=${item.guid}</linkurl>
   </item>
 </#list>
</section>
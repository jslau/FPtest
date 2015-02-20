<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
   <#include "/includes/ua.ftl"/>
   <#assign category = "Videos" />
   <#global servername = "http://" + page.request.getServerName() />
<#--
   <#assign feed = tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/video/latest.xml?count=5") />
-->
   <#assign feed = tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/video/topvideos.xml") />

<section>
 <name>${category}</name>
 <listurl>${servername}/video_series_list.ftl?category=${category}</listurl>
 <#assign i = 0 />

 <#list feed.rss.channel.item as item >

    <item>
     <series>${item["eonline:series"]?html}</series>
     <guid>${item.enclosure.@url}</guid>
     <title>${item.title?html}</title>

     <#assign localdate = p.convertTimezoneShort(item.pubDate, 'PDT', 'PST') />
     <updated>${localdate}</updated>

     <franchise></franchise>
     <imgurl>
      <#if display == "SD">${item["eonline:thumbnail_large/eonline:imgurl"]?replace("480/360/","173/130/")}
      <#elseif display == "HD">${item["eonline:thumbnail_large/eonline:imgurl"]?replace("480/360/","173/130/")}
      <#elseif display == "LG">${item["eonline:thumbnail_large/eonline:imgurl"]?replace("480/360/","200/150/")}
      <#else>${item["eonline:thumbnail_large/eonline:imgurl"]?replace("/480/360/","/173/130/")}</#if>
    </imgurl>
    <linkurl>${item.enclosure.@url}</linkurl>
    </item>

 </#list>
</section>
<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
   <#include "/includes/ua.ftl"/>
   <#assign category = "Videos" />
   <#global servername = "http://" + page.request.getServerName() />
   <#assign feed = tool.content.getRssFeed("${servername}/xml/homefeed/videofeed_pre.ftl") />
<section>
 <name>${category}</name>
 <listurl>${servername}/video_series_list.ftl?category=${category}</listurl>
 <#assign i = 0 />

 <#list feed.section.item?sort_by("series") as item >

    <item>
     <series>${item.series?html}</series>
     <guid>${item.guid}</guid>
     <title>${item.title?html}</title>
     <updated>${item.updated}</updated>
     <franchise></franchise>
     <imgurl>${item.imgurl}</imgurl>
    <linkurl>${item.linkurl}</linkurl>
    </item>

 </#list>
</section>
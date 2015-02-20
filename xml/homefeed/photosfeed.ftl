<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
   <#assign category = "Photo Galleries New" />
   <#include "/includes/ua.ftl"/>

   <#global servername = "http://" + page.request.getServerName() />
   <#assign feed = tool.content.getRssFeed("${servername}/xml/homefeed/photosfeed_pre.ftl") />
   <#assign feed = tool.content.getRssFeed("http://dev.etp.mtiny.com/xml/homefeed/photosfeed_pre.ftl") />
<#--
   <#assign maxgalleries = 10 />
   <#assign display = "SD" />
-->
<section>
 <name>Photos</name>
 <listurl>${servername}/photo_list.ftl?category=Photos</listurl>
 <#assign i = 0 />
 <#list feed.section.item?sort_by('displayorder') as item >
  <#if i &lt; maxgalleries >
   <item>
    <guid>${item.guid}</guid>
    <title>${item.title?html}</title>
    <displayorder>${item.displayorder}</displayorder>
    <franchise></franchise>
     <imgurl>
      <#if display == "SD">${item.imgurl_120}
      <#elseif display == "HD">${item.imgurl_240}
      <#elseif display == "LG">${item.imgurl_148}
      <#else>${item.imgurl_120}</#if>
    </imgurl>
    <linkurl>${servername}/photo.ftl?gid=${item.guid}</linkurl>
   </item>
   <#assign i = i + 1 />
  <#else>
   <#break />
  </#if>
 </#list>
</section>
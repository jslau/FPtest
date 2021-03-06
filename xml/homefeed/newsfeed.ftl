<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<#-- news, videos, photos, www, awful, eshows, red carpet, movies -->
   <#assign category = "Latest News" />
   <#assign feedUrl = f.feeds[category] />
   <#assign feed = tool.content.getRssFeed(feedUrl) />
   <#if display == "LG">
      <#assign multiplier = 2 />
   <#else>
      <#assign multiplier = 1 />
   </#if>

<section>
 <name>${category}</name>
 <listurl>${servername}/article_list.ftl?category=${category}</listurl>
 <#assign i = 0 />
 <#list feed.rss.channel.item as item >
  <#if i &lt; (maxarticles * multiplier) >
   <#include "resizearticle.ftl" />
   <item>
    <guid>${item.guid}</guid>
    <title>${item.title?html}</title>
    <#assign localdate = p.convertTimezoneShort(item["eonline:updated"], 'GMT', 'PST') />
    <updated>${localdate}</updated>
    <franchise>${item["eonline:franchise"]}</franchise>
     <imgurl>
      <#if display == "SD">${img120}
      <#elseif display == "HD">${img240}
      <#elseif display == "LG">${img148}
      <#else>${img120}</#if>
    </imgurl>
      <#assign linkurl = '/article.ftl?category=${category}&amp;franchise=${item["eonline:franchise"]}&amp;id=${item.guid}'/>
    <linkurl>${servername}${linkurl}</linkurl>
   </item>
   <#assign i = i + 1 />
  <#else>
   <#break />
  </#if>
 </#list>
</section>
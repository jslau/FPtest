<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<#assign feed = tool.content.getRssFeed("http://dev.etp.mtiny.com/xml/shows.xml") />
<@u.getDeviceDimension />
   <#assign category = "Videos" />
   <#assign feedUrl = f.feeds[category] />
   <#assign feed = tool.content.getRssFeed(feedUrl) />
<video_series>
<#assign prev = 'blank' />
<#list feed.rss.channel.item?sort_by("eonline:series") as item >
   <#if prev != item["eonline:series"] >
      <item><title>${item["eonline:series"]?html}</title>
             <imgurl><#if     item["eonline:series"] == 'Chelsea Lately' >images/${ImageWidth}_Chelsea_Smartphone_Thumbnails.jpg
                     <#elseif item["eonline:series"] == 'E! News Now' >logo.png
                     <#elseif item["eonline:series"] == 'Fashion Police' >images/${ImageWidth}_FP_Smartphone_Thumbnails.jpg
                     <#elseif item["eonline:series"] == 'Kourtney & Kim Take New York' >images/${ImageWidth}_KKTNY_Smartphone_Thumbnails.jpg
                     <#elseif item["eonline:series"] == 'The Soup' >images/${ImageWidth}_Soup_Smartphone_Thumbnails.jpg
                     <#elseif item["eonline:series"] == 'Keeping Up with The Kardashians' >logo.png
                     <#elseif item["eonline:series"] == 'Kourtney & Kim Take Miami' >images/${ImageWidth}_KKTM_Smartphone_Thumbnails.jpg
                     <#elseif item["eonline:series"] == 'Khloe & Lamar' >images/${ImageWidth}_KLAMAR_Smartphone_Thumbnails.jpg
                     </#if>
                     <#elseif item["eonline:series"] == 'Opening Act' >images/${ImageWidth}_OA_Smartphone_Thumbnails.png
                     </#if>
                     <#elseif item["eonline:series"] == 'Married to Jonas' >images/${ImageWidth}_jonas_Smartphone_Thumbnails.png
                     </#if>
             </imgurl>
      </item>
      <#assign prev = item["eonline:series"]/>
   </#if>
</#list>
</video_series>
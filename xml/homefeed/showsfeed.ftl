<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<#-- news, videos, photos, www, awful, eshows, red carpet, movies -->
<@u.getDeviceDimension />
   <#assign category = "Shows" />
   <#assign feedUrl = f.feeds[category] />
   <#global servername = "http://" + page.request.getServerName() />
   <#assign feed = tool.content.getRssFeed("http://testapps.eonline.com/nocache/latest_new.xml") />

<#--http://syndication.eonline.com/syndication/feeds/iphone/shows/latest.xml-->
<#--http://testapps.eonline.com/nocache/latest.xml-->


<section>
 <name>${category}</name>
 <listurl>${servername}/show_list.ftl?category=${category}</listurl>
 <#assign i = 0 />
 <#list feed.rss.channel.item as item >
  <#if !(item["eonline:title"]?contains('E! News Now')) && !(item["eonline:title"]?contains('Khloe Take Miami')) && !(item["eonline:title"]?contains('Trends'))&& !
(item["eonline:title"]?contains('Red Carpet'))>

<#attempt>
   <item>
    <#if item["eonline:title"]?contains('Kim Take New York') >
      <#assign show = 'kktny' /><#assign show2 = 'KKTNY' />
    <#elseif item["eonline:title"]?contains('Fashion Police') >
      <#assign show = 'fp' /><#assign show2 = 'FP' />
    <#elseif item["eonline:title"]?contains('Khloe Take Miami') >
      <#assign show = 'kktm' /><#assign show2 = 'KKTM' />
    <#elseif item["eonline:title"]?contains('Chelsea Lately') >
      <#assign show = 'ch' /><#assign show2 = 'Chelsea' />
    <#elseif item["eonline:title"]?contains('The Soup') >
      <#assign show = 'soup' /><#assign show2 = 'Soup' />
    <#elseif item["eonline:title"]?contains('Keeping Up With The Kardashians') >
      <#assign show = 'kuwtk' /><#assign show2 = 'KUWTK' />
    <#elseif item["eonline:title"]?contains('Lamar') >
      <#assign show = 'klamar' /><#assign show2 = 'KLAMAR' />
<#elseif item["eonline:title"]?contains('Opening Act') >
      <#assign show = 'openingact' /><#assign show2 = 'OA' />
<#elseif item["eonline:title"]?contains('Married to Jonas') >
      <#assign show = 'jonas' /><#assign show2 = 'JONAS' />
<#elseif item["eonline:title"]?contains('Love You, Mean It') >
      <#assign show = 'lymi' /><#assign show2 = 'LYMI' />

    </#if>
    <guid>${servername}/shows/${show}/index.ftl</guid>
    <title>${item["eonline:title"]?html}</title>
     <imgurl>
<#-- Replaced with local copy of images
      <#if display == "SD">${item["eonline:thumbnail_120/eonline:imgurl"]}
      <#elseif display == "HD">${item["eonline:thumbnail_240/eonline:imgurl"]}
      <#elseif display == "LG">${item["eonline:thumbnail_148/eonline:imgurl"]}
      <#else>${item["eonline:thumbnail_120/eonline:imgurl"]}</#if>
-->
      <#if display == "SD">${servername}/images/120_${show2}_Smartphone_Thumbnails.jpg
      <#elseif display == "HD">${servername}/images/240_${show2}_Smartphone_Thumbnails.jpg
      <#elseif display == "LG">${servername}/images/148_${show2}_Smartphone_Thumbnails.jpg
      <#else>${servername}/images/120_${show2}_Smartphone_Thumbnails.jpg</#if>
    </imgurl>

    <linkurl>${servername}/shows/${show}/index.ftl</linkurl>
   </item>
   <#assign i = i + 1 />

<#recover>
error: ${.error}
</#attempt>
  </#if>
 </#list>
</section>
<#attempt>

<#if tool.text.customAdiPhone=="true"> 

  <#assign ua = tool.device.ua />
  <#if ua?contains('iPhone')>
     <#assign link = tool.text.KUWTKOniTunes />
  <#elseif ua?contains('Android')|| ua?contains('Droid Build')>
     <#assign link = tool.text.KUWTKOnAndroidMarket />
  <#else>
     <#assign link = tool.text.KUWTKOniTunes />
  </#if>
     <#assign image = "/images/KUWTK_S5_refresh_banners_300.jpg" />

<#else>

  <#assign feed=tool.content.getRssFeed("http://www.eonline.com/static/syndication/feeds/iphone/marketing_bricks/index.xml")/>
  <#assign image = feed.rss.channel.image.url />
  <#assign link = feed.rss.channel.image.link />
</#if>

<#recover>
  <#assign image = '' />
  <#assign link = '' />
</#attempt>

<div align="center"><a href="${link}" ><img src="${image}" alt="Marketing Brick" width="300" height="50" /></a></div>
<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<?xml version="1.0" encoding="UTF-8"?>

<#global display = "LG" />

<#if display == "L" || display == "LG" >
 <#global maxarticles = tool.text.ipadCarouselMaxArticles?number />
 <#global maxgalleries = tool.text.ipadCarouselMaxGalleries?number />
<#else>
 <#global maxarticles = tool.text.iphoneCarouselMaxArticles?number />
 <#global maxgalleries = tool.text.iphoneCarouselMaxGalleries?number />
</#if>

<#global servername = "http://" + page.request.getServerName() />

<sections>
 <#include "/xml/homefeed/newsfeed.ftl" />
 <#include "/xml/homefeed/videofeed.ftl" />
 <#include "/xml/homefeed/marketingbrickfeed.ftl" />
 <#include "/xml/homefeed/photosfeed.ftl" />
 <#include "/xml/homefeed/showsfeed.ftl" />
 <#include "/xml/homefeed/wwkfeed.ftl" />
 <#include "/xml/homefeed/awfulfeed.ftl" />
 <#include "/xml/homefeed/morefeed.ftl" />
</sections>
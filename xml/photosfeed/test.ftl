<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<?xml version="1.0" encoding="UTF-8"?>

<#attempt>
 <#global display = page.params.display!"SD" />
<#recover>
 <#global display = "SD" />
</#attempt>

<#global servername = "http://" + page.request.getServerName() />

<#if display == "LG" >
 <#global maxarticles = tool.text.ipadCarouselMaxArticles?number />
 <#global maxgalleries = tool.text.ipadCarouselMaxGalleries?number />
<#else>
 <#global maxarticles = tool.text.iphoneCarouselMaxArticles?number />
 <#global maxgalleries = tool.text.iphoneCarouselMaxGalleries?number />
</#if>

<sections>
 <#include "photosfeed.ftl" />
<#--
 <#include "photosfeed_pre.ftl" />
-->
</sections>
<#assign langMenuMap = { '0' : 'menuGB',
                         '1' : 'menuFR',
                         '2' : 'menuIT',
                         '3' : 'menuDE' } />

<#assign langMenuButton = { '0' : 'menuLinkMulti',
                            '1' : 'menuLinkMulti',
                            '2' : 'menuLinkMulti',
                            '3' : 'menuLinkDE' } />

<#assign articleTitleMenuMap = { '0' : 'titleGB',
                                 '1' : 'titleFR',
                                 '2' : 'titleIT',
                                 '3' : 'titleDE' } />


<#-- Handle special characters -->
<#function clean(text)>
   <#return text?replace('&','&amp;')?replace("'","&apos;")?replace('"','&quot;')?replace('<','&lt;')?replace('>','&gt;') />
</#function>

<#-- Returns device width -->
<#macro getDeviceDimension>
  <#global defaultScreenWidth = 320 />
  <#global mywidth = '' />
  <#global device = '' />
  <#global itemspercarousel = 1 />
  <#global ua = tool.device.ua />

  <#attempt>

    <#global width = .globals.page.request.getSession().getAttribute("width")?number />

    <#if (width <= 128)>
      <#global mywidth = '128' />
    <#elseif (width > 128 && width <= 176)>
      <#global mywidth = '176' />
    <#elseif (width > 176 && width <= 240)>
      <#global mywidth = '240' />
    <#elseif (width > 240 && width <= 320)>
      <#global mywidth = '320' />
    <#elseif (width > 320 && width <= 480)>
      <#global mywidth = '480' />
    <#elseif (width > 480 && width <= 768)>
      <#global mywidth = '768' />
    <#elseif (width > 768)>
      <#global mywidth = '1024' />
    <#else>
      <#global mywidth = '320' />
    </#if>

                <#if ua?contains('iPad')>
                        <#global device='iPad' />
                        <#global display='LG' />
                        <#global itemspercarousel = tool.text.ipadCarouselMaxArticles />
                        <#global ImageWidth = tool.text.ipad.image.width />
                        <#global ImageHeight = tool.text.ipad.image.height />
                        <#global listItemsPerPage = tool.text.ipadListItemsPerPage?number />
                <#elseif ua?contains('iPhone')>
                        <#global device='iPhone' />
                        <#if ua?contains('iPhone OS 4') >
                          <#global display='HD' />
                        <#else>
                          <#global display='SD' />
                        </#if>
                        <#global itemspercarousel = tool.text.iphoneCarouselMaxArticles />
                        <#global ImageWidth = tool.text.iphone.image.width />
                        <#global ImageHeight = tool.text.iphone.image.height />
                        <#global listItemsPerPage = tool.text.iphoneListItemsPerPage?number />
                <#elseif ua?contains('Android') || ua?contains('Droid Build') >
                        <#global device='Android' />
                        <#global display='SD' />
                        <#global itemspercarousel = tool.text.iphoneCarouselMaxArticles />
                        <#global ImageWidth = tool.text.iphone.image.width />
                        <#global ImageHeight = tool.text.iphone.image.height />
                        <#global listItemsPerPage = tool.text.iphoneListItemsPerPage?number />
                        <#if ua?contains('Mobile') >
                          <#global device='Android Mobile' />
                        <#else>
                          <#global device='Android Tablet' />
                        </#if>
                <#elseif ua?contains('BlackBerry')>
                        <#global device='BlackBerry' />
                        <#global display='SD' />
                        <#global itemspercarousel = tool.text.ipadCarouselMaxArticles />
                        <#global ImageWidth = tool.text.ipad.image.width />
                        <#global ImageHeight = tool.text.ipad.image.height />
                        <#global listItemsPerPage = tool.text.ipadListItemsPerPage?number />
                <#else>
                        <#global device='iPad' />
                        <#global display='LG' />
                        <#global itemspercarousel = tool.text.ipadCarouselMaxArticles />
                        <#global ImageWidth = tool.text.ipad.image.width />
                        <#global ImageHeight = tool.text.ipad.image.height />
                        <#global listItemsPerPage = tool.text.ipadListItemsPerPage?number />
		</#if>

  <#recover>
                        <#global mywidth = defaultScreenWidth />
<#--
                        <#global device='iPad' />
                        <#global display='LG' />
                        <#global itemspercarousel = tool.text.ipadCarouselMaxArticles />
                        <#global ImageWidth = tool.text.ipad.image.width />
                        <#global ImageHeight = tool.text.ipad.image.height />
                        <#global listItemsPerPage = tool.text.ipadListItemsPerPage?number />
-->
                        <#global device='iPhone' />
                        <#global display='SD' />
                        <#global itemspercarousel = tool.text.iphoneCarouselMaxArticles />
                        <#global ImageWidth = tool.text.iphone.image.width />
                        <#global ImageHeight = tool.text.iphone.image.height />
                        <#global listItemsPerPage = tool.text.iphoneListItemsPerPage?number />
                        ${page.request.getSession(true).setAttribute('width', mywidth)}
  </#attempt>
<#--
  ${page.request.getSession(true).setAttribute('width', mywidth)}
-->
<#--
DEBUG: Device=${device}
ImageWidth=${ImageWidth}
ImageWidth=${ImageWidth}
-->
</#macro>

<#-- Fetch or Set userID session variable -->
<#macro setUserId>
  <#attempt>
    <#global userId=(page.request.getSession(true).getAttribute("userId")?string)>
  <#recover>
    <#assign randInteger=((tool.util.getDate().getTime())+1)?number />
      ${page.request.getSession(true).setAttribute("userId",randInteger)}
    <#global userId=(page.request.getSession(true).getAttribute("userId")?string)>
  </#attempt>
</#macro>

<#-- Set SiteId global variable -->
<#macro setSiteId>
  <#attempt>
    <#global ua=tool.device.ua/>
    <#if ua?contains('iPhone') || ua?contains('iPad')|| ua?contains('iPod')>
     <#global siteId=tool.text.rhythm.SiteId.EOnline.iPhone/>
     <#global photoInterstitialSiteId=tool.text.rhythm.SiteId.EOnline.photoInterstitial.iPhone/>
     <#global videoSiteId=tool.text.rhythm.SiteId.EOnline.video.iPhone/>
    <#elseif ua?contains('Android') || ua?contains('Droid Build')>
     <#global siteId=tool.text.rhythm.SiteId.EOnline.Android/>
     <#global photoInterstitialSiteId=tool.text.rhythm.SiteId.EOnline.photoInterstitial.Android/>
     <#global videoSiteId=tool.text.rhythm.SiteId.EOnline.video.Android/>
    <#elseif ua?contains('BlackBerry')>
     <#global siteId=tool.text.rhythm.SiteId.EOnline.BlackBerry/>
     <#global photoInterstitialSiteId=tool.text.rhythm.SiteId.EOnline.photoInterstitial.BlackBerry/>
     <#global videoSiteId=tool.text.rhythm.SiteId.EOnline.video.BlackBerry/>
    <#else>
     <#global siteId=tool.text.rhythm.SiteId.EOnline.misc/>
     <#global photoInterstitialSiteId=tool.text.rhythm.SiteId.EOnline.photoInterstitial.misc/>
     <#global videoSiteId=tool.text.rhythm.SiteId.EOnline.video.misc/>
    </#if>
  <#recover>
    <#global siteId=tool.text.rhythm.SiteId.EOnline.misc/>
     <#global photoInterstitialSiteId=tool.text.rhythm.SiteId.EOnline.photoInterstitial.misc/>
     <#global videoSiteId=tool.text.rhythm.SiteId.EOnline.video.misc/>
  </#attempt>
</#macro>

<#function getBitly(longUrl) >
<#--
<#assign bitlyApi = "http://api.bitly.com/v3/shorten" />
<#assign bitlyLogin = "eonline" />
<#assign bitlyApiKey = "R_2c390f9144ccc146e07ce354f935d278" />
-->
<#attempt>
   <#assign bitlyUrl = tool.text.bitlyApi + "?login=" + tool.text.bitlyLogin + "&apiKey=" +tool.text.bitlyApiKey + "&longUrl=" + longUrl?url + "&format=xml" />
   <#assign response = tool.content.parseXML( bitlyUrl) />

   <#list response.response as r>
      <#if r.status_txt == "OK">
         <#assign shortUrl =  r.data.url />
      <#else>
         <#assign shortUrl =  longUrl/>
      </#if>
   </#list>

   <#return shortUrl/>
<#recover>
   <#return longUrl/>
</#attempt>
</#function>
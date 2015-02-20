<#macro setCookie value>
    ${tool.util.getCookie().add("ClientGeolocalisation", "${value}", 604800)}
</#macro>

<#function getCookie()>
    <#assign cookie = ""/>
    <#list page.request.getHeaderNames() as header>
      <#if header?contains("cookie")>
        <#--<#assign cookie = "${header} - ${page.request.getHeader(header)!''}"/>-->
        <#assign cookie = "${page.request.getHeader(header)!''}"/>
        <#-- Break here to make sure that we are getting 'cookie'. We want to omit 'cookie2' if any -->
      <#break>
      </#if>
    </#list>
    <#return cookie />
</#function>
  
<#function getSpecificCookie(cookies,cookieS)>
     <#assign trimedCookie = 'null' />
     <#assign arrayCookies = cookies />  
     <#list arrayCookies?split(';') as currentItem> 
        <#assign currentCookie = currentItem?trim/>
        <#if (currentCookie?contains(cookieS))>
            <#assign result = currentCookie />
            <#assign posS = result?string?index_of("=")?number + 1 />
            <#assign trimedCookie = result?string?substring(posS) />
            <#break>
        </#if> 
     </#list>   
     <#return trimedCookie />  
</#function>


<#macro ClientCountry>
<#--
<#attempt>
-->
    <#assign testFunction = 1 />
    <#attempt>
        <#assign arrayC = getCookie() />
        <#assign cookieClientCountry = getSpecificCookie(arrayC,"ClientGeolocalisation") />
    <#recover>
        <#assign cookieClientCountry = 'null' />
    </#attempt>
<#--    
    <#attempt>
        <#assign sessionClientCountry = "${page.request.getSession().getAttribute('sessionClientCountry')}" />
    <#recover>
        <#assign sessionClientCountry = "null" />
    </#attempt>
-->  
    <#if (page.params.ipCC)??>
        <#assign ipClient = (page.params.ipCC) />
        <#global ipCountryTest = '&ipCC='+ipClient />
        <#global ipCountryTestMenu = '?ipCC='+ipClient />
        <#assign ipCCTest = ipClient />
    <#else>
        <#assign ipClient = (page.request.getHeader('x-forwarded-for')) />
        <#--<#assign ipClient = '31.186.234.41'/>-->
        <#global ipCountryTest = '' />
        <#global ipCountryTestMenu = '' />
        <#assign ipCCTest = '' />
    </#if>
    <#--
         Ip examples:

         (GB)United Kingdom - 212.140.167.69 , 188.39.78.2 , 31.186.234.41 , 178.79.173.228
         (FR)France         - 176.121.201.250(not working) , 91.121.96.167 , 94.23.45.19 ,  78.192.239.26
         (IT)Italy          - 212.31.237.174 , 141.108.5.48 , 151.13.151.101 , 151.13.151.105
         (DE)Germany        - 78.47.102.91 , 177.135.208.106 , 188.72.201.85 , 62.156.150.205
    -->

      <#if (ipClient?contains(','))>
          <#-- more then one ip client -->
          <#assign counter = 0 />
          <#list ipClient?split(',') as ipC> 
            <#if (counter == 0)>
                <#assign ipClient = ipC?trim />
            <#else>
            </#if> 
            <#assign counter = counter + 1 />
          </#list>
      <#else>
          <#-- only one ip client -->
      </#if>
 


        <#if (cookieClientCountry?contains('GB') || cookieClientCountry?contains('FR') || cookieClientCountry?contains('IT') || cookieClientCountry?contains('DE'))>
            <#assign clientCountry = cookieClientCountry />
            <#global testIp = 'cookie' />
        <#else>
            <#assign checkIPSerw = tool.content.parseXML("http://10.152.0.23/geo/iplocation.php?ip="+ipClient) />
            <#list checkIPSerw.geoResponse as X>
                 <#assign clientCountry = X.address.countryCode />
                 <#global clientCountrys = X.address.countryCode />
            </#list>
            <#if clientCountry?contains('GB')>
                <@ipcheck.setCookie "GB" />
                ${page.request.getSession().setAttribute('sessionClientCountry','GB')}
            <#elseif clientCountry?contains('FR')>
                <@ipcheck.setCookie "FR" />
                ${page.request.getSession().setAttribute('sessionClientCountry','FR')}
            <#elseif clientCountry?contains('IT')>
                <@ipcheck.setCookie "IT" />
                ${page.request.getSession().setAttribute('sessionClientCountry','IT')}
            <#elseif clientCountry?contains('DE')>
                <@ipcheck.setCookie "DE" />
                ${page.request.getSession().setAttribute('sessionClientCountry','DE')}
            <#else>
                <@ipcheck.setCookie "GB" />
                ${page.request.getSession().setAttribute('sessionClientCountry','GB')}
            </#if>
            <#global testIp = 'api platform' />
        </#if>


    <#if clientCountry?contains('GB')>
        ${page.request.getSession().setAttribute('ClientCountryArr',0)}
        <#global fixTransl = 0 /><#-- YOC -->
        <#global AdsProvider = 1 />
        <#global currentCountry = 'uk' />
    <#elseif clientCountry?contains('FR')>
        ${page.request.getSession().setAttribute('ClientCountryArr',1)}
        <#global fixTransl = 1 />
        <#global AdsProvider = 2 /><#-- AdMarvel -->
        <#global currentCountry = 'fr' />
    <#elseif clientCountry?contains('IT')>
        ${page.request.getSession().setAttribute('ClientCountryArr',2)}
        <#global fixTransl = 2 />
        <#global AdsProvider = 2 />
        <#global currentCountry = 'it' />
    <#elseif clientCountry?contains('DE')>
        ${page.request.getSession().setAttribute('ClientCountryArr',3)}
        <#global fixTransl = 3 />
        <#global AdsProvider = 2 />
        <#global currentCountry = 'de' />
    <#else>
        ${page.request.getSession().setAttribute('ClientCountryArr',0)}
        <#global fixTransl = 0 />
        <#global AdsProvider = 2 />
        <#global currentCountry = 'uk' />
    </#if>
    <#attempt>
      <#if clientCountry?contains('GB')>
          <#assign shareTranslate = 'Share' />
          <#assign photosTranslate = 'Photos' />
      <#elseif clientCountry?contains('FR')>
          <#assign shareTranslate = 'Partager' />
          <#assign photosTranslate = 'Photos' />
      <#elseif clientCountry?contains('IT')>
          <#assign shareTranslate = 'Condividi' />
          <#assign photosTranslate = 'Foto' />
      <#elseif clientCountry?contains('DE')>
          <#assign shareTranslate = 'Teilen' />
          <#assign photosTranslate = 'Fotos' />
      <#else>
          <#assign shareTranslate = 'Share' />
          <#assign photosTranslate = 'Photos' />
      </#if>
    <#recover>
          <#assign shareTranslate = 'Share' />
          <#assign photosTranslate = 'Photos' />
    </#attempt>
    <#if clientCountry?contains('GB')>
        ${page.request.getSession().setAttribute('ClientCountry','GB')}
        <#global feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=uk' />
        <#global feedPhotos = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=uk' />
        <#global feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=uk_row_intl_video_masterfeed' />
    <#elseif clientCountry?contains('FR')>
        ${page.request.getSession().setAttribute('ClientCountry','FR')}
        <#global feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=fr' />
        <#global feedPhotos = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=fr' />
        <#global feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=fr_row_intl_video_masterfeed' />
    <#elseif clientCountry?contains('IT')>
        ${page.request.getSession().setAttribute('ClientCountry','IT')}
        <#global feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=it' />
        <#global feedPhotos = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=it' />
        <#global feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=it_row_intl_video_masterfeed' />
    <#elseif clientCountry?contains('DE')>
        ${page.request.getSession().setAttribute('ClientCountry','DE')}
        <#global feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=de' />
        <#global feedPhotos = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=de' />
        <#global feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=de_row_intl_video_masterfeed' />
    <#else>
        ${page.request.getSession().setAttribute('ClientCountry','DEF_GB')}
        <#global feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=uk' />
        <#global feedPhotos = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=uk' />
        <#global feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=uk_row_intl_video_masterfeed' />
    </#if>
    <#--
<#recover>
    <p>Error ip check</p>
    ${page.request.getSession().setAttribute('ClientCountry','DEF_GB')}
    <#global feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=uk' />
    <#global feedPhotos = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=uk' />
    <#global feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=uk_row_intl_video_masterfeed' />
</#attempt>
-->
</#macro>
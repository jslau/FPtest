<#macro setCookie value>
    ${tool.util.getCookie().add("CustomerGeolocation", "${value}", 604800)}
</#macro>

<#function getCookie()>
  <#assign cookie = 'null' />
  <#list page.request.getHeaderNames() as header>
    <#if header?contains("cookie")>
      <#assign cookie = "${page.request.getHeader(header)!''}" />
    <#break>
    </#if>
  </#list>
  <#return cookie/>
</#function>
  
<#function getSpecificCookie(cookies,cookieS)>
   <#assign trimedCookie = 'null' />
   <#assign arrayCookies = cookies />  
   <#list arrayCookies?split(';') as currentItem> 
      <#assign currentCookie = currentItem?trim />
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

<#attempt>

    <#assign activeTestFunction = 1 />
    <#attempt>
        <#assign testIpClientCountry = page.params.ipCC />
        <#if ((testIpClientCountry?trim?length < 7) || !testIpClientCountry?contains('.') || activeTestFunction == 0)>
            <#assign testIpClientCountry = "null" />
        </#if>
    <#recover>
        <#assign testIpClientCountry = "null" />
    </#attempt>
    
    <#attempt>
        <#assign arrayC = getCookie() />
        <#assign cookieClientCountry = getSpecificCookie(arrayC,"CustomerGeolocation") />
    <#recover>
        <#assign cookieClientCountry = 'null' />
    </#attempt>
    
    <#attempt>
        <#assign paramCCUrl = page.params.cc />
        <#if (paramCCUrl == 'GB')>
            <#global ccUrl = 'GB' />
        <#elseif (paramCCUrl == 'FR')>
            <#global ccUrl = 'FR' />
        <#elseif (paramCCUrl == 'IT')>
            <#global ccUrl = 'IT' />
        <#elseif (paramCCUrl == 'DE')>
            <#global ccUrl = 'DE' />
        <#elseif (paramCCUrl == 'ND')>
            <#global ccUrl = 'ND' />
        <#else>
            <#global ccUrl = 'null' />
        </#if>
    <#recover>
        <#global ccUrl = 'null' />
    </#attempt>

    
    <#if ((testIpClientCountry != 'null') && (activeTestFunction == 1))>
        <#assign ipClient = testIpClientCountry />
        <#attempt> 
            <#assign checkIPSerw = tool.content.parseXML("http://geoip-int.iloopmobile.com/iplocation.php?ip="+ipClient) />
            <#--<#assign checkIPSerw = tool.content.parseXML("http://reports.iloopmobile.com/AppService/GEO/iplocation?token=GEO2012ACCESS&ip="+ipClient) />-->
            <#list checkIPSerw.geoResponse as X>
                 <#assign clientCountry = X.address.countryCode />
            </#list>
            <#if clientCountry?contains('GB')>
                <#assign clientCountry = 'GB' />
                <@ipcheck.setCookie "GB" />
                <#global ccUrl = 'GB' />
            <#elseif clientCountry?contains('FR')>
                <#assign clientCountry = 'FR' />
                <@ipcheck.setCookie "FR" />
                <#global ccUrl = 'FR' />
            <#elseif clientCountry?contains('IT')>
                <#assign clientCountry = 'IT' />
                <@ipcheck.setCookie "IT" />
                <#global ccUrl = 'IT' />
            <#elseif clientCountry?contains('DE')>
                <#assign clientCountry = 'DE' />
                <@ipcheck.setCookie "DE" />
                <#global ccUrl = 'DE' />
            <#else>
                <#assign clientCountry = 'NULL' />
                <@ipcheck.setCookie "ND" />
                <#global ccUrl = 'ND' />
            </#if>
        <#recover>
            <#assign clientCountry = 'NULL' />
            <@ipcheck.setCookie "ND" />
            <#global ccUrl = 'ND' />
        </#attempt>
        <#global testMessage = 'feeds from test function with api call' />
    <#elseif (cookieClientCountry?trim == 'GB' || cookieClientCountry?trim == 'FR' || cookieClientCountry?trim == 'IT' || cookieClientCountry?trim == 'DE' || cookieClientCountry?trim == 'ND')>
        <#assign clientCountry = cookieClientCountry />
        <#global ccUrl = cookieClientCountry />
        <#global testMessage = 'feeds from cookies without api call' />
    <#else>
        <#attempt>
            <#assign paramCountryUrl = .globals.ccUrl /> 
        <#recover>
            <#assign paramCountryUrl = 'null' /> 
        </#attempt>        
        <#if (!paramCountryUrl?contains('null') && paramCountryUrl?trim?length > 0)>
            <#if paramCountryUrl?contains('GB')>
              <#assign clientCountry = 'GB' />
            <#elseif paramCountryUrl?contains('IT')>
              <#assign clientCountry = 'IT' />
            <#elseif paramCountryUrl?contains('FR')>
              <#assign clientCountry = 'FR' />
            <#elseif paramCountryUrl?contains('DE')>
              <#assign clientCountry = 'DE' />
            <#else>
              <#assign clientCountry = 'NULL' />
            </#if>
            <#global testMessage = 'feeds from url parameter (cc) without api call' />
        <#else>
            <#assign ipClient = (page.request.getHeader('x-forwarded-for')) />
            <#--<#assign ipClient = '31.186.234.41'/>-->
            <#attempt>
                <#assign checkIPSerw = tool.content.parseXML("http://geoip-int.iloopmobile.com/iplocation.php?ip="+ipClient) />
                <#--<#assign checkIPSerw = tool.content.parseXML("http://reports.iloopmobile.com/AppService/GEO/iplocation?token=GEO2012ACCESS&ip="+ipClient) />-->
                <#list checkIPSerw.geoResponse as X>
                     <#assign clientCountry = X.address.countryCode />
                </#list>
            <#recover>
                <#assign clientCountry = 'NULL' />
            </#attempt>
            <#if clientCountry?contains('GB')>
                <#assign clientCountry = 'GB' />
                <@ipcheck.setCookie "GB" />
                <#global ccUrl = 'GB' />
            <#elseif clientCountry?contains('FR')>
                <#assign clientCountry = 'FR' />
                <@ipcheck.setCookie "FR" />
                <#global ccUrl = 'FR' />
            <#elseif clientCountry?contains('IT')>
                <#assign clientCountry = 'IT' />
                <@ipcheck.setCookie "IT" />
                <#global ccUrl = 'IT' />
            <#elseif clientCountry?contains('DE')>
                <#assign clientCountry = 'DE' />
                <@ipcheck.setCookie "DE" />
                <#global ccUrl = 'DE' />
            <#else>
                <#assign clientCountry = 'NULL' />
                <@ipcheck.setCookie "ND" />
                <#global ccUrl = 'ND' />
            </#if>
             <#global testMessage = 'feeds from api call after refresh should be from cookies' />
        </#if>
    </#if>
    
    <#attempt>
        <#-- parameters appended to links -->
        <#attempt>
            <#assign rV = .globals.ccUrl />
        <#recover>
            <#assign rV = '' />
        </#attempt>
        <#attempt>
            <#assign tV = testIpClientCountry />
            <#if (tV == 'null')>
                <#assign tV = '' />
            </#if>
        <#recover>
            <#assign tV = '' />
        </#attempt>
        <#if ((rV?trim?length > 0) && (tV?trim?length > 0))> 
              <#global ipTestA = '?cc=' + rV + '&ipCC=' + tV />
              <#global ipTestB = '&cc=' + rV + '&ipCC=' + tV />
        <#elseif ((rV?trim?length > 0) && (tV?trim?length == 0))> 
              <#global ipTestA = '?cc=' + rV />
              <#global ipTestB = '&cc=' + rV />
        <#elseif ((rV?trim?length == 0) && (tV?trim?length > 0))> 
              <#global ipTestA = '?ipCC=' + tV />
              <#global ipTestB = '&ipCC=' + tV />
        <#else>
              <#global ipTestA = '' />
              <#global ipTestB = '' />
        </#if>
    <#recover>
        <#global ipTestA = '' />
        <#global ipTestB = '' />
    </#attempt>
    
    <#--
         Ip examples:

         (GB)United Kingdom - 212.140.167.69 , 188.39.78.2 , 31.186.234.41 , 178.79.173.228
         (FR)France         - 176.121.201.250(not working) , 91.121.96.167 , 94.23.45.19 ,  78.192.239.26
         (IT)Italy          - 212.31.237.174 , 141.108.5.48 , 151.13.151.101 , 151.13.151.105
         (DE)Germany        - 78.47.102.91 , 188.72.201.85 , 62.156.150.205
    -->

    
    <#if clientCountry?contains('GB')>
      <#global fixTransl = 0 /><#-- YOC -->
      <#global AdsProvider = 1 />
      <#global currentCountry = 'uk' />
    <#elseif clientCountry?contains('FR')>
      <#global fixTransl = 1 />
      <#global AdsProvider = 2 /><#-- AdMarvel -->
      <#global currentCountry = 'fr' />
    <#elseif clientCountry?contains('IT')>
      <#global fixTransl = 2 />
      <#global AdsProvider = 2 />
      <#global currentCountry = 'it' />
    <#elseif clientCountry?contains('DE')>
      <#global fixTransl = 3 />
      <#global AdsProvider = 2 />
      <#global currentCountry = 'de' />
    <#else>
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
        <#global feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=uk' />
        <#global feedPhotos = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=uk' />
        <#global feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=uk_row_intl_video_masterfeed' />
    <#elseif clientCountry?contains('FR')>
        <#global feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=fr' />
        <#global feedPhotos = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=fr' />
        <#global feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=fr_row_intl_video_masterfeed' />
    <#elseif clientCountry?contains('IT')>
        <#global feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=it' />
        <#global feedPhotos = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=it' />
        <#global feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=it_row_intl_video_masterfeed' />
    <#elseif clientCountry?contains('DE')>
        <#global feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=de' />
        <#global feedPhotos = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=de' />
        <#global feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=de_row_intl_video_masterfeed' />
    <#else> 
        <#global feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=uk' />
        <#global feedPhotos = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=uk' />
        <#global feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=uk_row_intl_video_masterfeed' />
    </#if>
  
<#recover>
    <#--<p style='color:#fff;'>error ip check</p>-->
    <#global feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=uk' />
    <#global feedPhotos = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/galleries.xml?ed=uk' />
    <#global feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=uk_row_intl_video_masterfeed' />
    <#global fixTransl = 0 />
    <#global AdsProvider = 2 />
    <#global currentCountry = 'uk' />
</#attempt>

</#macro>
<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=false showfooter=false>

<#attempt>

<#assign gid = page.params.gid />

<#-- Assign Category. -->
<#attempt>
   <#assign category = page.params.category />
<#recover>
   <#assign category = "Photos" />
</#attempt>

<#-- Assign appropriate feed to use -->
<#include "/includes/assign-feed.ftl">

<#-- Test if gallery exist -->
<#attempt>
  <#assign idTest = feed.rss.channel.item[0].guid />
<#recover>
  ${page.response.sendRedirect("/index.ftl?at=2")}
</#attempt>

<#attempt>
  <#-- if guid not passed, start at 1st photo -->
<#attempt>
	<#assign id = page.params.id />
<#recover>
	<#assign id = feed.rss.channel.item[0].guid />
	<#assign idNext = feed.rss.channel.item[1].guid />
	<#assign idPrev = "" />
</#attempt>

<#-- Initialize total number of photos -->
<#attempt>
	<#assign totalCount = page.params.count?number />
<#recover>
	<#assign totalCount = feed.rss.channel.item?size />
</#attempt>

<#-- ad counter -->
<#attempt>
  <#assign ac = page.params.ac /> <#-- 0 : show on prev , 1: show on next -->
<#recover>
  <#assign ac = "" />
</#attempt>
<#assign adFreq = 0/>
<#if (ac!="")>
  <#assign showAd = true />
<#else>
  <#assign showAd = false />
</#if>

<#assign prepareAd = true />
<#assign adFreq = tool.text.rhythm.gallery.interstitialFrequency?number />

<#-- Set next and prev photo id -->
<#assign i = 0 />
<#attempt>
	<#assign i = 0 />
	<#assign idPrev = "" />
	<#assign idNext = ""/>
	<#list feed.rss.channel.item as item>
		<#if item.guid == id>
		   <#if showAd==true>
			<#if (i &gt; 0)>
				<#if (ac == "0")>
					<#assign idPrev = feed.rss.channel.item[i].guid />
				<#else>
					<#assign idPrev = feed.rss.channel.item[i-1].guid />
				</#if>
			</#if>
        <#if (i + 1) &lt; totalCount>
            <#if ac=="1">
              <#assign idNext = feed.rss.channel.item[i].guid />
            <#else>
              <#assign idNext = feed.rss.channel.item[i+1].guid />
            </#if>
        </#if>
        <#break/>
		   <#else>
        <#if i &gt; 0>
          <#assign idPrev = feed.rss.channel.item[i-1].guid />
        </#if>
        <#if (i + 1) &lt; totalCount>
          <#assign idNext = feed.rss.channel.item[i+1].guid />
        </#if>
        <#break/>
		   </#if>
		</#if>
		<#assign i = i+1 />
	</#list>
<#recover>
	${page.response.sendRedirect("/index.ftl")}
</#attempt>

<#if (i+1)%adFreq==0 >
  <#--| will show ad on next photo |-->
  <#assign ac="1"/>
  <#--<#elseif ((i-1)%adFreq==0 && (i-1)!=0) || i%adFreq==0>-->
<#elseif i%adFreq==0 && ac=="">
  <#--| will show ad on prev photo |-->
  <#assign ac="0"/>
<#else>
  <#--| will not show ad |-->
  <#assign prepareAd=false/>
</#if>

<#include "includes/container_top.ftl" />

<#if !showAd>
  <div class="photoContent" width="100%" style="background-color:#EBEBEB;" id="zoom">

      <div class="imageContainer" align="center">
        <div id="photoNav" class="photoNav"> 
          <ul><li class="prevPhoto" style="background:none;">
            <#if !(idPrev == "")>
              <a class="prev_arrow" href="/${page.id}?id=${idPrev}&amp;gid=${gid!''}&amp;count=${totalCount}<#if prepareAd==true && ac=="0">&amp;ac=${ac}</#if>&amp;nav=0${.globals.ipTestB}">					
              </a>
            </#if>
            </li>
            <li class="nextPhoto" style="background:none;">
              <#if !(idNext == "")>
                <a class="next_arrow" href="/${page.id}?id=${idNext}&amp;gid=${gid!''}&amp;count=${totalCount}<#if prepareAd==true && ac=="1">&amp;ac=${ac}</#if>&amp;nav=1${.globals.ipTestB}">
                </a>
              </#if>
            </li>
          </ul>
        </div>
                    
        <img id="gallery-photo" style="max-width:100%; margin-top:20px;" src='${feed.rss.channel.item[i]["eonline:image_full/eonline:imgurl"]}' alt='${feed.rss.channel.item[i]["eonline:image_full/eonline:imgtitle"]}' style="border:0; text-align:center;"/>
      </div>

        <@p.spacer/>

      <link rel="image_src" href='${feed.rss.channel.item[i]["eonline:image_full/eonline:imgurl"]}' />

      <#-- Set url of the page -->
      <#attempt>
        <#assign myurl="http://${site.domain}/${page.id}?${page.request.getQueryString()}"?replace('&','&amp;')/>
        <#assign mylink=myurl/>
      <#recover>
        <#assign myurl="http://${site.domain}/${page.id}?id=${id}"/>
        <#assign mylink=myurl/>
      </#attempt>

      <#assign shareTxt = feed.rss.channel.item[i].title?replace("&#38;","&")?replace("&amp;","&") />

      <#-- Share links -->
        <#--<@p.shareLinks myurl mylink shareTxt "share"/>-->
      	<#--<div id="homeShareButton"></div>-->
        <div style="width:100%;text-align:center;">
           <img id="homeShareButton" src="/images/iPhone/Details/button_share.png"/>	
        </div>
        <@editor.spacer />


        <#-- Display Back and Next Buttons -->
        <table class="nav_table"  cellpadding="0" cellspacing="0" border="0" >
          <tr align="center" class="subheader">
            <td width="25%" align="right">
              <#if !(idPrev == "")>
                <#--<a href="/${page.id}?id=${idPrev}&amp;gid=${gid!''}&amp;count=${totalCount}<#if prepareAd==true && ac=="0">&amp;ac=${ac}</#if>" class="prev">${translation.translations.back[.globals.fixTransl]}</a>-->
                    <a href="/${page.id}?id=${idPrev}&amp;gid=${gid!''}&amp;count=${totalCount}<#if prepareAd==true && ac=="0">&amp;ac=${ac}</#if>&amp;nav=0${.globals.ipTestB}" class="prev">${translation.translations.back[.globals.fixTransl]}</a>
              </#if>
            </td>
            <td class="total_counter" width="50%" style="text-align:center;">${i+1} ${translation.translations.of[.globals.fixTransl]} ${totalCount}</td>
            <td width="25%" align="left">
              <#if !(idNext == "")>
                <#--<a href="/${page.id}?id=${idNext}&amp;gid=${gid!''}&amp;count=${totalCount}<#if prepareAd==true && ac=="0">&amp;ac=${ac}</#if>" class="next">${translation.translations.next[.globals.fixTransl]}</a>-->
                    <a href="/${page.id}?id=${idNext}&amp;gid=${gid!''}&amp;count=${totalCount}<#if prepareAd==true && ac=="1">&amp;ac=${ac}</#if>&amp;nav=1${.globals.ipTestB}" class="next">${translation.translations.next[.globals.fixTransl]}</a>
              </#if>
            </td>
          </tr>
        </table>
      <@p.grayline/>

            <#-- photo title -->
            <@p.spacer/>
            <div class="photo-title">${feed.rss.channel.item[i].title}</div>
            <@p.spacer/>
            <#-- photo description-->
            <div class="photo-descr">${feed.rss.channel.item[i].description}</div>
            <@p.spacer/>
            <#-- photo credit -->
            <div class="photo-credit">${feed.rss.channel.item[i]["eonline:image_full/eonline:imgcopyright"]}</div>
  </div>
<#else>
  <div class="photoContent" width="90%" style="background-color:#EBEBEB;" id="zoom">

        <@p.spacer/>
        <@p.spacer/>
        <#-- arrows start-->
        <div class="photoNav" style="z-index:210!important;padding:0!important;margin-top:200px;"> 
          <ul><li class="prevPhoto" style="background:none;">
            <#if !(idPrev == "")>
              <a id="prev_href" class="prev_arrow" href="/${page.id}?id=${idPrev}&amp;gid=${gid!''}&amp;count=${totalCount}&amp;nav=0${.globals.ipTestB}">					
              </a>
            </#if>
            </li>
            <li class="nextPhoto" style="background:none;">
              <#if !(idNext == "")>
                <a id="next_href" class="next_arrow" href="/${page.id}?id=${idNext}&amp;gid=${gid!''}&amp;count=${totalCount}&amp;nav=1${.globals.ipTestB}">
                </a>
              </#if>
            </li>
          </ul>
        </div>

        <div class="imageContainer" align="center">
            <div id="adContainer">
              <#include "/includes/rhythm.ftl"/>
            </div>   
        </div>

        <@p.spacer/>

      <link rel="image_src" href='${feed.rss.channel.item[i]["eonline:image_full/eonline:imgurl"]}' />

      <#-- Set url of the page -->
      <#attempt>
          <#assign myurl="http://${site.domain}/${page.id}?${page.request.getQueryString()}"?replace('&','&amp;')/>
          <#assign mylink=myurl/>
      <#recover>
          <#assign myurl="http://${site.domain}/${page.id}?id=${id}"/>
          <#assign mylink=myurl/>
      </#attempt>

      <#assign shareTxt = feed.rss.channel.item[i].title?replace("&#38;","&")?replace("&amp;","&") />


        <#-- Display Back and Next Buttons -->
        <table style="background-color:#ccc;border-bottom:1px solid black; border-top: 1px solid black;" width="100%" cellpadding="0" cellspacing="0" border="0" >
          <tr align="center" class="subheader">
            <td width="20%" align="right" style="background: #C2C2C2;">
              <#if !(idPrev == "")>
                <a href="/${page.id}?id=${idPrev}&amp;gid=${gid!''}&amp;count=${totalCount}&amp;nav=0${.globals.ipTestB}" class="prev">${translation.translations.back[.globals.fixTransl]}</a>
              </#if>
            </td>
            <td width="60%" style="text-align:center; background: #C2C2C2;"></td>
            <td width="20%" align="left" style="background: #C2C2C2;">
              <#if !(idNext == "")>
                <a href="/${page.id}?id=${idNext}&amp;gid=${gid!''}&amp;count=${totalCount}&amp;nav=1${.globals.ipTestB}" class="next">${translation.translations.next[.globals.fixTransl]}</a>
              </#if>
            </td>
          </tr>
        </table>
        <@p.grayline/>
        
        <script>
        <#-- ############### Photo gallery test empty ads ################### -->
        
        function getURLParameters(paramName) 
        {
               var sURL = window.document.URL.toString();  
            if (sURL.indexOf("?") > 0)
            {
               var arrParams = sURL.split("?");         
               var arrURLParams = arrParams[1].split("&");      
               var arrParamNames = new Array(arrURLParams.length);
               var arrParamValues = new Array(arrURLParams.length);     
               var i = 0;
               for (i=0;i<arrURLParams.length;i++)
               {
                var sParam =  arrURLParams[i].split("=");
                arrParamNames[i] = sParam[0];
                if (sParam[1] != "")
                    arrParamValues[i] = unescape(sParam[1]);
                else
                    arrParamValues[i] = "No Value";
               }

               for (i=0;i<arrURLParams.length;i++)
               {
                        if(arrParamNames[i] == paramName){
                        //alert("Param:"+arrParamValues[i]);
                        return arrParamValues[i];
                     }
               }
               return "null";
            }

        }
        
        var lastParam = getURLParameters("nav");
        var parameters = location.search;
        var navParam = parameters.match(/nav/g);
        if(navParam == 'nav') {
            if(lastParam == '1') {
               link = $('#next_href').attr("href");
            } else {
               link = $('#prev_href').attr("href");
            }
          } else {
            link = $('#next_href').attr("href");
          }
        var wrapAdHeight = $('#adContainer').height();
        if(wrapAdHeight == 0 ) {
          if(link != '' || link != null) {
            window.location = link;
          }
        }
        </script>

  </div>
</#if>

    <#-- Parameters for Omniture Tag -->
    <#attempt>
      <#assign photoSiteName = feed.rss.channel.category!'' />
      <#assign galleryId = 'galleryUUID=${gid}'!'' />
      <#assign photoTitle = feed.rss.channel.item[i].title?trim!'' />
    <#recover>
      <#assign photoSiteName = 'E! Online Photo Gallery' />
      <#assign galleryId = '' />
      <#assign photoTitle = '' />
    </#attempt>

    <#-- Close container -->
    <#include "/includes/container_bottom.ftl" />

    <#attempt>
      <#assign mylink = feed.rss.channel.item[i].link!'http://eonline.com' />
    <#recover>
      <#assign mylink = 'http://eonline.com' />
    </#attempt>
    <#include "/includes/share.ftl" />
    <script type="text/javascript">
/*
    $(document).ready(function(){
function newDoc()
  {
        var shareText = escape("${shareTxt}");
        //$('#fbLink').href      = "/share.ftl?type=FB&t=${shareTxt?url}&u=${mylink?url}";
        //$('#twLink').href = 'http://twitter.com/home?status=' + shareText + ' ' + '${u.getBitly(mylink)?url}';
        var linkTw = 'http://twitter.com/home?status=' + shareText + ' ' + '${u.getBitly(mylink)?url}';

  window.location.assign(linkTw);
  }

$("#twLink").click(function(){
   newDoc();
});
        });
*/
    </script>

<#recover>
  ${.error}
</#attempt>


<#recover>
  <#--<@p.error_message/>-->
  ${page.response.sendRedirect("/index.ftl?at=2")}
</#attempt>

</@editor.page>

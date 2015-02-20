<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=true showfooter=false>
<#attempt>

<#attempt>
    <#assign ed = page.params.ed />
<#recover>
    <#assign ed = ""/>
    ${page.response.sendRedirect("/index.ftl")}
</#attempt>

<#attempt>
    <#assign programId = page.params.programId />
<#recover>
    <#assign programId = ""/>
    ${page.response.sendRedirect("/index.ftl")}
</#attempt>

<#attempt>
    <#assign show = page.params.show />
<#recover>
    <#assign show = ""/>
</#attempt>

<#attempt>
    <#assign pg = page.params.pg />
<#recover>
    <#assign pg = "1"/>
</#attempt>

<#attempt>
    <#assign listItemsPerPage = tool.text.listItemsPerPage?number />
<#recover>
    <#assign listItemsPerPage = 11 />
</#attempt>


<#if (show == '')>
  <#assign feedUrl = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/videos.xml?' + 'ed=' + ed + '&programId=' + programId + '&page=' + pg + '&pageSize=' + listItemsPerPage />
<#else>
  <#assign feedUrl = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/videos.xml?' + 'ed=' + ed + '&programId=' + programId + '&show=' + show + '&page=' + pg + '&pageSize=' + listItemsPerPage />
</#if>

<#assign feed = tool.content.getRssFeed(feedUrl) />

<#include "includes/container_top.ftl">

<#attempt>


  <#assign feedSize = feed.rss.channel.item?size />
  <#assign counter = 0 />
  
  <#list feed.rss.channel.item as item> 
      <#assign counter = counter + 1 />
      <#if counter == listItemsPerPage>
        <#break>
      </#if>

      <#assign href = '${item.enclosure.@url}' />
      <#assign img = '${item["eonline:thumbnail_image/eonline:imgurl"]}' />
      <#assign alt = '${item.title}' />
      <#assign tit = '${item.title}' />
      <#assign abs = '${item.description}' />
      <#assign cls = 'list-gray' />
      <#assign guid = href />
      <#assign dt = '${item["eonline:pubDate"]}' />
<#--
      <#if ua?contains('BlackBerry')>
          <#assign href="rtsp://eo.rtsp.rnmd.net:554/adservice/${guid}.3g2?siteId=${videoSiteId}&amp;userId=${userId}"/>
      <#else>
          <#assign href="http://ads.rnmd.net/playVideo?siteId=${videoSiteId}&amp;userId=${userId}&amp;content=${guid}"/>
      </#if>
-->
      
        <#--<@p.listVideo href img ImageWidth ImageHeight alt tit abs cls dt/>-->
        <div style="width:100%;">
          <#--<a href="#" onclick="net.rnmd.sdk.playVideo('${href}');">-->
          <a href="${href}" onclick="customLinks('${href}');">
            <table width="100%" border="0" cellpadding="0" cellspacing="5" align="center" class="list-gray-SD">
              <tr>
                <td class="tdLeft" style="padding-left: 3px;">
                  <img class="video_thumbs" src="${img}" alt="${alt?html}" class="img-round"></img>
                  <#--<img class="video_thumbs" src="${img}" alt="${alt?html}" width="${imgw}" height="${imgh}" class="img-round"></img>-->
                  <#--<div class="listnail" style="background: url(${img}) center center no-repeat"></div>-->
                </td> 		
                <td class="tdMiddle"> 
                    <p class="normal-text">${tit}</p>
                    <#attempt>
                      <#assign localdate = p.convertTimezoneShort(dt, 'PST', 'PST') />
                      <p class="list-date-text">${localdate}</p>
                    <#recover>
                    </#attempt>
                </td>
                <td class="tdRight">

                <div class="goreadstuff"></div>
                </td>	
              </tr>
            </table>
          </a>
          <@p.grayline />
          <@p.grayline />
        </div>   
  </#list>
  
  <@p.grayline />
	
  
    <#if (show == '')>          
      <#assign showParam = '' />
    <#else>
      <#assign showParam = 'show=' + show + '&amp;' />
    </#if>
    <table width="100%" height="36px" cellpadding="0" cellspacing="0" border="0" style="border: 1px solid black; border-width: 1px 0; padding: 3px 0 3px 0;">
      <tr align="center" class="subheader">
        <td width="20%" align="right" vertical-align: middle; style="background: #C2C2C2;">
          <#if (pg?number > 1)>
            <#assign pg_nr_prev = pg?number - 1 />
            <#assign hrefPrev = "?ed=${ed}&amp;programId=${programId}&amp;" + showParam + "pg=${pg_nr_prev}${.globals.ipTestB}" />
            <a href="${hrefPrev}" class="prev">${translation.translations.back[.globals.fixTransl]}</a>
          </#if>
        </td>
        <td width="60%" style="background: #C2C2C2"></td>
        <td width="20%" align="left" vertical-align: middle; style="background: #C2C2C2;">
          <#if (feedSize?number == 11)>
            <#assign pg_nr_next = pg?number + 1 />
            <#assign hrefNext = "?ed=${ed}&amp;programId=${programId}&amp;" + showParam + "pg=${pg_nr_next}${.globals.ipTestB}" />
            <a href="${hrefNext}" class="next">${translation.translations.next[.globals.fixTransl]}</a>
          </#if>
        </td>
      </tr>
    </table>

    <#assign feedUrl = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/videos.xml?' + 'ed=' + ed + '&programId=' + programId + '&show=' + show + '&page=' + pg + '&pageSize=' + listItemsPerPage />
    
    <script type="text/javascript">
    
        $(document).ready(function() {

        //############## Test empty thumbnails ##########################

        var hostname = window.location.hostname;
        var logoLocation = 'http://' + hostname + '/images/international/Elogo_245_140.png';
        $("table tr td.tdLeft img.video_thumbs").error(function () {
            $(this).unbind("error").attr("src", logoLocation);
        });

        //###############################################################

              
        });
    </script>
    
  <#include "/includes/container_bottom.ftl" />

<#recover>
	<@p.error_message />
</#attempt>

<#recover>
    ${page.response.sendRedirect("/index.ftl?at=3")}
</#attempt>

</@editor.page>
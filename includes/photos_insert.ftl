<#-- insert page of E!Shows photos gallery pages code -->

<#-- if photo id not passed, start at 1st photo -->
<#attempt>
  <#assign id=page.params.id/>
<#recover>
  <#assign id = feed.rss.channel.item[0].guid/>
  <#assign idNext = feed.rss.channel.item[1].guid/>
  <#assign idPrev = ""/>
</#attempt>

<#-- Initialize total number of photos -->
<#attempt>
  <#assign totalCount = page.params.count?number/>
<#recover>
  <#assign totalCount = feed.rss.channel.item?size />
</#attempt>

<#-- Set next and prev photo id -->
<#attempt>
  <#assign i = 0 />
  <#assign idPrev = "" />
  <#assign idNext = ""/>
  <#list feed.rss.channel.item as item>
    <#if item.guid == id>
      <#if i &gt; 0>
        <#assign idPrev = feed.rss.channel.item[i-1].guid/>
      </#if>
      <#if (i + 1) &lt; totalCount>
        <#assign idNext = feed.rss.channel.item[i+1].guid/>
      </#if>
      <#break/>
    </#if>
    <#assign i=i+1 />
  </#list>
<#recover>
  ${page.response.sendRedirect("/index.ftl")}
</#attempt>

<#-- Set url of the page -->
<#attempt>
  <#assign myurl=page.params.url/>
<#recover>
  <#assign myurl="http://${site.domain}${pageName}?id=${id}"/>
</#attempt>

<div width="90%" style="background-color:${colorCode}" id="zoom">

  <div class="bold_center">${feed.rss.channel.item[i].title}</div>
  <@editor.paragraph class="height" />

  <div class="photoNav"> 
    <ul>
      <li class="prevPhoto" style="background:none;"></li>
      <#if !(idPrev == "")>
        <a href="${pageName}?id=${idPrev}&amp;count=${totalCount}">
         <img src="/images/arrow_prev.png" alt="Previous" border="0"></img>
        </a>
      </#if>
      <li class="nextPhoto" style="background:none;">
        <#if !(idNext == "")>
          <a href="${pageName}?id=${idNext}&amp;count=${totalCount}">
           <img src="/images/arrow_next.png" alt="Next" border="0"></img>
          </a>
        </#if>
      </li>
    </ul>
  </div>
  <div align="center">
    <img src='${feed.rss.channel.item[i]["eonline:image_full/eonline:imgurl"]}' alt='${feed.rss.channel.item[i]["eonline:image_full/eonline:imgtitle"]}' style="border:0; text-align:center;"/>
  </div>
</div>

  <#-- Share links -->
<#--
  <div style="background-color:${colorCode}">
  <@p.shareLinks2 myurl myurl feed.rss.channel.item[i].title "share"/></div>
-->
  <#-- photo count -->
  <div class="normal_text" style="background-color:${colorCode} text-align:center;">${i+1} of ${totalCount}</div>

  <#-- photo description-->
  <@editor.paragraph class="height" />
  <div class="normal_text" style="background-color:${colorCode}">${feed.rss.channel.item[i].description?replace('&#13;&#10;','<br/>')}</div>
  <@editor.paragraph class="height" />
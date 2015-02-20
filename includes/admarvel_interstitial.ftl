<div class="spacer"><img src="images/spacer.gif" height="1" width="1" border="0"/></div>
<!-- START AD INTEGRATION -->
<@editor.code>
<#attempt>
<#assign widget=(page.request.getSession(true).getAttribute("samsungwidget")?string!'')>
<#recover>
</#attempt>

<#attempt>
<center>
<#--set site_id-->
<#if tool.device.ua?contains('iPhone')>
   <#assign site_id = tool.text.adMarvel.SiteId.EOnline.iPhone.Interstitial />
<#elseif tool.device.ua?contains('Android')>
   <#assign site_id = tool.text.adMarvel.SiteId.EOnline.Android.Interstitial/>
<#else>
   <#assign site_id = tool.text.adMarvel.SiteId.EOnline.iPhone.Interstitial />
   <#assign catId='Other'/>
</#if>

<#--set category_id-->

  <#if page.id?starts_with("index") || page.id?starts_with("uniques")>
	<#assign catId='Home Page'/>
  <#elseif page.id?starts_with("topstory.ftl") || page.id?starts_with("article.ftl")>			
	<#assign catId='News'/>
  <#elseif page.id?starts_with("celeb_pics") || page.id?starts_with("photo-detail.ftl")>			
	<#assign catId='Photo'/>
  <#elseif page.id?starts_with("shows.ftl")>			
	<#assign catId='Shows'/>
  <#elseif page.id?contains("blog_home.ftl") || page.id?contains("blog_article.ftl") >
        <#assign site_id = tool.text.adMarvel.SiteId.EOnline.RTRC />
	<#assign catId='Other'/>
  <#elseif page.id?contains("poseoff")>
        <#assign site_id = tool.text.adMarvel.SiteId.EOnline.Poseoff />
	<#assign catId='Other'/>
  <#else>
	<#assign catId='Other'/>
  </#if>


<@ad.admarvel partner_id='${tool.text.adMarvel.PartnerId}' 
              site_id='${site_id}' 
              version='${tool.text.adMarvel.Version}'
              category_id='${catId}' />

</center>
<#recover>
  <@p.error_message />
</#attempt>

</@editor.code>
<!-- END AD INTEGRATION -->
<div class="spacer"><img src="images/spacer.gif" height="1" width="1" border="0"/></div>
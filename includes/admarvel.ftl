<#attempt>
<#-- <div class="spacer"><img src="/images/spacer.gif" height="1" width="1" border="0"/></div> -->
<!-- START AD INTEGRATION -->
<#--set site_id-->
<#if device == 'iPhone' || device == 'iPad' >
   <#assign site_id = tool.text.adMarvel.SiteId.EOnline.iPhone />
<#elseif device == 'Android' >
   <#assign site_id = tool.text.adMarvel.SiteId.EOnline.Android/>
<#else>
   <#assign site_id = tool.text.adMarvel.SiteId.EOnline.iPhone />
   <#assign catId='Other'/>
</#if>

<#--set category_id to pass to Admarvel-->

  <#if page.id?starts_with("index") || page.id?starts_with("home")>
	<#assign catId="Home Page"/>
  <#elseif page.id?contains("show")>			
	<#assign catId="Shows"/>
  <#elseif page.id?starts_with("article") >			
	<#assign catId="News"/>
  <#elseif page.id?starts_with("photo") >			
	<#assign catId="Photo"/>
  <#else>
	<#assign catId="Other"/>
  </#if>

<#--Display Ad-->

<@ad.admarvel partner_id='${tool.text.adMarvel.PartnerId}' 
              site_id='${site_id}' 
              version='${tool.text.adMarvel.Version}'
              category_id='${catId}' />
 
<#recover>
   <#-- Display house ad -->
   <#-- <#include "/includes/housead.ftl" /> -->
</#attempt>
<!-- END AD INTEGRATION -->

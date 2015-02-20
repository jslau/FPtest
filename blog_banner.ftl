<#if (tool.device.info.displayDimensions)??>
  <#assign width=tool.device.info.displayDimensions.width/>
		
  <#if width < 320>
    <#assign blog_banner="shows/blog/images/RRCBLOG_240x26.jpg" class="nav"  border="0" alt="Rock the Red Carpet" />
  <#else>
    <#assign blog_banner="shows/blog/images/RRCBLOG_320x35.jpg" class="nav"  border="0" alt="Rock the Red Carpet" />
  </#if>

<#else>
  <#assign blog_banner="shows/blog/images/RRCBLOG_320x35.jpg" class="nav"  border="0" alt="Rock the Red Carpet" />
</#if>

<div align="center"><a href="/shows/blog/blog_home.ftl" ><img src="${blog_banner}" /></a></div>


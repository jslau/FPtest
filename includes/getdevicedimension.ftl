<@editor.code>
<#attempt>
        <#assign mywidth=tool.util.getSession().get("devicewidth")/>
<#recover>
        <#assign mywidth = ""/>
        <#attempt>
		<#assign width=tool.device.info.displayDimensions.width/>
		<#if (width<=128)>
			<#assign mywidth= "128">
		<#elseif (width>128 && width<=176)>
			<#assign mywidth = "176">
		<#elseif (width>176 && width<=240)>
			<#assign mywidth = "240">
		<#elseif (width>240 && width<=320)>
			<#assign mywidth = "320">
		<#elseif (width>320)>
			<#assign mywidth = "480">
		</#if>
      <#recover>
<!-- dimension not found. Check for device user agent header 
     and assign appropriate sytlesheet and banner size.
     If not found, default to width 240.
-->
   	      <#if tool.device.ua?contains('Firefox')
   	       || tool.device.ua?contains('MSIE')
    	       || tool.device.ua?contains('Safari')
     	       || tool.device.ua?contains('CB630')
     	       || tool.device.ua?contains('SGH-A707')>
			<#assign mywidth = "240">
   	     <#elseif tool.device.ua?contains('6085')>
			<#assign mywidth = "128">
    	     <#elseif tool.device.ua?contains('BlackBerry9000')>
			<#assign mywidth = "480">
    	     <#else>
			<#assign mywidth = "240">
   	     </#if>
     </#attempt>
     ${tool.util.getSession().put("devicewidth", "${mywidth}")}
</#attempt>

</@editor.code>
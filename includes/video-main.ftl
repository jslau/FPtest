<#attempt>
	<#assign con = page.params.count?number/>
<#recover>
	<#assign con=0 />
</#attempt>

<#attempt>

<#assign totcon =feed.rss.channel.item?size />

<#assign skip=0/>
<#assign counter=0/>
<#list feed.rss.channel.item as item> 

	<#assign skip=skip+1 />
	<#if skip?number <= con?number>
	<#else>
		
<#-- Fetch item  -->

<#assign href='${item.enclosure.@url}' />
<#assign img='${item["eonline:thumbnail"]}' /> 
<#assign alt='${item.title}' />
<#assign tit='${item.title}' />
<#assign abs='${item.description}'/>
<#assign cls='home-article'/>
<#assign tag1=''/>
<#assign lnk1=''/>
<#assign tag2=''/>
<#assign lnk2=''/>
<#assign tag3=''/>
<#assign lnk3=''/>

<#assign userid=userId/>
<#assign guid=href/>
<#if ua?contains('iPhone') || ua?contains('iPad')|| ua?contains('iPod')>
   <#assign siteid="eo_ios_web"/>
   <#assign href="http://eo.rnmd.net/playVideo?siteId=${siteid}&amp;userId=${userid}&amp;content=${guid}"/>
<#elseif ua?contains('Android')|| ua?contains('Droid Build')>
   <#assign siteid="eo_android_web"/>
   <#assign href="http://eo.rnmd.net/playVideo?siteId=${siteid}&amp;userId=${userid}&amp;content=${guid}"/>
<#elseif ua?contains('BlackBerry')>
   <#assign siteid="eo_bberry_web"/>
   <#assign href="rtsp://eo.rtsp.rnmd.net:554/adservice/${guid}.3g2?siteId=${siteid}&amp;userId=${userid}"/>
<#else>
   <#assign siteid="eo_misc_web"/>
   <#assign href="http://eo.rnmd.net/playVideo?siteId=${siteid}&amp;userId=${userid}&amp;content=${guid}"/>
</#if>


<#-- List item -->
<@p.listVideo href img 74 74 alt tit abs cls tag1 lnk1 tag2 lnk2 tag3 lnk3/>
<@p.grayline />

		<#if !item_has_next || (skip%10) == 0>
				
			<#assign next = con + 10/>
			<#assign prev = con-10/>
			<@editor.code>	
				<#if item_has_next>	
					<@editor.paragraph href="?count=${next}" class="moretext" text="More >>"/>						
				</#if>
				<#if (prev>=0)>
					<@editor.paragraph href="?count=${prev}" class="moretext" text="<< Back"/>	
				</#if>										
			</@editor.code>
			<#break>
		</#if>
			
	</#if>
	<#assign counter=counter+1/>
</#list>

<#recover>
	<@p.error_message />
</#attempt>

<#attempt>
	<#assign image_size = page.params.imgsize?number/>
<#recover>
	<#assign image_size=2 />
</#attempt>

<#attempt>
	<#assign con = page.params.count?number/>
<#recover>
	<#assign con=0 />
</#attempt>

<#assign totcon =feed.rss.channel.item?size />

<#assign skip=0/>
<div width="90%" align="center">
<#list feed.rss.channel.item as item> 

	<#assign skip=skip+1 />
	<#if skip?number <= con?number>
	<#else>
	
		<div class="spacer"><img src="images/spacer.gif" height="1" width="1" border="0"/></div>
		<#if image_size == 1>
			<@editor.image src='${item["eonline:image_medium/eonline:imgurl"]}' alt='${item["eonline:image_medium/eonline:imgtitle"]}' border="0" align="center"/>			
		<#elseif image_size == 2>
			<@editor.image src='${item["eonline:image_large/eonline:imgurl"]}' alt='${item["eonline:image_large/eonline:imgtitle"]}' border="0" align="center"/>			
		<#elseif image_size == 3>
			<@editor.image src='${item["eonline:image_full/eonline:imgurl"]}' alt='${item["eonline:image_full/eonline:imgtitle"]}' border="0" align="center"/>			
		<#else>
			<@editor.image src='${item["eonline:image_full/eonline:imgurl"]}' alt='${item["eonline:image_full/eonline:imgtitle"]}' border="0" align="center"/>
		</#if>

		<div class="spacer"><img src="images/spacer.gif" height="1" width="1" border="0"/></div>
 		<@editor.paragraph class="deepblue_bold_center" text="Back to Gallery" href="${page.name?replace('_lg','')}?count=${con}"/> 
		
		<#if !item_has_next || (skip%1) == 0>
		
			<#assign prev = con-1/>
			
			<#assign next = con + 1/>
			<@editor.code>
				<table width="100%">
					<tr>
						<td width="50%">
							<#if (prev>=0)>
								<div><a href="${page.name}?imgsize=${image_size}&amp;count=${prev}" class="pic_link2">&#60;prev</a></div>
							</#if>
						</td>
						<td align="right" width="50%">
							<#if item_has_next>	
								<div><a href="${page.name}?imgsize=${image_size}&amp;count=${next}" class="pic_link">next&#62;</a></div>							
							</#if>
						</td>
					</tr>
				</table>
			</@editor.code>
			<#break>
		</#if>
		
	</#if>
</#list>
</div>
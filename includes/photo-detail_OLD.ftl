<#-- if guid not passed, start at 1st photo -->
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
	<#assign myurl="http://${site.domain}/${page.name}?id=${id}"/>
</#attempt>

<div width="90%" align="center">

	<div class="photo-title">${feed.rss.channel.item[i].title}</div>  
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0" style="background-color:#363636">	
		<tr>
			<td width="10%">
				<#if !(idPrev == "")>
					<div><a href="${page.name}?id=${idPrev}&amp;count=${totalCount}" class="photo-link">
					<img src="images/arrow_prev.png"></img></a>
					</div>
				</#if>
			</td>
			<td width="90%">
				<img src='${feed.rss.channel.item[i]["eonline:image_full/eonline:imgurl"]}' alt='${feed.rss.channel.item[i]["eonline:image_full/eonline:imgtitle"]}' style="border:0; text-align:center; width:320px;" />
<#--
				<@editor.image src='${feed.rss.channel.item[i]["eonline:image_full/eonline:imgurl"]}' alt='${feed.rss.channel.item[i]["eonline:image_full/eonline:imgtitle"]}' border="0" align="center"/>
-->

			</td>
			<td width="10%" align="right">
				<#if !(idNext == "")>
					<div><a href="${page.name}?id=${idNext}&amp;count=${totalCount}" class="photo-link">
					<img src="images/arrow_next.png"></img></a>
					</div>
				</#if>
			</td>
		</tr>
	</table>
	<#-- Share links -->
	<div style="background-color:#363636">
	<@p.shareLinks myurl "share"/></div>

	<#-- photo count -->
	<div class="photo-descr" style="text-align:center;">${i+1} of ${totalCount}</div>

	<#-- photo description-->
	<div class="photo-descr">${feed.rss.channel.item[i].description}</div>

	<#-- photo credit -->
	<div class="photo-credit">${feed.rss.channel.item[i]["eonline:image_full/eonline:imgcopyright"]}</div>
</div>
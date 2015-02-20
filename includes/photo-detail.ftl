<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}">
<#attempt>
<#assign gid=page.params.gid/>

<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/photos/dynamic_gallery.jsp?gallery=${gid}")/>

<#attempt>
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

<#--
${page}
${page.params}
<@editor.paragraph text="${page.request.getQueryString()}"/>

<#list page.request.getParameterNames() as headerName>
<#assign h="${headerName} = ${page.request.getParameter(headerName)?string!''}\n">
<@editor.paragraph text="${h}"/>
</#list>
-->

<#-- Set url of the page -->
<#attempt>
<#--
	<#assign myurl=page.params.url/>
-->
	<#assign myurl="http://${site.domain}/${page.name}?${page.request.getQueryString()}"?replace('&','&amp;')/>
<#--
myurl=${myurl}
-->
<#recover>
	<#assign myurl="http://${site.domain}/${page.name}?id=${id}"/>
</#attempt>

<div width="90%" style="background-color:#484848;" id="zoom">

<#--
	<div class="photo-title" align="center">${feed.rss.channel.item[i].title}</div>
-->
	<div class="photoNav"> 
		<ul><li class="prevPhoto" style="background:none;"></li>
			<#if !(idPrev == "")>
				<a href="/${page.name}?id=${idPrev}&amp;gid=${gid!''}&amp;count=${totalCount}">
					<img src="/images/arrow_prev.png" alt="Previous" border="0"></img>
				</a>
			</#if>
			<li class="nextPhoto" style="background:none;">
				<#if !(idNext == "")>
					<a href="/${page.name}?id=${idNext}&amp;gid=${gid!''}&amp;count=${totalCount}">
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
<div style="background-color:#FFFFFF">
<#--
<@p.shareLinks myurl feed.rss.channel.item[i].title "share"/></div>
-->
<@p.shareLinks2 myurl myurl feed.rss.channel.item[i].title "share"/></div>

<@p.grayline/>

<#-- photo count -->
<div class="photo-descr" style="text-align:center;">${i+1} of ${totalCount}</div>
<@p.grayline/>

<#-- photo title -->
<div class="photo-title">${feed.rss.channel.item[i].title}</div>

<#-- photo description-->
<div class="photo-descr">${feed.rss.channel.item[i].description}</div>

<#-- photo credit -->
<div class="photo-credit">${feed.rss.channel.item[i]["eonline:image_full/eonline:imgcopyright"]}</div>
<#recover>
${.error}
</#attempt>



<#recover>
<@p.error_message/>
</#attempt>

</@editor.page>

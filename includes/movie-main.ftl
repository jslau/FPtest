<#-- <#include "/index_menu.ftl"> -->

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
		
			<#-- Fetch item -->
			<#if (page.id?starts_with("topstory") && !(item["eonline:franchise"] == ""))>
				<#assign href='franchise.ftl?id=${item.guid}&amp;franchise=${item["eonline:franchise"]}' />
			<#else>
				<#assign href='${page.name?replace(".ftl","")}_detail.ftl?id=${item.guid}'/>
			</#if>
			<#assign img='${item["eonline:image_full/eonline:imgurl"]}' /> 
			<#assign alt='${item["eonline:image_full/eonline:imgtitle"]}' />
			<#assign tit='${item.title}' />
			<#assign abs='${item["eonline:shortdesc"]}'/>
			<#assign cls='home-article'/>
			<#assign rating='${item["eonline:movie_grade"]}'/>

			<#assign tag1='Robert Downey Jr.' />
			<#assign lnk1="" />
			<#assign tag2='Iron Man' />
			<#assign lnk2="" />
			<#assign tag3='Top Stories' />
			<#assign lnk3="" />
			<#assign tag4='Box Office' />
			<#assign lnk4="" />
			<#assign tag5='Movies' />
			<#assign lnk5="" />

<#-- List item -->
			<@p.listArticle href img 74 74 alt tit abs cls tag1 lnk1 tag2 lnk2 tag3 lnk3 tag4 lnk4 tag5 lnk5 rating />
			<@p.grayline />

			<#if !item_has_next || (skip%10) == 0>
				<#assign next = con + 10/>
				<#assign prev = con-10/>

				<#if item_has_next>	
					<@editor.paragraph href="?count=${next}" class="moretext" text="More >>"/>
				</#if>
				<#if (prev>=0)>
					<@editor.paragraph href="?count=${prev}" class="moretext" text="<< Back"/>
				</#if>
				<#break>
			</#if>
		</#if>
		<#assign counter=counter+1/>
	</#list>
<#recover>
	<@editor.paragraph class="bold_center" text="Currently the page is not available!"/>
</#attempt>
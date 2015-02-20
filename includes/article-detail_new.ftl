<#assign next = 0/>
<#assign displayNext = false />

<#assign feed = tool.content.getRssFeed("/includes/sample.xml")/>

<#assign matchFound = false />
<#list feed.rss.channel.item as items>
	<#if items.guid == page.params.id>
		<#assign matchFound = true/>
		<#break />
	</#if>
</#list>

<#if !matchFound>
	${page.response.sendRedirect("/index.ftl")}
</#if>

<#attempt>
	<#assign myurl=page.params.url/>
<#recover>
	<#assign myurl="http://${site.domain}/${page.name}?id=${page.params.id}"/>
</#attempt>

<div width="90%">
<#list feed.rss.channel.item as item> 
	
	<#if item.guid == page.params.id>

		<#assign next = 0/>
		<#assign displayNext = true />
		<@editor.spacer />

		<#-- Display image -->
		<@editor.image src='${item["thumbnail"]}' alt='${item["title"]?html}' border="0" align="center"/>			
		<@editor.spacer />

		<#-- Display title -->
		<div class="news-heading">${item.title?html}</div>
		<@editor.spacer />

		<#-- Display date in PST -->
		<#assign localdate = p.convertTimezone(item["eonline:updated"], 'GMT', 'PST') />
		<div class="news-date">${localdate}</div>
		<@editor.spacer />

		<#-- Display author -->
		<div class="news-author">By ${item.author?html}</div>
		<@editor.spacer />

		<#-- Display description -->
		<div class="news-description">${item.description?html}</div>
		<@editor.spacer />

		<@p.grayline/>
		<@editor.spacer />
                <@p.listTags item["eonline:category"] />
		<@editor.spacer />
		<@p.grayline/>

		<#-- Share links -->
		<@p.shareLinks myurl item.title "share"/>
		<@p.grayline/>
	<#else>

		<#if displayNext>
			<#if next == 0>   

            		  <#-- Display franchise link -->
            		  <#if !(item["eonline:franchise"] == "") >
	 		    <#assign isDetail = false />
			    <#assign link = p.getFranchiseLink(item["eonline:franchise"], isDetail) />
		            <@editor.spacer />
			    <div class="read-more">
			      <a href="${link}">[Read More ${item["eonline:franchise"]}]</a>
                            </div>
		            <@editor.spacer />
            		  </#if>


				<div class="news-heading">Next 3 articles ...</div>
				<br/>  
			</#if>
			<#if (page.id?starts_with("topstory") && (item["eonline:franchise"] == ""))>
			  <div class="nextarticle">
                            <a href="topstory_detail.ftl?id=${item.guid}"> <img src="/images/arrw_gif.gif" border="0" />${item.title?html}</a>
			  </div>

			<#elseif !(item["eonline:franchise"] == "")>

				<#-- Display franchise detail link -->
				<#assign isDetail = true />
				<#assign link = p.getFranchiseLink (item["eonline:franchise"], isDetail) />
				<div class="nextarticle">
					<a href="${link}?id=${item.guid}"> <img src="/images/arrw_gif.gif" border="0" />${item.title?html}</a>
				</div>

			<#else>
                          <div class="nextarticle">
			    <a href="franchise.ftl?id=${item.guid}&amp;franchise=${item["eonline:franchise"]}"><img src="/images/arrw_gif.gif" border="0" />${item.title?html}</a>
                          </div>
				
			</#if>
			
			<#assign next = next+1/>
			<#if next == 3>
				<#assign displayNext = false/>
			</#if>
		</#if>
	</#if>
</#list>
<@editor.spacer />
</div>
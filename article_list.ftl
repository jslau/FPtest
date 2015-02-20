<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=false showfooter=false>

<#attempt>
<@u.getDeviceDimension />
    <#-- Assign Category. news, redcarpet, moviewreviews, wwk, awful -->
    <#attempt>
        <#assign category = page.params.category/>
    <#recover>
        <#assign category = "Latest News"/>
    </#attempt>

    <#-- Assign Franchise -->
    <#attempt>
        <#assign franchise = page.params.franchise/>
    <#recover>
        <#assign franchise = ""/>
    </#attempt>
    
    <#-- Assign Tag -->
    <#attempt>
        <#assign tag = page.params.tag/>
    <#recover>
        <#assign tag=""/>
    </#attempt>

    <#-- Assign appropriate feed -->
    <#attempt>
        <#include "includes/assign-feed.ftl">
    <#recover>
        <@p.error_message/>
    </#attempt>

    <#attempt>
	<#assign cnt = page.params.count?number/>
    <#recover>
	<#assign cnt = 0 />
    </#attempt>

    <#-- Open container -->
    <#include "/includes/container_top.ftl" />

    <div>

	<#assign totcon = feed.rss.channel.item?size />
	<#assign skip = 0/>
	<#assign counter = 0/>
	<#list feed.rss.channel.item as item> 

		<#assign skip = skip + 1 />
		<#if skip?number <= cnt?number>
		<#else>
		
			<#-- Fetch item -->

			<#assign href = 'article.ftl?category=${category}&amp;franchise=${franchise}&amp;id=${item.guid}' />

			<#assign img = '${item["eonline:image_full/eonline:imgurl"]}' /> 
			<#assign alt = '${item["eonline:image_full/eonline:imgtitle"]}' />
			<#assign tit = '${item.title}' />
			<#assign abs = '${item["eonline:shortdesc"]}'/>
			<#assign cls = 'list-gray-${display}' />

			<#-- If Movie Review, get rating -->
			<#if category == "Movie Reviews">
			  <#assign rating ='${item["eonline:movie_grade"]}' />
			</#if>

			<#assign dt = '${item["eonline:updated"]}' />
                        
                        <#-- List item -->
			<@p.listArticle href img ImageWidth ImageHeight alt tit abs cls rating dt/>

                        <#-- Display Back and Next Buttons -->
			<#if !item_has_next || (skip%listItemsPerPage) == 0>
				<#assign next = cnt + listItemsPerPage/>
				<#assign prev = cnt - listItemsPerPage/>
			        

                          <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border: 1px solid black; border-width: 1px 0;" >
                            <tr align="center" class="subheader-${display}">
                              <td width="20%" align="right" style="background: #C2C2C2;">
				<#if (prev>=0)>
                                  <a href="?category=${category}&amp;franchise=${franchise}&amp;tag=${tag}&amp;count=${prev}" class="prev ${display}">Back</a>
				</#if>
                              </td>
                              <td width="60%" style="background: #C2C2C2;"></td>
                              <td width="20%" align="left" style="background: #C2C2C2;">
			        <#if item_has_next>

                                  <a href="?category=${category}&amp;franchise=${franchise}&amp;tag=${tag}&amp;count=${next}" class="next ${display}">Next</a>
                                </#if>
                              </td>
                            </tr>
                         </table>

			 <#break/>

			</#if>

		</#if>
		<#assign counter=counter+1/>
	</#list>

    <#-- Placeholder to activate scrolling -->
    <section id="latest-news" class="main"></section>

    </div>

    <#-- Close container -->
    <#include "/includes/container_bottom.ftl" />

<#recover>
  <@p.error_message/>
</#attempt>
</@editor.page>
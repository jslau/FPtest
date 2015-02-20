<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=false showfooter=false>
<#attempt>
<@u.getDeviceDimension />
<#-- Assign Category. -->
<#attempt>
   <#assign category = page.params.category/>
<#recover>
   <#assign category = "Photos"/>
</#attempt>

<#-- Assign appropriate feed to use -->
<#include "/includes/assign-feed.ftl">

<#assign cls = 'list-gray-${display}'/>
<#if display == 'LG'>
   <#assign padding = 9 />
<#else>
   <#assign padding = 3 />
</#if>

<#attempt>
	<#assign con = page.params.count?number/>
<#recover>
	<#assign con=0 />
</#attempt>
<#-- Assign Number of items to display per pages -->
<#attempt>
    <#global listItemsPerPage = tool.text.listItemsPerPage?number />
<#recover>
    <#global listItemsPerPage = 10 />
</#attempt>

	<#assign totcon = feed.sections.section.item?size />
	<#assign skip=0/>
	<#assign counter=0/>

<#include "includes/container_top.ftl" />

<#-- List photo galleries (already sorted to display 1. Big Picture, 2. Fashion Police, and then the rest which change dynamically) -->
<#list feed.sections.section.item as item>
		<#assign skip=skip+1 />
		<#if skip?number <= con?number>
		<#else>
    <#-- Send iPhone. iPod, and iPad users to slideshow format -->
    <#if (ua?contains("iPhone")) || (ua?contains("iPod")) || (ua?contains("iPad"))>
    <a href="/photogallery-index.ftl?gid=${item.guid}">
    <#else>
    <a href="/photo.ftl?gid=${item.guid}">
    </#if>
	<table border="0" cellpading="0" cellspacing="0" class="${cls}">     
		<tr>
			<td width="20%" style="padding-left: ${padding}px;">
                          <#-- Current feed supplies 240x240 thumbnail, which can be dynamically resized.. -->
                          <#assign imgurl = item.imgurl?replace('resize/240/240', 'resize/'+ImageWidth+'/'+ImageHeight) />
			  <img src="${imgurl}" class="img-round"/>
			</td>
			<td class="list-title-text-${display}">
			  ${item.title?html}
			</td>
			<td width="10%">
				<img src="images/more_arrow.png" style="align:right; width:32px; padding-right:2px;"></img>
			</td>		
		</tr>
	</table>
        <@p.grayline />
   </a>
			<#if !item_has_next || (skip%listItemsPerPage) == 0>
				<#assign next = con + listItemsPerPage/>
				<#assign prev = con-listItemsPerPage/>

			  

                        <#-- Display Back and Next Buttons -->
                          <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-top: 1px solid black; border-bottom: 1px solid black;">
                            <tr align="center" class="subheader-${display}">
                              <td width="20%" align="right" style="background: #C2C2C2;">
				<#if (prev>=0)>
                                  <a href="?category=${category}&amp;count=${prev}" class="prev ${display}">Back</a>
				</#if>
                              </td>
                              <td width="60%" style="background: #C2C2C2;"></td>
                              <td width="20%" align="left" style="background: #C2C2C2;">
			        <#if item_has_next>	
                                  <a href="?category=${category}&amp;count=${next}" class="next ${display}">Next</a>
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

    <#-- Close container -->
    <#include "/includes/container_bottom.ftl" />

<#recover>
  <#-- something happened. display error -->
  <@p.error_message />
</#attempt>
</@editor.page>
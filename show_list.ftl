<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=true showfooter=false>
<@u.getDeviceDimension />
    <#-- Assign Category. -->
    <#attempt>
        <#assign category=page.params.category!"Shows"/>
    <#recover>
        <#assign category="Shows"/>
    </#attempt>

    <#-- Assign appropriate feed -->
    <#attempt>
        <#include "includes/assign-feed.ftl">
    <#recover>
        <@p.error_message/>
    </#attempt>

<#attempt>
	<#assign con = page.params.count?number/>   

<#recover>
	<#assign con=0 />
</#attempt>

<#include "/includes/container_top.ftl" />

<#attempt>
	<#assign totcon = feed.document.show?size />
	<#assign skip=0/>
	<#assign counter=0/>
	<#list feed.section.item as item> 

		<#assign skip=skip+1 />
		<#if skip?number <= con?number>
		<#else>
		
			<#-- Fetch item -->

			<#assign href='${item.linkurl}' />

			<#assign img='${item.imgurl}' /> 
			<#assign alt='${item.title}' />
			<#assign tit='${item.title}' />
			<#assign abs='${item.title}'/>
                        <#assign cls = 'list-gray-${display}'/>

                        <#-- List item -->

			<@p.listShow href img ImageWidth ImageHeight alt tit abs cls true/>
			<@p.grayline />

			<#if !item_has_next || (skip%listItemsPerPage) == 0>
				<#assign next = con + listItemsPerPage/>
				<#assign prev = con-listItemsPerPage/>

                        <#-- Display Back and Next Buttons -->
                          <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border: 1px solid black; border-width: 1px 0;" >
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

<#recover>
  <@p.error_message/>
</#attempt>

    <#-- Placeholder to activate scrolling -->
    <section id="latest-news" class="main"></section>

    <#-- Close container -->
    <#include "/includes/container_bottom.ftl" />
</@editor.page>
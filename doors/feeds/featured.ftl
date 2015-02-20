<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<#assign 
<#--feed=tool.content.parseXML("http://testapps.eonline.com/nocache/esmartphonesite/stack_eol_site.xml")/>
-->
feed=tool.content.parseXML("http://syndication.eonline.com/static/syndication/mobile/apps/eonline/stack.xml")/>

<root>
<#list feed.rss.channel.item as item>
    <item>
        <category>${item["eonline:category"]}</category>
        <title>${item.title?html}</title>
        <guid>${item.guid}</guid>
        <image>${item["eonline:image_full/eonline:imgurl"]}</image>
        <#if item["eonline:category"]=="Video">
            <#assign vidLink=item.link/>
            <#assign vidUrl=tool.content.urlToString("http://dev.eoldoors.mtiny.com/doors/feeds/featured0.ftl?xml=${vidLink?url}")/>
            ${vidUrl}
        </#if>
    </item>
</#list>
</root>
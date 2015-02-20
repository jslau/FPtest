<#assign pg=page.params.page!""/>
<#assign top=25/>
<#assign bottom=0/>
<#assign counter=0/>
<#assign feed=tool.content.parseXML("http://dev.eproto.mtiny.com/doors/feeds/videos0.ftl")/>
<root>
<#list feed.root.show as show>
<show>
${show}
</show>
</#list>
</root>
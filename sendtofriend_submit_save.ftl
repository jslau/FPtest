<@editor.page title="${site.name}" showheader=true showfooter=true>
<div class="spacer"><img src="images/spacer.gif" height="1" width="1" border="0"/></div>

<#attempt>
        <#assign mysendername=page.params.sendername/>
<#recover>
        <#assign mysendername=""/>
</#attempt>
<#attempt>
        <#assign mymsisdn=page.params.msisdn/>
<#recover>
        <#assign mymsisdn=""/>
</#attempt>
<#attempt>
        <#assign myurl=page.params.url/>
<#recover>
        <#assign myurl="http://${site.domain}/${page.name}"/>
</#attempt>
<#attempt>
	<#assign franchise=page.params.franchise/>
	<#assign url_suffix="&amp;franchise=${franchise}"/>
<#recover>
	<#assign url_suffix=""/>
</#attempt>

<#assign sendurl = myurl?replace("mblade.iloopmobile.com", "mobi")/>
<#assign sendurl = myurl + url_suffix/>
<!--
<@editor.paragraph text="url_suffix=${url_suffix}" class="normal-text"/>
<@editor.paragraph text="myurl=${myurl}" class="normal-text"/>
<@editor.paragraph text="sendurl=${sendurl}" class="normal-text"/>
-->
<#if (mymsisdn?length==10) && !(mymsisdn=="")>
        <#assign countrycode=1/>
        <#assign mymessage="Your friend ${mysendername} wants to share this page with you."/>

        <#assign xmlstring='<?xml version="1.0" encoding="UTF-8"?>
<memento-request>
<authentication><userToken>${tool.text.userToken}</userToken><interface>submit</interface></authentication>
<messages><message>
<msisdn>${countrycode}${mymsisdn}</msisdn><msisdn-excluded></msisdn-excluded>
<text>${mymessage} ${myurl?replace("mblade.iloopmobile.com", "mobi")}${url_suffix}</text>
<group-id></group-id><submit-date></submit-date><account-id>26</account-id><price>0</price>
<short-code>${tool.text.shortCode}</short-code><keyword>${tool.text.keyword}</keyword></message></messages>
</memento-request>'/>
<!--
<@editor.paragraph text="${xmlstring}" class="normal-text"/>
-->
        <#assign feed=tool.content.postXML("http://xmlapi.iloopmobile.com/saturn/group.ex", "xml=${xmlstring?url}")/>

        <#assign displaymsg="Thank you for sending."/>
        <#assign againmsg="Send to Another Friend"/>
<#else>
        <#assign displaymsg="Error in message Sending!"/>
        <#assign againmsg="Send Again"/>
</#if>

<@editor.paragraph text="" class="height"/>
<@editor.paragraph text="${displaymsg}" class="normal-text"/>
<@editor.paragraph text="" class="height"/>
<@editor.paragraph text="${againmsg}" class="deepblue-bold-center" href="sendtofriend.ftl?url=${sendurl}&sendername=${mysendername}"/>
<@editor.paragraph text="<<Back to Article" class="normal-text-pad" href="${sendurl}&sendername=${mysendername}"/>

</@editor.page>
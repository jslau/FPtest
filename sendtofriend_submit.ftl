<@editor.page title="${site.name}" showheader=true showfooter=false>

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
        <#assign sendUrl=page.params.url/>
<#recover>
        <#assign sendUrl="http://${site.domain}/${page.name}"/>
</#attempt>
<#attempt>
        <#assign returnurl=page.params.returnurl/>
<#recover>
        <#assign returnurl="http://${site.domain}/${page.name}"/>
</#attempt>

<#attempt>
        <#assign category="SEND TO FRIEND"/>
<#recover>
        <#assign category="SEND TO FRIEND"/>
</#attempt>

<#include "includes/container_top.ftl" />
    <#if device == "iPad">
       <div width="100%" style="background-color:#E6E6E6; min-height:1024px; height:auto;">
    <#else>
       <div width="100%" style="background-color:#E6E6E6; min-height:320px; height:auto;">
    </#if>
<#--
<@editor.paragraph text="sendUrl=${sendUrl}" class="normal-text"/>
<@editor.paragraph text="page.params.url=${page.params.url}" class="normal-text"/>
-->
<#if returnurl?contains("list")>
   <#assign messageEnd = " wants to share this page with you. " + u.getBitly(sendUrl?replace("mblade.iloopmobile.com", "mobi")) />
<#elseif returnurl?contains("article")>
   <#assign messageEnd = " wants to share this news with you. " + u.getBitly(sendUrl?replace("mblade.iloopmobile.com", "mobi")) />
<#elseif returnurl?contains("photo")>
   <#assign messageEnd = " wants to share this great photo with you. " + u.getBitly(sendUrl?replace("mblade.iloopmobile.com", "mobi")) />
<#elseif returnurl?contains("show")>
   <#assign messageEnd = " wants to share this page with you. " + u.getBitly(sendUrl?replace("mblade.iloopmobile.com", "mobi")) />
<#else>
   <#assign messageEnd = " wants to share this site with you. eonline.com" />
</#if>

<#if (mymsisdn?length==10) && !(mymsisdn=="")>
        <#assign countrycode=1/>
        <#assign mymessage="Your friend ${mysendername} ${messageEnd}"/>

        <#assign xmlstring='<?xml version="1.0" encoding="UTF-8"?>
<memento-request>
<authentication><userToken>${tool.text.userToken}</userToken><interface>submit</interface></authentication>
<messages><message>
<msisdn>${countrycode}${mymsisdn}</msisdn><msisdn-excluded></msisdn-excluded>
<text>${mymessage}</text>
<group-id></group-id><submit-date></submit-date><account-id>26</account-id><price>0</price>
<short-code>${tool.text.shortCode}</short-code><keyword>${tool.text.keyword}</keyword></message></messages>
</memento-request>'/>

<#--
<@editor.paragraph text="mymessage=${mymessage}" class="normal-text"/>
<@editor.paragraph text="sendUrl=${sendUrl}" class="normal-text"/>
<@editor.paragraph text="returnurl=${returnurl}" class="normal-text"/>
<@editor.paragraph text="xmlstring=${xmlstring}" class="normal-text"/>
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
<@editor.paragraph text="${againmsg}" class="deepblue-bold-center" href="sendtofriend.ftl?url=${sendUrl}&sendername=${mysendername}&returnurl=${returnurl}"/>
<#if returnurl?contains('?') >
<@editor.paragraph text="<<Back to Article" class="normal-text-pad" href="${returnurl}&sendername=${mysendername}&returnurl=${returnurl}"/>
<#else>
<@editor.paragraph text="<<Back to Article" class="normal-text-pad" href="${returnurl}?sendername=${mysendername}&returnurl=${returnurl}"/>
</#if>
</div>
    <#-- Placeholder to activate scrolling -->
    <section id="latest-news" class="main"></section>

    <#-- Close container -->
    <#include "/includes/container_bottom.ftl" />
</@editor.page>
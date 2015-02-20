<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=true showfooter=false>

<#attempt>

    <#-- Assign Category. news, redcarpet, moviewreviews, wwk, awful, videos, shows -->
    <#attempt>
        <#assign category = page.params.category/>
    <#recover>
        <#assign category = "Privacy"/>
    </#attempt>
    
    <#attempt>
       <#assign lang = .globals.fixTransl?number />
    <#recover>
       <#assign lang = 1 />
    </#attempt>

    <#include "/includes/container_top.ftl" />

    <div class="container-info">

    <@editor.spacer />

    <#-- Display title -->
    <p class="news-heading-info">${translation.translations.privacy_policy[.globals.fixTransl]}</p>

    <div class="news-description-info">
    
      <#if lang == 0><#-- GB -->
        <p class="content-terms">To learn more about how we protect your privacy, go to: <a class="info_links" href="http://uk.eonline.com/about/privacy/index.jsp">"http://uk.eonline.com/about/privacy/index.jsp"</a></p>
      <#elseif lang == 1><#-- FR -->
        <p class="content-terms">Pour savoir comment nous protégeons votre vie privée, allez sur: <a class="info_links" href="http://fr.eonline.com/about/privacy/index.jsp">"http://fr.eonline.com/about/privacy/index.jsp"</a></p>
      <#elseif lang == 2><#-- IT -->
        <p class="content-terms">Per saperne di più sulla protezione della privacy, cliccare su: <a class="info_links" href="http://it.eonline.com/about/privacy/index.jsp">"http://it.eonline.com/about/privacy/index.jsp"</a></p>
      <#elseif lang == 3><#-- DE -->
        <p class="content-terms">Mehr darüber, wie Sie Ihre Daten schützen können, erfahren Sie hier: <a class="info_links" href="http://de.eonline.com/about/privacy/index.jsp">"http://de.eonline.com/about/privacy/index.jsp"</a></p>
      <#else><#-- GB -->
        <p class="content-terms">To learn more about how we protect your privacy, go to: <a class="info_links" href="http://uk.eonline.com/about/privacy/index.jsp">http://uk.eonline.com/about/privacy/index.jsp</a></p>
      </#if> 
    
    </div>
    </div>
    <#-- Placeholder to activate scrolling -->
    <section id="latest-news" class="main"></section>

<#include "/includes/container_bottom.ftl" /> 

<#recover>
  <@p.error_message/>
</#attempt>
</@editor.page>
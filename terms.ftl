<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=true showfooter=false>

<#attempt>

    <#-- Assign Category. news, redcarpet, moviewreviews, wwk, awful, videos, shows -->
    <#attempt>
        <#assign category=page.params.category/>
    <#recover>
        <#assign category="Terms"/>
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
    <p class="news-heading-info">${translation.translations.terms_of_use[.globals.fixTransl]}</p>

    <div class="news-description-info">
    
      <#if lang == 0><#-- GB -->
        <p class="content-terms">For Eonline.com terms of service, go to: <a class="info_links" href="http://uk.eonline.com/about/terms/index.jsp">http://uk.eonline.com/about/terms/index.jsp</a>.</p>
        <p class="content-terms">For supplemental terms of service concerning our mobile offerings, go to: <a class="info_links" href="http://uk.eonline.com/everywhere/terms/index.jsp">http://uk.eonline.com/everywhere/terms/index.jsp</a>.</p>
      <#elseif lang == 1><#-- FR -->
        <p class="content-terms">Pour connaître les conditions d’utilisation de Eonline.com, allez sur: <a class="info_links" href="http://fr.eonline.com/about/terms/index.jsp">http://fr.eonline.com/about/terms/index.jsp</a>.</p>
        <p class="content-terms">Pour les conditions d’utilisation complémentaires concernant nos offres mobile, allez sur: <a class="info_links" href="http://fr.eonline.com/everywhere/terms/index.jsp">http://fr.eonline.com/everywhere/terms/index.jsp</a>.</p>
      <#elseif lang == 2><#-- IT -->
        <p class="content-terms">Per scoprire i termini e le condizioni d'uso di Eonline.com, cliccare su: <a class="info_links" href="http://it.eonline.com/about/terms/index.jsp">http://it.eonline.com/about/terms/index.jsp</a>.</p>
        <p class="content-terms">Per ulteriori informazioni sui termini d'utilizzo dell'offerta mobile, cliccare su: <a class="info_links" href="http://it.eonline.com/everywhere/terms/index.jsp">http://it.eonline.com/everywhere/terms/index.jsp</a>.</p>
      <#elseif lang == 3><#-- DE -->
        <p class="content-terms">Die Nutzungsbedingungen von Eonline.com finden Sie hier: <a class="info_links" href="http://de.eonline.com/about/terms/index.jsp">http://de.eonline.com/about/terms/index.jsp</a>.</p>
        <p class="content-terms">Zusatzbedingungen, die unsere mobilen Angebote betreffen, finden Sie hier: <a class="info_links" href="http://de.eonline.com/everywhere/terms/index.jsp">http://de.eonline.com/everywhere/terms/index.jsp</a>.</p>
      <#else><#-- GB -->
        <p class="content-terms">For Eonline.com terms of service, go to: <a class="info_links" href="http://uk.eonline.com/about/terms/index.jsp">http://uk.eonline.com/about/terms/index.jsp</a>.</p>
        <p class="content-terms">For supplemental terms of service concerning our mobile offerings, go to: <a class="info_links" href="http://uk.eonline.com/everywhere/terms/index.jsp">http://uk.eonline.com/everywhere/terms/index.jsp</a>.</p>
      </#if> 
    
    </div>
    </div>

<#include "/includes/container_bottom.ftl" /> 

<#recover>
  <@p.error_message/>
</#attempt>
</@editor.page>
<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=true showfooter=false>

<#attempt>

    <#-- Assign Category. news, redcarpet, moviewreviews, wwk, awful, videos, shows -->
    <#attempt>
        <#assign category=page.params.category/>
    <#recover>
        <#assign category="Copyright"/>
    </#attempt>
    
    <#attempt>
       <#assign lang = .globals.fixTransl?number />
    <#recover>
       <#assign lang = 1 />
    </#attempt>
    
    <#assign currentDate = tool.util.getDate() />
    <#assign currentYear = currentDate?date?string('yyyy') />

    <#include "/includes/container_top.ftl" />

    <div class="container-info">

    <@editor.spacer />

    <#-- Display title -->
    <p class="news-heading-info">${translation.translations.copyright[.globals.fixTransl]}</p>

    <div class="news-description-info">
    
      <#if lang == 0><#-- GB -->
        <p class="content-terms">Copyright ${currentYear} E! Entertainment Television, Inc. All rights reserved.</p>
        <p class="content-terms">All materials contained on this site are protected by United States copyright law and may not be reproduced, distributed, transmitted, displayed, published or broadcast without the prior written permission of E! Entertainment Television, Inc. You may not alter or remove any trademark, copyright or other notice from copies of the content.</p>
        <p class="content-terms">However, you may download material from Eonline.com on the Web (one machine readable copy and one print copy per page) for your personal, non-commercial use only.</p>
      <#elseif lang == 1><#-- FR -->
        <p class="content-terms">Copyright ${currentYear} Entertainment Television, Inc. Tous droits réservés.</p>
        <p class="content-terms">L’ensemble du contenu de ce site est protégé par le droit d’auteur des États-Unis et ne doit pas être reproduit, distribué, transmis, affiché, publié ou diffusé sans la permission écrite préalable de E! Entertainment Television, Inc. Vous ne pouvez modifier ou enlever toute marque déposée, tout copyright ou autre avis des copies du contenu.</p>
        <p class="content-terms">Vous pouvez toutefois télécharger le contenu d’Eonline.com sur le Web (une copie lisible sur ordinateur et une copie papier par page) pour votre usage personnel et non-commercial exclusivement.</p>
      <#elseif lang == 2><#-- IT -->
        <p class="content-terms">Copyright ${currentYear} E! Entertainment Television, tutti i diritti sono riservati.</p>
        <p class="content-terms">Tutto il materiale contenuto in questo sito è protetto dalle leggi americane sul copyright e non può essere riprodotto, ditribuito, trasmesso, mostrato, pubblicato o mandato in onda senza il consenso scritto di E! Entertainment Television, Inc. Trademark, copyright o altre notifiche sulle copie fatte non devono essere rimosse o alterate in ogni modo.</p>
        <p class="content-terms">Si può però scaricare il contenuto da Eonline.com sul Web (ona copia per sola lettura ed una stampa per pagina) per uso personale e non commerciale.</p>
      <#elseif lang == 3><#-- DE -->
        <p class="content-terms">"Copyright ${currentYear} E! Entertainment Television, Inc. Alle Rechte vorbehalten.</p>
        <p class="content-terms">Der Inhalt dieser Website untersteht dem Urheberschutz der Vereinigten Staaten von Amerika und darf ohne vorherige schriftliche Erlaubnis von E! Entertainment Television, Inc. nicht vervielfältigt, verteilt, übertragen, ausgestellt, veröffentlicht oder ausgestrahlt werden. Das Verändern oder das Entfernen von Schutzmarken oder anderen urheberrechtlichen Markierungen ist nicht erlaubt.</p>
        <p class="content-terms">Sie dürfen jedoch Material für Ihren persönlichen, nichtgewerblichen Nutzen von Eonline.com im Netz herunterladen (eine computerlesbare Kopie und eine ausgedruckte Kopie per Seite).</p>
      <#else><#-- GB -->
        <p class="content-terms">Copyright ${currentYear} E! Entertainment Television, Inc. All rights reserved.</p>
        <p class="content-terms">All materials contained on this site are protected by United States copyright law and may not be reproduced, distributed, transmitted, displayed, published or broadcast without the prior written permission of E! Entertainment Television, Inc. You may not alter or remove any trademark, copyright or other notice from copies of the content.</p>
        <p class="content-terms">However, you may download material from Eonline.com on the Web (one machine readable copy and one print copy per page) for your personal, non-commercial use only.</p>
      </#if> 

    </div>
    </div>

<#include "/includes/container_bottom.ftl" /> 

<#recover>
  <@p.error_message/>
</#attempt>
</@editor.page>
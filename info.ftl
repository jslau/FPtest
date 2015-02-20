<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=true showfooter=false>

<#attempt>

    <#attempt>
       <#assign lang = .globals.fixTransl?number />
    <#recover>
       <#assign lang = 1 />
    </#attempt>

    <#-- Assign Category. news, redcarpet, moviewreviews, wwk, awful, videos, shows -->
    <#attempt>
        <#assign category=page.params.category/>
    <#recover>
        <#assign category="Info"/>
    </#attempt>
    
    <#if lang == 0><#-- GB -->
      <#assign feedbackImg = '/images/international/GB/feedback.png' />
      <#assign copyrightImg = '/images/international/GB/copyright.png' />
      <#assign privacyImg = '/images/international/GB/privatepolicy.png' />
      <#assign termsImg = '/images/international/GB/terms.png' />
    <#elseif lang == 1><#-- FR -->
      <#assign feedbackImg = '/images/international/French/feedback.png' />
      <#assign copyrightImg = '/images/international/French/copyright.png' />
      <#assign privacyImg = '/images/international/French/privatepolicy.png' />
      <#assign termsImg = '/images/international/French/terms.png' />
    <#elseif lang == 2><#-- IT -->
      <#assign feedbackImg = '/images/international/Italian/feedback.png' />
      <#assign copyrightImg = '/images/international/Italian/copyright.png' />
      <#assign privacyImg = '/images/international/Italian/privatepolicy.png' />
      <#assign termsImg = '/images/international/Italian/terms.png' />
    <#elseif lang == 3><#-- DE -->
      <#assign feedbackImg = '/images/international/German/feedback.png' />
      <#assign copyrightImg = '/images/international/German/copyright.png' />
      <#assign privacyImg = '/images/international/German/privatepolicy.png' />
      <#assign termsImg = '/images/international/German/terms.png' />
    <#else><#-- GB -->
      <#assign feedbackImg = '/images/international/GB/feedback.png' />
      <#assign copyrightImg = '/images/international/GB/copyright.png' />
      <#assign privacyImg = '/images/international/GB/privatepolicy.png' />
      <#assign termsImg = '/images/international/GB/terms.png' />
    </#if> 

    <#include "/includes/container_top.ftl" />

    <div class="info_page_contener">

    <@editor.spacer />

    <#-- Display title -->
    <@editor.paragraph text="${translation.translations.about_e_online[.globals.fixTransl]}" class="news-heading"/>
    <#--<@editor.spacer />-->


    <div class="info-text">
      <#if lang == 0><#-- GB -->
        E! Online is the number-one entertainment website providing the latest Red Carpet coverage, daily news and celebrity inside information in a fun, irreverent tone. E! Online presents up-to-the-minute entertainment news, fashion, gossip, and reviews.
      <#elseif lang == 1><#-- FR -->
        E! Online est le site de référence en matière de divertissement et fournit les dernières infos Tapis Rouge, des infos quotidiennes et des informations sur les stars sur un ton léger et sympa. E! Online offre les toutes dernières infos sur le divertissement, la mode, les potins de stars et les critiques de films. 
      <#elseif lang == 2><#-- IT -->
        E! Online è miglior sito d'informazione sul mondo dello spettacolo ed ogni giorno vi porta le notizie sugli eventi da tappeto rosso, lo show business e le celebrità con un tono spesso irriverente. E! Online offre le ultimissime in fatto di moda, gossip e tutto qullo che succede a Hollywood.
      <#elseif lang == 3><#-- DE -->
        E! Online ist die Top-Entertainment Website mit Berichten über den Roten Teppich, tägliche News und Promi-Insiderinfo. Topaktuelle Entertainment News, Fashion-Kritiken und Tratsch und Klatsch - manchmal ironisch, oftmals witzig, immer frisch.
      <#else><#-- GB -->
        E! Online is the number-one entertainment website providing the latest Red Carpet coverage, daily news and celebrity inside information in a fun, irreverent tone. E! Online presents up-to-the-minute entertainment news, fashion, gossip, reviews, fames E!-branded merchandise (http://shop.eonline.com) to movie, TV and music enthusiasts.
      </#if>  
    </div>
    <@editor.spacer />
    
    <div class="list_contener_info_page">
      <a href="mailto:intlappsupport@eentertainment.com?subject=Feedback on the E! Online Mobile Site"><img class="img_feedback" src="${feedbackImg}" /></a>
      <@editor.spacer />
      <ul class="info_list">
           <li class="li_info_copright"><a href="copyright.ftl${.globals.ipTestA}"><img class="img_info_page" src="${copyrightImg}" /></a></li>
           <li class="li_info_privacy"><a href="privacy.ftl${.globals.ipTestA}"><img class="img_info_page" src="${privacyImg}" /></a></li>
           <li class="li_info_terms"><a href="terms.ftl${.globals.ipTestA}"><img class="img_info_page" src="${termsImg}" /></a></li>
      </ul>
      <@editor.spacer />
    </div>
    <@editor.spacer />

    </div>

<#include "/includes/container_bottom.ftl" /> 

<#recover>
  <#--<@p.error_message/>-->
  ${page.response.sendRedirect("/index.ftl")}
</#attempt>
</@editor.page>
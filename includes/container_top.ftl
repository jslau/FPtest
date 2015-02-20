<#attempt>
   <#assign lang = .globals.fixTransl />
   <#assign langTitle = u.articleTitleMenuMap[lang?string] />
   <#assign langMenuButton = u.langMenuButton[lang?string] />
<#recover>
   <#assign lang = 0 />
   <#assign langTitle = 0 />
   <#assign langMenuButton = 'menuLinkMulti' />
</#attempt>

<div class="dropdownHide dropdownHeader" id="dropdownHeader">
  <h2 class="sectionHeader h1 d0">   
    <header id="header2" class="currentHeader">
      <a href="/index.ftl${.globals.ipTestA}"><h1 id="logoActive"></h1></a>
      <#if (page.id?contains('article.ftl')) || (page.id?contains('photo.ftl'))>
        <div class="menuLink ${langMenuButton}" id="menuLink" onclick="dropdownToggle()"></div>
      <#else>
        <#assign mylink  = "http://" + page.request.getServerName() />
        <#assign myurl  = "http://" + page.request.getServerName() />
        <#assign shareTxt  = translation.translations.title_eonline[.globals.fixTransl] />
        <div class="menuLink ${langMenuButton}" id="menuLink" onclick="dropdownToggle()"></div>
      </#if>
    </header>
  </h2>
</div>
   
<#-- Place Menu button -->
<div id="headerMenuButton"></div>

<div class="dropdown dropdownHide" id="dropdown">
  <div class="shadow"></div>
  <ul id="dropdown_container">
    <#include "../doors/dropdown.ftl"/>
  </ul>
</div>

<div id="container">

    <#-- ads container -->
    <#if page.id?contains("photo.ftl")>
    <#else>
        <#if page.id?contains("photo.ftl")>
        <#else>
             <#include "/includes/rhythm.ftl"/>
        </#if>
    </#if>
    
    <div id="dropdownHeader" class="dropdownHeader">
      <#-- Place section header -->
      <h2 class="sectionHeader h1 d0">
        <header id="header" class="currentHeader">
          <a href="/index.ftl${.globals.ipTestA}" id="header-logo-link"><h1 id="logo2" class="logo2"></h1></a>

          <#-- Place FB and Twitter buttons only on detail pages -->
          <#if (page.id?contains('article.ftl')) || (page.id?contains('photo.ftl'))>
            <#assign shareTxt  = translation.translations.title_eonline[.globals.fixTransl] />
            <#assign mylink  = "http://" + page.request.getServerName() />
            <a id="fbButton" href="/share.ftl?type=FB&amp;t=${shareTxt?url}&amp;u=${mylink?url}"></a>
            <a id="twitterButton" href="/share.ftl?type=TW&amp;t=${shareTxt?url}&amp;u=${mylink?url}"></a>
            <div class="menuLink ${langMenuButton}" id="menuLink" onclick="dropdownToggle()"></div>
          <#else>
            <#assign mylink  = "http://" + page.request.getServerName() />
            <#assign myurl  = "http://" + page.request.getServerName() />
            <#assign shareTxt  = translation.translations.title_eonline[.globals.fixTransl] />
            <div class="menuLink ${langMenuButton}" id="menuLink" onclick="dropdownToggle()"></div>
          </#if>
        </header>

        <span class="categoryTitle ${langTitle}">
                  <#if (page.id?contains('article.ftl')) >
                     ${translation.translations.latest_news[.globals.fixTransl]}
                  <#elseif (page.id?contains('photo.ftl'))>
                     ${translation.translations.photos[.globals.fixTransl]}
                  <#elseif (page.id?contains('video_list.ftl'))>
                     ${translation.translations.videos[.globals.fixTransl]}
                  </#if>
        </span>

      </h2>
    </div>
<noscript>
    <div class="container-no-js">
       <p class="txt-no-js">${translation.translations.js_disabled[.globals.fixTransl]}</p>
       <p class="txt-no-js">${translation.translations.turn_js_on[.globals.fixTransl]}</p>
    </div>
</noscript>
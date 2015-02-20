<@editor.page>
<#attempt>

<#attempt>
   <#assign lang = .globals.fixTransl />
   <#assign langMenu = u.langMenuMap[lang?string] />
   <#assign langMenuButton = u.langMenuButton[lang?string] />
<#recover>
   <#assign lang = 0 />
   <#assign langMenu = 0 />
   <#assign langMenuButton = 'menuLinkMulti' />
</#attempt>

<#attempt>
  <#assign PartnerId = tool.text.adMarvel.PartnerId />
  <#assign adType = tool.text.adMarvel.SiteId.EOnline.Top />
<#recover>
  <#assign PartnerId = '' />
  <#assign adType = '' />
</#attempt>

<div class="dropdown" id="dropdown">
   <div class="shadow"></div>
    <ul id="dropdown_container">
        <#include "doors/dropdown.ftl"/>
    </ul>
</div>

<div id="viewport">
    <div class="topAd">
          <#include "/doors/ads.ftl"/>
    </div>

    <div class="menu" id="menu">
        <#--<div class="homeLink" id="homeLink"></div>-->
        <div class="menuLink ${langMenuButton}" id="menuLink"></div>
    </div>

    <nav>
        <ul>
            <li id="newsLink">
              <div class="newsLink ${langMenu} navCurrent">NEWS</div>
            </li>
            <li id="photosLink">
              <div class="photosLink ${langMenu}">PHOTOS</div>
            </li>
            <li id="videosLink">
              <div class="videosLink ${langMenu}">VIDEOS</div>
            </li>
        </ul>
    </nav>
    <div class="article_container" id="news">
      <ul>
      </ul>
    </div>
    <div class="article_container hideMe" id="photos">
      <ul>
      </ul>
    </div>
    <#--<div class="article_container hideMe video_container" id="videos">-->
    <div class="article_container hideMe" id="videos">
      <ul>
      </ul>
      <#-- <#include "doors/shows.ftl"/> -->
    </div>
</div>

<#-- WAP-1873 -->
<script type="text/javascript" id="jsSiteCatCode" src="/javascript/s_code.js"></script>
<script language="JavaScript" type="text/javascript">
    function getCookie(cname) {
      var name = cname + "=";
      var ca = document.cookie.split(';');
      for(var i=0; i<ca.length; i++)
        { var c = ca[i]; while (c.charAt(0)==' ') c = c.substring(1); if (c.indexOf(name) != -1) return c.substring(name.length,c.length); }
      return "";
    }

    s.pageName="index.ftl";
    s.prop1="Home page";
    s.prop2="";
    s.prop25 = getCookie("s_fid");
    s.eVar25 = getCookie("s_fid");
    var s_code=s.t();if(s_code)document.write(s_code)
</script>
<noscript>
    <div class="container-no-js">
       <p class="txt-no-js">${translation.translations.js_disabled[.globals.fixTransl]}</p>
       <p class="txt-no-js">${translation.translations.turn_js_on[.globals.fixTransl]}</p>
    </div>
</noscript>

<#recover>
</#attempt>
</@editor.page>
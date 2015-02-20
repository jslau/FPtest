  <#--
  <#if !(page.id == "index.ftl") || !(page.id == "index_iphone.ftl") || !(page.id == "index_ipad.ftl")>	
  <a href="/home.ftl"><h2 class="homeBanner">Home</h2></a>
  </#if>
  -->
  <#assign currentDate = tool.util.getDate() />
  <#assign currentYear = currentDate?date?string('yyyy') />

  <div class="sectionNavi" id="footer">
  <div style="padding-top:10px">
  <@editor.paragraph class="footer" text="${translation.translations.copyright[.globals.fixTransl]} ${currentYear} E! Entertainment Television, Inc."/>
  <@editor.paragraph class="footer" text="${translation.translations.all_r_res[.globals.fixTransl]}"/>

  <img src="http://eo.rnmd.net/pixel.gif?siteId=${siteId}" width="1px" height="1px" />

  <#-- WAP-1873 -->
  <#attempt>
    <#assign pageName = page.id!'' />
  <#recover>
    <#assign pageName = 'eprotoeu' />
  </#attempt>

  <#assign tagSite = "home" />
  <#assign tagSite2 = "" />
  <#if page.id?matches("index") || page.id?matches("home")>
    <#assign tagSite = "home" />
    <#assign sTitle = "Home page" />
  <#elseif (page.id?contains("article.ftl"))>
    <#assign tagSite = "news-detail" />
    <#assign sTitle = shareTxt?replace("&#39;", "'")?replace("&#34;", "'")?replace("&#38;", "&")!'' />
  <#elseif (page.id?contains("photo.ftl"))>
    <#assign tagSite = galleryId!'' />
    <#assign tagSite2 = photoTitle?replace("&amp;", "&")!'' />
    <#assign sTitle = photoSiteName?replace("&#39;", "'")?replace("&#34;", "'")!'' />
  <#elseif (page.id?contains("video_list.ftl"))>
    <#assign tagSite = "videos-list" />
    <#assign sTitle = show!'' />
    <#if (sTitle == 'enewsnow')>
      <#assign sTitle = 'E news now' />
    <#elseif (sTitle == 'chelsea')>
      <#assign sTitle = 'Chelsea Lately' />
    <#elseif (sTitle == 'fpolice')>
      <#assign sTitle = 'Fashion Police' />
    <#elseif (sTitle == 'soup')>
      <#assign sTitle = 'The Soup' />
    <#elseif (sTitle == 'lfrc')>
      <#assign sTitle = 'E Live from the Red Carpet' />
    <#else>
      <#assign sTitle = 'Videos' />
    </#if>
  <#elseif (page.id?contains("info.ftl"))>
    <#assign tagSite = "about_eonline" />
    <#assign sTitle = "About E! Online" />
  <#elseif (page.id?contains("copyright.ftl"))>
    <#assign tagSite = "copyright" />
    <#assign sTitle = "Copyright" />
  <#elseif (page.id?contains("privacy.ftl"))>
    <#assign tagSite = "privacy_policy" />
    <#assign sTitle = "Privacy Policy" />
  <#elseif (page.id?contains("terms.ftl"))>
    <#assign tagSite = "terms_of_use" />
    <#assign sTitle = "Terms of Use" />
  <#else>
    <#assign tagSite = "home" />
    <#assign sTitle = "Home page" />
  </#if>

  <script type="text/javascript" id="jsSiteCatCode" src="/javascript/s_code.js"></script>
  <script language="JavaScript" type="text/javascript">
    function getCookie(cname) {
      var name = cname + "=";
      var ca = document.cookie.split(';');
      for(var i=0; i<ca.length; i++)
        { var c = ca[i]; while (c.charAt(0)==' ') c = c.substring(1); if (c.indexOf(name) != -1) return c.substring(name.length,c.length); }
      return "";
    }

    var strTitle = "${sTitle}";
    strTitle = strTitle.replace("&#233;", "\351");
    s.pageName=strTitle;
    s.prop1="${tagSite}";
    s.prop2="${tagSite2}";
    s.prop25 = getCookie("s_fid");
    s.eVar25 = getCookie("s_fid");
    var s_code=s.t();if(s_code)document.write(s_code)

  </script>

  <#if (page.id?contains("video_list.ftl"))>
    <script language="javascript">
      function customLinks (link) {
        var s=s_gi('comcastegemobileinternetinternational');
        s.linkTrackVars="prop1,eVar7,products,events";
        s.linkTrackEvents="event5,event9";
        s.prop1="Video Link Click";
        s.eVar7=link;
        s.events="event5";
        s.tl(true,'o','Custom Link Click');
      }
    </script>
  </#if>

  <#include "/includes/analytics.ftl">
</div>
</div>
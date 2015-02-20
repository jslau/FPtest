<#-- START AD INTEGRATION -->
<#attempt> 
  
  <#assign PartnerId = tool.text.adMarvel.PartnerId />
  <#if page.name?contains("photogallery-index.ftl") >
     <#assign adType = tool.text.adMarvel.SiteId.EOnline.Interstitial />
       <div id="interstitial_ad">
        <#if (.globals.AdsProvider == 1)>
          <#-- YOC ADS -->
            <#--
            <script type="text/javascript" src="http://tag.yoc-adserver.com/js/yoctag.d8a0963b665f68a339c95486553b6435e2fde01a.js"></script>
            <noscript>
              <a href="http://tag.yoc-adserver.com/nojs/click/d8a0963b665f68a339c95486553b6435e2fde01a/" target="_blank">
                <img src="http://tag.yoc-adserver.com/nojs/view/d8a0963b665f68a339c95486553b6435e2fde01a/" border="0" alt=""/>
              </a>
            </noscript>
            --> 
            <#--<div style="width:320px;height:400px;margin:0 auto 0 auto;background-color:#666666;color:#FFF;text-align:center;"><p style="padding-top:150px;">TEST YOC AD</p></div>-->
        <#else>
          <#-- ADMarvel ADS -->
          <script type='text/javascript'>
                  var partnerId = "${PartnerId}";
                  var siteId = "${adType}";
                  var m3_u = 'http://ads.admarvel.com/fam/javascriptGetAd.php';
                  var m3_r = Math.floor(Math.random()*99999999999);
                  document.write ("<scr"+"ipt type='text/javascript' src='"+m3_u);
                  document.write ("?partner_id=" + partnerId);
                  document.write ('&amp;site_id=' + siteId);
                  document.write ('&amp;version=1.5');
                  document.write ('&amp;language=javascript');
                  document.write ('&amp;format=wap');
                  document.write ('&amp;cb=' + m3_r);
                  document.write ("'><\/scr"+"ipt>");
          </script>
        </#if>
       </div> 
  <#elseif page.name?contains("photo.ftl") >
     <#assign adType = tool.text.adMarvel.SiteId.EOnline.Interstitial />
       <div id="interstitial_ad">
        <#if (.globals.AdsProvider == 1)>
          <#-- YOC ADS -->
            <#--
            <div style="width:320px;height:350px;">
              <script type="text/javascript" src="http://tag.yoc-adserver.com/js/yoctag.9241b23ced126179cb3328cc4217c559ee35fa5e.js"></script>
              <noscript><a href="http://tag.yoc-adserver.com/nojs/click/9241b23ced126179cb3328cc4217c559ee35fa5e/" target="_blank"><img src="http://tag.yoc-adserver.com/nojs/view/9241b23ced126179cb3328cc4217c559ee35fa5e/" border="0" alt=""/></a></noscript>
            </div>
            -->
            <#--<div style="width:320px;height:400px;margin:0 auto 0 auto;background-color:#666666;color:#FFF;text-align:center;"><p style="padding-top:150px;">TEST YOC AD</p></div>-->
        <#else>
          <#-- ADMarvel ADS -->
          <script type='text/javascript'>
                  var partnerId = "${PartnerId}";
                  var siteId = "${adType}";
                  var m3_u = 'http://ads.admarvel.com/fam/javascriptGetAd.php';
                  var m3_r = Math.floor(Math.random()*99999999999);
                  document.write ("<scr"+"ipt type='text/javascript' src='"+m3_u);
                  document.write ("?partner_id=" + partnerId);
                  document.write ('&amp;site_id=' + siteId);
                  document.write ('&amp;version=1.5');
                  document.write ('&amp;language=javascript');
                  document.write ('&amp;format=wap');
                  document.write ('&amp;cb=' + m3_r);
                  document.write ("'><\/scr"+"ipt>");
          </script>
        </#if>
       </div> 
  <#else>
     <#assign adType = tool.text.adMarvel.SiteId.EOnline.Top />
        <style>
          div#top_ad {
            padding:0px;
            margin:0 auto 0 auto;
            background-color:#EBEBEB;
            text-align:center;
          }
          div#top_ad a{
            padding:0px;
            margin:0 auto 0 auto;
          }
          div#top_ad a img{
            padding:0px;
            margin:0 auto -3px auto;
          }
          div#top_ad div img {

          }
        </style>
       <div id="top_ad">
          <#if (.globals.AdsProvider == 1)>
            <#-- YOC ADS -->
              <script type="text/javascript" src="http://tag.yoc-adserver.com/js/yoctag.d8a0963b665f68a339c95486553b6435e2fde01a.js"></script>
              <noscript>
                <a href="http://tag.yoc-adserver.com/nojs/click/d8a0963b665f68a339c95486553b6435e2fde01a/" target="_blank">
                  <img src="http://tag.yoc-adserver.com/nojs/view/d8a0963b665f68a339c95486553b6435e2fde01a/" border="0" alt=""/>
                </a>
              </noscript>
            <#--<div style="width:320px;height:50px;margin:0 auto 0 auto;background-color:#666666;color:#FFF;text-align:center;"><p style="padding-top:15px;">TEST YOC AD</p></div>-->
          <#else>
            <#-- ADMarvel ADS -->
            <script type='text/javascript'>
                    var partnerId = "${PartnerId}";
                    var siteId = "${adType}";
                    var m3_u = 'http://ads.admarvel.com/fam/javascriptGetAd.php';
                    var m3_r = Math.floor(Math.random()*99999999999);
                    document.write ("<scr"+"ipt type='text/javascript' src='"+m3_u);
                    document.write ("?partner_id=" + partnerId);
                    document.write ('&amp;site_id=' + siteId);
                    document.write ('&amp;version=1.5');
                    document.write ('&amp;language=javascript');
                    document.write ('&amp;format=wap');
                    document.write ('&amp;cb=' + m3_r);
                    document.write ("'><\/scr"+"ipt>");
            </script>
          </#if>
       </div> 
  </#if>
  
  <#--<#assign adType = tool.text.adMarvel.SiteId.EOnline.Preroll />-->

<#recover>
</#attempt>
<#-- END AD INTEGRATION -->
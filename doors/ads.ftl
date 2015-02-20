<#attempt>
    <@ipcheck.ClientCountry/>
<#recover>
    <#global AdsProvider = 2 />
</#attempt>
<#--
<#assign currentDate = tool.util.getDate() />
<#assign delayedDate = currentDate?date?string('yyyy/MM/dd kk:mm') />
<p style="color:#FFF;">${delayedDate}</p>
-->
<#attempt>
  <#assign PartnerId = tool.text.adMarvel.PartnerId />
  <#assign adType = tool.text.adMarvel.SiteId.EOnline.Top />
<#recover>
  <#assign PartnerId = '' />
  <#assign adType = '' />
</#attempt>

<div id="my_rnmd_ad">
  <#if (.globals.AdsProvider == 1)>
    <#-- YOC ADS -->
      <script type="text/javascript" src="http://tag.yoc-adserver.com/js/yoctag.d8a0963b665f68a339c95486553b6435e2fde01a.js"></script>
      <noscript>
        <a href="http://tag.yoc-adserver.com/nojs/click/d8a0963b665f68a339c95486553b6435e2fde01a/" target="_blank"><img src="http://tag.yoc-adserver.com/nojs/view/d8a0963b665f68a339c95486553b6435e2fde01a/" border="0" alt=""/></a>
      </noscript>

<#--<div style="width:320px;height:50px;margin:0 auto 0 auto;background-color:#666666;color:#FFF;text-align:center;"><p style="padding:15px;">Test YOC AD</p></div>-->
  <#else>
    <#-- ADMarvel ADS -->
    <script type='text/javascript'>
            var partnerId = "${PartnerId}";
            var siteId = "${adType}";
            var m3_u = 'http://ads.admarvel.com/fam/javascriptGetAd.php';
            var m3_r = Math.floor(Math.random()*99999999999);
            var contenerAdmarvel = document.getElementById("my_rnmd_ad");
/*
            contenerAdmarvel.innerHTML = "<scr"+"ipt type='text/javascript' src='"+m3_u+"?partner_id=" + partnerId+"&amp;site_id=" + siteId + "&amp;version=1.5.1&amp;language=javascript&amp;format=wap&amp;cb=" + m3_r + "'><\/scr"+"ipt>";
*/
      
            document.write ("<scr"+"ipt type='text/javascript' src='"+m3_u);
            document.write ("?partner_id=" + partnerId);
            document.write ('&amp;site_id=' + siteId);
            document.write ('&amp;version=1.5.1');
            document.write ('&amp;language=javascript');
            document.write ('&amp;format=wap');
            document.write ('&amp;cb=' + m3_r);
            document.write ("'><\/scr"+"ipt>");


            
    </script>
  </#if>
</div>
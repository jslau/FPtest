<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=true showfooter=false>
<#attempt>

  <#attempt>
          <#assign sendUrl = page.params.url/>
  <#recover>
          <#assign sendUrl = "http://${site.domain}/${page.name}"/>
          <#--<#assign sendUrl = page.params.url/>-->
  </#attempt>

  <#include "includes/container_top.ftl" />

<style>
#homeShareButton {
    cursor:pointer;
}

#share_close {
    text-align:right;
}
#share_content {
    text-align:center;
}
#share_content img {
  
}
.subShare {
    width:100%; 
    margin:0; 
    padding:10px 0 20px 0;
}
.subDiv {
    width:100%; 
    text-align:center;
    padding:80px 0 10px 0;
}
img#close_button {
    width:40px;
    height:40px;
    padding:15px 15px 5px 15px;
    border:none;
    text-decoration:none;
    cursor:pointer;
}
img.share_btn {
    width:80px;
    height:80px;
    padding:2px;
    border:none;
    text-decoration:none;
    cursor:pointer;
}
.hideMe {
    display:none;
}


/*
@media screen and (orientation:portrait) {
    img#close_button {
      padding-top:60px;
      padding-bottom:30px;
      padding-right:5px;
    }
    img.share_btn {
      padding:2px;
    }
}
@media screen and (orientation:landscape) {
    img#close_button {
      padding-top:15px;
      padding-bottom:15px;
      padding-left:15px;
    }
    img.share_btn {
      padding:8px;
    }
}
*/
</style>

  <#attempt>
      <#if shareTxt = "" >
          <#assign shareTxt = "E!" +  translation.translations.gallery[.globals.fixTransl] />
      </#if>
      <#if mylink = "" >
          <#assign mylink = sendUrl />
      </#if>
  <#recover>
      <#assign shareTxt = "E!" +  translation.translations.gallery[.globals.fixTransl] />
      <#assign mylink = sendUrl />
  </#attempt>

  <#if page.id?contains('list') >
      <#assign shareTxt  = translation.translations.title_eonline[.globals.fixTransl] />
      <#assign emailSubject  =  translation.translations.great_stuff_from_eonline[.globals.fixTransl] />
      <#assign emailBody = translation.translations.hey_there1[.globals.fixTransl] + "\n\n" + translation.translations.hey_there2[.globals.fixTransl] />
  <#elseif page.id?contains('article') >
      <#assign emailSubject  = shareTxt />
      <#assign emailBody = translation.translations.hi[.globals.fixTransl] + "\n\n" + translation.translations.check_this_out[.globals.fixTransl] + emailSubject + "- " + translation.translations.via[.globals.fixTransl] + " E! Online: " />
  <#else>
      <#assign emailSubject  = shareTxt />
      <#assign emailBody = translation.translations.hi[.globals.fixTransl] + "\n\n" + translation.translations.check_this_pic[.globals.fixTransl] + emailSubject + translation.translations.from[.globals.fixTransl] + " E! Online: " />
  </#if>

  <#attempt>
    <#assign myurl = page.params.url/>
  <#recover>
    <#assign pg    = "article.ftl"/>
    <#assign myurl = ''/><#--"http://${site.domain}/${pg}?id=${page.params.id}"/>-->
  </#attempt>



<div width="100%" style = "background-color:#E6E6E6; min-height:320px; height:auto;">
<#--
    <div id="share_close" class="subShare"> 
       <img id="close_button" src="images/share_buttons/close_button.png" alt="Close"/> 
    </div>
-->
    
    <div class="subDiv">
       <span class="shareText">${translation.translations.share_with_a_friend[.globals.fixTransl]}</span>
    </div>
    
    <div id="share_content" class="subShare">
      <a id="fbLink" href="javascript: void(0);"><img class="share_btn" src="images/share_buttons/fb_button_share.png" alt="Facebook"/></a>
      <a id="twLink" href="javascript: void(0);"><img class="share_btn" src="images/share_buttons/twitter_button_share.png" alt="Twitter"/></a>			   		
      <a id="emLink" href="javascript: void(0);"><img class="share_btn" src="images/share_buttons/email_button_share.png" alt="Email"/></a>
   </div>

<#assign hi = translation.translations.hi[.globals.fixTransl] />
<#assign check = translation.translations.check_this_out[.globals.fixTransl] />
<#assign via = translation.translations.via[.globals.fixTransl] />

<script>
  var tmp = "${shareTxt}";
  var decoded = $('<textarea />').html(tmp).val(); 
  var replacedTitle = decoded.replace(/&/gi, '%26' );
  document.getElementById("fbLink").href = "http://m.facebook.com/sharer.php?t=" + replacedTitle + "&u=${u.getBitly('${sendUrl}')?url}";
  document.getElementById("twLink").href = "http://twitter.com/home?status=" + replacedTitle + " ${u.getBitly('${sendUrl}')?url}";
  document.getElementById("emLink").href = "mailto:?subject=" + replacedTitle + "&body=" + "${hi} " + "${check}:\n " + replacedTitle + " ${u.getBitly('${sendUrl}')?url} - ${via} E! Online"; 
</script>


  <#-- Close container -->
  <#include "/includes/container_bottom.ftl" />

<#recover>

  <@p.error_message />
</#attempt>
</@editor.page>
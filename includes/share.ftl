<style>
#homeShareButton {
    cursor:pointer;
}
#share_container {
    position:absolute;
    z-index:1000;
    top:0px;
    left:0px;
    width:100%;
    height:100%;
    margin:0;
    padding:0px;
    background-color:#000000;
    overflow:hidden;
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
    padding:0px;
}
.subDiv {
    width:100%; 
    text-align:center;
    padding:10px; 0px 10px 0px;
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
</style>

  <#attempt>
      <#if shareTxt="" >
          <#assign shareTxt="E! Online"/>
      </#if>
      <#if mylink="" >
          <#assign mylink="http://wwww.eonline.com"/>
      </#if>
  <#recover>
      <#assign shareTxt="E! Online"/>
      <#assign mylink="http://wwww.eonline.com"/>
  </#attempt>


  <#if page.id?contains('list') >
      <#assign shareTxt  = translation.translations.title_eonline[.globals.fixTransl] />
      <#assign emailSubject  = translation.translations.great_stuff_from_eonline[.globals.fixTransl] />
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


<#if (page.id?contains("photogallery"))>
  <div id="share_container" class="hideMe" onclick="closeShare()">
<#else>
 <div id="share_container" class="hideMe">
</#if>
    <div id="share_close" class="subShare"> 
      <img id="close_button" src="images/share_buttons/close_button.png" alt="Close"/>
    </div>
    <#--
    <div class="subShare subDiv">
       <span style="color:#FFFFFF;font-size:18px;padding:0 40px 0  0px;">Share with a friend:</span>
    </div>
    -->
    <#--<#assign and = shareTxt?replace('&','${translation.translations.and[.globals.fixTransl]}') />-->
    <#assign and = translation.translations.and[.globals.fixTransl] />
    <#assign shareTxt1 = shareTxt />

    <div id="share_content" class="subShare">
      <a id="fbLink" href="javascript: void(0);"><img class="share_btn" src="images/share_buttons/fb_button_share.png" alt="Facebook"/></a>
      <a id="twLink" href="javascript: void(0);"><img class="share_btn" src="images/share_buttons/twitter_button_share.png" alt="Twitter"/></a>			   		
      <a id="emLink" href="javascript: void(0);"><img class="share_btn" src="images/share_buttons/email_button_share.png" alt="Email"/></a>
    </div>


<#if page.id?contains('article') >
  <#assign hi = translation.translations.hi[.globals.fixTransl] />
  <#assign check = translation.translations.check_this_out[.globals.fixTransl] />
  <#assign via = translation.translations.via[.globals.fixTransl] />
<#else>
  <#assign hi = translation.translations.hi[.globals.fixTransl] />
  <#assign check = translation.translations.check_this_pic[.globals.fixTransl] />
  <#assign via = translation.translations.from[.globals.fixTransl] />
</#if>

<script>
  var tmp = "${shareTxt}";
  var decoded = $('<textarea />').html(tmp).val(); 
  var replacedTitle = decoded.replace(/&/gi, '%26' );
  document.getElementById("fbLink").href = "http://m.facebook.com/sharer.php?t=" + replacedTitle + "&u=${u.getBitly('${mylink}')?url}";
  document.getElementById("twLink").href = "http://twitter.com/home?status=" + replacedTitle + " ${u.getBitly('${mylink}')?url}";
  document.getElementById("emLink").href = "mailto:?subject=" + replacedTitle + "&body=" + "${hi} " + "${check}:\n " + replacedTitle + " ${u.getBitly('${mylink}')?url} - ${via} E! Online";
  document.getElementById("fbButton").href = "http://m.facebook.com/sharer.php?t=" + replacedTitle + "&u=${u.getBitly('${mylink}')?url}";
  document.getElementById("twitterButton").href = "http://twitter.com/home?status=" + replacedTitle + " ${u.getBitly('${mylink}')?url}";
</script>

</div>

<script type="text/javascript">
  var initShare = $('#homeShareButton,#share_container');
  var shareCont = $('#share_container');
  var closeButton = $('#close_button');
  var intervalShare;
  var doorsBody = document.body;
  var browserName = navigator.userAgent;
  //var BB = browserName.match(/BlackBerry/gi);
  //var NOKIA = browserName.match(/NOKIA/gi);
  var BB = browserName.indexOf("BlackBerry"); 
  var NOKIA = browserName.indexOf("NOKIA"); 

<#if (page.id?contains("photogallery"))>
<#else>
  initShare.on("click",function(){
       if (shareCont.hasClass("hideMe")) {
          window.scrollTo(0,1);
          //var h = window.innerHeight + "px";
          $('div,hr,h2').addClass("hideMe");
          $("#share_container, .subShare").removeClass("hideMe");	
          //$("#share_container").css({"height":h});
          doorsBody.className="background_menu";

          if( BB > 0 ) {
               $("#share_container").css({"height":"130%"});
          } else if ( NOKIA > 0 ) {
               $("#share_container").css({"height":"115%"});
          } else {
          }
         
       }
       else {
          $('div,hr,h2').removeClass("hideMe");
          $('#share_container').addClass("hideMe");
          doorsBody.className="";
       }
  });

  closeButton.live("click",function(e){                       
        $('div').removeClass("hideMe");
        $('#share_container').addClass("hideMe");
        doorsBody.className="";
  });
</#if>

  function turnOnShare() {
       if (shareCont.hasClass("hideMe")) {
          window.scrollTo(0,1);
          //var h = window.innerHeight + "px";
          $('div').addClass("hideMe");
          $("div.ui-page, #share_container, .subShare").removeClass("hideMe");	
          //$("#share_container").css({"height":h});
          doorsBody.className="background_menu";

          if( BB > 0 ) {
               $("#share_container").css({"height":"130%"});
          } else if ( NOKIA > 0 ) {
               $("#share_container").css({"height":"115%"});
          } else {
          }
         
       }
       else {
          $('div').removeClass("hideMe");
          $('#share_container').addClass("hideMe");
          doorsBody.className="";
       }
  }
  function closeShare() {
          $('div').removeClass("hideMe");
          $('#share_container').addClass("hideMe");
          doorsBody.className="";
  }
</script>

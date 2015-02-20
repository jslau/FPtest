<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="" showheader=false showfooter=false>

<#attempt>

  <#attempt>
     <#assign lang = .globals.fixTransl?number />
  <#recover>
     <#assign lang = 1 />
  </#attempt>

  <#-- Delimiter separating elements in next article array -->
  <#assign d1 = tool.text.delimiterElement />

  <#-- Initialize next article array -->
  <#assign link  = '' />
  <#assign title = '' />
  <#assign image = '' />
  <#assign dt    = '' />

  <#-- Assign id -->
  <#attempt>
    <#assign id = page.params.id />
  <#recover>
    <#assign id = "" />
  </#attempt>

  <#-- Assign Category. news, redcarpet, moviewreviews, wwk, awful, videos, shows -->
  <#attempt>
    <#assign category = page.params.category />
  <#recover>
    <#assign category = "Latest News" />
  </#attempt>

  <#-- Assign Franchise -->
  <#attempt>
    <#assign franchise = page.params.franchise />
  <#recover>
    <#assign franchise = "" />
  </#attempt>

  <#-- Fetch show short name and full name, if applicable. [soup, kktm, kktny, ch, fp enews..] -->
  <#attempt>
    <#assign showShortName = page.params.show!"" />
  <#recover>
    <#assign showShortName = "" />
  </#attempt>

  <#assign showFullName = p.getShowFullName[showShortName] />

  <#-- Assign appropriate feed -->
  <#attempt>
    <#include "/includes/assign-feed.ftl">
  <#recover>
    <@p.error_message/>
  </#attempt>

  <#-- Initialize -->
  <#assign next = 0/>
  <#assign displayNext = true />

<#--
feedUrl:=${feedUrl!''}<br/>
lang:=${lang!''}<br/>
id:=${id!''}<br/>
category:=${category!''}<br/>
franchise:=${franchise!''}<br/>
showShortName:=${showShortName!''}<br/>
showFullName:=${showFullName!''}<br/>
-->


  <#include "/includes/container_top.ftl" />
  <div class="art_container">
    <#-- Finding matching content from article api and display -->
    <#list article.rss.channel.item as item> 
      <@editor.spacer />
        <table class="art_table_head">
          <tr>
            <td class="art_td_left">
              <#--<#assign src_img = item["eonline:thumbnail_image/eonline:imgurl"]?html />-->
              <#assign src_img = item["eonline:resizerlink"]?replace("$width","500")?replace("$height","500")?html	/>				
              <img id="art_img" class="zoomInit" src='${src_img}' alt='' class='img-round' />	
            </td>	
            <td class="art_td_right">						
              <#-- Display title -->
              <p class="news-heading">${item.title?trim}</p>
              <#-- Display date in PST -->
              <#assign localdate = p.convertTimezone(item["eonline:lastModDate"], 'GMT', 'PST') />
              <p class="news-date">${localdate}</p>
              <#-- Display author -->
              <p class="news-author">By ${item.author?trim}</p>
            </td>
          </tr>
        </table>
        
        <div class="contenerFontResize">
          <p>
            <span id="fontNormal" class="fontBold">A</span>
            <span id="fontBigger">A</span>
            <span id="fontBigest">A</span>
            <span id="resize_font">(${translation.translations.resize_font[.globals.fixTransl]})</span>
          </p>
        </div>
        <script>
            $(document).ready(function(){
              stringFontSize = $('div#news-desc').css('font-size');
              var trimedVal = stringFontSize.replace("px","");
              integerCurrentFontSize = parseInt(trimedVal);
              integerBiggerFontSize = integerCurrentFontSize + 3;
              integerBigestFontSize = integerBiggerFontSize + 3;
              $("#fontNormal").click(function(){
                   $("div.news-description").css({"font-size":integerCurrentFontSize + "px"});
                   $('#fontBigger,#fontBigest').removeClass('fontBold');
                   $('#fontNormal').addClass('fontBold');
              });
              $("#fontBigger").click(function(){
                   $("div.news-description").css({"font-size":integerBiggerFontSize + "px"});
                   $('#fontNormal,#fontBigest').removeClass('fontBold');
                   $('#fontBigger').addClass('fontBold');
              });
              $("#fontBigest").click(function(){
                   $("div.news-description").css({"font-size":integerBigestFontSize + "px"});
                   $('#fontNormal,#fontBigger').removeClass('fontBold');
                   $('#fontBigest').addClass('fontBold');
              });
            });
         </script>

      <#-- Display description -->
      <#--<div class="news-description">${item.description?replace("&","&amp;")?trim}</div>-->
      <#--<div class="news-description">${item.description?replace("&","&amp;")?trim}</div>-->
      <div id="news-desc" class="news-description"><p>${item.description?replace("&#13;&#10;","\n\n")}</p></div>

      <#-- Share links -->
      <@p.spacer />
      <#assign mylink = item["eonline:shareLink"] />
      <#assign shareTxt = item.title />
      <#-- Assign url -->
      <#attempt>
        <#assign myurl = page.params.url/>
      <#recover>
        <#assign pg    = "article.ftl"/>
        <#assign myurl = "http://${site.domain}/${pg}?id=${page.params.id}"/>
      </#attempt>

      <div class="container_plusone"><div class="g-plusone"></div></div>
      <script type="text/javascript" src="http://apis.google.com/js/plusone.js"></script>
      
      <#-- share button -->
      	<#--<div id="homeShareButton"></div>	-->
        <div style="width:100%;text-align:center;">
           <img id="homeShareButton" src="/images/iPhone/Details/button_share.png"/>	
        </div>
      <#-- end share button -->

      <@p.spacer />


      <#-- Display Links to Related Stories -->
      <#if lang == 0><#-- GB -->
        <#assign relStoriesImg = '/images/international/GB/Related_Stories.png' />
      <#elseif lang == 1><#-- FR -->
        <#assign relStoriesImg = '/images/international/French/Related_Stories.png' />
      <#elseif lang == 2><#-- IT -->
        <#assign relStoriesImg = '/images/international/Italian/Related_Stories.png' />
      <#elseif lang == 3><#-- DE -->
        <#assign relStoriesImg = '/images/international/German/Related_Stories.png' />
      <#else><#-- GB -->
        <#assign relStoriesImg = '/images/international/GB/Related_Stories.png' />
      </#if> 
          
      <#attempt>
          <#assign tags = ''/>
          <#assign categorys = item["eonline:category"] />
          <#assign counterCat = 0 />
          <#assign posTopStories = '' />
          <#list categorys as x>
            <#assign currentCat = item["eonline:category"][counterCat] />
            <#if currentCat?contains('top_stories')>
                <#assign posTopStories = counterCat />
            </#if>
            <#assign counterCat = counterCat + 1 />
            <#if (counterCat == 1)>
                <#assign tags = tags + currentCat />
            <#else>
                <#assign tags = tags + ',' + currentCat />
            </#if>
          </#list> 
      <#recover>
           <#assign counterCat = 0 />
           <#assign posTopStories = '' />
           <#assign tags = '' />
      </#attempt>

      <#--
      <#attempt>
            <#assign tags = item["eonline:category"][1] />
            <#if (tags?trim?length == 0)>
              <#assign tags = item["eonline:category"][1] />
            </#if>
      <#recover>
            <#assign tags = item["eonline:category"][0] />
      </#attempt>
      -->
      <#--
      <#attempt>
        <@p.spacer />
        <ul id="relatedArticles">
          <@p.displayRelatedStories tags category "article_list" id showShortName relStoriesImg />
        </ul>
      <#recover>
        <#assign tags = 'top_stories' />
        <@p.spacer />
        <ul id="relatedArticles">
          <@p.displayRelatedStories tags category "article_list" id showShortName relStoriesImg />
        </ul>
      </#attempt>
      -->
      <#-- Display Links to Related Stories -->
      <#attempt>
          <@p.spacer />
          <ul id="relatedArticles">
<#--
              <div class="OUTBRAIN" data-src='${item["eonline:image_full/eonline:imglink"]}' data-widget-id="MB_1" data-ob-template="E!US"></div>
              <script type="text/javascript" async="async" src="http://widgets.outbrain.com/outbrain.js"></script>
-->
              <#if lang == 0><#-- GB -->
                <div class="OUTBRAIN" data-src="${item["eonline:shareLink"]}" data-widget-id="MB_1" data-ob-template="E!UK"></div>
                <script type="text/javascript" async="async" src="http://widgets.outbrain.com/outbrain.js"></script>
              <#elseif lang == 1><#-- FR -->
                <div class="OUTBRAIN" data-src="${item["eonline:shareLink"]}" data-widget-id="MB_1" data-ob-template="E!FR"></div>
                <script type="text/javascript" async="async" src="http://widgets.outbrain.com/outbrain.js"></script>
              <#elseif lang == 2><#-- IT -->
                <div class="OUTBRAIN" data-src="${item["eonline:shareLink"]}" data-widget-id="MB_1" data-ob-template="E!IT"></div>
                <script type="text/javascript" async="async" src="http://widgets.outbrain.com/outbrain.js"></script>
              <#elseif lang == 3><#-- DE -->
                <div class="OUTBRAIN" data-src="${item["eonline:shareLink"]}" data-widget-id="MB_1" data-ob-template="E!DE"></div>
                <script type="text/javascript" async="async" src="http://widgets.outbrain.com/outbrain.js"></script>
              <#else><#-- GB -->
                <div class="OUTBRAIN" data-src="${item["eonline:shareLink"]}" data-widget-id="MB_1" data-ob-template="E!UK"></div>
                <script type="text/javascript" async="async" src="http://widgets.outbrain.com/outbrain.js"></script>
              </#if>
          </ul>
      <#recover>
      </#attempt>
    </#list>
  </div>
  
  <div>
  
<#-- ############################# carousel ######################################### -->

        <@p.displayNextStoriesInt tags category "article_list" id showShortName lang/>

<#-- ###################################################################### -->
  
<#include "/includes/container_bottom.ftl" />
<#-- ################################### outside the main container ####################################################### -->
<#include "/includes/share.ftl" />

<#-- zoom photo -->
<div id="zoom_container" class="hideMeZoom">
    <div id="zoom_cont_photo">
      <img id="close_zoom_button" width="40" height="40" src="images/share_buttons/close_button2.png" alt="Close"/>
      <img id="zoom_photo" style="max-width:95%;" src="${src_img}" alt="" />
    </div>
</div>


<script>
var initZoom = $('.zoomInit,#zoom_container');
var zoomCont = $('#zoom_container');
var closeZoomButton = $('#close_zoom_button');
var intervalZoom;


initZoom.on("click tap",function(){
		 if (zoomCont.hasClass("hideMeZoom")) {
                        $('#zoom_me').hide();
			window.scrollTo(0,1);
			//var h = window.innerHeight + "px";
			$('div,hr').addClass("hideMeZoom");
			//$("#zoom_container").css({"height":h}); 
			$("#zoom_container,#zoom_close,#zoom_cont_photo").removeClass("hideMeZoom");
			var imgZoom = $('#zoom_photo');
		        var closeZoom = $('#close_zoom_button');
		        var offset = imgZoom.offset();
		        var imgWidth = imgZoom.width();
		        var closeWidth = closeZoom.width();
		        var closeHeight = (closeZoom.height() / 2) * (-1);
		        var posLeftCloseBtn = (offset.left + imgWidth) - (closeWidth - 9);
			closeZoom.css({'top':closeHeight+'px','left':posLeftCloseBtn + 'px'});
			intervalZoom = setInterval(function(){setPosCloseBtn()},800);
			
	     }
		 else {
			$('div,hr').removeClass("hideMeZoom");
			$('#zoom_container,#zoom_close,#zoom_cont_photo').addClass("hideMeZoom");
			clearInterval(intervalZoom);
		 }
});

closeZoomButton.live("click",function(e){
                            
			$('div').removeClass("hideMeZoom");
			$('#zoom_container,#zoom_close,#zoom_cont_photo').addClass("hideMeZoom");
			clearInterval(intervalZoom);
});



function setPosCloseBtn() {

		var imgZoom = $('#zoom_photo');
		var closeZoom = $('#close_zoom_button');
		var offset = imgZoom.offset();
		var imgWidth = imgZoom.width();
		var closeWidth = closeZoom.width();
		var closeHeight = (closeZoom.height() / 2) * (-1);
		var posLeftCloseBtn = (offset.left + imgWidth) - (closeWidth - 9);
		closeZoom.css({'top':closeHeight+'px','left':posLeftCloseBtn + 'px'});

}
</script>
<#-- ########################################################################################## -->

<#recover>
  <#--<@p.error_message/>-->
  ${page.response.sendRedirect("/index.ftl")}
</#attempt>
</@editor.page>
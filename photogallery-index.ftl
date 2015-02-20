<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=false showfooter=false>

<#attempt>
  <#assign gid = page.params.gid />
  <#assign feed = tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/photos/dynamic_gallery.jsp?gallery=${gid}") />
  <#assign totalCount = (feed.rss.channel.item?size)-1 />
<#recover>
  <@p.error_message/>
</#attempt>
	
  <!-- 
    Important! 
    Do not remove elements with html attribute id set to some value. Those elements are required by javascript application.
    All other can be customized as required by project needs.
  -->
	
	<!-- SPLASH SCREEN -->
  <table id="splash-screen" class="splash-screen">
    <tr>
      <td class="text">
        ${translation.translations.loading[.globals.fixTransl]}
      </td>
    </tr>
    <tr>
      <td class="image">
        &nbsp;
      </td>
    </tr>
  </table>
	
  <script type="text/javascript">
    // SPLASH SCREEN INIT
    scrollTo(0,1);
    <#if ua?contains("iPad")>	 
      var or_mngr	=	new JphUtil_OrientationManager( 768, 1024); // iPad version
    <#else>
      var or_mngr	=	new JphUtil_OrientationManager( 320, 480); // iPhone version
    </#if>
    or_mngr.Init();
  </script>
	
  <!-- JAIPHO PRELOAD IMAGES -->
  <div id="preloader">
  </div>
		
  <!-- THUMBNAILS -->
  <div class="toolbar" id="thumbs-toolbar-top">
    <table cellpadding="0" cellspacing="0">
      <tr>
        <td class="wing">
          <a class="button" href="/index.ftl?at=2">
            E! ${translation.translations.photos[.globals.fixTransl]}
          </a>
        </td>
        <td class="center">${translation.translations.gallery_title[.globals.fixTransl]}</td>
        <td class="wing"></td>
      </tr>
    </table>
  </div>
	
  <div id="thumbs-container">
    <div id="thumbs-images-container">
    </div>	
    <div id="thumbs-count-text">
    </div>
  </div>

	
  <!-- SLIDER -->
  <div id="slider-overlay">
    <div class="toolbar" id="slider-toolbar-top">
      <table cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td class="wing">
            <#--<a class="button" href="#" onclick="history.go(-1);return false;">-->
            <a class="button" href="#" onclick="changeAdres();return false;">
              E! ${translation.translations.photos[.globals.fixTransl]}
            </a> 
          </td>
          <td class="center" id="navi-info">
          </td>
          <td class="wing" id="share-info"></td>
        </tr>
      </table>
    </div>

    <div class="toolbar" id="slider-toolbar-bottom">
      <table cellpadding="0" cellspacing="0" border="0" width="100%">
        <tr>
          <td>
            <a class="navi-button" id="navi-prev" href="javascript: void(0);">
            </a> 
          </td>
          <td style="width: 80px;">
            <a class="navi-button" id="navi-play" href="javascript: void(0);">
            </a>
            <a class="navi-button" id="navi-pause" href="javascript: void(0);">
            </a>
          </td>
          <td style="width: 1px;" id="track-info"></td>
          <td>
            <a class="navi-button" id="navi-next" href="javascript: void(0);">
            </a>
          </td>
        </tr>
      </table>
    </div>
  </div>
	
  <div id="slider-container">
  </div>

  <!--
  The whole source in one file.
  -->	
  <script src="/jaipho/jaipho-0.54.00-main-src2.ftl" type="text/javascript"></script>
  <!--	

  Developer version. All classes are in separate files. Much easier to debug.


    <script src="/jaipho/Jph/Thumbs/Manager.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Thumbs/Item.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Thumbs/Behavior.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Slider/ToolbarsManager.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Slider/SlideShow.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Slider/SliderControls.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Slider/Slider.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Slider/Slide.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Slider/ImageQueue.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Slider/Description.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Slider/ComponentVisibility.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Slider/Behavior.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/SafariHistory.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/NaviButton.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Image.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/History.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Dao.js" type="text/javascript"></script>
    <script src="/jaipho/Jph/Application.js" type="text/javascript"></script>
  -->			
		
<script type="text/javascript">
  // APPLICATION INIT BLOCK 
  // v 0.53

  // load images
  var dao	=	new Jph_Dao();

  <#list 0..totalCount as i >
    <#-- Fetch item i  -->
    <#assign img = feed.rss.channel.item[i]['eonline:image_full/eonline:imgurl'] />
    <#assign thumb = feed.rss.channel.item[i]['eonline:image_small/eonline:imgurl'] />
    <#assign title = feed.rss.channel.item[i].title?js_string />
    <#assign shareTxt = feed.rss.channel.item[i].title?replace("&#38;","&")?replace("&amp;","&") />
    <#-- Set url of the page -->
    <#attempt>
      <#assign myurl = "http://${site.domain}/${page.id}?gid=${gid}"/>
      <#assign mylink = myurl/>
    <#recover>
      <#assign myurl = "http://${site.domain}/${page.id}?gid=${gid}" />
      <#assign mylink = myurl />
    </#attempt>

    <#-- <#assign jstitle= title?replace('&','&amp;') /> -->  
    <#assign jstitle= format.unescape(title) />

    <#assign desc= feed.rss.channel.item[i].description?js_string />
    <#--  <#assign jsdesc= desc?replace('&','&amp;') /> -->
    <#assign jsdesc = format.unescape(desc) />

    <#assign credit= feed.rss.channel.item[i]['eonline:image_large/eonline:imgcopyright']?js_string />

    <#--   <#assign jscredit= credit?replace('&','&amp;') /> -->
    <#assign jscredit= format.unescape(credit) /> 

    <#--<#assign share= feed.rss.channel.item[i].link?js_string />-->
    <#assign share= feed.rss.channel.item[i].link?url />
    <#-- Construct Analytics URL  -->
    <#if gid="6">
        <#assign tag = "eonline-photos-bigpicture" />
        <#elseif gid="233">
        <#assign tag = "eonline-photos-fashionpolice" />
    <#else>
        <#assign tag = "eonline-photos-other" />
    </#if>
    <#if ua?contains('iPad') >
        <#assign track="ipad%3A${tag}" />
    <#elseif ua?contains('Android') >
        <#assign track="android%3A${tag}" />
    <#elseif (ua?contains('iPhone')) || (ua?contains('iPod'))>
        <#assign track="iphone%3A${tag}" />
    <#else>
        <#assign track="tsundef%3A${tag}" />
    </#if>

    <#-- List item i  -->
    <#if ua?contains("Android")>
        dao.ReadImage( ${i},'${img}','${thumb}','${title}','${desc}','${credit}','${share}','${track}');
    <#else>
        dao.ReadImage( ${i},'${img}','${thumb}','${jstitle}','${jsdesc}','${jscredit}','${share}','${track}');
    </#if>
  </#list>
  // global reference to jaipho application
  var app;
  var splash	=	document.getElementById( 'splash-screen');
  
  function init_jaipho() {
    if (SPLASH_SCREEN_DURATION > 0)
    splash.style.display	=	'table';
    setTimeout('_init_jaipho()', SPLASH_SCREEN_DURATION);
  }

  function _init_jaipho() {
    // remove splash screen
    splash.style.display	=	'none';

    // start jaipho
    app	=	new Jph_Application( dao, or_mngr, splash);
    app.Init();
    app.Run();
  }
  var daoReplacement = ${tool.text.rhythm.gallery.interstitialFrequency};
  var daoNew = [];
  var daoNewIndex = 0;

  for(var e=0;e<dao.maImages.length;e++){
    if(e%daoReplacement==0 && e!=0) {
      var newDaoImg = new Jph_Image();
      daoNew.push(newDaoImg);
    }
    daoNew.push(dao.maImages[e]);
  }

  for(var f=0;f<daoNew.length;f++)  {
    daoNew[f].mIndex=f;
  }

  dao.maImages=daoNew;

  /*
  for(var e=0;e<dao.maImages.length;e++){
    if(e%daoReplacement==0)console.log(e+" : "+dao.maImages[e]);
  }
  */

  //console.log(dao.maImages);
  //console.log(daoNew);
  //console.log(daoReplacement);
</script>

<#-- BEGIN TP mary.mattern@trailerpark.com 11/11/2011 -->
     <#include "/includes/rhythm-ondemand.ftl" />
    <#--    
      <div id="ad-wrapper" style="margin:0!important;">
      <div class="centered" style="height:400px!important;margin-top:15px!important;">
      <div id="${adDiv}">
      </div>
      <a id="ad-close" href="#" onclick="hideAndClearRMNAd();return false;">X</a>
      </div>
      </div>
    -->
<#-- END TP mary.mattern@trailerpark.com 11/11/2011 -->
<#--<#include "/includes/share.ftl" />-->

<#-- WAP-1873 -->
<script type="text/javascript" id="jsSiteCatCode" src="/javascript/s_code.js"></script>
<script language="JavaScript" type="text/javascript">
    s.pageName="E! Online Photo Gallery";
    s.prop1="galleryUUID=${gid}";
    s.prop2="";
    var s_code=s.t();if(s_code)document.write(s_code)
</script>
			
</@editor.page>
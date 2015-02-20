<#ftl ns_prefixes = { 'eonline' : 'http://www.eonline.com/static/xml/xmlns/' }>
<#attempt>
  <#assign gid = page.params.gid />
  <#assign feed = tool.content.getRssFeed('http://syndication.eonline.com/syndication/feeds/iphone/photos/dynamic_gallery.jsp?gallery=${gid}') />
  <#assign totalCount = (feed.rss.channel.item?size) - 1 />
<#recover>
  <@p.error_message />
</#attempt>

<!DOCTYPE html>
<html>
  <head>
    <#include '/includes/ua.ftl' />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <link href="/jaipho2/Themes/Default/jaipho.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="javascript/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="javascript/jquery.mobile-1.1.0.min.js"></script>
    <script src="/jaipho2/jaipho-0.60.01.ftl" type="text/javascript"></script>
<#--
    <script src="/jaipho2/jaipho-0.60.01.js" type="text/javascript"></script>
    <script src="/jaipho2/Jph/Util/Touches2.js" type="text/javascript"></script>
    <script src="/jaipho2/Jph/Util/Preloader2.js" type="text/javascript"></script>
-->
<#--
    <script src="jaipho2/Jph/Util/WebkitAnimation.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Util/Touches.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Util/PreloaderItem.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Util/Preloader.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Util/OrientationManager.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Util/JaiphoContainerFactory.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Util/IphoneSafariContainer.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Util/Event.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Util/DisplayContainer.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Util/DefaultAnimation.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Util/Console.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Util/AnimationFactory.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Thumbs/ThumbsApp.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Thumbs/Item.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Thumbs/Behavior.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Slider/ToolbarsManager.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Slider/SwipeComponentCell.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Slider/SwipeComponent.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Slider/SlideShow.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Slider/SlidesComponent.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Slider/SliderControls.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Slider/SliderApp.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Slider/Slide.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Slider/ImageQueue.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Slider/Description.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Slider/ComponentVisibility.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Slider/Behavior.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/SafariHistory.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/NaviButton.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Image.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/History.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Dao.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/common.js" type="text/javascript"></script>
    <script src="jaipho2/Jph/Application.js" type="text/javascript"></script>
-->
  </head>
  <body style="position: relative; background: #000;" onload="init_jaipho()">
    <!-- SPLASH SCREEN -->
    <table id="splash-screen" class="splash-screen">
      <tr>
        <td class="text">
          Loading...
        </td>
      </tr>
      <tr>
        <td class="image">
          &nbsp;
        </td>
      </tr>
    </table>
    
    <!-- JAIPHO PRELOAD IMAGES -->
    <div id="preloader"></div>
      
    <div id="thumbs-container">
      <div id="thumbs-images-container"></div>  
      <div id="thumbs-count-text"></div>
    </div>
    
    <!-- SLIDER -->
    <div id="slider-container">
      <div class="toolbar" id="slider-toolbar-top">
        <table cellpadding="0" cellspacing="0" border="0">
          <tr>
            <td class="wing"></td>
            <td class="center" id="navi-info"></td>
            <td class="wing" id="share-info"></td>
          </tr>
        </table>
      </div>

      <div class="toolbar" id="slider-toolbar-bottom">
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
          <tr>
            <td>
              <a class="navi-button" id="navi-prev" href="javascript: void(0);"></a> 
            </td>
            <td style="width: 80px;">
              <a class="navi-button" id="navi-play" href="javascript: void(0);"></a>
              <a class="navi-button" id="navi-pause" href="javascript: void(0);"></a>
            </td>
            <td style="width: 1px;" id="track-info"></td>
            <td>
              <a class="navi-button" id="navi-next" href="javascript: void(0);"></a>
            </td>
          </tr>
        </table>
      </div>
    </div>
    
    <script type="text/javascript">
      <#-- Hide address bar -->
      scrollTo(0,1);
    
      // CONFIGURATION BLOCK - v 0.53
      
      // basic parameters
      var TOOLBARS_HIDE_TIMEOUT  = 100000;
      var SLIDESHOW_ROLL_TIMEOUT = 5000;
      var SLIDE_SCROLL_DURATION  = '0.3s';
      var SLIDE_PRELOAD_TIMEOUT  = 5000;
      var SLIDE_PRELOAD_SEQUENCE = '1,-1,2';
      var SPLASH_SCREEN_DURATION = 5000;
      var DEFAULT_STARTUP_MODE   = 'slider';  // thumbs, slider, slideshow
      var SLIDE_SPACE_WIDTH      = 40;

      // advanced parameters
      var ENABLE_SAFARI_HISTORY_PATCH      = true;
      var MAX_CONCURENT_LOADING_THUMBNAILS = 0;
      var MAX_CONCURENT_LOADING_SLIDE      = 5;
      var MIN_DISTANCE_TO_BE_A_DRAG        = 50;
      var MAX_DISTANCE_TO_BE_A_TOUCH       = 5;
      var CHECK_ORIENTATION_INTERVAL       = 1000;
      var BLOCK_VERTICAL_SCROLL            = true;
      var BASE_URL                         = '/jaipho2/';
      var SLIDE_MAX_IMAGE_ELEMENS          = 20;
      
      // debug parameters
      var DEBUG_MODE   = false;
      var DEBUG_LEVELS = '';
      
      if (DEBUG_MODE) {
        JphUtil_Console.CreateConsole(DEBUG_LEVELS);
      }
      
      // APPLICATION INIT BLOCK - v 0.53
      
      // load images
      var dao = new Jph_Dao();

      <#list 0..totalCount as i >
        <#assign img = feed.rss.channel.item[i]['eonline:image_full/eonline:imgurl'] />
        <#assign thumb = feed.rss.channel.item[i]['eonline:image_small/eonline:imgurl'] />
        <#assign title = feed.rss.channel.item[i].title?js_string />
        <#assign jstitle= format.unescape(title) />
        <#assign desc = feed.rss.channel.item[i].description?js_string />
        <#assign jsdesc = format.unescape(desc) />
        <#assign credit = feed.rss.channel.item[i]['eonline:image_large/eonline:imgcopyright']?js_string />
        <#assign jscredit = format.unescape(credit) /> 
        <#assign share = feed.rss.channel.item[i].link?js_string />

        <#-- Construct Analytics URL  -->
        <#if gid = '6'>
          <#assign tag = 'eonline-photos-bigpicture' />
        <#elseif gid = '233'>
          <#assign tag = 'eonline-photos-fashionpolice' />
        <#else>
          <#assign tag = 'eonline-photos-other' />
        </#if>
        
        <#if ua?contains('iPad') >
          <#assign track = 'ipad%3A${tag}' />
        <#elseif ua?contains('Android') >
          <#assign track = 'android%3A${tag}' />
        <#elseif (ua?contains('iPhone')) || (ua?contains('iPod'))>
          <#assign track = 'iphone%3A${tag}' />
        <#else>
          <#assign track = 'tsundef%3A${tag}' />
        </#if>
    
        <#-- List item i  -->
        <#if ua?contains('Android')>
          dao.ReadImage(${i}, '${img}', '${thumb}', '${title}', '${desc}', '${credit}', '${share}', '${track}');
        <#else>
          dao.ReadImage(${i}, '${img}', '${thumb}', '${jstitle}', '${jsdesc}', '${jscredit}', '${share}', '${track}');
        </#if>
      </#list>
      
      // global reference to jaipho application
      var app;
      var splash = document.getElementById('splash-screen');
      function init_jaipho() {
        if (SPLASH_SCREEN_DURATION > 0)
          splash.style.display = 'table';
          setTimeout('_init_jaipho()', SPLASH_SCREEN_DURATION);
      }
      
      function _init_jaipho() {
        // remove splash screen
        splash.style.display = 'none';
        
        // start jaipho
        app = new Jph_Application(dao, splash);
        app.Init();
        app.Run();
      }
      
      var daoReplacement = ${tool.text.rhythm.gallery.interstitialFrequency};
      var daoNew = [];
      var daoNewIndex = 0;

      for (var e = 0; e < dao.maImages.length; e++) {
        if(e % daoReplacement == 0 && e != 0) {
          var newDaoImg = new Jph_Image();
          daoNew.push(newDaoImg);
        }
        daoNew.push(dao.maImages[e]);
      }


      for (var f = 0; f < daoNew.length; f++) {
        daoNew[f].mIndex = f;
      }

      dao.maImages = daoNew;

      // console.log(dao.maImages);
      // console.log(daoNew);
      // console.log(daoReplacement);

<#--
      $(document).ready(function() {
        $('body').append('<div id="overlay" style="display: block; position: absolute; width: 100%; height: 60px; bottom: 0px; left: 0; background: #000; z-index: 200; text-align: center; font-size: 12px; font-weight: bold; color: #fff; line-height: 44px;">Swipe to dismiss</div>');
        $('#overlay').hide();

        $('#overlay').on('swipeleft', function(e) {
          app.mrSlider.mrSlidesComponent.Next();
          e.preventDefault();
        });

        $('#overlay').on('swiperight', function(e) {
          app.mrSlider.mrSlidesComponent.Previous();
          e.preventDefault();
        });
      });

      function changeAdres() {
        window.location.href = '/photo_list.ftl?category=Photos';
      }
-->
    </script> 

    <#-- BEGIN TP mary.mattern@trailerpark.com 11/11/2011 -->
    <#include '/includes/rhythm-ondemand-android.ftl' />
    <#-- END TP mary.mattern@trailerpark.com 11/11/2011 -->
  </body>
</html>
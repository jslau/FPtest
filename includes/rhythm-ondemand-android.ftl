<#-- START AD INTEGRATION USED ONLY FOR PHOTO INTERSTITIALS    -->
<#attempt>
  <#if page.name?contains('photogallery-android.ftl') >
    <#assign adType = tool.text.rhythm.adType.photo />
  <#elseif device == 'iPad' >
    <#assign adType = tool.text.rhythm.adType.leaderboard />
  <#else>
    <#assign adType = tool.text.rhythm.adType.default />
  </#if>
  
  <#assign adHost = tool.text.rhythm.adHost />
  <#assign adDiv = tool.text.rhythm.adDiv />

  <style>
    .adVisible {
      top: 380px !important;
    }
    
    #sliderContainer {
      position: absolute;
      top: 0;
      left: -3px;
      margin-top: 60px;
    }

    .hideMe{
      left: -999em;
    }
  </style>
  
  
<script type="text/javascript" src="http://ads.rnmd.net/js/rnmd_cs.js"></script>
<script type="text/javascript">
  var adRequester = new net.rnmd.sdk.AdRequester();
  var myCallbackFunction = function(ready, adDisplayCallback) {
    if (ready === true) {
      if (adDisplayCallback) {
        adDisplayCallback(true, adRequester);
        $('#overlay').attr('href', $('#sliderContainer_rnmd_iframe').attr('src'));
        $('#sliderContainer').css( {
          'z-index' : '100'
        });
        hideRMNAd();
      }
    }
  }
  
  function getRMNAd(containerId) {
    adRequester.getAds( {
        siteId: 'nbcu_testing_appid',
        adHost: 'ads.rnmd.net',
        adDiv: 'slide_' + containerId + '_div',
        adType: 'phoneFullpage',
        adShowType: 'prefetch'
    }, myCallbackFunction);
  }

  function hideRMNAd() {
    $('#overlay').hide();
    $('#slider-toolbar-top').show();
    $('#slider-toolbar-bottom').show();
  }

  function showRMNAd(containerId, dir) {
    var testH = $('#slide_' + containerId + '_div_rnmd_iframe').height();
    console.log('TestH: ' + testH);
    if (testH !== null) {
      $('#overlay').show();
      $('#overlay').css( {
        'top': '360px'}
      );
      $('#slider-toolbar-top').hide();
      $('#slider-toolbar-bottom').hide();
      console.log('showRMNAd');
    } else {
      if (dir == 'next') {
        app.mrSlider.mrSlidesComponent.Next();
      } else {
        app.mrSlider.mrSlidesComponent.Previous();
      }
    }
  }

  function hideAndClearRMNAd() {
    // hide the div
  }
</script>

<#recover>
</#attempt>
<#-- END AD INTEGRATION -->

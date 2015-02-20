<#-- START AD INTEGRATION USED ONLY FOR PHOTO INTERSTITIALS    -->
<#attempt>

<#-- BEGIN TP mary.mattern@trailerpark.com 11/11/2011, changed file name in next line -->
<#if page.name?contains("photogallery-index.ftl") >
<#-- END TP mary.mattern@trailerpark.com 11/11/2011 -->
   <#assign adType = tool.text.rhythm.adType.photo />
<#elseif device == 'iPad' >
   <#assign adType = tool.text.rhythm.adType.leaderboard />
<#else>
   <#assign adType = tool.text.rhythm.adType.default />
</#if>
<#--set adHost-->
   <#assign adHost = tool.text.rhythm.adHost />
<#--set adDiv-->
   <#assign adDiv = tool.text.rhythm.adDiv />

<style>
.adVisible{
top:380px!important;
}
#sliderContainer{
position:absolute;
top:0;
left:-3px;
margin-top:60px;
}
.hideMe{
left:-999em;
}
</style>
<script type="text/javascript" src="http://ads.rnmd.net/js/rnmd_cs.js"></script>
<#--
<script type="text/javascript" src="http://stageepg.mtv.rnmd.net/js/rnmd_cs.js"></script>
-->
<script type="text/javascript">
var adRequester = new net.rnmd.sdk.AdRequester();
var myCallbackFunction = function(ready, adDisplayCallback) {
    if(ready === true) {
        if(adDisplayCallback) {
            adDisplayCallback(true, adRequester);
            $("#overlay").attr("href", $("#sliderContainer_rnmd_iframe").attr("src"));
            $("#sliderContainer").css({
                "z-index" : "100"
            });
            hideRMNAd();
        }
    }
}
function getRMNAd(containerId) {
/*
    try {
        $("#sliderContainer_rnmd_iframe").remove();
        $("#sliderContainer").remove();
    } catch(e) {
    }
    newEl = document.createElement('div');
    newEl.setAttribute("id", "sliderContainer");
    sliderBody = document.getElementsByClassName("slider");
    sliderBody[0].appendChild(newEl);
    document.getElementById("sliderContainer").style.left = '-999em!important';
    $("#sliderContainer").css({
        "max-height" : "320px",
        "overflow" : "hidden"
    });
*/

//$("#slide_"+containerId+"_div").append("<div id='slide_'"+containerId+"'_div_container'></div>");
//BP filling ad container temporary - ads unavail at the moment
//$("#slide_"+containerId+"_div").css({"padding-top":"44px;"});
//$("#slide_"+containerId+"_div").append("<div style='background:#0f0;width:100%;height:379px;;'></div>");


/*
    adRequester.getAds({
        //siteId : "55",
        siteId:"eo_ios_web",
        adHost : "ads.rnmd.net",
        //adHost:"stageepg.mtv.rnmd.net",
        //adDiv : "my_rnmd_ad",
        adDiv : "slide_"+containerId+"_div",
        //adDiv : "sliderContainer",
        adType : "phoneFullpage",
        adShowType : "prefetch"
    }, myCallbackFunction);
*/  
}

function hideRMNAd() {
    $("#overlay").hide();
//    $("#slider-toolbar-bottom").removeClass("adVisible");
    $("#slider-toolbar-top").show();
    $("#slider-toolbar-bottom").show();
}

function showRMNAd(containerId,dir) {

var testH = $("#slide_"+containerId+"_div_rnmd_iframe").height();
//console.log(testH);
if(testH !==null){
    $("#overlay").show();
//    $("#overlay").css({"top":testH}); //can't do that - iframe height might be greater than actual ad image size pushing 'swipe to dismiss' overlay out of visible area
    $("#overlay").css({"top":"360px"});
//    $("#slider-toolbar-bottom").addClass("adVisible");
    $("#slider-toolbar-top").hide();
    $("#slider-toolbar-bottom").hide();
}
else{
if(dir=="next"){
  app.mrSlider.Next();
}
else{
  app.mrSlider.Previous();
}
}
}

function hideAndClearRMNAd() {
    //hide the div
}
</script>

<#recover>
</#attempt>
<#-- END AD INTEGRATION -->

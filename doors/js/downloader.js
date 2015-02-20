function getURLParameters(paramName) 
{
        var sURL = window.document.URL.toString();  
    if (sURL.indexOf("?") > 0)
    {
       var arrParams = sURL.split("?");         
       var arrURLParams = arrParams[1].split("&");      
       var arrParamNames = new Array(arrURLParams.length);
       var arrParamValues = new Array(arrURLParams.length);     
       var i = 0;
       for (i=0;i<arrURLParams.length;i++)
       {
        var sParam =  arrURLParams[i].split("=");
        arrParamNames[i] = sParam[0];
        if (sParam[1] != "")
            arrParamValues[i] = unescape(sParam[1]);
        else
            arrParamValues[i] = "No Value";
       }

       for (i=0;i<arrURLParams.length;i++)
       {
                if(arrParamNames[i] == paramName){
                //alert("Param:"+arrParamValues[i]);
                return arrParamValues[i];
             }
       }
       return "null";
    }

}


browser = navigator.appName;
paramIp = '';
(function($) {
    JsonController = function() {
    
    var paramTest = getURLParameters("ipCC") ;
    if(paramTest == 'null' || paramTest == undefined || paramTest == '') {
       paramIp = '';
       paramIpLinkArticles = '';
    } else {
       paramIp = 'ipCC=' + paramTest + '&';
       paramIpLinkArticles = '&ipCC=' + paramTest;
    }
    
    var feeds = {
        "featured" : {
            "name" : "featured",
            "sourceLink" : "http://dev.eprotoeu.mtiny.com/doors/feeds/featured.ftl",
            "targetLink" : "http://dev.eprotoeu.mtiny.com/article.ftl?id=",
            "photosLink" : "http://dev.eprotoeu.mtiny.com/photogallery-index.ftl?gid=",
            "callCount" : 0,
            "ready" : true,
            "artCount" : 0
        },
        "news" : {
            "name" : "news",
            //"sourceLink" : "http://dev.eprotoeu.mtiny.com/doors/feeds/news.ftl?page=",
            "sourceLink" : "http://dev.eprotoeu.mtiny.com/doors/feeds/news.ftl?cc=" + CountryUser + "&" + paramIp + "page=",
            "targetLink" : "http://dev.eprotoeu.mtiny.com/article.ftl?id=",
            "callCount" : 1,
            "ready" : true,
            "artCount" : 0
        },
        "photos" : {
            "name" : "photos",
            //"sourceLink" : "http://dev.eprotoeu.mtiny.com/doors/feeds/photos.ftl?page=",
            "sourceLink" : "http://dev.eprotoeu.mtiny.com/doors/feeds/photos.ftl?cc=" + CountryUser + "&" + paramIp + "page=",
            "targetLink" : "http://dev.eprotoeu.mtiny.com/photogallery-index.ftl?gid=",
            "callCount" : 1,
            "ready" : true,
            "artCount" : 0
        },
        "videos" : {
            "name" : "videos",
            "sourceLink" : "http://dev.eprotoeu.mtiny.com/doors/feeds/videos0.ftl?cc=" + CountryUser + "&" + paramIp + "page=",
            //"sourceLink" : "http://dev.eprotoeu.mtiny.com/doors/feeds/videos0.ftl?page=",
            "targetLink" : "http://dev.eprotoeu.mtiny.com/photogallery-index.ftl?gid=",
            "callCount" : 1,
            "ready" : true,
            "artCount" : 0,
            "showsCount" : 0
        }
    };

var retryCount=0;
var retryCountFeatured=0;
var retryCountVideos=0;
    
    this.setFeeds=function(currentUrl){
        //TODO apply to target links later
       feeds["featured"].sourceLink = feeds["featured"].sourceLink.replace("dev.eprotoeu.mtiny.com",currentUrl);
       feeds["news"].sourceLink = feeds["news"].sourceLink.replace("dev.eprotoeu.mtiny.com",currentUrl);
       feeds["photos"].sourceLink = feeds["photos"].sourceLink.replace("dev.eprotoeu.mtiny.com",currentUrl);
       feeds["featured"].targetLink = feeds["featured"].targetLink.replace("dev.eprotoeu.mtiny.com",currentUrl);
       feeds["featured"].photosLink = feeds["featured"].photosLink.replace("dev.eprotoeu.mtiny.com",currentUrl);
       feeds["news"].targetLink = feeds["news"].targetLink.replace("dev.eprotoeu.mtiny.com",currentUrl);
       feeds["photos"].targetLink = feeds["photos"].targetLink.replace("dev.eprotoeu.mtiny.com",currentUrl);
       feeds["videos"].sourceLink = feeds["videos"].sourceLink.replace("dev.eprotoeu.mtiny.com",currentUrl);
    }

//set old gallery type for non-iOS
    this.setPhotoGalleryType=function(){
       feeds["featured"].photosLink=feeds["featured"].photosLink.replace("photogallery-index","photo");
       feeds["photos"].targetLink=feeds["photos"].targetLink.replace("photogallery-index","photo");
    }

this.getState=function(name){
    return feeds[name].ready;
}

    this.getArticles = function(source, target, retry) {
        
        if(feeds[source].ready) {
           if(typeof retry == "undefined"){
            if(source == 'news') {
                target.append("<ul class='wrap_art_cont_news'><li class='art_cont tempSpin preload_height'></li></ul>");
            }
            else if(source == 'photos') {
                target.append("<ul class='wrap_art_cont_photos'><li class='art_cont tempSpin preload_height'></li></ul>");
            } 
            else {
                target.append("<ul class='wrap_art_cont_videos'><li class='video_cont tempSpin preload_height '></li></ul>");
            }
           }
            var that=this;
            feeds[source].ready = false;
            $.ajax({
                timeout: 2000,
                dataType: "xml",
                url : feeds[source].sourceLink+feeds[source].callCount,
                success : function(data) {
                    //$(".wrap_art_cont").remove();
                    if(source == 'news') {
                        $(".wrap_art_cont_news").remove();
                    }
                    else if(source == 'photos') {
                        $(".wrap_art_cont_photos").remove();
                    } 
                    else {
                        $(".wrap_art_cont_videos").remove();
                    }
                    appendArticles(source, target, data);
                },
                error:function(){
                    //console.log('ajax error');
                    that.retryAjax(source,target);
                }
            });
        }
    }

this.retryAjax=function(source,target){
  retryCount++;
//$(".art_cont.tempSpin").remove();
//$(".wrap_art_cont").remove();
  if(retryCount<2000){
      feeds[source].ready = true;
      this.getArticles(source, target, true);
  }
  else{
   setTimeout(function(){
      retryCount=0;
   }, 2000);
  }
}
/*
        this.getFeatured = function(source,target){
            var that=this;
            $.ajax({
                timeout: 20000,
                url:feeds[source].sourceLink,
                success:function(data){appendFeatured(data,target)},
                error:function(){
                    that.retryFeaturedAjax(source,target);
                }
            });
        }
*/       
        this.getVideos = function(source,target){
            $("#videos").append('<div class="video_container tempSpin" id="video_container"><div class="horScroll"><ul><li class="video_item tempSpin"></li></ul></div></div>');
            $(".video_container.tempSpin").css({"width":$(window).width()});
            if(feeds["videos"].ready) {
                //$("#videos div div ul").eq(0).append('<li class="video_item tempSpin">');
            var that=this;
            feeds["videos"].ready=false;
            $.ajax({
                timeout:30000,
                url:feeds[source].sourceLink+feeds[source].callCount,
                success:function(data){
                    $(".video_container.tempSpin").remove();
                    appendVideos(data,target)
                    },
                error:function(){
                    that.retryVideosAjax(source,target);
                }
            });
            }
        }

this.retryVideosAjax=function(source,target){
    retryCountVideos++;
    if(retryCountVideos<6){
      //console.log("retry"+retryCountVideos);
      feeds[source].ready = true;
      this.getVideos(source, target);
  }
  else{
   retryCountVideos=0;
  }
}
/*
this.retryFeaturedAjax=function(source,target){
  retryCountFeatured++;
  if(retryCountFeatured<4){
      feeds[source].ready = true;
      this.getFeatured(source, target);
  }
  else{
   retryCountFeatured=0;
  }
}
*/


        var appendArticles = function(source, target, data) {
            // console.log(source);
           //console.log(data);
            if(jQuery.isXMLDoc(data)){
               xmlData = data;
            }else{
               xmlData = $.parseXML(data);
            }            
            $data = $(xmlData), $items = $data.find("item");
            feeds[source].artCount = $items.size();
            $items.each(function(index) {
                var guid = $(this).find("guid").text();
                var ParamGeo = ''; 
                var param = $(this).find("param").text();
                if(param.length > 0) {
                    ParamGeo = '&cc=' + param;
                }
                if($("." + feeds[source].name + guid).length == 0) { 
                if(source == 'news'){
                    var pn = s.pageName;
                    var DestUrl = feeds[source].targetLink + guid + ParamGeo + paramIpLinkArticles; 
                    var pos = index+1;
                    var elem1 = 'image';
                    var elem2 = 'headline';
                    var cta = $(this).find("image").text();
                    var cta1 = $(this).find("title").text();

                    $('#news ul').append('<li class="art_cont spinner preload_height ' + feeds[source].name + guid + '"></li>');
                    //console.log('news');   
                    getImage($(this).find("image").text(), $(".art_cont.spinner." + feeds[source].name + guid));
                    $(".art_cont.spinner." + feeds[source].name + guid).append('<a href="' + feeds[source].targetLink + guid + ParamGeo + paramIpLinkArticles + '" onclick="s.products=\';a1-photo-teaser;;;event21\'; s.eVar4=\'' + pn + '\'; s.eVar17=\'a1-photo-teaser:' + DestUrl + '\'; s.prop17=\'a1-photo-teaser:' + pos + ':' + elem1 + ':' + cta + '\';"></a><div><a href="' + feeds[source].targetLink + guid + ParamGeo + paramIpLinkArticles + '" onclick="s.products=\';a2-photo-teaser;;;event21\'; s.eVar4=\'' + pn + '\'; s.eVar17=\'a1-photo-teaser:' + DestUrl + '\'; s.prop17=\'a1-photo-teaser:' + pos + ':' + elem2 + ':' + cta1 + '\';"><p class="scaletext">' + $(this).find("title").text() + '</p></a></div>');
                }
                else if (source == 'photos') {
                    $('#photos ul').append('<li class="art_cont spinner preload_height  ' + feeds[source].name + guid + '"></li>');
                    //console.log('photos');
                    getImage($(this).find("image").text(), $(".art_cont.spinner." + feeds[source].name + guid));
                    $(".art_cont.spinner." + feeds[source].name + guid).append('<a href="' + feeds[source].targetLink + guid + ParamGeo + paramIpLinkArticles + '"><div><p class="scaletext">' + $(this).find("title").text() + '</p></div></a>');
                }  
                else {           
                    //target.append('<li class="art_cont spinner preload_height ' + feeds[source].name + guid + '"></li>');
                    //$('#videos ul').append('<li class="video_item show art_cont spinner preload_height ' + feeds[source].name + guid + '"></li>');
                    $('#videos ul').append('<li class="video_item spinner show preload_height ' + feeds[source].name + guid + '"></li>');    
                    //console.log('default target');
                    getImage($(this).find("image").text(), $(".video_item.spinner." + feeds[source].name + guid));
                    $(".video_item.spinner." + feeds[source].name + guid).append('<a class="video_link" href="http://' + location.host + '/video_list.ftl?' + $(this).find("program").text() + ParamGeo + paramIpLinkArticles + '"></a>');
                    //$(".video_item.spinner." + feeds[source].name + guid).append('<a href="http://' + feeds[source].targetLink + guid + '"><div><p class="scaletext">' + $(this).find("title").text() + '</p></div></a>');
                    videoLoader = 1;
                }    
                    //getImage($(this).find("image").text(),target.children().eq(index));
                    //target.children().eq(index).append('<a href="'+feeds[source].targetLink+guid+'"><div>'+$(this).find("title").text()+'</div></a>');

                }
                feeds[source].artCount--;
                if(feeds[source].artCount == 0) {
                    feeds[source].ready = true;
                    feeds[source].callCount++;
                }
                //target.css({"width":target.width()+target.children().width()});
            })
        }
        
        var appendArticlesVideo = function(source, target, data) {
            if(jQuery.isXMLDoc(data)){
               xmlData = data;
            }else{
               xmlData = $.parseXML(data);
            }            
            $data = $(xmlData), $items = $data.find("item");
            feeds[source].artCount = $items.size();
            $items.each(function(index) {
          
                    //target.append('<li class="art_cont spinner preload_height ' + feeds[source].name + guid + '"></li>');
                    $('#videos ul').append('<li class="art_cont spinner preload_height ' + feeds[source].name + '"></li>');  
                  
                    //getImage($(this).find("image").text(),target.children().eq(index));
                    //target.children().eq(index).append('<a href="'+feeds[source].targetLink+guid+'"><div>'+$(this).find("title").text()+'</div></a>');
                    getImage($(this).find("image").text(), $(".art_cont.spinner." + feeds[source].name));
                    //$(".art_cont.spinner." + feeds[source].name + guid).append('<a href="' + feeds[source].targetLink + guid + '"><div>' + $(this).find("title").text() + '</div></a>');
                feeds[source].artCount--;
                if(feeds[source].artCount == 0) {
                    feeds[source].ready = true;
                    feeds[source].callCount++;
                }
                //target.css({"width":target.width()+target.children().width()});
            })
        }
        
/*
        var appendFeatured = function(data,target){
            xmlData = $.parseXML( data ),
            $data = $( xmlData ),
            $items = $data.find( "item" );
            $items.each(function(index){
                var category = $(this).find("category").text();
                target.append('<li class="featured_item spinner"></li>');
                getImage($(this).find("image").text(),target.children().eq(index));
                if(category=="News"){
                    target.children().eq(index).append('<a href="'+feeds["featured"].targetLink+$(this).find("guid").text()+'"><div>'+$(this).find("title").text()+'</div></a>');
                }
                else if(category=="Video"){
                    if(frontDoors_isIphone){
                        var rnmdPlayer="net.rnmd.sdk.playVideo('http://ads.rnmd.net/playVideo?siteId=55&userId=1341824245985&content="+$(this).find("v_iphone").text()+"');";
                    }
                    else{
                        var rnmdPlayer="net.rnmd.sdk.playVideo('http://ads.rnmd.net/playVideo?siteId=55&userId=1341824245985&content="+$(this).find("v_and_mq").text()+"');";
                    }
                    target.children().eq(index).append('<a href="#" onclick="'+ rnmdPlayer +'"><div>'+$(this).find("title").text()+'</div></a>');
                }
                else{
                    //additionally appending photos to photo list as per WAP-1600
                    $("#photos ul").append('<li class="art_cont ' + feeds["photos"].name + $(this).find("guid").text() + '"></li>');
                    getImage($(this).find("image").text(), $("." + feeds["photos"].name + $(this).find("guid").text()));
                    $("." + feeds["photos"].name + $(this).find("guid").text()).append('<a href="' + feeds["photos"].targetLink + $(this).find("guid").text() + '"><div>' + $(this).find("title").text() + '</div></a>');
                    target.children().eq(index).append('<a href="'+feeds["featured"].photosLink+$(this).find("guid").text()+'"><div>'+$(this).find("title").text()+'</div></a>');
                }
                //TODO and video category!!!
                target.css({"width":target.width()+target.children().outerWidth()});
                target.children().eq(index).css({"left":target.children().eq(index).outerWidth()*index})
                //$(".horDots").append("<li></li>");
                //$(".horDots").css({"left":$(".horDots").position().left-$(".horDots").children().eq(0).width()/2})
               if(index==0){
                   //$(".horDots").children().eq(0).addClass("dotCurrent");
               }
            })
        }
*/       
        var appendVideos = function(data,target){
            xmlData = $.parseXML( data ),
            $data = $( xmlData ),
            $show = $data.find( "show" );
            feeds["videos"].artCount = feeds["videos"].artCount + $show.find("item").size();
            $show.each(function(index){ 
               var currContainer="#video_container"+index;
               //feeds["videos"].artCount = feeds["videos"].artCount + $(this).find("item").size();
               //console.log("a "+feeds["videos"].artCount);
               if(feeds["videos"].callCount===0){
                   target.append('<div class="video_container" id="video_container'+ index +'"><div class="horScroll"><ul></ul></div></div>');
                   $(currContainer+" ul").append("<li class='video_item show spinner'></li>");
                   getImage($(this).find("showHead").text(),$(currContainer+" ul li.show"));
                   $(currContainer+" div.horScroll").css({"width":$(currContainer+" ul li").outerWidth()});
                   //$(currContainer).css({"width":$(currContainer+" ul li").outerWidth()});
               }
               $(this).find("item").each(function(index){
                   var guid = $(this).find("guid").text();
                   if($("." + feeds["videos"].name + guid).length == 0) {
                   $(currContainer+" ul").append("<li class='video_item spinner " + feeds["videos"].name + guid + "'></li>");
                   getImage($(this).find("image").text(),$(currContainer+" ul li.videos" + guid));
                   if(frontDoors_isIphone){
                        var rnmdPlayer="net.rnmd.sdk.playVideo('http://ads.rnmd.net/playVideo?siteId=55&userId=1341824245985&content="+$(this).find("v_iphone").text()+"');";
                    }
                    else{
                        var rnmdPlayer="net.rnmd.sdk.playVideo('http://ads.rnmd.net/playVideo?siteId=55&userId=1341824245985&content="+$(this).find("v_and_mq").text()+"');";
                    }
                    $(currContainer+" ul li.videos" + guid).append('<a href="#" onclick="'+ rnmdPlayer +'"><div>'+$(this).find("title").text()+'</div></a>');
                    //$(currContainer+".horScroll").css({"width":$(currContainer+" ul li").outerWidth()*(index+2)});
                    $(currContainer+" div.horScroll").css({"width":$(currContainer+" div.horScroll").outerWidth()+$(currContainer+" ul li").outerWidth()});
                    //$(currContainer).css({"width":$(currContainer+" ul li").outerWidth()*(index+2)});
                    //$(currContainer).css({"width":"100%"});
                    //$(currContainer+" ul li.videos" + guid).css({"left":$(currContainer+" ul li.videos" + guid).outerWidth()*(index+1)});
                    $(currContainer+" ul li.videos" + guid).css({"left":$(currContainer+" ul li.videos" + guid).prev().position().left+640});
                    $(currContainer).css({"width":$(currContainer + " ul").outerWidth()});
                    //$(currContainer+" ul").css({"width":$(currContainer+" ul").outerWidth()+$(currContainer+" ul li").outerWidth()})
                    }

                    feeds["videos"].artCount--;
                    if(feeds["videos"].artCount === 0) {
                        feeds["videos"].ready = true;
                        feeds["videos"].callCount++;
                    }

               })
            });
        }
        
        var getImage = function(source,target){
            var img = new Image();
                $(img).load(function () {
                    target.append(this);
                    target.removeClass("spinner preload_height");
                }).attr('src',source);
        }


    }
})(jQuery);

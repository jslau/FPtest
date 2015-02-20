/* bp.js */
(function($) {
    $.ajaxSetup({
       timeout:5000
     });
    document.ready=function(){

    //console.log($.ajaxSettings);
    var jsonController = new JsonController();
    var swipes = new SwipeController(jsonController);

    if(frontDoors_isAndroid){
            swipes.updateLayout();
        }

    if(!frontDoors_isIphone){
        jsonController.setPhotoGalleryType();
    }
    
    jsonController.setFeeds(frontDoors_currentUrl);
    //jsonController.getFeatured("featured",$("#featured_container div ul"));
    if(activeTab == '1') {
      //active news
      jsonController.getArticles("news",$("#news ul"));
      if(!$('#newsLink').children().hasClass("navCurrent")){
          $("nav ul li div").removeClass("navCurrent");
          $('#newsLink').children().addClass("navCurrent");
          swipes.setCurrentItem($("#news"));
      }
      $(".article_container").addClass("hideMe");
      if($('#news').hasClass("hideMe")){ 
          $("#news").removeClass("hideMe");
      }
      $('#news').addClass("menuActive");
    } 
    else if(activeTab == '2'){
        //active photos
        jsonController.getArticles("photos",$("#photos ul"));
        if(!$('#photosLink').children().hasClass("navCurrent")){
            $("nav ul li div").removeClass("navCurrent");
            $('#photosLink').children().addClass("navCurrent");
            swipes.setCurrentItem($("#photos"));
        }
        $(".article_container").addClass("hideMe");
        if($('#photos').hasClass("hideMe")){ 
            $("#photos").removeClass("hideMe");
        }
        $('#photos').addClass("menuActive");
    }
    else if(activeTab == '3'){
        //active videos
        jsonController.getArticles("videos",$("#videos ul"));
        if(!$('#videosLink').children().hasClass("navCurrent")){
            $("nav ul li div").removeClass("navCurrent");
            $('#videosLink').children().addClass("navCurrent");
            swipes.setCurrentItem($("#videos"));
        }
        $(".article_container").addClass("hideMe");
        if($('#videos').hasClass("hideMe")){ 
            $("#videos").removeClass("hideMe");
        }
        $('#videos').addClass("menuActive");
    }
    else{
        //active news
        jsonController.getArticles("news",$("#news ul"));
        if(!$('#newsLink').children().hasClass("navCurrent")){
            $("nav ul li div").removeClass("navCurrent");
            $('#newsLink').children().addClass("navCurrent");
            swipes.setCurrentItem($("#news"));
        }
        $(".article_container").addClass("hideMe");
        if($('#news').hasClass("hideMe")){ 
            $("#news").removeClass("hideMe");
        }
        $('#news').addClass("menuActive");
    }
    setInterval(function(){swipes.callFlip()},5000);

    var NewsDisplay = 0;
    var PhotosDispaly = 0;
    var VideosDisplay = 0;

    $("#menuLink").on("click",function(){
        if(!$(this).hasClass("menuActive")){
            $(this).addClass("menuActive");
            $()
            swipes.switchControl("menu");
            if($('#videos').hasClass("hideMe")){        
            } else {
                 VideosDisplay = 1;
            }
            if($('#photos').hasClass("hideMe")) {
            }
            else {
                 PhotosDispaly = 1;
            }
            if($('#news').hasClass("hideMe")) {
            }
            else {
                 NewsDisplay = 1;
            }           
            $(".article_container").addClass("hideMe");
            $(".topAd").addClass("hideMe");
            $(this).css("top","15px");
        }
        else{
            $(this).removeClass("menuActive");
            $(".topAd").removeClass("hideMe");
            var topAdH = $(".topAd").height();
            $(this).css("top",topAdH + 15 + "px");
            //$(this).css("top","80px");
            swipes.switchControl("free");

            if(VideosDisplay == 1) {
                  
                  $("#videos").removeClass("hideMe");
                  NewsDisplay = 0;
                  PhotosDispaly = 0;
                  VideosDisplay = 0;
            }
            else if(PhotosDispaly == 1) {
                  
                  $("#photos").removeClass("hideMe");
                  NewsDisplay = 0;
                  PhotosDispaly = 0;
                  VideosDisplay = 0;
            }
            else {
                  
                  $("#news").removeClass("hideMe");
                  NewsDisplay = 0;
                  PhotosDispaly = 0;
                  VideosDisplay = 0;
            }     
        }
        $("#dropdown").css({"top":$("#menu").position().top+$("#menu").height()});
        $("#dropdown").toggle();
    })
    
    $("#newsMenu").on("click",function(){
        $("#menuLink,#newsLink").click();
        //$("#newsLink").click();
    })
    
    $("#photosMenu").on("click",function(){
        $("#menuLink,#photosLink").click();
    })

    $("#videosMenu").on("click",function(){
        $("#menuLink,#videosLink").click();
    })
 /*   
    $("#homeLink").on("click",function(){
            $("nav ul li div").removeClass("navCurrent");
            $("#newsLink").children().addClass("navCurrent");
            $(".article_container").addClass("hideMe");
            $("#news").removeClass("hideMe");
            //swipes.setCurrentItem($("#news"));
    })
 */   
    $("#newsLink").on("click",function(){
        if(!$(this).children().hasClass("navCurrent")){
            //swipes.toggleLockState(true);
            $("nav ul li div").removeClass("navCurrent");
            $(this).children().addClass("navCurrent");
            $(".article_container").addClass("hideMe");
            $("#news").removeClass("hideMe");
            swipes.setCurrentItem($("#news"));
            jsonController.getArticles("news",$("#news ul"));
            //$('#my_rnmd_ad').load("doors/ads.ftl");
        }
    })
    $("#photosLink").on("click",function(){
        if(!$(this).children().hasClass("navCurrent")){
            //swipes.toggleLockState(true);
            $("nav ul li div").removeClass("navCurrent");
            $(this).children().addClass("navCurrent");
            $(".article_container").addClass("hideMe");
            $("#photos").removeClass("hideMe");
            swipes.setCurrentItem($("#photos"));
            jsonController.getArticles("photos",$("#photos ul"));
            //$('#my_rnmd_ad').load("doors/ads.ftl");
        }
    })
    
    $("#videosLink").on("click",function(){
            if(!$(this).children().hasClass("navCurrent")){
            //swipes.toggleLockState(true);
            $("nav ul li div").removeClass("navCurrent");
            $(this).children().addClass("navCurrent");
            $(".article_container").addClass("hideMe");
            $("#videos").removeClass("hideMe");
            //swipes.setCurrentItem($("#videos"));
            //jsonController.getVideos("videos",$("#videos"));
            if(videoLoader == 1) {
            } else {
              jsonController.getArticles("videos",$("#videos"));
            }
            //$('#my_rnmd_ad').load("doors/ads.ftl");
        }
    /*
        if(!$(this).children().hasClass("navCurrent")){
            //swipes.toggleLockState(true);
            $("#videos").css({"height":$(".video_item.show").height()*$(".video_item.show").size()+200});
            $("nav ul li div").removeClass("navCurrent");
            $(this).children().addClass("navCurrent");
            $(".article_container").addClass("hideMe");
            $("#videos").removeClass("hideMe");
//          swipes.setCurrentItem($("#videos"));
        }
        */

//VIDEOS
//use action below to connect to old videos page
//        window.open("http://eproto.mtiny.com/video_series_list.ftl?category=Videos");
//use action below to inject videos to doors page
/*
       if(!$(this).children().hasClass("navCurrent")){
            $("nav ul li div").removeClass("navCurrent");
            $(this).children().addClass("navCurrent");
            $(".article_container").addClass("hideMe");
            $("#videos").removeClass("hideMe");
            swipes.setCurrentItem($("#videos"));
            jsonController.getVideos("videos",$("#videos"));
        }
*/
    })
}
})(jQuery);
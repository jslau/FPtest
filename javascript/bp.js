(function($) {
    document.ready=function(){
    var jsonController = new JsonController();
    var swipes = new SwipeController(jsonController);
    if(frontDoors_isAndroid){
            swipes.updateLayout();
        }
    //$("#menu").on("click",function(){
        jsonController.setFeeds(frontDoors_currentUrl);
        jsonController.getFeatured("featured",$("#featured_container div ul"));
        jsonController.getArticles("news",$("#news ul"));
        setInterval(function(){swipes.callFlip()},5000);
    //})
    $("#headerMenuButton").on("click",function(){
        if(!$(this).hasClass("menuActive")){
            $(this).addClass("menuActive");
            swipes.switchControl("menu");
            //TODO below fix is for andoids -  for some reason  it displays far below menu bar. solve it another way
            $("#dropdown ul").css({"top":$("#menu").position().top+$("#menu").height()});
        }
        else{
            $(this).removeClass("menuActive");
            swipes.switchControl("free");
        }
        $("#dropdown").css({"top":$("#menu").position().top+$("#menu").height()});
        //TODO too slow
        $("#dropdown").slideToggle();
    })
    $("#newsLink").on("click",function(){
        if(!$(this).hasClass("navCurrent")){
            $("nav ul li div").removeClass("navCurrent");
            $(this).addClass("navCurrent");
            $(".article_container").addClass("hideMe");
            $("#news").removeClass("hideMe");
            swipes.setCurrentItem($("#news"));
        }
    })
    $("#photosLink").on("click",function(){
        if(!$(this).hasClass("navCurrent")){
            $("nav ul li div").removeClass("navCurrent");
            $(this).addClass("navCurrent");
            $(".article_container").addClass("hideMe");
            $("#photos").removeClass("hideMe");
            swipes.setCurrentItem($("#photos"));
            jsonController.getArticles("photos",$("#photos ul"));
        }
    })
    $("#videosLink").on("click",function(){
        window.open("http://eproto.mtiny.com/video_series_list.ftl?category=Videos");
/*
        if(!$(this).hasClass("navCurrent")){
            $("nav ul li div").removeClass("navCurrent");
            $(this).addClass("navCurrent");
        }
*/
    })
}
})(jQuery);
videoLoader = 0;
(function($) {
    SwipeController = function(myJsonController) {
/*
http://help.dottoro.com/ljorlllt.php
 * order of dissapearance:
 * menu bar
 * featured box
 * top ad
 * lock nav bar
 */
        var lockTable={"menuItem":".menu","featuredItem":".featured_container","topAdItem":".topAd","navBarItem":"nav","currentItem":"#news","dropdown":"#dropdown ul","menulink":".menuLink" };
        var viewportItem=$("#viewport");
        for(var key in lockTable) {
                var obj = lockTable[key];
                lockTable[key]=$(obj);
        }
        
        // Code that is responsible for downloading new portion of articles.
        if (Modernizr.touch) {
            $(document).bind('touchend', mobileInfscr);
            $(document).on('touchmove', mobileMove);
        } else {
            $(document).bind('mouseup', mobileInfscr);
            $(document).on('scroll', mobileMove);
        }


        var that = this;
/* 
old
        function mobileMove(event){

            setTimeout(function() {    
                //var touch = event.touches[0] || event.changedTouches[0];       
                //var y = touch.pageY;
                var documentHeight = $(document).height();
                var distance = documentHeight; //- y;
                var distanceThreshold = window.innerHeight * 3;
        
                if (distance < distanceThreshold) {
                    console.log('load data called from move');
                    myJsonController.getArticles(lockTable.currentItem.selector.replace(/#/, ''), $(lockTable.currentItem.selector));
                }
           }, 0)
        }
*/

function mobileMove(event){
           setTimeout(function() {
                var documentHeight = $(document).height();
                var scrollHeight = $(window).scrollTop();
                var distance = documentHeight - scrollHeight;
                var distanceThreshold = window.innerHeight * 3;
                if(lockTable.currentItem.selector != '#videos') {
                 if (distance < distanceThreshold) {                  
                    myJsonController.getArticles(lockTable.currentItem.selector.replace(/#/, ''), $(lockTable.currentItem.selector));
                 }
                }
            }, 0)
        }


        function mobileInfscr() {
            setTimeout(function() {
                var documentHeight = $(document).height();
                var scrollHeight = $(window).scrollTop();
                var distance = documentHeight - scrollHeight;
                var distanceThreshold = window.innerHeight * 3;
                if(lockTable.currentItem.selector != '#videos') {
                  if (distance < distanceThreshold) {
                    myJsonController.getArticles(lockTable.currentItem.selector.replace(/#/, ''), $(lockTable.currentItem.selector));
                  }
                }
            }, 0)
        }

        // REMOVED since elements don't need to be fixed on page anymore
        // 2012-08-31 by KD
        for(var key in lockTable) {
                //lockTable[key].css({"position":"fixed"});
        }
        
        this.updateLayout = function(){
            $(".featured_container div ul li").css({"width":screen.width});
            navbarH=lockTable.navBarItem.height();
            menuitemH=lockTable.menuItem.height();
            topadItemH=lockTable.topAdItem.height();
            featureditemH=lockTable.featuredItem.height();
        }
        
        var navbarH=lockTable.navBarItem.height();
        var menuitemH=lockTable.menuItem.height();
        var topadItemH=lockTable.topAdItem.height();
        var featureditemH=lockTable.featuredItem.height();
        
        
        //var horDots = $(".horDots");
        lockTable.topAdItem.css({"top":0});
        lockTable.menuItem.css({"top":topadItemH});
        // lockTable.featuredItem.css({"top":topadItemH+menuitemH});
        lockTable.navBarItem.css({"top":topadItemH+menuitemH+featureditemH});
        //viewportItem.css({"top":lockTable.navBarItem.position().top+navbarH});
        //lockTable.menulink.css({"top":topadItemH + 15});

        //TODO for testing, width will be updated later in json section
        $("."+lockTable.featuredItem.attr("class")+" div ul li").each(function(){
            $(this).parent().css({"width":$(this).parent().width()+$(this).width()});
        });


        this.setCurrentItem = function(obj){
            if(obj){
                lockTable.currentItem=obj;
                //lockTable.currentItem.css({"position":"fixed"});
                rearrange();
                setTimeout(function(){
                    toggleLock=false;
                },700)
            }
            else {
                return lockTable.currentItem;
            }
        }
        
        var mac=false;

        //disable vertical scrolling while sccrolling horizontaly, but might cause probs on video page...
        var vertLock=false;
        var horzLock=false;
        var menuLock=true;
        var vidLock=true;
        var flipLock=false;
        var toggleLock=false;
        
        this.toggleLockState = function(val){
            if(val===true||val===false){
                toggleLock=val;
            }
            else{
                return toggleLock;
            }
        }
        
        var pseudoSwipeValue=0;
        var pseudoSwipeDir=0;
        
        this.callFlip = function(){
            flip(-1);
        }
        
        this.switchControl = function(state){
            if(state==="menu"){
                vertLock=true;horzLock=true;vidLock=true;
                menuLock=false;
            }
            else if(state==="video")
            {
                vertLock=true;horzLock=true;menuLock=true;
                vidLock=false;
            }
            else{
                vertLock=false;horzLock=false;
                menuLock=true;vidLock=true;
            }
        }
        
        var scrlCoords={"x1":"","x2":"","y1":"","y2":""};

        scrlCoords.y1=0;
        
        var bounceDir=0;
        var bounceTarg="";
        
        var horizontalScrollClass="horScroll";
        var verticalScrollClass="vertScroll";
        var horizontalFlipClass="horFlip";
        //bad things happen on android default browser when mouse events are supported
        //but we might want to keep this for desktops (at least for dev/qa) 





        function updateOrientation() {
//            this.updateLayout();
if(menuLock===false){
   if(lockTable.menuItem.position().top < 0) {
alert(lockTable.menuItem.position().top);
                    lockTable.menuItem.css({
                        "top" : lockTable.navBarItem.position().top + navbarH
                    });
                }
}
        }
//        window.onorientationchange = updateOrientation;
/*
$(window).on('orientationchange',function(){
if(!frontDoors_isIphone){
   $("#menuLink").click();
   $("#menuLink").click();
}
else{
   if(window.orientation==90||window.orientation==-90){
      $(".menuLink.menuActive").click();
   }
}
})
  */    
/*
$(window).on('orientationchange',function(){
alert("1");
   if((window.orientation==90||window.orientation==-90 ) && frontDoors_isIphone){
alert("2");
      $(".menuLink.menuActive").click();
   }
})
 */
        

        var pseudoSwipe = function() {
            if(!toggleLock){
                           if(menuLock && horzLock){
                var curItemTopPos = lockTable.currentItem.position().top;
            if(pseudoSwipeValue <0 && curItemTopPos+lockTable.currentItem.height()>$(window).height()) {
                lockTable.currentItem.addClass("trans2");
                 cascade(curItemTopPos);
                 if(curItemTopPos + pseudoSwipeDir*1.8>navbarH){
                     lockTable.currentItem.css({"top" : navbarH});
                 }
                 else{
                     lockTable.currentItem.css({"top" : curItemTopPos + pseudoSwipeDir*1.8});
                 }
                        setTimeout(function() {
                            horzLock = false;
                            flipLock = false;
                            lockTable.currentItem.removeClass("trans2");
                        },700);
            }
            //else if(horzLock && pseudoSwipeValue >0){
                else if( pseudoSwipeValue >0 && lockTable.currentItem.position().top<topadItemH+menuitemH+featureditemH+navbarH){
                //lockTable.menuItem.css({"top":pseudoSwipeValue-menuitemH-featureditemH-navbarH}).addClass("trans2");
               lockTable.featuredItem.css({"top":pseudoSwipeValue-featureditemH-navbarH}).addClass("trans2");
               lockTable.topAdItem.css({"top":pseudoSwipeValue-topadItemH-menuitemH-featureditemH-navbarH}).addClass("trans2");
               lockTable.navBarItem.css({"top":pseudoSwipeValue-navbarH}).addClass("trans2");
                lockTable.currentItem.addClass("trans2");
                
                 lockTable.currentItem.css({"top" : curItemTopPos + pseudoSwipeDir});
                        lockTable.menuItem.css({"top" : lockTable.menuItem.position().top + pseudoSwipeDir});
                        lockTable.topAdItem.css({"top" : lockTable.topAdItem.position().top + pseudoSwipeDir});
                        lockTable.featuredItem.css({"top" : lockTable.featuredItem.position().top + pseudoSwipeDir});
                        lockTable.navBarItem.css({"top" : lockTable.navBarItem.position().top + pseudoSwipeDir});
                            setTimeout(function() {
                                             cascade(pseudoSwipeValue + pseudoSwipeDir);
                        },700);
                        
                        setTimeout(function() {
                            
                            horzLock = false;
                            flipLock = false;
                            lockTable.currentItem.removeClass("trans2");
                lockTable.menuItem.removeClass("trans2");
                 lockTable.topAdItem.removeClass("trans2");
                 lockTable.featuredItem.removeClass("trans2");
                 lockTable.navBarItem.removeClass("trans2");
                        },1400);
            }
            }
            }
 
        }

    var flip = function(dir){
        if(!flipLock){
            if(dir<0){
                flipLock=true;
                var targ=$("."+lockTable.featuredItem.attr("class")+" ."+horizontalFlipClass).children();
                var len=targ.children().size()-1;
                targ.children().animate({"left":"-=640"},500,function(){
                    if($(this).index()==len){
                        targ.children(":first-child").css({"left":targ.children().eq(len).position().left+640}).appendTo(targ);
                        //targ.children(":first-child").css({"left":targ.children().eq(len).position().left+640});
                        //targ.children(":first-child").appendTo(targ);
                        //horDots.children().eq(len).prependTo(horDots);
                        flipLock=false;
                    }
                    
                })
            }
            else {
                flipLock=true;
                var targ=$("."+lockTable.featuredItem.attr("class")+" ."+horizontalFlipClass).children();
                var len=targ.children().size()-1;
                targ.children().eq(len).css({"left":-640}).prependTo(targ);
                //targ.children().eq(len).css({"left":-640});
                //targ.children().eq(len).prependTo(targ);
                //horDots.children(":first-child").appendTo(horDots);
                targ.children().animate({"left":"+=640"},500,function(){
                    flipLock=false;
                })              
            }
            
        }
    }
    var setSpeed = function(start,stop){
        var diff=stop-start;
        if (-20 < diff <20)
            return diff;
        else return 0;
    }
    var menuLimiter = function(){
        if(lockTable.dropdown.position().top+lockTable.dropdown.height()<$(window).height()){
            lockTable.dropdown.css({"top":-lockTable.dropdown.height()+$(window).height()});
        }
        if(lockTable.dropdown.position().top>lockTable.menuItem.position().top+lockTable.menuItem.height()){
            lockTable.dropdown.css({"top":lockTable.menuItem.position().top+lockTable.menuItem.height()});
        }
    }

    var bounce = function(target,dir){
        if(target.position().left>0){
            horzLock=true;
            target.animate({"left":0},500,function(){
                horzLock=false;
            })
        }
//        else if(target.position().left-$(window).width()+target.outerWidth()<$(window).width()){
        else if(target.position().left+target.outerWidth()<$(window).width()){
            var src = lockTable.currentItem.attr("id");
            if(src === "videos") {
                if(myJsonController.getState(src)) {
                    myJsonController.getVideos(src, $("#videos"));
                    horzLock=true;
                    var mult=Math.floor(target.position().left/target.children(":first-child").children(":first-child").outerWidth());
                    target.animate({"left":mult*target.children(":first-child").children(":first-child").outerWidth()},500,function(){
                        horzLock=false;
                        bounceDir=0;
                    });
                }
                else{
                    horzLock=true;
                    //target.animate({"left":2*$(window).width()-target.outerWidth()},500,function(){
                    target.animate({"left":$(window).width()-target.outerWidth()},500,function(){
                                horzLock=false;
                    });
                }
            }
            else{
                horzLock=true;
                //target.animate({"left":2*$(window).width()-target.outerWidth()},500,function(){
                target.animate({"left":$(window).width()-target.outerWidth()},500,function(){
                    horzLock=false;
                });
           }
        }
        else{
            if(target.position().left<0 && dir<0){
                var mult=Math.floor(target.position().left/target.children(":first-child").children(":first-child").outerWidth());
                horzLock=true;
                target.animate({"left":mult*target.children(":first-child").children(":first-child").outerWidth()},500,function(){
                    horzLock=false;
                    bounceDir=0;
                });
            }
            else if(target.position().left+target.width()>$(window).width() && dir>0){
                var mult=Math.floor(target.position().left/target.children(":first-child").children(":first-child").outerWidth())+1;
                horzLock=true;
                target.animate({"left":mult*target.children(":first-child").children(":first-child").outerWidth()},500,function(){
                    horzLock=false;
                    bounceDir=0;
                });
            }
        }
    }
       
       rearrange = function(){
           //TODO redundancies
           var navbarT=lockTable.navBarItem.position().top;
      //     if(navbarT>0 || lockTable.currentItem.position().top > navbarT+navbarH){
               lockTable.navBarItem.css({"top":0});
               lockTable.currentItem.css({"top":navbarH});
               lockTable.featuredItem.css({"top":-featureditemH});
               lockTable.menuItem.css({"top":-menuitemH-featureditemH});
               lockTable.topAdItem.css({"top":-topadItemH-menuitemH-featureditemH});    
        //   }
           /*
           if(lockTable.currentItem.position().top > navbarT+navbarH ){
               lockTable.currentItem.css({"top":navbarT+navbarH});
           }
           */
       } 
       cascade=function(direction){
           //if(direction>0){
               if(!toggleLock){
               /*
               var navbarH=lockTable.navBarItem.height();
               var menuitemH=lockTable.menuItem.height();
               var topadItemH=lockTable.topAdItem.height();
               var featureditemH=lockTable.featuredItem.height();
               */

               lockTable.menuItem.css({"top":direction-menuitemH-featureditemH-navbarH});
               lockTable.featuredItem.css({"top":direction-featureditemH-navbarH});
               lockTable.topAdItem.css({"top":direction-topadItemH-menuitemH-featureditemH-navbarH});
               lockTable.navBarItem.css({"top":direction-navbarH});
               //lock navbar at top
               if(lockTable.navBarItem.position().top<0){
                   lockTable.navBarItem.css({"top":0});
               }
               //lock ad container at top until nav cover it
               if(lockTable.navBarItem.position().top>topadItemH){
                   //TODO migh still be required somewhere to hide address bar again  
                   /*window.scrollTo(0,1);*/
                   lockTable.topAdItem.css({"top":0});
               }
               else{
                   lockTable.topAdItem.css({"top":lockTable.navBarItem.position().top-topadItemH});
               }
               //lock scroll down when all items are visible
               if(lockTable.currentItem.position().top>topadItemH+menuitemH+featureditemH+navbarH){
                   lockTable.topAdItem.css({"top":0});
                    lockTable.menuItem.css({"top":topadItemH});
                    lockTable.featuredItem.css({"top":topadItemH+menuitemH});
                    lockTable.navBarItem.css({"top":topadItemH+menuitemH+featureditemH});
                    lockTable.currentItem.css({"top":topadItemH+menuitemH+featureditemH+navbarH});
               }
               //lock scroll up when end of page is reached
               //TODO store $(window).height() somewhere, but keep in mind that it might change on rotate (or resize)
                if(lockTable.currentItem.position().top + lockTable.currentItem.height() < $(window).height()) {
                    lockTable.currentItem.css({
                        "top" : -lockTable.currentItem.height() + $(window).height()
                    });
                    var src = lockTable.currentItem.attr("id");
                    if(src != "videos") {
                        if(myJsonController.getState(src)) {
                            myJsonController.getArticles(src, $("#" + src + " ul"));
                        }
                    }
                }

               //TODO: remove redundancy and reoragnize above to improve perf
               /*TODO launch json at the end of scrolling*/
           }
       }
    }
})(jQuery);

/*
$(document).ready(function() {
    if (Modernizr.touch) {
        $(document).bind('touchend', mobileInfscr);
    } else {
        $(document).bind('mouseup', mobileInfscr);
    }

    function mobileInfscr() {
        setTimeout(function() {
            var documentHeight = $(document).height();
            var scrollHeight = $(window).scrollTop();
            var distance = documentHeight - scrollHeight;
            var distanceThreshold = window.innerHeight + 200;
 
            if (distance < distanceThreshold) {
                
            }
        }, 400)
    }
});
*/

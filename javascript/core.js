(function($) {
    SwipeController = function(myJsonController) {
/*
 * order of dissapearance:
 * menu bar
 * featured box
 * top ad
 * lock nav bar
 */
        var lockTable={"menuItem":".header","featuredItem":".featured_container","topAdItem":".topAd","navBarItem":"nav","currentItem":"#news","dropdown":"#dropdown ul" };
        var viewportItem=$("#viewport");
        for(var key in lockTable) {
                var obj = lockTable[key];
                lockTable[key]=$(obj);
        }
        
        for(var key in lockTable) {
                lockTable[key].css({"position":"fixed"});
        }
        
        this.updateLayout = function(){
        }
        
        var navbarH=lockTable.navBarItem.height();
        var menuitemH=lockTable.menuItem.height();
        var topadItemH=lockTable.topAdItem.height();
        var featureditemH=lockTable.featuredItem.height();
        
        var horDots = $(".horDots");

        lockTable.topAdItem.css({"top":0});
        lockTable.menuItem.css({"top":topadItemH});
        lockTable.featuredItem.css({"top":topadItemH+menuitemH});
        lockTable.navBarItem.css({"top":topadItemH+menuitemH+featureditemH});
        
        //TODO for testing, width will be updated later in json section
        $("."+lockTable.featuredItem.attr("class")+" div ul li").each(function(){
            $(this).parent().css({"width":$(this).parent().width()+$(this).width()});
        });

        this.setCurrentItem = function(obj){
            if(obj){
                lockTable.currentItem=obj;
                lockTable.currentItem.css({"position":"fixed"});
                rearrange();
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
        
        this.callFlip = function(){
            flip(-1);
        }
        
        this.switchControl = function(state){
            if(state==="header"){
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
        
        var horizontalScrollClass="horScroll";
        var verticalScrollClass="vertScroll";
        var horizontalFlipClass="horFlip";
        //bad things happen on android default browser when mouse events are supported
        //but we might want to keep this for desktops (at least for dev/qa) 


        if(!Modernizr.hasEvent('touchstart')) {
            $(document).on('mousedown', function() {
                event.preventDefault();
                scrlCoords.x1 = event.pageX;
                scrlCoords.y1 = event.pageY;
                mac = true;
                //this might get useful once vids are implemented
                //            if(menuLock || vidLock)vertLock=false;
                //if(menuLock)
                    vertLock = false;
            });

            $(document).on('mouseup', function() {
                event.preventDefault();
                scrlCoords.x1 = event.pageX;
                scrlCoords.y1 = event.pageY;
                //TODO handle universal way
                if(vertLock){
                    bounce($("." + lockTable.featuredItem.attr("class") + " .horScroll"), bounceDir);
                }
                //resolveAni();
                mac = false;
                    vertLock = false;
                    horzLock = false;
                   
            });

            $(document).on('mousemove', function() {

                if(mac) {
                    event.preventDefault();
                    var x = event.pageX;
                    var y = event.pageY;
                    //vertical scroll
                    if(!vertLock&&(Math.abs(setSpeed(scrlCoords.y1, y)) > Math.abs(setSpeed(scrlCoords.x1, x)))) {
                        horzLock=true;
                        //general vertical scroll
                        if(menuLock) {
                            //var topPos = lockTable.currentItem.position().top;
                            var newPos = lockTable.currentItem.position().top + setSpeed(scrlCoords.y1, y);
                            if(y != scrlCoords.y1) {
                                lockTable.currentItem.animate({
                                    top : newPos
                                }, 0);
                                scrlCoords.y1 = y;
                                cascade(newPos);
                            }
                        } 
                        //dropdown menu vertical scroll
                        else {
                            //var topPos = lockTable.dropdown.position().top;
                            var newPos = lockTable.dropdown.position().top + setSpeed(scrlCoords.y1, y);
                            if(y != scrlCoords.y1) {
                                /*lockTable.dropdown.animate({
                                    top : newPos
                                }, 0);*/
                               lockTable.dropdown.css({"top":newPos});
                                scrlCoords.y1 = y;
                                menuLimiter();
                            }
                        }
                    } 
                    //horizontal scroll
                    else {
                        var targ = $(event.target);
                        //targ=targ.closest("."+horizontalScrollClass)||targ.closest("."+horizontalFlipClass);
                        targ.closest("."+horizontalScrollClass).size()>0?targ=targ.closest("."+horizontalScrollClass):targ=targ.closest("."+horizontalFlipClass);
                        if(!horzLock && menuLock && targ.hasClass(horizontalScrollClass)) {
                            vertLock = true;
                            //var leftPos = targ.position().left;
                            var rightPos = targ.width();
                            bounceDir = setSpeed(scrlCoords.x1, x);
                            var newPos = targ.position().left + bounceDir;
                            if(x != scrlCoords.x1) {
                                targ.animate({
                                    left : newPos
                                }, 0);
                                scrlCoords.x1 = x;
                            }
                        }
                        else if(!flipLock && menuLock && targ.hasClass(horizontalFlipClass)){
                            // var leftPos = targ.position().left;
                            var rightPos = targ.width();
                            bounceDir = setSpeed(scrlCoords.x1, x);
                            var newPos = targ.position().left + bounceDir;
                            if(x != scrlCoords.x1) {
                                flip(bounceDir);
                            }
                            
                        }
                    }
                }
                /* TODO use this for horizontal scroll on videos
                 if(mac && targ.hasClass(horizontalScrollClass)){
                 vertLock=true;
                 var leftPos=targ.position().left;
                 var rightPos=targ.width();
                 var newPos=leftPos+setSpeed(scrlCoords.x1,x);
                 if(x!=scrlCoords.x1){
                 targ.animate({left:newPos},0);
                 scrlCoords.x1=x;
                 }
                 }
                 */
            });
        }



        function updateOrientation() {
        }
        window.onorientationchange = updateOrientation;


       
       $(document).on('touchstart', function() {
           //event.preventDefault();
            var touch = event.touches[0] || event.changedTouches[0];
            scrlCoords.x1=touch.pageX;
            scrlCoords.y1=touch.pageY;
            //mac=true;
            vertLock = false;
        });
        
        $(document).on('touchend',function() {
            event.preventDefault();
            var touch = event.touches[0] || event.changedTouches[0];
            //resolveAni();
            if(vertLock){
                scrlCoords.x1=touch.pageX;
            }
            else{
                scrlCoords.y1=touch.pageY;
            }
            //TODO handle universal way
            if(vertLock){
                bounce($("."+lockTable.featuredItem.attr("class")+" .horScroll"),bounceDir);
            }
           // mac=false;
            //if(menuLock)vertLock=false;
            vertLock = false;
                    horzLock = false;
        });
        


        $(document).on('touchmove', function() {
           // if(mac) {
                event.preventDefault();
                var touch = event.touches[0] || event.changedTouches[0];
                var x = touch.pageX;
                var y = touch.pageY;
                if(!vertLock&&(Math.abs(setSpeed(scrlCoords.y1, y)) > Math.abs(setSpeed(scrlCoords.x1, x)))) {
                    horzLock=true;
                    if(menuLock) {
                        //var topPos = lockTable.currentItem.position().top;
                        var newPos = lockTable.currentItem.position().top + setSpeed(scrlCoords.y1, y);
                        if(y != scrlCoords.y1) {
                            /*lockTable.currentItem.animate({
                                top : newPos
                            }, 0);*/
                            lockTable.currentItem.css({"top":newPos});
                            scrlCoords.y1 = y;
                            cascade(newPos);
                        }
                    } else {
                        //var topPos = lockTable.dropdown.position().top;
                        var newPos = lockTable.dropdown.position().top + setSpeed(scrlCoords.y1, y);
                        if(y != scrlCoords.y1) {
                            lockTable.dropdown.animate({
                                top : newPos
                            }, 0);
                            scrlCoords.y1 = y;
                            menuLimiter();
                        }
                    }

                } else {
                    var targ = $(touch.target);
                    //targ=targ.closest("."+horizontalScrollClass);
                    targ.closest("."+horizontalScrollClass).size()>0?targ=targ.closest("."+horizontalScrollClass):targ=targ.closest("."+horizontalFlipClass);
                    if(!horzLock&&menuLock && targ.hasClass(horizontalScrollClass)) {
                        vertLock = true;
                        //var leftPos = targ.position().left;
                        bounceDir = setSpeed(scrlCoords.x1, x);
                        var newPos = targ.position().left + bounceDir;
                        if(x != scrlCoords.x1) {
                            targ.animate({
                                left : newPos
                            }, 0);
                            scrlCoords.x1 = x;
                        }
                    }
else if(!flipLock && menuLock && targ.hasClass(horizontalFlipClass)){
                             //var leftPos = targ.position().left;
                            bounceDir = setSpeed(scrlCoords.x1, x);
                            var newPos = targ.position().left + bounceDir;
                            if(x != scrlCoords.x1) {
                                flip(bounceDir);
                            }
                            
                        }
                }

            //}
        });
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
                        horDots.children().eq(len).prependTo(horDots);
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
                horDots.children(":first-child").appendTo(horDots);
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
        else if(target.position().left-$(window).width()+target.width()<$(window).width()){
            horzLock=true;
            target.animate({"left":2*$(window).width()-target.width()},500,function(){
                horzLock=false;
            })
        }
        else{
            if(target.position().left<0 && dir<0){
                var mult=Math.floor(target.position().left/target.children(":first-child").children(":first-child").width());
                horzLock=true;
                target.animate({"left":mult*target.children(":first-child").children(":first-child").width()},500,function(){
                    horzLock=false;
                    bounceDir=0;
                });
            }
            else if(target.position().left+target.width()>$(window).width() && dir>0){
                var mult=Math.floor(target.position().left/target.children(":first-child").children(":first-child").width())+1;
                horzLock=true;
                target.animate({"left":mult*target.children(":first-child").children(":first-child").width()},500,function(){
                    horzLock=false;
                    bounceDir=0;
                });
            }
        }
    }
       
       rearrange = function(){
           //TODO redundancies
           var navbarT=lockTable.navBarItem.position().top;
           if(navbarT>0 || lockTable.currentItem.position().top > navbarT+navbarH){
               lockTable.currentItem.css({"top":navbarT+navbarH});               
           }
           /*
           if(lockTable.currentItem.position().top > navbarT+navbarH ){
               lockTable.currentItem.css({"top":navbarT+navbarH});
           }
           */
       } 
       cascade=function(direction){
           //if(direction>0){
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
               if(lockTable.currentItem.position().top+lockTable.currentItem.height()<$(window).height()){
                   lockTable.currentItem.css({"top":-lockTable.currentItem.height()+$(window).height()});
                   var src=lockTable.currentItem.attr("id");
                   if(myJsonController.getState(src)){
                       myJsonController.getArticles(src,$("#"+src+" ul"));
                   }
               }
               //TODO: remove redundancy and reoragnize above to improve perf
               /*TODO launch json at the end of scrolling*/
          // }
       }
    }
})(jQuery);

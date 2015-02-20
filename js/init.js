window.onload = function(){
    window.scrollTo(0, 1);
    //setTimeout(function() { window.scrollTo(0, 1); }, 100);

    //window.addEventListener('orientationchange', this, true);
    window.addEventListener('orientationchange', handleEvent, true);
    if(ua=="Android"){
        window.addEventListener('resize', function(){
            setOrientation();
        }, true);
    }

    window.allScrollers = [];
    window.sectionIndex = -1;
    window.sectionOffset = 0;

    //if(!ua ||  deviceName=="GalaxyTab" || ua!= "Android" ){
        //document.body.addEventListener("touchmove", function(e) {
            // This prevents native scrolling from happening.
            //e.preventDefault();
        //}, false);
    window.scrollviewer = null;

    if(document.getElementById('scroller')){
        window.scrollviewer = new Scroller({
            id:"scroller",              //ID of the parent scroller
            axis: "y",              //Axis along which the parent ought    to be scrollable
            pagination:false,           //Must be false for parent scroller
            linkingClass: null            //Must be null for parent scroller
            //stickyHeaders: 'sectionHeader',       //Class name of the header elements that will stick to the top of the page.
                                //Make this element null
            // feedUrl:'http://dev.etp.mtiny.com/xml/homefeed_HD.ftl'       //URL to XML feed of NewsItems
        });
    }


        // if(deviceName=="GalaxyTab"){
        //    var s = window.innerHeight + "px";
        //    $("#container").style.height = s;
        //    $("#scroll-view").style.height = s;
        //    //alert(s);
        // }
    //} else{
       //window.scrollviewer = null;
       //var t = $(".sectionHeader")[0].offsetTop;
       //$("#header").style.marginTop = t+"px";
       //console.log(t);
    //}
      //To remove a section, comment out the following block of code and remove the entire section element from the HTML

    window.news = null;
    if(document.getElementById('latest-news')){
        window.news = new Scroller({
            id:"latest-news",
            axis: "x",
            pagination:true,
            pageIndicator:false,
            footerBar:true,
            linkingClass: null,
            stickyHeaders: false,
            snapToTop:false,
            linkText:'Related Articles',

            articleClass: 'latestNewsArticle',
            articlesPerPage: 1,
            rows:1,
            columns:1,
            articleTitle: true,
            articleDesc: false,
            articleImage: true
        });
    }


    window.body= $('body');
    window.menu = $('#menu');
    $('#headerMenuButton').addEventListener('click',this, false);

    if(location.href.indexOf('video_series_list') != -1){
        var allRows = $('tr');
        //Add event listeners to rows
        for(var row=0; row <allRows.length; row++){
            allRows[row].addEventListener('click',this, false);
        }
    }
    setOrientation();

};
/*
$(document).ready(function(){
    $('#menu').addEventListener('click', function(e) {
             //e.preventDefault();
             alert('ok');
    });
});
*/
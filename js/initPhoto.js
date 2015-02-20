/*
window.onload = function(){

         $('#menuOverlay').addEventListener("touchmove", function(e) {  
	      e.preventDefault();
         }, false);
         setTimeout(function() { window.scrollTo(0, 1); }, 100);

	window.addEventListener('orientationchange', this, true);
        if(ua=="Android"){
             window.addEventListener('resize', function(){setOrientation();}, true);
        }
	window.allScrollers = new Array();
	window.sectionIndex = -1;
	window.sectionOffset = 0;
        window.ad = $('.ad1.marketingBrick');
        window.header = $('#header');
     if(!ua ||  deviceName=="GalaxyTab" || ua!= "Android"){ 
	document.body.addEventListener("touchmove", function(e) {
	  // This prevents native scrolling from happening.
	  e.preventDefault();
	}, false);
        if(document.getElementById('scroller')){
	    window.scrollviewer = new Scroller({
						id:"scroller",				//ID of the parent scroller
						axis: "y",				//Axis along which the parent ought to be scrollable
						pagination:false,			//Must be false for parent scroller
						linkingClass: null ,			//Must be null for parent scroller
						// stickyHeaders: 'sectionHeader', 	//Class name of the header elements that will stick to the top of the page.		
						stickyHeaders: null			//Class name of the header elements that will stick to the top of the page.		
											//Make this element null
						// feedUrl:'http://dev.etp.mtiny.com/xml/homefeed_HD.ftl'		//URL to XML feed of NewsItems
						});
       }else{
            window.scrollviewer = null;
       }
       if(deviceName=="GalaxyTab"){
          var s = window.innerHeight + "px";
          $("#container").style.height = s;
          $("#scroll-view").style.height = s;
          //alert(s);
       }
    }
    else{
       window.scrollviewer = null;
       var t = $(".sectionHeader")[0].offsetTop;
     //  $("#header").style.marginTop = t+"px";
       //console.log(t);
    }   
        if(document.getElementById('scroller')){   
	     window.news = new Scroller({
						id:"latest-news",
						axis: "x",				
						pagination:true,
				                footerBar:false,
						pageIndicator:false,
						articlesPerPage: 1,
						stickyHeaders: false,
						linkText:'All Latest News',
						articleClass: 'latestNewsArticle',
						linkingClass: null,
						snapToTop:true,
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
	if($('.ad1.marketingBrick') != null){
	  if((location.href.indexOf('photo.f') != -1) && $('.ad1.marketingBrick').offsetHeight > 0){
		// $('header.teflon').style.marginTop = $('.ad1.marketingBrick').offsetHeight+'px';
	  }
	}
	setOrientation();
}
*/

$(document).ready(function() {

var currentURL = document.URL;
var currentPath = location.pathname;

/* #### Photo Gallery placing nav bar position #### */

if (currentPath == "/photo.ftl") {     
    navBarSet();
}

function navBarSet() {
    var photoH = $('#gallery-photo').height() + 20;
    var navContainerH = $('#photoNav').height();
    var posTop =  (photoH / 2) - (navContainerH / 2);

    $('#photoNav').css('margin-top',posTop+'px');
}


if (currentPath == "/photo.ftl") {
    navBarSet();
    setInterval(function(){navBarSet()},1000);
}

});

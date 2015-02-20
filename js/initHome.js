window.onload = function(){
	
window.scrollTo(0, 1);
setTimeout(function() { window.scrollTo(0, 1); }, 100);


	window.addEventListener('orientationchange', this, true);
	
        if(ua=="Android"){
             window.addEventListener('resize', function(){setOrientation();}, true);
        }

	window.sectionIndex = -1;
	window.sectionOffset = 0;
      	//The allScrollers will contain every scroller that runs along the X-axis.
	window.allScrollers = new Array();
	var newsRows;
	if(navigator.userAgent.indexOf('iPad')!=-1){
	  newsRows = 2;
	}
	else{
	  newsRows = 1;
	}
	window.news = new Scroller({
						id:"latest-news",
						axis: "x",				
						pagination:true,
						pageIndicator:false,
						footerBar:true,
						linkingClass: null,
						stickyHeaders: false,
						snapToTop:true,
						linkText:'All Latest News',
						articleClass: 'latestNewsArticle',
						articlesPerPage: 1,
						rows:newsRows,
						columns:1,
						articleTitle: true,
						articleDesc: false,
						articleImage: true
				  });

	window.videos = new Scroller({
						id:"videos",
						axis: "x",
						pagination:true,
						pageIndicator:false,
						footerBar:true,
						stickyHeaders: false,
						linkText:'All Videos',
						articleClass: 'videoArticle',
						rows:1,
						articlesPerPage: 1,
						articleTitle: true,
						articleDesc: false,						
						articleImage: true
				  });

	window.photos = new Scroller({
						id:"photos",
						axis: "x",
						pagination:true,
						pageIndicator:false,
						footerBar:true,
						stickyHeaders: false,
						linkText:'All Photos',
						articleClass: 'photoArticle underside',
						rows:1,
						articlesPerPage: 1,
						articleTitle: true,
						articleDesc: false,
						articleImage: true
				  });
	window.shows = new Scroller({
						id:"shows",
						axis: "x",
						pagination:true,
						pageIndicator:false,
						footerBar:true,
						stickyHeaders: false,
						linkText:'All Shows',
						articleClass: 'showArticle underside',
						rows:1,
						articlesPerPage: 1,
						articleTitle: true,
						articleDesc: false,
						articleImage: true
				});

	window.kristin = new Scroller({
						id:"kristin",
						axis: "x",
						pagination:true,
						pageIndicator:false,
						footerBar:true,
						stickyHeaders: false,
						linkText:'All WWK',
						articleClass: 'kristinArticle',
						rows:1,
						articlesPerPage: 1,
						articleTitle: true,
						articleDesc: false,						
						articleImage: true
				  });
	
	window.awfulTruth = new Scroller({
						id:"awfulTruth",
						axis: "x",
						pagination:true,
						pageIndicator:false,
						footerBar:true,
						stickyHeaders: false,
						linkText:'All Awful Truth',
						articleClass: 'awfulTruthArticle',
						rows:1,
						articlesPerPage: 1,
						articleTitle: true,
						articleDesc: false,
						articleImage: true
					});
	
	
	
	window.more = new Scroller({
						id:"more",					//ID of section element that will contain a series of articles
						axis: "x",					//Axis along which the articles will scroll
						pagination:true,				//Should the section paginate and snap to bounds.
						pageIndicator:false,				//If pagination is enabled, should page indictors be made visible
						footerBar:false,					//If pagination is enabled, should the footer bar be made visible?
						articlesPerPage: 1,				//This value is only used if pagination and pageIndicator are set to true.						
						stickyHeaders: false,				//Must be false for sections that aren't the root element
						linkText:'All More',				//Text that will be visible in the linked, bubble in the section footer.
						articleClass: 'moreArticle underside',		//Class name which must be appended to each article in the section.  Underside class makes the text sit underneath the image.
						rows:1,						//Number of rows per section.  More modifications necessary if rows is to be more than 1.						
						articleTitle: true,				//Display article title?
						articleDesc: false,				//Display article text?						  
						articleImage: true				//Display article image?
					});
    if(!ua || deviceName=="GalaxyTab" || ua!= "Android" ) {
	document.body.addEventListener("touchmove", function(e) {
	  // This prevents native scrolling from happening.
	  e.preventDefault();
	}, false);
	window.scrollviewer = new Scroller({
						id:"scroller",			//ID of the parent scroller
						axis: "y",				//Axis along which the parent ought to be scrollable
						pagination:false,			//Must be false for parent scroller
						linkingClass: null ,			//Must be null for parent scroller
						//stickyHeaders: "sectionHeader",	//Class name of the header elements that will stick to the top of the page
						feedUrl:'http://dev.etp.mtiny.com/xml/homefeed_HD.ftl'		//URL to XML feed of NewsItems
						});
		window.scrollTo(0,1);
      if(deviceName=="GalaxyTab"){
          var s = window.innerHeight + "px";
          $("#container").style.height = s;
          $("#scroll-view").style.height = s;
       }
}
    else{
       window.scrollviewer = null;
       var t = $(".sectionHeader")[0].offsetTop;
       $("#header").style.marginTop = t+"px";
       //console.log(t);
    }


 $('#menu').style.height = window.innerHeight + "px";
	window.body= $('body');
	window.menu = $('#menu');
	$('#headerMenuButton').addEventListener('click',this, false);
	setOrientation();
        preload_image = new Image(750,375); 
        preload_image.src="/images/menu_sprite2.png"; 


if(readCookie('firstVisit') == null && window.location.href.indexOf("via_bookmark") == -1 && ua == "iphone"){
    if(window.location.href.indexOf(".ftl") != -1){
        window.location = window.location + "?via_bookmark=true";
    }
    else{
        window.location = window.location + "index.ftl?via_bookmark=true";
    }
}

if(readCookie('firstVisit') == null && window.location.href.indexOf("via_bookmark") != -1 && ua == "iphone"){
    createCookie('firstVisit', 'done', 365);
    promptHomeScreen();


}


}
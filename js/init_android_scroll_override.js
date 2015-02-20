var ua;
var TOUCHSTART;
var TOUCHMOVE;
var TOUCHEND;
var articlesPerRow=2;
var myOrientation;
var deviceName;

if((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i))) {
  ua = "iphone";
}
else if(navigator.userAgent.match(/iPad/i)){
  ua = "ipad"
}
else if(navigator.userAgent.match(/SGH\s*-\s*I987/i) || navigator.userAgent.match(/SCH\s*-\s*I800/i)){
   ua="Android";
   deviceName = "GalaxyTab";
}
else if(navigator.userAgent.match(/Android/i)){
   ua="Android";
}
    
switch(ua){
  case undefined:
	TOUCHSTART = "mousedown";
	TOUCHMOVE = "mousemove";
	TOUCHEND = "mouseup";
	break;
  default:
	TOUCHSTART = "touchstart";
	TOUCHMOVE = "touchmove";
	TOUCHEND = "touchend";
	break;
}
function refreshMenu(){
    $('#buttonContainer').style.display = "block";
    $('#secondButtonContainer').style.display = "none";    
    $('#closeButton2').removeEventListener('click', this, true);
    $('#menuMenuButton').removeEventListener('click', this, true);
}
function showSecondContainer(){
    $('#buttonContainer').style.display = "none";
    $('#secondButtonContainer').style.display = "block";
    $('#closeButton2').addEventListener('click', this, true);
    $('#menuMenuButton').addEventListener('click', this, true);
}
function returnToOriginalMenu(){
    $('#closeButton2').removeEventListener('click', this, true);
    $('#buttonContainer').style.display = "block";
    $('#secondButtonContainer').style.display = "none";
}
function toggleMenu(){
        window.scrollTo(0,1);
	var menu = $('#menu');
	var closeButton = $('#closeButton1');
	var shareButton = $('#shareButton');
	var menuOverlay = $('#menuOverlay');
	var buttonContainer = $('#buttonContainer');
	if(menu.hasClass('on')){
		menu.toggleClass('on');
		closeButton.removeEventListener('click', this, true);
		menuOverlay.removeEventListener('click', this, true);
		shareButton.removeEventListener('click', this, true);
		return 'menu off';
	}
	else{
		menu.toggleClass('on');
		shareButton.addEventListener('click', this, true);
		closeButton.addEventListener('click', this, true);
		menuOverlay.addEventListener('click', this, true);
		return 'menu on';
	}	
       window.scrollTo(0,1);
}

function setOrientation(){
    window.scrollTo(0,1);
    if(menu.hasClass('on')){
        toggleMenu();
        setTimeout(function(){toggleMenu();},10);
    }
     // if(deviceName=="GalaxyTab" && ua != 'Android'){
          var s = window.innerHeight + "px";
          $("#container").style.height = s;
          $("#scroll-view").style.height = s;
     // }
    for(var i=0; i < allScrollers.length; i++){
      allScrollers[i].setWidth();

      if(allScrollers[i].pageIndicators && (allScrollers[i].elm.children.length !=0)){
        allScrollers[i].calculateArticlesPerWindow();
	allScrollers[i].updatePageIndicators();
      }
    }
    if(window.location.pathname.indexOf('/shows/')==-1){
        var t = $(".sectionHeader")[0].offsetTop;
        $("#header").style.marginTop = t+"px";
    }
    else if($('.marketingBrick')){
        var t = $(".sectionHeader")[0].offsetTop;
        $('#header').style.cssText = "position:absolute;top:"+t+"px;right:10px;";
    }
    else{
        var t = $(".sectionHeader")[0].offsetTop;
        $("#header").style.marginTop = t+"px";
    }
    window.scrollTo(0,1);
}


handleEvent = function(e){
	//console.log('handle event ' + e.type + ', target id: ' + e.target.id + ' hasClass: ' +e.target.className);
	if(e.type == 'orientationchange'){
        console.log("we be orienting")
	    var s = window.innerHeight + "px";
	    //$("#container").style.height = s;
	    setOrientation();
	}
	else if(e.target.id == 'headerMenuButton'){
		toggleMenu();
	}
	else if(e.target.hasClass('share-button')){
	    showSecondContainer();
	}
	else if(e.target.id == 'homeShareButton'){
	    toggleMenu();
	    showSecondContainer();
	}
	else if(e.target.id == 'menuOverlay' || e.target.id =='closeButton1' || e.target.id =='closeButton2'){
	    toggleMenu();
	    refreshMenu();
	}
	else if(e.target.id == 'menuMenuButton'){
	    returnToOriginalMenu();
	}
	else if(e.target.hasClass('tableRow')){
	      //alert('hit button');
	}
}

function $(query){
  if(document.querySelectorAll(query).length> 1)
	return document.querySelectorAll(query);
  else
	return document.querySelector(query);
}
Element.prototype.hasClass = function(c){
  el = this.className;
  var p = new RegExp("\\b"+c+"\\b")

  if(p.test(el)){
	return true;
  }
  else{
	return false;
  }
}
Element.prototype.addClass = function(c){
  if(!this.hasClass(c)){
	var space = null;
	if(this.className=="")
	  space = "";
	else
	  space = " ";
	this.className += space+c;
	return true;
  }
}
Element.prototype.removeClass = function(c){
  if (this.hasClass(c)){
	var p = new RegExp("\\b"+c+"\\b", "g")
	var el = this.className;
	var newc = el.replace(p,"");
	this.className = newc;
	return true;
  }
}
Element.prototype.toggleClass = function(c){
  if(this.hasClass(c))
	this.removeClass(c);
  else
	this.addClass(c);
}
Object.prototype.nextObject = function() {
	var n = this;
	do n = n.nextSibling;
	while (n && n.nodeType != 1);
	return n;
}

Object.prototype.previousObject = function() {
	var p = this;
	do p = p.previousSibling;
	while (p && p.nodeType != 1);
	return p;
}

NewsItem = function(id, title, franchise, imgUrl, url, sectionName, sectionUrl, updated){
	this.id = id;
	this.title = title;
	this.imgUrl = imgUrl;
	this.franchise = franchise;
	this.imgUrl = imgUrl;
	this.url  = url;
	this.sectionUrl = sectionUrl;
	this.sectionName = sectionName;
	this.updated = updated;
}
String.prototype.truncate = function(n){
     return this.substr(0,n-1)+(this.length>n?'...':'');
 };
 
Scroller = function(options) {
	this.options = options;
	this.pageview = false;
	this.ignoreTouch = true;
	this.elm = $("#"+this.options.id);
        this.pages = this.elm.children;
	if(options.axis=='x'){
	  window.allScrollers.push(this);
	}
	if(!this.options.feedUrl){
	  window.sectionIndex++;
	  this.sectionIndex = window.sectionIndex;
	// console.log(window.sectionIndex)
	}


	if(options.pagination)
	      this.pageview = true;
	if(this.options.columns){
	  this.pageViewerOffset = this.options.columns;
	  this.columnsCheck = this.options.columns;
	}
	else{
	  this.columnsCheck=1;
	  this.pageViewerOffset = options.articlesPerPage;
	}
	
	if (this.options.stickyHeaders){
	  this.headers = $("."+this.options.stickyHeaders);
	  this.headerLength = this.headers.length;
	  this.lastHeader = null;
	  this.marketing = $(".marketingBrick");
	}
	else{
	  if(this.options.axis == 'y'){
	    $('#header').addClass('teflon');
	  }
	}
	if(this.options.linkText){
		this.linkText = this.options.linkText;
	}
	this.snapToTop = options.snapToTop;
	this.startTouch = 0;
	this.animateTo(0);  
	this.itemTap = false;
	if (this.options.feedUrl && this.options.feedUrl != "") {
		//this.myXml = this.getXml(this.options.feedUrl);
	}
	document.addEventListener(TOUCHSTART, this, true);
	document.addEventListener(TOUCHMOVE, this, true);
	document.addEventListener(TOUCHEND, this, true);
	
	document.getElementById("eventCatcher").addEventListener("load", this, false);
	
	switch(this.options.axis){
	  case "x":
		this.axis = 0;
		this.maxOffset = (this.elm.parentNode.offsetWidth-this.elm.offsetWidth)
		break;
	  case "y":
		this.axis = 1;
		this.maxOffset = (this.elm.parentNode.offsetHeight-this.elm.offsetHeight)
	//	console.log('parent'+ this.elm.parentNode.offsetHeight +'numberL: '  +this.elm.offsetHeight);
		break;
	}
	if($('.'+this.options.id + ' ol.navList') && (this.elm.children.length!=0)){
          this.pageIndicators = true;
	  this.updatePageIndicators();
	}
	else{
	  this.pageIndicators = false;
	}
	
}
Scroller.prototype.setWidth = function(){
  var pages = this.elm.children;
  var pageviewWidth;
  var qRes = $('body article.underside');
  if(qRes && this.options.articleClass.indexOf('underside')!=-1){
    pageviewWidth = qRes[0].offsetWidth * (this.elm.children.length / this.options.rows);
  }
  else{
      qRes = $('body article');
      if(qRes){
	  	pageviewWidth = $('body article')[0].offsetWidth * (this.elm.children.length / this.options.rows);  
      }
  }  
  this.elm.style.width = (this.options.rows* pageviewWidth)+"px";

}
Scroller.prototype.calculateArticlesPerWindow = function(){

   if(this.elm.children.length!=0){
        var width = this.elm.children[0].offsetWidth;
        var screenSpace = window.innerWidth;
         this.articlesPerWindow = 0;
         while(screenSpace > width){
	        this.articlesPerWindow++;
          	screenSpace -= width;
        }
    }
}

Scroller.prototype.updatePageIndicators = function(){
  var pageList = $('.'+this.options.id + ' ol.navList');
  if(!this.articlesPerWindow && this.pageIndicators){
     this.calculateArticlesPerWindow();
  }
  if(pageList){    
    for(var i=0; i< pageList.children.length; i++){
      pageList.children[i].className = "";      
    }
    var workingIndex = Math.round(Math.abs(this.contentOffset)/this.elm.children[0].offsetWidth);
    var articlesToGo = this.articlesPerWindow;
    while(articlesToGo != 0 && pageList.children[workingIndex]){
      pageList.children[workingIndex++].className = "current";
      articlesToGo--;
    }
  }
}

Scroller.prototype.handleEvent = function(e) {
  switch (e.type) {
	case TOUCHSTART:
	  this.onTouchStart(e);
	  break;
	case TOUCHMOVE:
          if(ua=='Android' && window.menu.hasClass('on')){
               e.preventDefault();
               e.stopPropagation();
          }
          else{
	       this.onTouchMove(e);
          }
	  break;
	case TOUCHEND:
	  this.onTouchEnd(e);
	  break;
	case "mouseout":
	  this.onClickEnd(e);
	  break;
	case "webkitTransitionEnd":
	  this.onWebkitTransitionEnd(e);
	  break;
  }
}
Scroller.prototype.onTouchStart = function(e) {
    var st = new Date().getTime();
    
	if(ua != undefined)
	  this.startTouch = [e.touches[0].pageX, e.touches[0].pageY];
	else
	  this.startTouch = [e.pageX, e.pageY]
  	this.startEvent = e;
	this.itemTap = false;
  	if(this.overElm(this.startTouch) && !window.menu.hasClass('on') ){
		this.ignoreTouch = false;
		this.timeItTook = false;
		this.timer();
		this.stopMomentum();
		this.contentStartOffset = this.contentOffset;
		this.time = new Date().getTime();
		this.elm.style.webkitTransition = "";
		this.movement = null;
	}	
	else{
	      this.ignoreTouch = true;
	}
        //console.log('touch start time:' + st - new Date().getTime())
}
Scroller.prototype.onTouchMove = function(e) {
    var st = new Date().getTime();
  if(!this.ignoreTouch){
	this.movement = true;
	this.oldTime = this.time;
	this.time = new Date().getTime();
	this.deltaTime = this.time-this.oldTime;
	this.oldOffset = this.current;
	if(ua != undefined)
	  this.current = [e.targetTouches[0].pageX, e.targetTouches[0].pageY];
	else
	  this.current = [e.pageX,e.pageY];
	var delta = this.current[this.axis] - this.startTouch[this.axis];
	this.newOffset = delta + this.contentStartOffset;
	this.animateTo(this.newOffset);
  }
  //console.log(st - new Date().getTime())
}
Scroller.prototype.onTouchEnd = function(e) {

	if(ua != undefined)
	  et = e.changedTouches[0];
	else
	  et = e;	  

	if((e.currentTarget.id  == this.startEvent.target.id) &&  (typeof e.currentTarget.id != 'undefined')){
		//Check to determine if the displacement of the tap was little enough to qualify as a selection
		
		if ((Math.abs(et.pageX - this.startTouch[0]) < 5) && (Math.abs(et.pageY - this.startTouch[1]) < 5)) {
			this.itemTap = true;
			this.selectItem('#'+this.startEvent.target.id);
    
		}
		else{
			this.itemTap = false;
		}
	}
	else{
		this.itemTap=false;
	}
	if(!this.ignoreTouch){
		this.ignoreTouch = true;
		this.endOffset = [et.pageX, et.pageY];
		if(this.detectTapOnArticle(e)){
		  this.openArticle(e);
		}
		else{
		  //console.log('doMomentum or Snap, isDragging:'+this.isDragging() + 'pageview:'+this.pageview);
		  if (!this.isDragging() && !this.pageview) {
                    
			this.doMomentum();
		  }
		  else {
			this.snapToBounds();
		  }
		}
		clearInterval(this.startTimer);	
				 
	}
}
Scroller.prototype.detectTapOnArticle = function(e){
  if(((Math.abs(this.startTouch[0] -this.endOffset[0])<5) && (Math.abs(this.startTouch[1]-this.endOffset[1])<5)) && (e.target.hasClass(this.options.articleClass) || e.target.parentNode.hasClass(this.options.articleClass))){
	return true;
  }
  else{
	return false;
  }
}
Scroller.prototype.openArticle = function(e){
  var c = null;
  if(e.target.hasClass(this.options.articleClass) ){
	c = e.target.children
  }
  else if(e.target.parentNode.hasClass(this.options.articleClass)){
	c = e.target.parentNode.children
  }
  cl = c.length
  for (var i=0; i < cl; i++){
	      
	      if (c[i].hasClass("arrow") || c[i].hasClass("undersideLink")) {
		      window.location =  c[i].href;
		      break;
	      }
      }
}
Scroller.prototype.overElm = function(finger){
	var bounds={};
	
	if(ua=='iphone'){
	      var webkitPoint = window.webkitConvertPointFromNodeToPage(this.elm, new WebKitPoint(0,0));
	      bounds.top = webkitPoint.y;
	      bounds.left = webkitPoint.x;
	      bounds.bottom = webkitPoint.y + this.elm.offsetHeight;
	      bounds.right = webkitPoint.x + this.elm.offsetWidth;
           }
	else{
	   bounds = this.elm.getBoundingClientRect();
	 }

	if(window.scrollviewer == null){
		var s = document.body.scrollTop;
		if ((finger[1]-s) < bounds.bottom && (finger[1]-s) > bounds.top && finger[0] > bounds.left && finger[0] < bounds.right){
			  //console.log(this.elm)
			  return true;
			}
			else
			  return false;
	}
	else{
		if (finger[1] < bounds.bottom && finger[1] > bounds.top && finger[0] > bounds.left && finger[0] < bounds.right){
		  //console.log(this.elm)
         // alert("overelm")
		  return true;
		}
		else
		  return false;
	}
}
Scroller.prototype.selectItem = function(itemToSelect){	
	var item = $(itemToSelect);
	this.elm.style.webkitTransition ='-webkit-transform 200ms cubic-bezier(0.33, 0.66, 0.66, 1)';
	this.animateTo(item.offsetLeft*-1);
	
	//console.log('item:'+itemToSelect);
	if($('.highlight')){
		$('.highlight').removeClass("highlight");
	}
	setTimeout(function(){
		item.addClass("highlight");}, 1);
}
Scroller.prototype.animateTo = function(y) {

  this.contentOffset = y;
  offset=y;
  if(this.axis == 0){
    this.elm.style.webkitTransform = 'translate3d(' + y + 'px, 0, 0)';
	var scrollDir = this.scrollDirection();
	if(scrollDir=="left"||scrollDir=="right"){
		if(window.scrollviewer != null)
			window.scrollviewer.ignoreTouch = true;
	}
	else{
	  this.ignoreTouch=true;
	}
  }
  else{
	if (!this.headerBanner){
	  this.headerBanner=document.querySelector("#header");
	}
	y = -y;
	var dy = 0;
	var d  = null;
	var el = null;
	var mh = null;
	var mo = null;
	var mhb= null;
	/*for(i = 0; i < this.headerLength; i++){
	  
	  el = this.headers[i];
	  
	  if(el.previousObject().hasClass("marketingBrick")){
	    
		var mb = el.previousObject();
		mh = mb.offsetHeight;
		mhb = mh;
		if (!mb.hasClass("sticky"))
		  mhb = mhb;
	  }
	  else{
	    
		mh = 0;
	  }
	  var ot = el.offsetTop - mh;
	  if(y >= ot)
	  {
		d  = el;
		dy = ot;
		mo = mh;
		me = mb;
		if(!d.previousObject().hasClass("marketingBrick")){
		  mo=0;
		  hy = d.offsetTop;
		}
		else{
		  hy = d.offsetTop;
		}
	  }
	  else if(d){
		nextHeader = this.headers[i];
		if(mhb)
			mo=mhb;
		break;
	  }
	}*/
	/*if (d)
	{
	  var h = d.offsetHeight;
	  if(!mo || (!d.previousObject().hasClass("marketingBrick") && !el.previousObject().hasClass("marketingBrick"))){
		mo=0;
		//hy = 0;
	  }
	  else if(!me.hasClass("sticky")){
		mo = offset+mo;
	  }
	  if (mo<=0){
		oldmo = mo;
		mo = 0;
	  }
	  
	  var mxy = (d != el) ? el.offsetTop - mo : (this.elm.offsetHeight);
	  var c = false;
	  
	  if (y + h >= mxy){
		y = (mxy - h) - dy;
		hy = y +mo;
	  
		if(-offset>= nextHeader.offsetTop - el.offsetHeight){
		  hy =  -offset;
		  c = true;
		}
	  }
	  else{
		y = y - dy;
		//console.log('y-2:'+y);
		if(mb && mb.hasClass("sticky") || (this.lastHeader && this.lastHeader.previousObject().hasClass("marketingBrick") && this.lastHeader.previousObject().hasClass("sticky"))){
		  hy = -offset+mo;
		}
		else if(mb && !mb.hasClass("sticky")|| (this.lastHeader && this.lastHeader.previousObject().hasClass("marketingBrick") && !this.lastHeader.previousObject().hasClass("sticky"))){
		  hy = -offset+mo;
		}
		else{
		  hy = -offset;
		}
	  }
	  var lh = this.lastHeader;
	  var lm = this.lastMhead;
	  if (lh && d != lh) {
		  this.headerBanner.style.webkitTransform = 'translate3d(0,'+y+'px, 0)';
		  lh.style.webkitTransform = "translate3d(0, 0,0)";
	  }
	  if (lm && me!=lm){
 		this.headerBanner.style.webkitTransform = 'translate3d(0,'+y+'px, 0)';
		lm.style.webkitTransform = "translate3d(0, 0,0)";
	  }
	  this.headerBanner.style.webkitTransform = 'translate3d(0,'+hy+'px, 0)';
	  if(me && me.hasClass("sticky")){
		me.style.webkitTransform = 'translate3d(0,'+y+'px, 0)';
	  }
	  if (lh && d == lh && this.lastHeader.previousObject().hasClass("marketingBrick") && !this.lastHeader.previousObject().hasClass("sticky")){
		if(y!=hy && !c){
		  y = -y-offset
		}
		else if(c){
		  if(el.hasClass('second')){
		    y=y-el.offsetHeight-15;
		  }
		  else{
		    y=y-el.offsetHeight-3;
		  }		  
		}
		else{
		  y = -oldmo
		}
	  }

	  d.style.webkitTransform = 'translate3d( 0, '+y+'px,0)';
	  
	  this.lastHeader = d;
	  this.lastMhead = me;
	}*/
	 this.elm.style.webkitTransform = 'translate3d(0, ' + offset + 'px, 0)';
  }
}
Scroller.prototype.scrollDirection = function(){
	if(this.current){
		var dX = this.current[0] - this.startTouch[0];
		var xDir = null;
		if (dX > 0) 
			xDir = "right";
		else 
			if (dX < 0) 
				xDir = "left";
			else 
				xDir = "nochange"
		var dY = this.current[1] - this.startTouch[1];
		var yDir = null;
		if (dY > 0) 
			yDir = "down";
		else 
			if (dY < 0) 
				yDir = "up";
			else 
				yDir = "nochange"
		
		if (Math.abs(dX) > Math.abs(dY)) 
			scrollDir = xDir;
		else 
			if (Math.abs(dX) < Math.abs(dY)) 
				scrollDir = yDir;
			else 
				scrollDir = "equal";

		return scrollDir;
	}
	return 'nochange';	
}

Scroller.prototype.snapToBounds = function() {
	this.transition = '-webkit-transform 200ms cubic-bezier(0.33, 0.66, 0.66, 1)';
	var scrollDir = this.scrollDirection();
	if(this.axis==1)
	  this.maxOffset = (this.elm.parentNode.offsetHeight-this.elm.offsetHeight)
	else
	  this.maxOffset = (this.elm.parentNode.offsetWidth-this.elm.offsetWidth)
	
        if(this.maxOffset>0)
        this.maxOffset = 0;

	if (this.pageview && !this.itemTap){
	  
	  var snap = false;
	  if(Math.abs(this.startTouch[0]-this.endOffset[0]) >= (this.elm.offsetParent.offsetWidth/4)){
		snap = true;
	  }
	  if (scrollDir=="left"){
		this.leftOffset = this.elm.offsetParent.offsetWidth-(this.elm.offsetParent.offsetWidth/4);
	  }
	  else if(scrollDir == "right"){
		this.leftOffset = this.elm.offsetParent.offsetWidth-(this.elm.offsetParent.offsetWidth/1.25);
	  }
	  else
		this.leftOffset = this.elm.offsetParent.offsetWidth-(this.elm.offsetParent.offsetWidth/3);

	  if(this.options.rows > 1){
	    this.pages = $('.myColumn');
	  }

	  for(i=0; i<this.pages.length; i++){
		  //this.pages are all children of scroll view
		  var p = this.pages[i];
		  var pb={};
                  if(ua=='iphone'){
		        var webkitPoint = window.webkitConvertPointFromNodeToPage(this.pages[i], new WebKitPoint(0,0));
			pb.top = webkitPoint.y;
			pb.left = webkitPoint.x;
			pb.bottom = webkitPoint.y + this.pages[i].offsetHeight;
			pb.right = webkitPoint.x + this.pages[i].offsetWidth;
		  }
		  else{
		     pb = p.getBoundingClientRect();
		   }
		  
             
		  //console.log("bounding rect:" + pb.left + ', offsetLeft:'+p.offsetLeft);
		  if(i % this.columnsCheck== 0 && i % this.options.articlesPerPage == 0){
		    
		      var q = "."+this.options.id+" .navList .current";
		      if (pb.left>this.elm.offsetParent.offsetLeft && pb.left < this.leftOffset ){
			
			    this.currentPage = p;
			    var o = p.offsetLeft - 1;
			    o = -o;
			    
			    this.elm.style.webkitTransition = this.transition;
			    if (window.scrollviewer != null)
			    	window.scrollviewer.elm.style.webkitTransition = this.transition;
			    
			    //console.log('o:'+o+', contentoffset:'+ this.contentOffset + ' maxOffset:'+this.maxOffset);
			    if(o < this.maxOffset){
				//console.log('1a.1');
				if(o==1 || ((this.maxOffset==this.contentOffset) && this.contentOffset > 0) || (this.contentOffset==0 && this.maxOffset > 0)){
				  this.animateTo(0);
				}				
				else{
				  this.animateTo(this.maxOffset);
				}
			    }
			    else{
			      //console.log('1a.2');
			      this.animateTo(o);
			      this.currentOffset = o;
			    }
			    
			    
			    if(this.options.pageIndicator){
			        $(q).removeClass("current");
			        this.navList[Math.ceil(i/(this.columnsCheck*this.options.articlesPerPage))].addClass("current");
			    }
			    if (scrollDir != "up" && scrollDir != "down" && this.snapToTop && window.scrollviewer != null)
			      window.scrollviewer.animateTo(0);
			
			    this.currentPageIndex = i;			    
			    break;
		      }		      
		      else if(pb.left>this.elm.offsetParent.offsetLeft && pb.left > this.leftOffset ){
			if(this.options.pageIndicator)			
			  $(q).removeClass("current");			  
			  
			    if (i>0){
				//console.log('2a');
				
				  var prevPage = i-this.pageViewerOffset;
				  o = this.pages[prevPage].offsetLeft;
				  if(this.options.pageIndicator)	
				   this.navList[Math.ceil(prevPage/this.options.articlesPerPage)].addClass("current");
			    }
			    else{
				//console.log('2b');
				if(this.options.pageIndicator)	
				    this.navList[Math.ceil(i/(this.columnsCheck*this.options.articlesPerPage))].addClass("current");
				  var prevPage = 0;
				  o = 0;
			    }
			    o = -o
			    
			    this.elm.style.webkitTransition = this.transition;
			    if(window.scrollviewer != null)
			    	window.scrollviewer.elm.style.webkitTransition = this.transition;
			    var q = "."+this.options.id+" .navList .current";
	
			    
			    
			    if (scrollDir != "up" && scrollDir != "down" && this.snapToTop && window.scrollviewer!=null)
			    window.scrollviewer.animateTo(0);
			    
			    this.animateTo(o);		    
			    break;
		      }
		      else if (this.contentOffset < this.maxOffset){
			this.elm.style.webkitTransition = this.transition;
			if((this.contentOffset <= 0 && this.maxOffset >0) || ((this.contentOffset == this.maxOffset) && this.maxOffset > 0)){
			  this.animateTo(0);
			}		
			else{
			  this.animateTo(this.maxOffset);
			}
		      }
		}
	    }
	}
	else if (this.contentOffset < this.maxOffset){
	    if((this.maxOffset > 0 && this.contentOffset < 0) ){ //|| (Math.abs(this.maxOffset) > window.innerHeight)
	      this.elm.style.webkitTransition = this.transition;
	      this.animateTo(0);
          //alert("snap");
	    }	
	    else{	      
		this.elm.style.webkitTransition = this.transition;
		this.animateTo(this.maxOffset);
	    }
	}
	else if(this.contentOffset>0){
		this.elm.style.webkitTransition = this.transition;
		this.animateTo(0);
	}
	if((scrollDir == 'left' || scrollDir == 'right') && this.pageIndicators && (this.elm.children.length!=0)){
	  this.updatePageIndicators();
	}
}

Scroller.prototype.timer = function(){	
	if (!self.timeItTook){
		self.timeItTook = 10;
		self.startTimer = setInterval(self.timer ,1);
	}
	else{
		self.timeItTook += 1;		
	}
}
Scroller.prototype.isDragging = function() {
  if(this.endOffset && this.oldOffset)
    this.vel = (this.endOffset[this.axis] - this.oldOffset[this.axis]) / this.deltaTime;
   //console.log('check is dragging, vel:'+this.vel)
  if(Math.abs(this.vel) > 0.5 && this.movement){  	
	return false;
  }
  else{
	return true;
  } 	
}
Scroller.prototype.shouldStartMomentum = function() {
  return true;
}
Scroller.prototype.getEndVelocity = function(){
	this.displacement = (this.current[this.axis] - this.startTouch[this.axis]) ;
	var v = this.displacement/ (this.timeItTook);
	return this.vel;
	
}
Scroller.prototype.doMomentum = function() {
    
    var self = this;
    if(this.axis==1)
      this.maxOffset = (this.elm.parentNode.offsetHeight-this.elm.offsetHeight);
    else
      this.maxOffset = (this.elm.parentNode.offsetWidth-this.elm.offsetWidth);
      
    if(this.maxOffset>0)
        this.maxOffset = 0;
   
    var velocity = this.getEndVelocity();
    var acceleration = velocity < 0 ? .005 : -.005;
    var displacement = - (velocity * velocity) / (20 * acceleration);
    var time = - ((velocity / acceleration));
    var newoffset = this.contentOffset + displacement;

    if (newoffset < this.maxOffset ){
      newoffset = this.maxOffset;
      this.elm.style.webkitTransition = '-webkit-transform 300ms ease-out';//cubic-bezier(0.33, 0.66, 0.66, 1)';
      console.log('do momentum1')
  
    }
    else if(newoffset >= 0 || this.maxOffset == 0){ //|| (newoffset < this.maxOffset && Math.abs(this.maxOffset) < window.innerHeight)
        this.elm.style.webkitTransition = '-webkit-transform 300ms ease-out';//cubic-bezier(0.33, 0.66, 0.66, 1)';  
        newoffset = 0;
        console.log('do momentum2')
    }
    else{
        time=time/3;
      this.elm.style.webkitTransition = '-webkit-transform '+time+'ms ease-out';//cubic-bezier(0.33, 0.66, 0.66, 1)';
      console.log('do momentum, time:'+time)
    }
    this.animateTo(newoffset);
    this.contentOffset = newoffset;
}

Scroller.prototype.anim=function(y){
  this.newspot += y;
  if(Math.abs(this.newspot)>=Math.abs(this.nextOffset)){
	this.newspot = null;
	clearInterval(this.animateTimer)
  }
  else{
	this.animateTo(this.newspot);
  }
}
Scroller.prototype.stopMomentum = function() {
	if (this.isDecelerating()) {
	  var style = document.defaultView.getComputedStyle(this.elm, null);
	  var transform = new WebKitCSSMatrix(style.webkitTransform);
	  this.elm.style.webkitTransition = '';
	  this.animateTo(transform.m42);
	}
}
Scroller.prototype.isDecelerating = function(){
}
function promptHomeScreen(){
  var h = '<div id="promptHomeScreen"> <div class="logo"></div><p>Install this web app on your phone: tap on the arrow and then <b>\'Add to Home Screen.\'</b></p><div class="arrow-down"></div><div class="arrow-down" style="  border-top: 20px solid #c2c2c2; bottom: -17px;"></div><div id="closeModal">x</div></div>';
  $("#promptHomeScreen").style.opacity = 1;
   $("#promptHomeScreen").style.bottom = "20px";
  //$("body").innerHTML += h; 
  
}
function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}
function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}
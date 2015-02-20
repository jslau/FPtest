var ua;
var TOUCHSTART;
var TOUCHMOVE;
var TOUCHEND;

if((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i))) {
  ua = "iphone";
}
else if(navigator.userAgent.match(/iPad/i)){
  ua = "ipad"
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
function toggleMenu(){
	var menu = $('#menu');
	if(menu.style.opacity==1){
		menu.style.opacity=0;
		menu.removeEventListener(TOUCHSTART, this, true);
		menu.removeEventListener(TOUCHEND, this, true);		
		return 'menu off'
	}
	else{
		menu.style.opacity=1;
		menu.addEventListener(TOUCHSTART, this, true);
		menu.addEventListener(TOUCHEND, this, true);
		return 'menu on'
	}	
}
handleEvent = function(e){
	console.log('overlay id:'+e.target.id);
	if(e.target.className != 'shareButton' && e.target.className != 'closeButton'){
		toggleMenu();
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
	this.className += " "+c;
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

NewsItem = function(title, imgUrl, shortDesc){
	this.title = title;
	this.imgUrl = imgUrl;
	this.shortDesc = shortDesc;
	var dimensions = '128/128';
	this.smallUrl =  imgUrl.replace(/300\/300/g, dimensions);
}

Scroller = function(options) {	
	this.options = options;
	this.pageview = false;
	this.ignoreTouch = true;
	this.elm = $("#"+this.options.id);
	if(this.options.linkingClass != null){
		this.addEventListenersToRow(this.options.linkingClass);
	}
	this.storyArray=[];
	if(options.pagination)
		this.pageview = true;
	
	if (this.options.stickyHeaders){
	  this.headers = $("."+this.options.stickyHeaders);
	  this.headerLength = this.headers.length;
	  this.lastHeader = null;
	  this.marketing = $(".marketingBrick");
	}
	if(this.options.linkText){
		this.linkText = this.options.linkText;
	}
	this.snapToTop = options.snapToTop;
	this.startTouch = 0;
	this.animateTo(0);  
	this.itemTap = false;
	if (this.options.parse) {
		this.myXml = this.getXml('http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=1');
		this.parseXml(this.myXml);
	}
	
	document.addEventListener(TOUCHSTART, this, true);
	document.addEventListener(TOUCHMOVE, this, true);
	document.addEventListener(TOUCHEND, this, true);
	
	if(this.pageview){
	  this.setPageViewer();
	}
	else{
	switch(this.options.axis){
	  case "x":
		this.axis = 0;
		this.maxOffset = (this.elm.parentNode.offsetWidth-this.elm.offsetWidth)
		break;
	  case "y":
		this.axis = 1;
		this.maxOffset = (this.elm.parentNode.offsetHeight-this.elm.offsetHeight)
		console.log('parent'+ this.elm.parentNode.offsetHeight +'numberL: '  +this.elm.offsetHeight);
		break;
	}
	}
}
Scroller.prototype.getXml = function(url){
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	xmlhttp.open("GET",url,false);
	xmlhttp.send();
	xmlDoc=xmlhttp.responseXML;
	return xmlDoc;
}
Scroller.prototype.parseXml = function(xml){
	var item;	
	var allItems = xml.getElementsByTagName("item");	
	this.allItems = allItems;
	for(var i =0; i< allItems.length; i++){
		var title = allItems[i].getElementsByTagName("title")[0].textContent;
		var imgUrl = allItems[i].getElementsByTagName("imgurl")[0].textContent;
		var shortDesc = allItems[i].getElementsByTagName("shortdesc")[0].textContent;
		var newsItem = new NewsItem(title, imgUrl, shortDesc);
		this.storyArray[i] = newsItem;
	}
	this.injectContent(5,2, 'newsArticle');
}

Scroller.prototype.injectContent = function(pages, articlesPerPage, className){
	var parent = $('#latest-news');
	for(var i=1;i<=pages;i++){
		var section = document.createElement('section');
		section.setAttribute('class', 'page page'+i);
		parent.appendChild(section);		
		for(var j=1;j<=articlesPerPage;j++){
			var articleIndex = (((i-1)*articlesPerPage)+j);
			
			var article = document.createElement('article');
			article.setAttribute('class', className);
			article.setAttribute('id', className+j);
		
			var image = document.createElement('img');
			image.setAttribute('src', this.storyArray[articleIndex].imgUrl);
			image.setAttribute('height', 128);
			image.setAttribute('width', 128);
			article.appendChild(image);
			
			var header = document.createElement('h6');
			header.innerHTML = this.storyArray[articleIndex].title;
			article.appendChild(header);
			
			section.appendChild(article);
		}
	}
}

Scroller.prototype.setPageViewer = function(){
	this.axis = 0;

  	this.pages = this.elm.children;
	this.pagesLength = this.pages.length;
	var pageviewWidth = this.pages.length*this.pages[0].offsetWidth;
	this.elm.style.width = pageviewWidth+"px";
	this.currentPage = this.pages[0];
	
	this.pageNav = document.createElement("div");
	this.pageNav.addClass("sectionNavi");
	this.pageNav.addClass(this.options.id);
	this.pageNav.innerHTML = '<ol class="navList"></ol>';
	this.pageNav.innerHTML += '<div class="floatingLink ' + this.options.id + '" >'+this.linkText+'</div>'
	
	for(i=0;i<this.pagesLength;i++){
	  this.pageNav.children[0].innerHTML += "<li></li>";
	}
		
	this.elm.parentNode.insertBefore(this.pageNav,this.elm.nextSibling)
	
	this.navList = document.querySelectorAll("."+this.options.id+" .navList li");
	
	this.navList[0].addClass("current");
	
	this.maxOffset = (this.elm.parentNode.offsetWidth-this.elm.offsetWidth)
}
Scroller.prototype.handleEvent = function(e) {
  switch (e.type) {
	case TOUCHSTART:
	  this.onTouchStart(e);
	  break;
	case TOUCHMOVE:
	  this.onTouchMove(e);
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
	if(ua != undefined)
	  this.startTouch = [e.touches[0].pageX, e.touches[0].pageY];
	else
	  this.startTouch = [e.pageX, e.pageY]
  	this.startEvent = e;
	this.itemTap = false;
  	if(this.overElm(this.startTouch)){
		this.ignoreTouch = false;
		this.timeItTook = false;
		self = this;
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
}
Scroller.prototype.onTouchMove = function(e) {
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
			console.log(e.currentTarget.id + ' tapped');
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
		clearInterval(this.startTimer);	
		  if (!this.isDragging() && !this.pageview) {
			  this.doMomentum();          
		  }
		  else {
			this.snapToBounds();
		  }
	}
}
Scroller.prototype.overElm = function(finger){
	var bounds = this.elm.getBoundingClientRect();
	//if(this.elm.className == "main")
	  //console.log(this.elm.getBoundingClientRect().right)
	if (finger[1] < bounds.bottom && finger[1] > bounds.top && finger[0] > bounds.left && finger[0] < bounds.right)
	  return true;
	else
	  return false;
}
Scroller.prototype.selectItem = function(itemToSelect){	
	var item = $(itemToSelect);
	this.elm.style.webkitTransition ='-webkit-transform 200ms cubic-bezier(0.33, 0.66, 0.66, 1)';
	this.animateTo(item.offsetLeft*-1);
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
  	//console.log('animate along x:'+y)
    this.elm.style.webkitTransform = 'translate3d(' + y + 'px, 0, 0)';
  }
  else{
	
	y = -y;
	var dy = 0;
	var d  = null;
	var el = null;
	var mh = null;
	var mo = null;
	for(i = 0; i < this.headerLength; i++)
	{
	  
	  el = this.headers[i];
	  if(el.previousObject().hasClass("marketingBrick")){
		var mb = el.previousObject();
		mh = mb.offsetHeight;
		mhb = mh;
	  }
	  else{
		mh = 0;
	  }
		
	  var ot = el.offsetTop - mh;
	  //console.log("offsetTop: "+ ot+" y:"+y)
	  if(y >= ot)
	  {
		//console.log("boom"+mh)
		d  = el;
		dy = ot;
		mo = mh;
		//console.log("top"+i+": "+mo)
		me = mb;
		if(!d.previousObject().hasClass("marketingBrick")){
		  mo=0;
		  //console.log("hiiiiiiiiiiiiiii")
		}
	  }
	  else if(d){
		//if (d.previousObject() == me){
			mo=mhb;
			//console.log(me)
		//}
		break;
	  }
	}
	
	if (d)
	{
	  var h = d.offsetHeight;
	  //console.log(mo)
	  //console.log("mo- "+mo);
	  if(!mo || (!d.previousObject().hasClass("marketingBrick") && !el.previousObject().hasClass("marketingBrick"))){
		mo=0;
	  }
	  console.log()
	  var mxy = (d != el) ? el.offsetTop - mo : (this.elm.offsetHeight);
	  
	  if (y + h >= mxy){
		  //console.log("switch" + y + " "+ h + " " +mxy+" " + mo)
		  y = (mxy - h) - dy;
		  //console.log(mo);
	  }
	  else{
		  y = y - dy;
		  //console.log(y)
	  }	  
	  //console.log("y here: "+y)
	  var lh = this.lastHeader;
	  var lm = this.lastMhead;
	  if (lh && d != lh) {
		  lh.style.webkitTransform = "translate3d(0, 0,0)";
	  }
	  if (lm && me!=lm){
		lm.style.webkitTransform = "translate3d(0, 0,0)";
	  }
	  me.style.webkitTransform = 'translate3d(0,'+y+'px, 0)';
	  d.style.webkitTransform = 'translate3d( 0, '+y +'px,0)';
	  //console.log(y)
	  this.lastHeader = d;
	  this.lastMhead = me;
	}
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
		
		//alert("dx: "+dX + " dy: "+dY + " "+scrollDir)  
		return scrollDir;
	}
	return 'nochange';	
}

Scroller.prototype.snapToBounds = function() {
	this.transition = '-webkit-transform 200ms cubic-bezier(0.33, 0.66, 0.66, 1)';

	if (this.pageview && !this.itemTap){
	  var scrollDir = this.scrollDirection();
		  
		  if (scrollDir=="left")
			this.leftOffset = this.elm.offsetParent.offsetWidth-(this.elm.offsetParent.offsetWidth/3);
		  else if(scrollDir == "right")
			this.leftOffset = this.elm.offsetParent.offsetWidth-(this.elm.offsetParent.offsetWidth/1.6);
		  else
			this.leftOffset = this.elm.offsetParent.offsetWidth-(this.elm.offsetParent.offsetWidth/3);
		  
	  for(i=0; i<this.pagesLength;i++){
		  var p = this.pages[i];
		  var pb = p.getBoundingClientRect();
		  
		  if (pb.left>this.elm.offsetParent.offsetLeft && pb.left < this.leftOffset ){			
			this.currentPage = p;
			var o = p.offsetLeft - 1;
			o = -o;
			
			this.elm.style.webkitTransition = this.transition;
			window.scrollviewer.elm.style.webkitTransition = this.transition;
			this.animateTo(o);
			var q = "."+this.options.id+" .navList .current";
			$(q).removeClass("current");
			this.navList[i].addClass("current");
			
			if (scrollDir != "up" && scrollDir != "down" && this.snapToTop)
			  window.scrollviewer.animateTo(0);
		    
			this.currentPageIndex = i;
			break;
		  }
		  else if(pb.left>this.elm.offsetParent.offsetLeft && pb.left > this.leftOffset ){
			if (i>0){
				var prevPage = i-1;
				o = this.pages[prevPage].offsetLeft;
			}
			else{
				var prevPage = 0;
				o = 0;
			}
			
			o = -o
			
			this.elm.style.webkitTransition = this.transition;
			window.scrollviewer.elm.style.webkitTransition = this.transition;
			var q = "."+this.options.id+" .navList .current"
  			$(q).removeClass("current");
			this.navList[prevPage].addClass("current");
			
			if (scrollDir != "up" && scrollDir != "down" && this.snapToTop)
			  window.scrollviewer.animateTo(0);
			
			this.animateTo(o);
			
			break;
		  }
		  else if (this.contentOffset < this.maxOffset){
			this.elm.style.webkitTransition = this.transition;
			this.animateTo(this.maxOffset);
		  }
		}
	}
	else if (this.contentOffset < this.maxOffset){
		this.elm.style.webkitTransition = this.transition;
		this.animateTo(this.maxOffset);
	}
	else if(this.contentOffset>0){
		this.elm.style.webkitTransition = this.transition;
		this.animateTo(0);
	}
}

Scroller.prototype.onWebkitTransitionEnd = function(){
	
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
	return v;
	
}
Scroller.prototype.doMomentum = function() {
	var self = this;
	var velocity = this.getEndVelocity();
	var acceleration = velocity < 0 ? .03 : -.03;
	var displacement = - (velocity * velocity) / (20 * acceleration);
	var time = - ((velocity / acceleration));
	//this.elm.style.webkitTransition = '-webkit-transform '+time+'ms cubic-bezier(0.33, 0.66, 0.66, 1)';  	
	var newoffset = this.contentOffset + displacement;
	console.log('momentum vel:'+velocity);
	//console.log("end v: "+velocity+", acc: "+acceleration+", dis: "+displacement+", time "+time+", newy: "+newY)
	if (newoffset < this.maxOffset){
	  newoffset = this.maxOffset;
	  this.elm.style.webkitTransition = '-webkit-transform 300ms cubic-bezier(0.33, 0.66, 0.66, 1)';  
	}
	else if(newoffset > 0){
	  this.elm.style.webkitTransition = '-webkit-transform 300ms cubic-bezier(0.33, 0.66, 0.66, 1)';  
	  newoffset = 0;
	}
	else{
	  this.elm.style.webkitTransition = '-webkit-transform '+time+'ms cubic-bezier(0.33, 0.66, 0.66, 1)';  
	}
	this.animateTo(newoffset);
	this.contentOffset = newoffset;
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
	//console.log(offsetY)
}
Scroller.prototype.addEventListenersToRow = function(linkingClass){
	var nodeList = $(linkingClass);
	for(var i=0; i < nodeList.length; i++){
		nodeList[i].addEventListener('touchstart', this, true);
		nodeList[i].addEventListener('touchend', this, true);
	}
}

window.onload = function(){

	document.body.addEventListener("touchmove", function(e) {
	  // This prevents native scrolling from happening.
	  e.preventDefault();
	}, false);
	
	window.page = new Scroller({id:"latest-news",axis: "x", pagination:true, linkingClass: null , stickyHeaders: false, snapToTop:true, parse:true, linkText:'All Latest News' });
	
	var videos = new Scroller({id:"videos",axis: "x", pagination:false, linkingClass: '.videosSub1Article' , stickyHeaders: false });
	var photos = new Scroller({id:"photos",axis: "x", pagination:false, linkingClass: '.photos' , stickyHeaders: false });
	var kristin = new Scroller({id:"kristin",axis: "x", pagination:true, linkingClass: '.kristin' , stickyHeaders: false });
	var awfulTruth = new Scroller({id:"awfulTruth",axis: "x", pagination:true, linkingClass: '.awfulTruth' , stickyHeaders: false });
	var shows = new Scroller({id:"shows",axis: "x", pagination:true, linkingClass: '.shows' , stickyHeaders: false });
	var redCarpet = new Scroller({id:"redCarpet",axis: "x", pagination:false, linkingClass: '.redCarpet' , stickyHeaders: false });
	var reviews = new Scroller({id:"reviews",axis: "x", pagination:false, linkingClass: '.reviews' , stickyHeaders: false });
	var apps = new Scroller({id:"apps",axis: "x", pagination:false, linkingClass: '.apps' , stickyHeaders: false });
	window.scrollviewer = new Scroller({id:"scroller",axis: "y", pagination:false, linkingClass: null , stickyHeaders: "sectionHeader" });
	
	setTimeout(toggleMenu, 1000);

}
/******************************************************************************
 *	JAIPHO BETA, version 0.54.00 iPad support
 *	(c) 2009,2010 jaipho.com
 *
 *	JAIPHO BETA is freely used under the terms of an LGPL license.
 *	For details, see the JAIPHO web site: http://www.jaipho.com/
 ******************************************************************************/
 <#assign frequency = tool.text.rhythm.gallery.interstitialFrequency />
 <#assign duration = tool.text.rhythm.gallery.interstitialDuration />
 var frequency = ${frequency};
 var duration = ${duration};
				
 function JphThumbs_Manager( app)
 {
 	this.mrApp			=	app;
	
 	this.mhThumbnails		=	null;
 	this.mhThumbsTopBar		=	null;
 	this.mhThumbsContainer  	=	null;
 	this.mhThumbsCount		=	null;
	
 	this.mrBehavior			=	null;
	this.mrPreloader		=	null;
	
	this.mInitialzed		=	false;
	
	this.maThumbnails		=	new Array();
 }
 
 // INIT
 JphThumbs_Manager.prototype.Create		=	function()
 {
	this.mhThumbsTopBar		=	document.getElementById('thumbs-toolbar-top');
	this.mhThumbnails		=	document.getElementById('thumbs-images-container');
	this.mhThumbsContainer	        =	document.getElementById('thumbs-container');
	this.mhThumbsCount		=	document.getElementById('thumbs-count-text');	
	
	this.mrBehavior			=	new JphThumbs_Behavior( this);
	
	for (var i in this.mrApp.mrDao.maImages)
	{
		this.maThumbnails[this.maThumbnails.length]	=	
				new JphThumbs_Item( this.mrApp, this.mrApp.mrDao.maImages[i]);
	} 	
	
	this.mrPreloader				=	new JphUtil_Preloader( MAX_CONCURENT_LOADING_THUMBNAILS);
 }
 
 JphThumbs_Manager.prototype.Init			=	function()
 {
 	this.mrBehavior.Init();
	
 	this.mhThumbnails.innerHTML		=	this._HtmlThumbs();
	this.mhThumbsCount.innerHTML	=	this._HtmlCount();
	
	for (var i in this.maThumbnails)
	{
		this.maThumbnails[i].Init();
		
		var mover	= new JphUtil_Touches( this.maThumbnails[i].mhDiv, false);
		mover.AttachListener( 'TouchStart', this.mrBehavior, 'ThumbTouched', this.maThumbnails[i]);	
		mover.AttachListener( 'TouchEnd', this.mrBehavior, 'ThumbSelected', this.maThumbnails[i]);	
		mover.Init();
	}
	
	this.mInitialized	=	true;
 }

 
 JphThumbs_Manager.prototype._HtmlThumbs	=	function()
 {
 	var str	=	new Array();
	var cnt	=	0;
	
	for (var i in this.maThumbnails)
		str[cnt++]	=	this.maThumbnails[i].Html();
	
	return str.join('');
 }
 
 JphThumbs_Manager.prototype._HtmlCount		=	function()
 {
	var count	=	this.mrApp.mrDao.maImages.length;
	var text	=	count + ' photos';
	if (count == 1)
		text	=	count + ' photo';
			
	return text;
 }

 // ACTIONS
 JphThumbs_Manager.prototype.Show			=	function()
 {
	if (!this.mInitialized)
		this.Init();
		
	this.mhThumbsTopBar.style.display		=	'block';
	this.mhThumbnails.style.display			=	'block';
	this.mhThumbsContainer.style.display	=	'block';
	
	document.body.className	=	'thumbs';
	this.mrPreloader.Play();
 }
 
 
 JphThumbs_Manager.prototype.Hide			=	function()
 {
	this.mhThumbsTopBar.style.display		=	'none';
	this.mhThumbnails.style.display			=	'none';
	this.mhThumbsContainer.style.display	=	'none';
	this.mrPreloader.Pause();
 }
				
function JphThumbs_Item( app, image)
 {
 	this.mrApp		=	app;
 	this.mrImage	=	image;
	this.mhDiv		=	null;
	this.mhImage	=	null;
 }
 
 JphThumbs_Item.prototype.Init		=	function()
 {
 	this.mhDiv		=	document.getElementById( this.GetHtmlId('thumb_div'));
 	this.mhImage	=	document.getElementById( this.GetHtmlId('thumb_img'));
 	this.mrApp.mrThumbnails.mrPreloader.Load( this.mhImage, this.mrImage.mSrcThumb);
 }

 JphThumbs_Item.prototype.SelectSlide = function()
 {
 	this.mrApp.ShowSliderAction( this.mrImage.mIndex);
 	//this.mrApp.mrSlider.Show();
 }
 JphThumbs_Item.prototype.SelectThumb = function()
 {
 	this.mhDiv.style.opacity	=	'.50';
 }
 JphThumbs_Item.prototype.DeselectThumb = function()
 {
 	this.mhDiv.style.opacity	=	'1.0';
 }
 
 JphThumbs_Item.prototype.Html				=	function()
 {
 	var str		=	new Array();
	var cnt		=	0;
	
	str[cnt++]	=	'<div class="thumbnail"';
	str[cnt++]	=	get_html_attribute("id", this.GetHtmlId('thumb_div'));
	str[cnt++]	=	'>';
	str[cnt++]	=	'<img';
	str[cnt++]	=	get_html_attribute("id", this.GetHtmlId('thumb_img'));
	str[cnt++]	=	get_html_attribute('title', this.mrImage.mTitle);
	str[cnt++]	=	get_html_attribute('src', BASE_URL + 'dummy.gif');
	str[cnt++]	=	'/>';
	str[cnt++]	=	'</div>';
	
	
	return str.join('');
 }
 
 
 JphThumbs_Item.prototype.GetHtmlId = function( key)
 {
 	return this.mrImage.mIndex + '_' + key;
 }
				
var TOOLS_MODE_ALL_HIDDEN	=	'ALL_HIDDEN';
 var TOOLS_MODE_TOOLBARS_ON	=	'TOOLBARS_ON';
 var TOOLS_MODE_TEXT_ON		=	'TEXT_ON';
 var TOOLS_MODE_BOTH_ON		=	'VISIBLE_ON';

 
 function JphThumbs_Behavior( thumbs)
 {
	this.mrThumbs	=	thumbs;
	
	this.mrLastSelectedThumb	=	null;
 }
 
 
 
 JphThumbs_Behavior.prototype.Init					=	function()
 {
 }

 
 JphThumbs_Behavior.prototype.ThumbTouched		=	function( e, thumbItem)
 {
	
	if (this.mrLastSelectedThumb)
	{
		this.mrLastSelectedThumb.DeselectThumb();
		this.mrLastSelectedThumb	=	null;
	}
	
	
	thumbItem.SelectThumb();
	
	this.mrLastSelectedThumb	=	thumbItem;
 } 
 
 
 JphThumbs_Behavior.prototype.ThumbSelected		=	function( e, thumbItem)
 {
	thumbItem.SelectSlide();
	thumbItem.DeselectThumb();
 }
				
function JphSlider_ToolbarsManager()
 {
	this.mDeactivation	=	null;
	this.maElements		=	new Array();
	this.mIndex			=	0;
	
	this.mHidden		=	true;
 }
 
 JphSlider_ToolbarsManager.prototype.Register	=	function( elem)
 {
 	this.maElements[this.maElements.length]	=	elem;
 }
 
 // ACTIONS
 JphSlider_ToolbarsManager.prototype.Show	=	function()
 {
	this._RemoveDeactivation();
		
 	for (var i in this.maElements)
		this.maElements[i].style.display	=	'block';
		
	this._SetDeactivation();
	
	this.mHidden	=	false;
 }
 
 JphSlider_ToolbarsManager.prototype.Hide	=	function()
 {
	this._DeactivateToolbars();
 } 
  
 
 JphSlider_ToolbarsManager.prototype.IsHidden		=	function()
 {
	return this.mHidden;
 }  
 
 JphSlider_ToolbarsManager.prototype._DeactivateToolbars	=	function()
 {
	this._RemoveDeactivation();
	
 	for (var i in this.maElements)
		this.maElements[i].style.display	=	'none';
		
	this.mHidden	=	true;
 } 
  
 JphSlider_ToolbarsManager.prototype.Toggle	=	function()
 {
 	if (this.mHidden) 	
		this.Show();
	else
		this.Hide();
 }
 
 // TIMER
 JphSlider_ToolbarsManager.prototype._SetDeactivation	=	function()
 {
 	this.mDeactivation		=	set_timeout( this, '_DeactivateToolbars', '', TOOLBARS_HIDE_TIMEOUT);	
 }  

 JphSlider_ToolbarsManager.prototype._RemoveDeactivation	=	function()
 {
 	if (this.mDeactivation)
		clearTimeout( this.mDeactivation);
		
	this.mDeactivation	=	null;
 }
				
function JphSlider_SlideShow( slider)
 {
 	this.mrSlider		=	slider;
	this.mSlideTimeout	=	null;
 }
 
 JphSlider_SlideShow.prototype.IsActive	=	function()
 {
	if (this.mSlideTimeout)
		return true;
 	return false;
 }
 
 JphSlider_SlideShow.prototype.TogglePlay	=	function()
 {
	if (this.IsActive())
	{
	 	this.StopSlideshow();
	}
	else
	{
	 	this._RequestNext();
	}
	this.mrSlider.mrSliderNavi.CheckButons();
 }
 
 JphSlider_SlideShow.prototype.StopSlideshow	=	function()
 {
 	clearTimeout( this.mSlideTimeout);
	this.mSlideTimeout	=	null;	
 }
 
 JphSlider_SlideShow.prototype._RollSlideshow	=	function()
 {
 	this.mrSlider.Next();
	
	if (this.mrSlider.IsLast())
	{		
		this.StopSlideshow();
		this.mrSlider.mrSliderNavi.CheckButons();
		this.mrSlider.mrToolbars.Show();
	}
	
	if (this.IsActive())
	{
		this._RequestNext();		
	}
 }
 

 
 JphSlider_SlideShow.prototype._RequestNext	=	function()
 { 		
	this.mSlideTimeout		=	set_timeout( this, '_RollSlideshow', '', SLIDESHOW_ROLL_TIMEOUT);	
/* BP ads
	if ( frequency != undefined && frequency > 0 && ((this.mCurrent+2) % frequency) == 0) {
            //call rmn to get an ad
            getRMNAd(this.mCurrent+2);
	}
	
	if ( frequency != undefined && frequency > 0 && (this.mCurrent % frequency) == 0) {
	    document.getElementById("ad-wrapper").style.left = "0";
	    setTimeout('hideAndClearRMNAd()', duration);
	}
*/
 }
				
function JphSlider_SliderControls( slider)
 {
 	this.mrSlider	=	slider;
	
 	this.mhInfo;
	
 	this.mrPrev;
	this.mrPlay;
	this.mrPause;
	this.mrNext;
 }
 
 JphSlider_SliderControls.prototype.Init		=	function()
 {
 	this.mhInfo		=	document.getElementById('navi-info');

	this.mrPrev		=	new Jph_NaviButton( 'navi-prev');
	this.mrPrev.Init();
	var mover		= 	new JphUtil_Touches( this.mrPrev.mhImage, false);
	mover.AttachListener( 'TouchEnd', this.mrSlider.mrBehavior, 'PreviousPressed');	
	mover.Init();

	
	this.mrPlay		=	new Jph_NaviButton( 'navi-play');
	this.mrPlay.Init();
	var mover		= 	new JphUtil_Touches( this.mrPlay.mhImage, false);
	mover.AttachListener( 'TouchEnd', this.mrSlider.mrBehavior, 'PlayPressed');	
	mover.Init();
	
	
	this.mrPause	=	new Jph_NaviButton( 'navi-pause');
	this.mrPause.Init();
	var mover		= 	new JphUtil_Touches( this.mrPause.mhImage, false);
	mover.AttachListener( 'TouchEnd', this.mrSlider.mrBehavior, 'PausePressed');	
	mover.Init();
	
		
	this.mrNext		=	new Jph_NaviButton( 'navi-next');
	this.mrNext.Init();
	var mover		= 	new JphUtil_Touches( this.mrNext.mhImage, false);
	mover.AttachListener( 'TouchEnd', this.mrSlider.mrBehavior, 'NextPressed');	
	mover.Init();
		
 }
 
 JphSlider_SliderControls.prototype.CheckButons = function()
 {
	
	if (this.mrSlider.mrSlideshow.IsActive())
	{
		this.mrPlay.Hide();
		this.mrPause.Show();
	}
	else
	{
		this.mrPlay.Show();
		this.mrPause.Hide();
	}
	
	if (this.mrSlider.IsFirst())
		this.mrPrev.Disable();
	else
		this.mrPrev.Enable();

	if (this.mrSlider.IsLast())
		this.mrNext.Disable();
	else
		this.mrNext.Enable();
 }

// EVENT HANDLER
 JphSlider_SliderControls.prototype.OnSlideChanged = function( e)
 {
	this.CheckButons();
 }
				
function JphSlider_Slider( app)
 {
 	this.mrApp				=	app;
	
 	this.mhSliderTable		=	null;
 	this.mhSliderDiv		=	null;
	this.mhSliderOverlay	=	null;
	

	this.mrToolbars			=	null;	
	this.mrSliderNavi		=	null;
	this.mrSlideshow		=	null;
	this.mrCompnents		=	null;
	
	this.mCurrent			=	0;
	this.mrCurrentSlide		=	null;
	
	this.mInitialized		=	false;
	
	this.maSlides			=	new Array();
	
	this.mhTopBar			=	null;
	this.mhBottomBar		=	null;
	
	this.mrPreloader		=	null;
	this.mrImageQueue		=	null;	
	this.mrBehavior			=	null;
	
	this.mVisible			=	true;
	this.mReverse			=	false;
 }
 

 JphSlider_Slider.prototype.Create		=	function()
 {
	
	this.mrPreloader			=	new JphUtil_Preloader( MAX_CONCURENT_LOADING_SLIDE);
	this.mrImageQueue			=	new JphSlider_ImageQueue( SLIDE_MAX_IMAGE_ELEMENS);	
 	
	var last_slide	=	null;
	for (var i in this.mrApp.mrDao.maImages)
	{
		var image 	=	this.mrApp.mrDao.maImages[i];
		var slide	=	new JphSlider_Slide( this.mrPreloader, this.mrImageQueue, image);	
		this.maSlides[image.mIndex]	=	slide;
		
		if (last_slide != null)
		{
			last_slide.mrNext 	= 	slide;
			slide.mrPrevious	=	last_slide;	
		}
		
		last_slide	=	slide;
	} 	
	
	this.mhSliderOverlay	=	document.getElementById('slider-overlay');
	this.mhSliderDiv		=	document.getElementById('slider-container');
	
	this.mrSlideshow		=	new JphSlider_SlideShow( this);
	this.mrSliderNavi		=	new JphSlider_SliderControls( this);
	this.mrBehavior			=	new JphSlider_Behavior( this);
	this.mrBehavior.Init();
 }
 
 
 JphSlider_Slider.prototype.Init		=	function()
 {
	
	this.mhTopBar				=	document.getElementById('slider-toolbar-top');
	this.mhBottomBar			=	document.getElementById('slider-toolbar-bottom');

	this.mrDescription			=	new JphSlider_Description( this.mrApp);
	this.mrDescription.Init();
	
	this.mrToolbars				=	new JphSlider_ToolbarsManager();
	this.mrToolbars.Show();
	
	
	this.mhSliderDiv.innerHTML	=	this._HtmlSlider();
	
	this.mhSliderTable			=	document.getElementById('slider-table');
	// this.mhSliderTable.style.webkitTransitionProperty	=	'margin-left';
	this.mhSliderTable.style.webkitTransitionDuration	=	SLIDE_SCROLL_DURATION;
	this.mhSliderTable.style.WebkitTransition      =       "-webkit-transform "+SLIDE_SCROLL_DURATION+" ease";
	
 	this.mrToolbars.Register( this.mhSliderOverlay);
	
	this.mrSliderNavi.Init();
	
	for (var i in this.maSlides) 
	{
		this.maSlides[i].Init();
	}
	
	this.mrCurrentSlide		=	this.maSlides[this.mCurrent];	
	
	this.mrCompnents		=	new JphSlider_ComponentVisibility( this);
	
	// TODO: refactor
	var top_tool_touch		= 	new JphUtil_Touches( this.mhTopBar, false);
	top_tool_touch.AttachListener( 'TouchEnd', this.mrBehavior, 'ToolbarTouched');
	top_tool_touch.Init();
	
	var bottom_tool_touch	= 	new JphUtil_Touches( this.mhBottomBar, false);
	bottom_tool_touch.AttachListener( 'TouchEnd', this.mrBehavior, 'ToolbarTouched');
	bottom_tool_touch.Init();
	
	var slider_mover		= 	new JphUtil_Touches( this.mhSliderDiv, true);
	slider_mover.AttachListener( 'TouchEnd', this.mrBehavior, 'SlideTouched');
	slider_mover.AttachListener( 'MovedLeft', this.mrBehavior, 'SlideDraggedLeft');
	slider_mover.AttachListener( 'MovedRight', this.mrBehavior, 'SlideDraggedRight');
	slider_mover.Init();

	var desc_mover			= 	new JphUtil_Touches( this.mrDescription.mhDescContainer, true);
	desc_mover.AttachListener( 'TouchEnd', this.mrBehavior, 'SlideTouched');	
	desc_mover.AttachListener( 'MovedLeft', this.mrBehavior, 'SlideDraggedLeft');
	desc_mover.AttachListener( 'MovedRight', this.mrBehavior, 'SlideDraggedRight');
	desc_mover.Init();

	var text_mover			= 	new JphUtil_Touches( this.mrDescription.mhDescTitle, true);
	text_mover.AttachListener( 'TouchEnd', this.mrBehavior, 'DescriptionTouched');	
	text_mover.Init();
	
	var title_mover			= 	new JphUtil_Touches( this.mrDescription.mhDescText, true);
	title_mover.AttachListener( 'TouchEnd', this.mrBehavior, 'DescriptionTouched');	
	title_mover.Init();
	
	var credit_mover			= 	new JphUtil_Touches( this.mrDescription.mhDescCredit, true);
	title_mover.AttachListener( 'TouchEnd', this.mrBehavior, 'DescriptionTouched');	
	credit_mover.Init();

	this.mInitialized		=	true;

 }


 JphSlider_Slider.prototype._HtmlSlider		=	function()
 {
 	
 	var str		=	new Array();
 	var str_1	=	new Array();
 	var str_2	=	new Array();
	var cnt_1	=	0;
			
	for (var i in this.maSlides)
	{
		var slide 		=	this.maSlides[i];
		str_1[cnt_1++]	=	slide.HtmlSlide();
		str_2[cnt_1++]	=	slide.HtmlSpace();
	} 	
	
	str[str.length]	=	'<table cellpadding="0" cellspacing="0" border="0" id="slider-table">';
	str[str.length]	=	'<tr>';
	str[str.length]	=	str_1.join('');
	str[str.length]	=	'</tr>';
	str[str.length]	=	'<tr>';
	str[str.length]	=	str_2.join('');
	str[str.length]	=	'</tr>';
	str[str.length]	=	'</table>';
	
	return str.join('');
 } 
 
 
 /*******************************************/
 /*			SLIDER - NAVIGATION				*/
 /*******************************************/  
 
 // ACTIONS
 JphSlider_Slider.prototype.Hide			=	function()
 {
	if (!this.mInitialized)
		this.Init();
		
	this.mhSliderDiv.style.display			=	'none';
	this.mhSliderOverlay.style.display		=	'none';
	this.mhSliderTable.style.display		=	'none';
	this.mVisible							=	false;
		
	this.mrDescription.Hide();
 }
 
 JphSlider_Slider.prototype.Show			=	function()
 {
	if (!this.mInitialized)
		this.Init();
	
	document.body.className					=	'slider';
		
	this.mhSliderDiv.style.display			=	'block';
	this.mhSliderOverlay.style.display		=	'block';
	this.mhSliderTable.style.display		=	'block';
	this.mVisible							=	true;
	
	this.mrCompnents.Show();
	this.mrApp.NormalizeVertical();
	this.SelectSlide( this.mCurrent);
 }
 
JphSlider_Slider.prototype.Previous = function() {
    if(this.IsFirst()) {
        this.mrToolbars.Show();
        return;
    }

    this.mReverse = true;
    this.SelectSlide(this.mCurrent - 1);
    //BP ads
    if(frequency != undefined && frequency > 0 && ((this.mrCurrentSlide.mrImage.mIndex + 1) % 5) == 0 && this.mrCurrentSlide.mrImage.mIndex != 0) {
        showRMNAd(this.mrCurrentSlide.mrImage.mIndex,"prev");
    }
    else if(frequency != undefined && frequency > 0 && ((this.mrCurrentSlide.mrImage.mIndex + 3) % 5) == 0) {
        //call rmn to get an ad
        getRMNAd(this.mrCurrentSlide.mrImage.mIndex - 6);
    } else {
        hideRMNAd();
    }
}
 
JphSlider_Slider.prototype.Next = function() {
    if(this.IsLast()) {
        this.mrToolbars.Show();
        return;
    }

    this.mReverse = false;
    this.SelectSlide(this.mCurrent + 1);
    //BP ads
    if(frequency != undefined && frequency > 0 && ((this.mrCurrentSlide.mrImage.mIndex + 1) % 5) == 0 && this.mrCurrentSlide.mrImage.mIndex != 0) {
        showRMNAd(this.mrCurrentSlide.mrImage.mIndex,"next");
    }
//    else if(frequency != undefined && frequency > 0 && ((this.mrCurrentSlide.mrImage.mIndex + 3) % 5) == 0) {
    else if(frequency != undefined && frequency > 0 && (this.mrCurrentSlide.mrImage.mIndex + 4) == 5){
        getRMNAd(4);
        console.log("will get ad for 4th slot");
    }
    else if(frequency != undefined && frequency > 0 && ((this.mrCurrentSlide.mrImage.mIndex + 8) % 5) == 0) {
        //call rmn to get an ad
        getRMNAd(this.mrCurrentSlide.mrImage.mIndex + 7);
        console.log("will get ad for "+(this.mrCurrentSlide.mrImage.mIndex+7)+" slot");
    } else {
        hideRMNAd();
    }
}

 JphSlider_Slider.prototype.SelectSlide		=	function( index)
 { 	
		
	if (!this.mInitialized)
		this.Init();
		
 	var last_slide			=	this.mrCurrentSlide;
 	this.mrCurrentSlide		=	this.maSlides[index];	
	this.mCurrent			=	index;

	if (!this.mrCurrentSlide)
		throw Error('Slide not found by index ['+index+']');

	this.mrCurrentSlide.SetActive();
	
	if (last_slide)
		last_slide.SetInactive();
	
	this.RepaintPosition();
	
	this.mrDescription.SetDescription( this.mrCurrentSlide.mrImage);
	this.mrCompnents.FirstTimeTextFix();
	
	this._RepaintInfo();
	this.mrSliderNavi.CheckButons();
	
	this.mrApp.mrHistory.SelectSlide( this.mCurrent);
	this.mrApp.NormalizeVertical();
 }
 
 
// INFO
 JphSlider_Slider.prototype.IsLast	=	function()
 {
 	if ((this.mCurrent + 1) == this.mrApp.mrDao.GetImagesCount())
		return true;	
	return false;
 }
 
 JphSlider_Slider.prototype.IsFirst	=	function()
 {
 	if (this.mCurrent == 0)
		return true;	
	return false;
 }
 
 
 // UTIL

 JphSlider_Slider.prototype.RepaintPosition     =       function()
 {
        var     left    =       this._GetPositionLeft( this.mCurrent);
        //this.mhSliderTable.style.marginLeft   =       left + "px";
        this.mhSliderTable.style.WebkitTransform        =       "translate3d( "+left + 'px'+",0,0)";   
 }
 
 JphSlider_Slider.prototype._RepaintInfo		=	function()
 {
 	var count	=	this.mrApp.mrDao.GetImagesCount();
 	var current	=	this.mCurrent + 1;
	this.mrSliderNavi.mhInfo.innerHTML	=	current + ' ' + OF_TRANSLATE + ' ' + count;
	
 }
 
 JphSlider_Slider.prototype._GetPositionLeft	=	function( index)
 {
	 var space_width	=	20;
	 var width	=	
		 this.mrApp.mrOrientation.mWidth + space_width;
	 return width * index * -1;
 } 

				
function JphSlider_Slide( preloader, queue, image)
 {
 	this.mrPreloader	=	preloader;
 	this.mrImageQueue	=	queue;
 	this.mrImage		=	image;
 	
	this.mActive		=	false;
	this.mrPrevious		=	null;
	this.mrNext			=	null;
	
	this.mhImage		=	null;
	this.mhDiv			=	null;
	
	this.maNeighboursDefault	=	new Array();
	this.maNeighboursReverse	=	new Array();
	
	this.mPreloadTimeoutId		=	null;
 }

 JphSlider_Slide.prototype.Init = function()
 {
 	this.mhImageWidth	=	document.getElementById( this.GetHtmlId('img-width'));
 	this.mhDiv			=	document.getElementById( this.GetHtmlId('div'));
 	
 	var indexes			=	SLIDE_PRELOAD_SEQUENCE.split(',');
 	for (var i in indexes)
 	{
 		var distance			=	parseInt( indexes[i]);
 		var sequence_slide		=	this.GetSibling( distance);
 		if (sequence_slide)
 			this.maNeighboursDefault[this.maNeighboursDefault.length]	=	sequence_slide;
 			
 		var sequence_slide		=	this.GetSibling( -distance);
 		if (sequence_slide)
 			this.maNeighboursReverse[this.maNeighboursReverse.length]	=	sequence_slide;
 	}
 	
 }
 

 JphSlider_Slide.prototype.HtmlSlide		=	function()
 {
 	var str		=	new Array();
	var cnt		=	0;
	
	str[cnt++]	=	'<td class="slide"';
	str[cnt++]	=	get_html_attribute('id', this.GetHtmlId('div'));
	str[cnt++]	=	'>';
	str[cnt++]	=	'</td>';
	str[cnt++]	=	'<td>';
	str[cnt++]	=	'<img';	
	str[cnt++]	=	get_html_attribute('src', BASE_URL + 'dummy.gif');
	str[cnt++]	=	get_html_attribute('class', 'space');
	str[cnt++]	=	'/>';
	str[cnt++]	=	'</td>';
				
	return str.join('');
 }
 
 
 JphSlider_Slide.prototype.HtmlSpace		=	function()
 {
 	var str		=	new Array();
	var cnt		=	0;
	
	str[cnt++]	=	'<td><img class="space-width"';
	str[cnt++]	=	get_html_attribute('id', this.GetHtmlId('img-width'));
	str[cnt++]	=	get_html_attribute('src', BASE_URL + 'dummy.gif');
	str[cnt++]	=	' height="1"/></td>';
	str[cnt++]	=	'<td>';
	str[cnt++]	=	'<img';	
	str[cnt++]	=	get_html_attribute('width', BASE_URL + 'dummy.gif');
	str[cnt++]	=	get_html_attribute('src', BASE_URL + 'dummy.gif');
	str[cnt++]	=	'/>';
	str[cnt++]	=	'</td>';
	return str.join('');
 } 
 
 
 JphSlider_Slide.prototype.SetInactive = function()
 {
 	
 } 
 
 JphSlider_Slide.prototype.SetActive = function()
 {

	this._Load();
	
 	if (this.mPreloadTimeoutId)
 	{
 		clearTimeout( this.mPreloadTimeoutId);
 		this.mPreloadTimeoutId	=	null;
 	}
 	
	this.mPreloadTimeoutId	=	set_timeout( this, '_PrepaireNeighbours', this.mReverse ? 'true' : '', SLIDE_PRELOAD_TIMEOUT);
 } 
 
 JphSlider_Slide.prototype._PrepaireNeighbours = function( strReverse)
 {
 	var reverse		=	strReverse == 'true' ? true : false
 	var slides		=	reverse ? this.maNeighboursReverse : this.maNeighboursDefault
 	
 	for (var i in slides)
 		slides[i]._Load();
 }
 
 JphSlider_Slide.prototype._Load = function()
 {
//BP ads
//	this.mrPreloader.Load( this._GetImage(), this.mrImage.mSrc);
//	if(this.mrImage.mIndex==0 || (this.mrImage.mIndex)%4!=0){
	if(this.mrImage.mIndex==0 || (typeof this.mrImage.mSrc!=="undefined")){
            this.mrPreloader.Load( this._GetImage(), this.mrImage.mSrc);
        }
 } 
 
 JphSlider_Slide.prototype._GetImage = function()
 {
 	var img		=	this.mhDiv.childNodes[0];
 	
 	if (img)
 	{
 		this.mrImageQueue.RegisterUsage( img); 		
 	}
 	else
 	{
		img		=	this.mrImageQueue.GetImage();
		this.mhDiv.appendChild( img);
 	}
 	
 	return img;
 }
 
 JphSlider_Slide.prototype.IsLast = function()
 {
	if (this.mrNext == null)
		return true;
 }
 
 JphSlider_Slide.prototype.IsFirst = function()
 {
	if (this.mrPrevious == null)
		return true;
 }  

 JphSlider_Slide.prototype.GetSibling = function( distance)
 {
	if (distance == 0)
		return this;
	if (this.mrNext && distance > 0)
		return this.mrNext.GetSibling( distance - 1);
	if (this.mrPrevious && distance < 0)
		return this.mrPrevious.GetSibling( distance + 1);		
 } 

 
 JphSlider_Slide.prototype.GetHtmlId = function( key)
 {
 	return 'slide_' + this.mrImage.mIndex + '_' + key;
 }
 
 JphSlider_Slide.prototype.toString	=	function()
 {
 	return '[JphSlider_Slide ['+this.mrImage.mIndex+']]';
 }
				
function JphSlider_ImageQueue( queueSize)
 {
 	this.maQueueSize	=	queueSize;
 	this.maLruQueue		=	new Array();
 }
 
 JphSlider_ImageQueue.prototype.GetImage	=	function()
 {
	
	if (this._IsFull())
	{
		return this._ReuseImage();
	}	
	
	return this._CreateImage();
 }
 
 
 JphSlider_ImageQueue.prototype.RegisterUsage	=	function( img)
 {
	
	var arr	=	new Array();
	
	for (var i in this.maLruQueue)
		if (this.maLruQueue[i] != img)
			arr[arr.length]	=	this.maLruQueue[i];
			
	this.maLruQueue	=	arr;
	this.maLruQueue[this.maLruQueue.length]	=	img;
 }
  
 
 JphSlider_ImageQueue.prototype._ReuseImage	=	function()
 {
 	var img	=	this.maLruQueue.shift();
 	img.parentNode.removeChild( img);
 	this.maLruQueue[this.maLruQueue.length]	=	img;
 	return img;
 }
 
 JphSlider_ImageQueue.prototype._CreateImage	=	function()
 {
 	var img	=	document.createElement('img');
 	this.maLruQueue[this.maLruQueue.length]	=	img;
 	return img; 
 }
 
 JphSlider_ImageQueue.prototype._IsFull	=	function( src)
 {
 	if (this.maLruQueue.length >= this.maQueueSize)
 		return true;
 }

 JphSlider_ImageQueue.prototype.toString	=	function()
 {
 	return 'JphSlider_ImageQueue [length='+this.maLruQueue.length+'][max-size='+this.maQueueSize+']';
 }
				
function JphSlider_Description( app)
 {
 	this.mrApp				=	app;
	
	this.mhDescContainer	=	null;
	this.mhDescTitle		=	null;
	this.mhDescText			=	null;
	this.mhDescCredit		=	null;
	this.mhShare			=	null;
	this.mhTrack			=	null;
	
	this.mHidden			=	false;
 }
 

 JphSlider_Description.prototype.Create		=	function()
 {
 }
 
 
 JphSlider_Description.prototype.Init		=	function()
 {
	
	var tmp	=	document.createElement('div');
	tmp.innerHTML			=	this.Html();
//	tmp.style.display		=	'none';
	document.body.appendChild( tmp);
	
	this.mhDescContainer	=	document.getElementById('slider-desc-container');		
	this.mhDescTitle		=	document.getElementById('desc-title');
	this.mhDescText			=	document.getElementById('desc-text');	
	this.mhDescCredit		=	document.getElementById('desc-credit');		
	this.mhShare			=	document.getElementById('share-info');			
	this.mhTrack			=	document.getElementById('track-info');	
 }
 
 JphSlider_Description.prototype.Html = function()
 {
 	var str		=	new Array();
	var cnt		=	0;	
	
	str[cnt++]	=	'<table id="slider-desc-container" class="slider-text" border="0" style="display: none;">';
	str[cnt++]	=	'<tr>';
	str[cnt++]	=	'	<td valign="bottom">';
	str[cnt++]	=	'		<div id="desc-title">';
	str[cnt++]	=	'		</div>		';
	str[cnt++]	=	'		<div id="desc-text">';
	str[cnt++]	=	'		</div>';
	str[cnt++]	=	'		<div id="desc-credit">';
	str[cnt++]	=	'		</div>';
	str[cnt++]	=	'	</td>';
	str[cnt++]	=	'</tr>';
	str[cnt++]	=	'</table>';
				
	return str.join('');
 } 
 
 JphSlider_Description.prototype._OnTouch		=	function( e)
 {
	this.mrApp.mrSlider.mrToolbars.Deactivate();
 }
 
 JphSlider_Description.prototype.IsHidden		=	function()
 {
	return this.mHidden;
 }
 
 JphSlider_Description.prototype.Hide			=	function()
 {
	this.mhDescContainer.style.display	=	'none';
	this.mHidden						=	true;
 }
 
 JphSlider_Description.prototype.Show			=	function()
 {
 	try
 	{
		this.mhDescContainer.style.display	=	'table';
	}
	catch(e)
	{
		this.mhDescContainer.style.display	=	'block';
	}
	this.mHidden						=	false;
 }
 

 JphSlider_Description.prototype.SetDescription		=	function( image)
 {
 	var sharestr1				=	'<a class="button2" href="#"';
 	var sharestr2				=	'&amp;returnurl=';  
 	var sharestr3				=	' onclick="shareLink('+'\''+ location.host + '/sendtofriend.ftl?url=' + image.mShare +'\''+');">' + SHARE_TRANSLATE + '</a>';
 	
 	var trackstr1				=	'<img src="http://wa.eonline.com/b/ss/comcastegeonlinemobile/5/H.20.3--WAP?pageName=';
 	var trackstr2				=	'&amp;state=';
 	var trackstr3				=	'"/>';
 
	this.mhDescTitle.innerHTML	=	image.mTitle;
	this.mhDescText.innerHTML	=	image.mDesc;
	this.mhDescCredit.innerHTML	=	image.mCredit;
	this.mhShare.innerHTML        =	sharestr1 + image.mShare + sharestr2 + image.mShare + sharestr3;
	//this.mhShare.innerHTML		=	sharestr1 + sharestr3;
	this.mhTrack.innerHTML		=	trackstr1 + image.mTrack + trackstr2 + Math.floor(Math.random()*999999) + trackstr3;
 }

function shareLink( urlParam ) {
  var url = 'http://' + urlParam;
  window.open(url, '_blank');
}
 
 JphSlider_Description.prototype.ShowDescription	=	function( title, desc, credit, share, track)
 {
	this.SetDescription( title, desc, credit, share, track);
	this.Show();
 }
				
function JphSlider_ComponentVisibility( slider)
 {
 	this.mrSlider			=	slider;
	
	// defaults
	this.mTextAllreadyUsed	=	false;
	this.mTextAvailable		=	true;
	this.mTextVisible		=	true;
	this.mToolsVisible		=	true;
 }


 JphSlider_ComponentVisibility.prototype.HideAll = function()
 {
	this.mrSlider.mrToolbars.Hide();
	this.mrSlider.mrDescription.Hide();
 }
 
 JphSlider_ComponentVisibility.prototype.Show = function()
 {
	this.mrSlider.mrToolbars.Show();
	this.mrSlider.mrDescription.Show();
 }
  
 JphSlider_ComponentVisibility.prototype.ToggleAll = function()
 {

 	this._Refresh();
 	
 	
	if (this.mToolsVisible)
	{
		this.mrSlider.mrToolbars.Hide();
		this.mrSlider.mrDescription.Hide();
		
		if (this.mTextAvailable)
		{
			this.mTextAllreadyUsed	=	true;
		}
	}
	else
	{
		this.mrSlider.mrToolbars.Show();
		
		if (this.mTextAvailable)
		{
			this.mrSlider.mrDescription.Show();
		}
	}
 }
  
 JphSlider_ComponentVisibility.prototype.FirstTimeTextFix = function()
 {
 	this._Refresh();
	var force_desc	=	!this.mTextAllreadyUsed && this.mTextAvailable;
	
	
	if (force_desc)
		this.mrSlider.mrDescription.Show();
 }
  
 JphSlider_ComponentVisibility.prototype.Roll				=	function()
 {
	this._Refresh();
	
	if (this.mTextAvailable)
	{
		if (!this.mTextAllreadyUsed)
		{
			this.mrSlider.mrDescription.Show();
		}
		
		if (this.mTextVisible && this.mToolsVisible)
		{
			this.mrSlider.mrToolbars.Hide();
		}
		else if ( this.mTextVisible)
		{
			this.mrSlider.mrDescription.Hide();
		}
		else if ( !this.mTextVisible && !this.mToolsVisible)
		{
			this.mrSlider.mrToolbars.Show();
			this.mrSlider.mrDescription.Show();
		}
		else
		{
			this.mrSlider.mrToolbars.Show();
			this.mrSlider.mrDescription.Show();
		}
		
		this.mTextAllreadyUsed	=	true;
	}
	else
	{
		if (this.mToolsVisible)
		{
			this.mrSlider.mrToolbars.Hide();
		}
		else
		{
			this.mrSlider.mrToolbars.Show();
		}
	}
 }
 
 JphSlider_ComponentVisibility.prototype._Refresh 		= 	function()
 {
 	this.mTextAvailable	=	this.mrSlider.mrCurrentSlide.mrImage.HasText();
	
	if (this.mrSlider.mrToolbars.IsHidden())
		this.mToolsVisible	=	false;
	else
		this.mToolsVisible	=	true;
	
	if (this.mrSlider.mrDescription.IsHidden())
		this.mTextVisible	=	false;
	else
		this.mTextVisible	=	true;
		
	if (!this.mTextAvailable)
	{
		this.mTextVisible		=	true;
	}
 }
				
var TOOLS_MODE_ALL_HIDDEN	=	'ALL_HIDDEN';
 var TOOLS_MODE_TOOLBARS_ON	=	'TOOLBARS_ON';
 var TOOLS_MODE_TEXT_ON		=	'TEXT_ON';
 var TOOLS_MODE_BOTH_ON		=	'VISIBLE_ON';

 
 function JphSlider_Behavior( slider)
 {
	this.mrSlider	=	slider;
 }
 
 
 
 JphSlider_Behavior.prototype.Init					=	function()
 {
	this.mrSlider.mrApp.mrOrientation.AttachListener( 'OrientationChanged', this, '_OrientationChanged');
 }
 
 // DRAG
 JphSlider_Behavior.prototype.SlideDraggedLeft		=	function( e)
 {
	
 	if (this.mrSlider.mrSlideshow.IsActive())
	 	this.mrSlider.mrSlideshow.StopSlideshow();
 	this.mrSlider.Next();
 }
 
 JphSlider_Behavior.prototype.SlideDraggedRight		=	function( e)
 {
	
 	if (this.mrSlider.mrSlideshow.IsActive())
	 	this.mrSlider.mrSlideshow.StopSlideshow();
		
	this.mrSlider.Previous();
 }

 // TOUCH
 JphSlider_Behavior.prototype.SlideTouched			=	function( e)
 {
	
	this.mrSlider.mrCompnents.ToggleAll();
 }
  
 JphSlider_Behavior.prototype.DescriptionTouched	=	function( e)
 {
	this.mrSlider.mrCompnents.Roll();
	if (e.mrEvent)
		e.mrEvent.cancelBubble = true
 }
  
 JphSlider_Behavior.prototype.ToolbarTouched		=	function( e)
 {
 	this.mrSlider.mrToolbars.Show();
 }

 // BUTTONS
 JphSlider_Behavior.prototype.NextPressed			=	function( e)
 {
 	if (this.mrSlider.mrSlideshow.IsActive())
	 	this.mrSlider.mrSlideshow.StopSlideshow();
		
 	this.mrSlider.Next();
//BP ads

/*		if ( frequency != undefined && frequency > 0 && ((this.mCurrent+2) % frequency) == 0) {
            //call rmn to get an ad
            getRMNAd(this.mCurrent+2);
	}
	
	if ( frequency != undefined && frequency > 0 && (this.mCurrent % frequency) == 0) {
	    document.getElementById("ad-wrapper").style.left = "0";
	    setTimeout('hideAndClearRMNAd()', duration);
	}
*/
 }
 
 JphSlider_Behavior.prototype.PreviousPressed		=	function( e)
 {
	
 	if (this.mrSlider.mrSlideshow.IsActive())
	 	this.mrSlider.mrSlideshow.StopSlideshow();
		
 	this.mrSlider.Previous();


/*		if ( frequency != undefined && frequency > 0 && ((this.mCurrent-2) % frequency) == 0) {
            //call rmn to get an ad
            getRMNAd(this.mCurrent-2);
	}
	
	if ( frequency != undefined && frequency > 0 && (this.mCurrent % frequency) == 0) {
	    document.getElementById("ad-wrapper").style.left = "0";
	    setTimeout('hideAndClearRMNAd()', duration);
	}
*/
 }
 
 JphSlider_Behavior.prototype.PlayPressed			=	function( e)
 {
	
	this.mrSlider.mrSlideshow.TogglePlay();
 }
 
 JphSlider_Behavior.prototype.PausePressed			=	function( e)
 {
	
	this.mrSlider.mrSlideshow.TogglePlay();
 }
 
 // ORIENTATION
 JphSlider_Behavior.prototype._OrientationChanged	=	function( e)
 {
	
	if (this.mrSlider.mVisible)
	{
		this.mrSlider.Hide();
		set_timeout( this.mrSlider, 'Show', '', 100);
	}	
	this.mrSlider.RepaintPosition();

 }
				
function Jph_SafariHistory( app)
{
	this.mrApp	=	app;
	
	this.mStartupMode		=	null;
	this.mMode				=	null;
	this.mIndex				=	0;
	this.mFirtsTimeSlider	=	true;
	
	this.mTrackValue		=	'';
	this.mTrackPattern		=	'/?nats';	
	
	implement_events( this);
}

Jph_SafariHistory.prototype.Init = function(index)
{
	this._CheckLoacation();
	set_interval( this, '_CheckLoacation', '', 500);
}

 Jph_SafariHistory.prototype._CheckLoacation = function()
 {
 	var last_index	=	this.mIndex;	
 	var last_mode	=	this.mMode;	
	
	this._Refresh();

	if (last_index != this.mIndex || last_mode != this.mMode)
	{
	//	this.FireEvent('LocationChanged');
	}
 }	

Jph_SafariHistory.prototype._Refresh = function(index)
{
	var hash = document.location.hash;
	var parts	=	hash.split( this.mTrackPattern);
	if (parts.length > 1)
	{
		this.mTrackValue	=	this.mTrackPattern + parts[1];
		hash				=	parts[0];
	}

	hash = hash.replace('#', '');
	
	if (hash) 
	{
		var args = hash.split('-');
		if (args.length > 1) {
			this.mMode = args[0];
			this.mIndex = parseInt( args[1]);
		}
		else 
		{
			var value = args[0];
			
			if (value == parseInt(value)) 
			{
				this.mMode	=	GALLERY_STARTUP_SLIDER;
				this.mIndex = 	parseInt( value);
			}
			else 
				this.mMode = value;
		}
	}
	else {
		this.mMode = this.mrApp.mDefaultMode;
		this.mIndex = 0;
	}
	
	if (this.mStartupMode == null)
		this.mStartupMode	=	this.mMode;
}
	

Jph_SafariHistory.prototype.SelectSlide	=	function( index)
{
	if (this.mStartupMode == GALLERY_STARTUP_THUMBNAILS &&
	 this.mFirtsTimeSlider)
	 {
	 //	document.location.hash	=	index + this.mTrackValue;
		this.mFirtsTimeSlider	=	false;
	 }
	 else
	 {
	 //	document.location.replace( '#' + index + this.mTrackValue);
	 }
	 
	this.mMode 	= 	GALLERY_STARTUP_SLIDER;
	this.mIndex = 	index;
}

Jph_SafariHistory.prototype.SelectThumbnails	=	function()
{
	this.mMode 	= 	GALLERY_STARTUP_THUMBNAILS;
	this.mIndex = 	0;
	
	// document.location.hash	=	'thumbs' + this.mTrackValue;
}
				
function Jph_NaviButton( htmlId)
 {
	this.mHtmlId	=	htmlId;
	this.mhImage;
 }
 
 Jph_NaviButton.prototype.Init		=	function()
 {
	this.mhImage	=	document.getElementById( this.mHtmlId);
 }
 
 Jph_NaviButton.prototype.Hide		=	function()
 {
 	this.mhImage.style.display	=	'none';
 }
 Jph_NaviButton.prototype.Show		=	function()
 {
 	this.mhImage.style.display	=	'block';
 }
 Jph_NaviButton.prototype.Disable	=	function()
 {
 	this.mhImage.style.opacity	=	'0.30';
 }
 Jph_NaviButton.prototype.Enable	=	function()
 {
 	this.mhImage.style.opacity	=	'1.00';
 }
				
function Jph_Image( index, src, thumbSrc, title, desc, credit, share, track)
 {
 	if (title==undefined)
		title =	'';
 	if (desc==undefined)
		desc =	'';
 	if (credit==undefined)
		credit =	'';
 	if (share==undefined)
		share =	'';
			
 	this.mIndex		=	index;
 	this.mSrcThumb	=	thumbSrc;
	this.mSrc		=	src;
	this.mTitle		=	title;	
	this.mDesc		=	desc;	
	this.mCredit	=	credit;	
	this.mShare		=	share;	
	this.mTrack		=	track;
	
 }
 
 
 Jph_Image.prototype.HasText		=	function()
 {
 	if (this.mTitle == '' && this.mDesc == '')
		return false;
	return true;
 }
				
function Jph_History( app)
{
	this.mrApp	=	app;
	
	this.mStartupMode		=	null;
	this.mMode				=	null;
	this.mIndex				=	0;
	this.mFirtsTimeSlider	=	true;
	
	this.mTrackValue		=	'';
	this.mTrackPattern		=	'/?nats';	
	
	implement_events( this);
}

Jph_History.prototype.Init = function(index)
{
	this._CheckLoacation();
	set_interval( this, '_CheckLoacation', '', 500);
}

 Jph_History.prototype._CheckLoacation = function()
 {
 	var last_index	=	this.mIndex;	
 	var last_mode	=	this.mMode;	
	
	this._Refresh();

	if (last_index != this.mIndex || last_mode != this.mMode)
	{
		this.FireEvent('LocationChanged');
	}
 }	

Jph_History.prototype._Refresh = function(index)
{
	var hash = document.location.hash;
	var parts	=	hash.split( this.mTrackPattern);
	if (parts.length > 1)
	{
		this.mTrackValue	=	this.mTrackPattern + parts[1];
		hash				=	parts[0];
	}

	hash = hash.replace('#', '');
	
	if (hash) 
	{
		var args = hash.split('-');
		if (args.length > 1) {
			this.mMode = args[0];
			this.mIndex = parseInt( args[1]);
		}
		else 
		{
			var value = args[0];
			
			if (value == parseInt(value)) 
			{
				this.mMode	=	GALLERY_STARTUP_SLIDER;
				this.mIndex = 	parseInt( value);
			}
			else 
				this.mMode = value;
		}
	}
	else {
		this.mMode = this.mrApp.mDefaultMode;
		this.mIndex = 0;
	}
	
	if (this.mStartupMode == null)
		this.mStartupMode	=	this.mMode;
}
	

Jph_History.prototype.SelectSlide	=	function( index)
{
	if (this.mStartupMode == GALLERY_STARTUP_THUMBNAILS &&
	 this.mFirtsTimeSlider)
	 {
	 	document.location.hash	=	index + this.mTrackValue;
		this.mFirtsTimeSlider	=	false;
	 }
	 else
	 {
	 	document.location.replace( '#' + index + this.mTrackValue);
	 }
	 
	this.mMode 	= 	GALLERY_STARTUP_SLIDER;
	this.mIndex = 	index;
}

Jph_History.prototype.SelectThumbnails	=	function()
{
	this.mMode 	= 	GALLERY_STARTUP_THUMBNAILS;
	this.mIndex = 	0;
	
	document.location.hash	=	'thumbs' + this.mTrackValue;
}
				
function Jph_Dao()
 {
 	this.maImages				=	new Array();
 }
 
 Jph_Dao.prototype.AddImage 	= function( img)
 {
 	this.maImages[img.mIndex]	=	img;
 } 
 
 Jph_Dao.prototype.ReadImages	=	function()
{
	var i=0;
	do
	{
		var id			=	arguments[i++];
		var src			=	arguments[i++];
		var src_thumb	=	arguments[i++];
		var title		=	arguments[i++];
		var desc		=	arguments[i++];
		var credit		=	arguments[i++];
		var share		=	arguments[i++];
		var track		=	arguments[i++];
		
		this.AddImage( new Jph_Image( id, src, src_thumb, title, desc, credit, share, track));	
	}
	while (i<arguments.length) 
}

 Jph_Dao.prototype.ReadImage		=	function( id, src, thumbSrc, title, desc, credit, share, track)
{
// function Jph_Image( index, src, thumbSrc, title, desc, credit, share)	
	
	var obj			=	new Jph_Image();
	obj.mIndex		=	id;
 	obj.mSrcThumb	=	thumbSrc;
	obj.mSrc		=	src;
	obj.mTitle		=	title;	
	obj.mDesc		=	desc;	
	obj.mCredit		=	credit;	
	obj.mShare		=	share;	
	obj.mTrack		=	track;

	this.AddImage( obj);	
}

 Jph_Dao.prototype.GetImage			=	function( url)
 {
	for (var i in this.maImages)
	{
		var image		=	this.maImages[i];
		if ( image.src == url)
			return image;
	}

	throw new Error('Image [' + url + '] not found');
 } 
 
 Jph_Dao.prototype.GetImagesCount = function()
 {
 	return this.maImages.length;
 }
				
var GALLERY_STARTUP_THUMBNAILS	=	'thumbs';
 var GALLERY_STARTUP_SLIDER		=	'slider';
 var GALLERY_STARTUP_SLIDE_SHOW	=	'slideshow';


 function Jph_Application( dao, orientation, splash)
 {
	this.mrDao				=	dao;	
	this.mrOrientation		=	orientation;
	this.mhSplash			=	splash;
	
	this.mrSlider			=	null;
	this.mrThumbnails		=	null;

	this.mrHistory			=	null;
	
	this.mDefaultMode		=	DEFAULT_STARTUP_MODE;
 }
 /*******************************************/
 /*			INIT							*/
 /*******************************************/
 Jph_Application.prototype.Init		=	function()
 {
	this.mrSlider		=	new JphSlider_Slider( this, 0);
	this.mrSlider.Create();

	this.mrThumbnails	=	new JphThumbs_Manager( this);
	this.mrThumbnails.Create();
	
	if (ENABLE_SAFARI_HISTORY_PATCH)
		this.mrHistory		=	new Jph_SafariHistory( this);
	else
		this.mrHistory		=	new Jph_History( this);
		
	this.mrHistory.Init();
	
	this.mrHistory.AttachListener( 'LocationChanged', this, '_OnLocationChanged');
	
 }
 
 Jph_Application.prototype.Run		=	function()
 {
	 	
	if (GALLERY_STARTUP_THUMBNAILS == this.mrHistory.mMode)
	{
		this.ShowThumbsAction();
	}
	else if (GALLERY_STARTUP_SLIDER == this.mrHistory.mMode)
	{	
		this.mrSlider.Init();
		this.mrSlider.mrToolbars.Show();
		this.ShowSliderAction( this.mrHistory.mIndex);
	}
	else if (GALLERY_STARTUP_SLIDE_SHOW == this.mrHistory.mMode)
	{	
		this.mrSlider.Init();
		this.mrSlider.mrToolbars.Show();
		this.StartSlideshw( this.mrHistory.mIndex);
	}
	else
	{
		throw new Error('Invalid mode ['+this.mrHistory.mMode+']');	
	}
 } 

 /*******************************************/
 /*			EVENTS							*/
 /*******************************************/  
 Jph_Application.prototype._OnLocationChanged = function()
 {
 	this.Run();
 }

 /*******************************************/
 /*			ACTIONS							*/
 /*******************************************/
 Jph_Application.prototype.ShowThumbsAction		=	function()
 {
	this.NormalizeVertical();
		
	this.mrSlider.Hide();
	this.mrSlider.mrSlideshow.StopSlideshow();		
	
	this.mrThumbnails.Show();	
	this.mrHistory.SelectThumbnails();
 }
 
 Jph_Application.prototype.ShowSliderAction		=	function( index)
 { 	
	index	=	parseInt(index);
	
	this.NormalizeVertical();
	this.mrThumbnails.Hide();
	
	this.mrSlider.SelectSlide( index);
	this.mrSlider.Show();
	
 }
 
 Jph_Application.prototype.StartSlideshw		=	function( index)
 { 	
	this.ShowSliderAction( index);
	this.mrSlider.mrSlideshow.TogglePlay();
 }
 
 
 /*******************************************/
 /*			UTIL							*/
 /*******************************************/  
  
 Jph_Application.prototype.NormalizeVertical = function()
 {
	setTimeout('scrollTo(0,1)',100);
 }
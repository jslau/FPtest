

function JphSlider_SlidesComponent( app, images, container)
 {
 	this.mrApp				=	app;
 	this.mrContainer		=	app.mrContainer;
 	this.maImages			=	images;
 	this.mhContainer		=	container;
 	
 	this.mhSliderTable		=	null;
	
	this.mCurrent			=	0;
	this.mrCurrentSlide		=	null;
	
	this.maSlides			=	new Array();
	
	this.mrBehavior			=	this.mrApp.mrSlider.mrBehavior;
	this.mrPreloader		=	this.mrApp.mrSlider.mrPreloader;
	this.mrImageQueue		=	this.mrApp.mrSlider.mrImageQueue;
	
	this.mReverse			=	false;
	
	this.mLeft				=	0;
	
	this.mrAnimation		=	null;
	
	
	implement_events( this);
 }
 

 JphSlider_SlidesComponent.prototype.Init		=	function()
 {
 	debug('slider: Init()');
	
	debug('slider: creaiting slides');
	var last_slide	=	null;
	for (var i in this.maImages)
	{
		var image 	=	this.maImages[i];
		var slide	=	new JphSlider_Slide( this.mrContainer, this.mrPreloader, this.mrImageQueue, image);	
		this.maSlides[image.mIndex]	=	slide;
		
		if (last_slide != null)
		{
			last_slide.mrNext 	= 	slide;
			slide.mrPrevious	=	last_slide;	
		}
		
		last_slide	=	slide;
	} 	
	
	
	prepend_html( this.mhContainer, this._HtmlSlider());
	
	
	this.mhSliderTable				=	document.getElementById('slider-table');
	
	var factory						=	new JphUtil_AnimationFactory( this.mhSliderTable);
	this.mrAnimation				=	factory.GetAnimation();
	
//	this.mrAnimation				=	new JphSlider_Animation( this.mhSliderTable);
//	this.mrAnimation.Init();
	
	debug('slider: initializing slides');
	for (var i in this.maSlides) 
	{
		this.maSlides[i].Init();
	}
	
	
	this.mrCurrentSlide		=	this.maSlides[this.mCurrent];	
	
	var slider_mover		= 	new JphUtil_Touches( this.mhSliderTable, true);
	slider_mover.AttachListener( 'TouchEnd', this.mrBehavior, 'SlideTouched');
	slider_mover.AttachListener( 'MovedLeft', this.mrBehavior, 'SlideDraggedLeft');
	slider_mover.AttachListener( 'MovedRight', this.mrBehavior, 'SlideDraggedRight');
	slider_mover.AttachListener( 'Moving', this.mrBehavior, 'SlideDragging');
	slider_mover.AttachListener( 'MoveCancel', this, 'RepaintPosition');
	slider_mover.Init();

	this.mrContainer.AttachListener( 'ContainerResized', this, 'ContainerResized');
	this.ContainerResized();
	
	this.AttachListener( 'SlideChanged', this.mrBehavior, 'SlideChanged');
	
	debug('slider: Init() - End');
 };


 JphSlider_SlidesComponent.prototype._HtmlSlider		=	function()
 {
 	debug('slider: Html()');
 	
 	var str		=	new Array();
	var cnt		=	0;
			
	str[cnt++]	=	'<table id="slider-table" cellspacing="0" cellpadding="0" style="position: absolute;">';
	str[cnt++]	=	'<tr>';
	for (var i in this.maSlides)
	{
		str[cnt++]	=	this.maSlides[i].HtmlSlide();
	} 	
	str[cnt++]	=	'</tr>';
	str[cnt++]	=	'</table>';
	
	return str.join('');
 };
 
 
 /*******************************************/
 /*			SLIDER - NAVIGATION				*/
 /*******************************************/  
 
 // ACTINS
 
 JphSlider_SlidesComponent.prototype.Previous		=	function()
 {
 	debug('slider: Previous()');
 	if (this.IsFirst())
	{
 		// TODO: first reached event
//		this.mrToolbars.Show();
		return ;
	}
	
	this.mReverse	=	true;
	this.SelectSlide( this.mCurrent - 1);
 };
 
 JphSlider_SlidesComponent.prototype.Next			=	function()
 {
 	debug('slider: Next()');
 	if (this.IsLast())
	{
 	// TODO: last reached event
//		this.mrToolbars.Show();
		return ;
	}
	
	this.mReverse	=	false;
	this.SelectSlide( this.mCurrent + 1);
 };

 JphSlider_SlidesComponent.prototype.SelectSlide		=	function( index)
 { 	
	debug('slider: SelectSlide() ['+index+']');
		
 	var last_slide			=	this.mrCurrentSlide;
 	this.mrCurrentSlide		=	this.maSlides[index];	
	this.mCurrent			=	index;

	if (!this.mrCurrentSlide)
		throw Error('Slide not found by index ['+index+']');

	this.mrCurrentSlide.SetActive();
	
	if (last_slide)
		last_slide.SetInactive();
	
	this.RepaintPosition();
	
	this.FireEvent('SlideChanged');
	
 };
 
// EVENT LISTENERS
JphSlider_SlidesComponent.prototype.ContainerResized	=	function( e)
{
 	debug('slider: -------------');
 	debug('slider: ContainerResized()');
 	debug('resize: slider - ContainerResized()');
 	
	this.mhSliderTable.style.height = 	this.mrContainer.GetHeight() + 'px';
	this.mhSliderTable.style.width	=	this._GetTotalWidth()+'px';
};

// INFO
 JphSlider_SlidesComponent.prototype.IsLast	=	function()
 {
 	if ((this.mCurrent + 1) == this.maImages.length)
		return true;	
	return false;
 };
 
 JphSlider_SlidesComponent.prototype.IsFirst	=	function()
 {
 	if (this.mCurrent == 0)
		return true;	
	return false;
 };
 
 
 // UTIL

 JphSlider_SlidesComponent.prototype.RepaintPosition	=	function( immediate)
 {
	this.mLeft	=	this._GetPositionLeft( this.mCurrent);
	
	if (typeof( immediate) == 'boolean' && immediate)
		immediate = true;
	else
		immediate = false;
	
	if (immediate)
	{
		this.mrAnimation.SetTo( this.mLeft);
	}
	else
	{
		this.mrAnimation.SlideTo( this.mLeft);
	}
 };
 
 JphSlider_SlidesComponent.prototype.MovePosition	=	function( move)
 {
	 var left	=	this.mLeft + move;
	 
	 if (left > MIN_DISTANCE_TO_BE_A_DRAG)
		 return;
	 
	 if (left <  - (this._GetTotalWidth() - this.mrContainer.GetWidth() + MIN_DISTANCE_TO_BE_A_DRAG))
		 return;	 
	 
	 this.mLeft	=	left;
	 
	 this.mrAnimation.SetTo( this.mLeft);
 };
 
 JphSlider_SlidesComponent.prototype._GetTotalWidth		=	function()
 {
	 var count	=	this.maImages.length;
	 var space	=	SLIDE_SPACE_WIDTH * (count - 1);
	 return count * this.mrContainer.GetWidth() + space;
 };
 
 JphSlider_SlidesComponent.prototype._GetPositionLeft	=	function( index)
 {
	 var width	=	
		 this.mrContainer.GetWidth() + SLIDE_SPACE_WIDTH;
	 return width * index * -1;
 };

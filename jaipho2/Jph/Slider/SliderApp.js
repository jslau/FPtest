
function JphSlider_SliderApp( app)
 {
 	this.mrApp				=	app;
 	this.mrContainer		=	this.mrApp.mrContainer;
 	this.mhSliderDiv		=	null;
 	this.mrSlidesComponent	=	null;
 	
 	
	this.mrToolbars			=	null;	
	this.mrSliderNavi		=	null;
	this.mrSlideshow		=	null;
	this.mrCompnents		=	null;
	
	
	this.mhTopBar			=	null;
	this.mhBottomBar		=	null;
	
	this.mrPreloader		=	null;
	this.mrImageQueue		=	null;	
	this.mrBehavior			=	null;
 }
 

 JphSlider_SliderApp.prototype.Init		=	function()
 {
 	debug('slider-app: Init()');
	
 	// temp solution - mrContainer should be enough
 	this.mhSliderDiv		=	document.getElementById('slider-container');
 	
	this.mhTopBar			=	document.getElementById('slider-toolbar-top');
	this.mhBottomBar		=	document.getElementById('slider-toolbar-bottom');
 	
	this.mrPreloader		=	new JphUtil_Preloader( MAX_CONCURENT_LOADING_SLIDE);
	this.mrImageQueue		=	new JphSlider_ImageQueue( SLIDE_MAX_IMAGE_ELEMENS);	
 	
	this.mrBehavior			=	new JphSlider_Behavior( this);
	this.mrBehavior.Init();
	
	this.mrSlidesComponent	=	new JphSlider_SlidesComponent( this.mrApp, this.mrApp.mrDao.maImages, this.mhSliderDiv);
	this.mrSlidesComponent.Init();
	
	this.mrSlideshow		=	new JphSlider_SlideShow( this);
	
	this.mrSliderNavi		=	new JphSlider_SliderControls( this);
	this.mrSliderNavi.Init();
	
	this.mrToolbars			=	new JphSlider_ToolbarsManager();
	this.mrToolbars.Register( this.mhTopBar);
	this.mrToolbars.Register( this.mhBottomBar);
	
	
	this.mrDescription		=	new JphSlider_Description( this.mrApp, this.mrToolbars.GetSingleHeight());
	this.mrDescription.Init();
	
	
	this.mrCompnents		=	new JphSlider_ComponentVisibility( this);
	
	// TODO: refactor
	var top_tool_touch		= 	new JphUtil_Touches( this.mhTopBar, false);
	top_tool_touch.AttachListener( 'TouchEnd', this.mrBehavior, 'ToolbarTouched');
	top_tool_touch.Init();
	
	var bottom_tool_touch	= 	new JphUtil_Touches( this.mhBottomBar, false);
	bottom_tool_touch.AttachListener( 'TouchEnd', this.mrBehavior, 'ToolbarTouched');
	bottom_tool_touch.Init();
	
	var text_mover			= 	new JphUtil_Touches( this.mrDescription.mhDescTitle, true);
	text_mover.AttachListener( 'TouchEnd', this.mrBehavior, 'DescriptionTouched');	
	text_mover.Init();
	
	var title_mover			= 	new JphUtil_Touches( this.mrDescription.mhDescText, true);
	title_mover.AttachListener( 'TouchEnd', this.mrBehavior, 'DescriptionTouched');	
	title_mover.Init();
	
	
	var slider_mover		= 	new JphUtil_Touches( this.mrDescription.mhDescContainer, true);
	slider_mover.AttachListener( 'TouchEnd', this.mrBehavior, 'SlideTouched');
	slider_mover.AttachListener( 'MovedLeft', this.mrBehavior, 'SlideDraggedLeft');
	slider_mover.AttachListener( 'MovedRight', this.mrBehavior, 'SlideDraggedRight');
	slider_mover.AttachListener( 'Moving', this.mrBehavior, 'SlideDragging');
	slider_mover.AttachListener( 'MoveCancel', this.mrSlidesComponent, 'RepaintPosition');
	slider_mover.Init();
	

	this.mrContainer.AttachListener( 'ContainerResized', this, 'ContainerResized');
	this.ContainerResized();
	
	debug('slider-app: Init() - End');
 };


 /*******************************************/
 /*			SLIDER - NAVIGATION				*/
 /*******************************************/  
 
 // ACTINS
 JphSlider_SliderApp.prototype.Hide			=	function()
 {
 	debug('slider-app: Hide()');
		
	this.mhSliderDiv.style.display			=	'none';
		
	this.mrDescription.Hide();
	this.mrToolbars.Hide();
 };
 
 JphSlider_SliderApp.prototype.Show			=	function()
 {
 	debug('slider-app: Show()');
	
	this.mhSliderDiv.style.display			=	'block';
	this.mrToolbars.Show();
	
	this.mrCompnents.Show();
 };
 
 JphSlider_SliderApp.prototype.IsVisible		=	function()
 {
	 debug('slider-app: IsVisible()');
	 
	 if (this.mhSliderDiv.style.display == 'block')
		 return true;
	 return false;
 };
 JphSlider_SliderApp.prototype.HideTable		=	function()
 {
 	debug('slider-app: Hide()');
		
 	this.mrSlidesComponent.mhSliderTable.style.display			=	'none';
 };
 
 JphSlider_SliderApp.prototype.ShowTable		=	function()
 {
 	debug('slider-app: Show()');
	
	this.mrSlidesComponent.mhSliderTable.style.display			=	'block';
 };
 
 
 JphSlider_SliderApp.prototype.SetDefaultSlide		=	function( index)
 { 	
	 this.mrSlidesComponent.SelectSlide( index);
 };
 
// EVENT LISTENERS
JphSlider_SliderApp.prototype.ContainerResized	=	function( e)
{
 	debug('slider-app: -------------');
 	debug('slider-app: ContainerResized()');
 	debug( 'resize: slider - ContainerResized()');
 	
 	
	this.mhSliderDiv.style.width = this.mrContainer.GetWidth() + 'px';
	this.mhSliderDiv.style.height = this.mrContainer.GetHeight() + 'px';
	
	var padding			=	this.mrToolbars.GetHeight(); // top & bottom
	var padded_height	=	this.mrContainer.GetHeight() - padding;
	this.mrDescription.mhDescContainer.style.height = 	padded_height + 'px';
};


 // REPAINT
 JphSlider_SliderApp.prototype.RepaintInfo		=	function()
 {
	debug('slider-app: RepaintInfo()');
 	var count	=	this.mrApp.mrDao.GetImagesCount();
 	var current	=	this.mrSlidesComponent.mCurrent + 1;
	this.mrSliderNavi.mhInfo.innerHTML	=	current + ' of ' + count;
 };
 
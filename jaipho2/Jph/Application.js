				
 var GALLERY_STARTUP_THUMBNAILS	=	'thumbs';
 var GALLERY_STARTUP_SLIDER		=	'slider';
 var GALLERY_STARTUP_SLIDE_SHOW	=	'slideshow';

function Jph_Application( dao)
{
	this.mrDao				=	dao;	
	this.mrOrientation		=	null;
	this.mrContainer		=	null;
	
	this.mrContainerFactory	=	new JphUtil_JaiphoContainerFactory();
	
	this.mrSlider			=	null;
	this.mrThumbnails		=	null;

	this.mrHistory			=	null;
	
	
	this.mDefaultMode		=	DEFAULT_STARTUP_MODE;
	
	this.mVerticalTimeout	=	null;
	debug('app: Init');
	
}

/*******************************************/
/*			INIT							*/
/*******************************************/
Jph_Application.prototype.Init		=	function()
{
 	debug('app: Init');
 	
	 this.mrContainer	=	this.mrContainerFactory.GetContainer();
	 
	 this.mrOrientation	=	new JphUtil_OrientationManager( this.mrContainer);
//		this.mrOrientation.LockWidthAt( 320);
	 this.mrOrientation.Init();	 
	 
	 
//	this.mrSlider		=	new JphSlider_SliderApp( this);
//	this.mrSlider.Init();
//	
//	this.mrThumbnails	=	new JphThumbs_ThumbsApp( this);
//	this.mrThumbnails.Init();
//	
	if (ENABLE_SAFARI_HISTORY_PATCH)
		this.mrHistory		=	new Jph_SafariHistory( this);
	else
		this.mrHistory		=	new Jph_History( this);
		
	this.mrHistory.Init();
	
	this.mrHistory.AttachListener( 'LocationChanged', this, '_OnLocationChanged');
	
	var back	=	document.getElementById('slider-back-button');
	if (back)
	{
		var mover	= new JphUtil_Touches( back, true);
//		mover.AttachListener( 'TouchStart', this.mrBehavior, 'ThumbTouched', this.maThumbnails[i]);	
		mover.AttachListener( 'TouchEnd', this, 'ShowThumbsAction');	
//		mover.Init();
	}
	
//	attach_method( back, 'onclick', this, 'ShowThumbsAction');
};
 
 Jph_Application.prototype.Run		=	function()
 {
 	debug('--------------------------');
 	debug('app: Run[' + this.mrHistory.mMode + '][' + this.mrHistory.mIndex + ']');
	 	
	if (GALLERY_STARTUP_THUMBNAILS == this.mrHistory.mMode)
	{
		this.ShowThumbsAction();
	}
	else if (GALLERY_STARTUP_SLIDER == this.mrHistory.mMode)
	{	
		this.ShowSliderAction( this.mrHistory.mIndex);
	}
	else if (GALLERY_STARTUP_SLIDE_SHOW == this.mrHistory.mMode)
	{	
		this.StartSlideshow( this.mrHistory.mIndex);
	}
	else
	{
		throw new Error('Invalid mode ['+this.mrHistory.mMode+']');	
	}
 };
 
 Jph_Application.prototype.GetSliderApp = function()
 {
	if (!this.mrSlider)
	{
		this.mrSlider		=	new JphSlider_SliderApp( this);
		this.mrSlider.Init();
	}
	
	return this.mrSlider;
 };
 Jph_Application.prototype.GetThumbnailsApp = function()
 {
	if (!this.mrThumbnails)
	{
		this.mrThumbnails	=	new JphThumbs_ThumbsApp( this);
		this.mrThumbnails.Init();
	}
	
	return this.mrThumbnails;
 };

 /*******************************************/
 /*			EVENTS							*/
 /*******************************************/  
 Jph_Application.prototype._OnLocationChanged = function()
 {
 	this.Run();
 };

 /*******************************************/
 /*			ACTIONS							*/
 /*******************************************/
 Jph_Application.prototype.ShowThumbsAction		=	function()
 {
 	debug('app: ShowThumbsAction()');
	
 	var thumbs	=	this.GetThumbnailsApp();
 	
 	if (this.mrSlider)
 	{
 		this.mrSlider.Hide();
 		this.mrSlider.mrSlideshow.StopSlideshow();		
 		this.mrSlider.mrToolbars.Hide();
 	}

 	thumbs.Show();	
	this.mrHistory.SelectThumbnails();
	
	this.NormalizeVertical();
 };
 
 Jph_Application.prototype.ShowSliderAction		=	function( index)
 { 	
	debug('app: ShowSliderAction( '+this.mrHistory.mIndex+')');
	index	=	parseInt(index);
	
 	var slider	=	this.GetSliderApp();
	
 	if (this.mrThumbnails)
 		this.mrThumbnails.Hide();
	
	slider.SetDefaultSlide( index);
	slider.Show();
	slider.mrToolbars.Show();
	
	this.NormalizeVertical();
 };
 
 Jph_Application.prototype.StartSlideshow		=	function( index)
 { 	
	debug('app: StartSlideshow( '+index+')');
	
	this.ShowSliderAction( index);
	this.mrSlider.mrSlideshow.TogglePlay();
	this.mrSlider.mrToolbars.Show();
 };
 
 
 /*******************************************/
 /*			UTIL							*/
 /*******************************************/  
  
 Jph_Application.prototype.NormalizeVertical = function()
 {
 	debug('app: NormalizeVertical()');
 	if (this.mVerticalTimeout)
 		clearTimeout( this.mVerticalTimeout);
 	this.mVerticalTimeout	=	setTimeout('scrollTo(0,0)',100);
 };
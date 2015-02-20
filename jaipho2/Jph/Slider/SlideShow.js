
		
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
 	debug('--------------------------');
 	debug( 'slideshow: TogglePlay()');
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
 	debug( 'slideshow: StopSlideshow()');
 	debug( 'slideshow: clearTimeout( '+this.mSlideTimeout+')');
 	clearTimeout( this.mSlideTimeout);
	this.mSlideTimeout	=	null;	
 }
 
 JphSlider_SlideShow.prototype._RollSlideshow	=	function()
 {
 	debug('--------------------------');
	debug('slideshow: _RollSlideshow()');
	debug('slideshow: moving next');
 	this.mrSlider.mrSlidesComponent.Next();
	
	if (this.mrSlider.mrSlidesComponent.IsLast())
	{		
		debug('slideshow: it is last');
		this.StopSlideshow();
		this.mrSlider.mrSliderNavi.CheckButons();
		this.mrSlider.mrToolbars.Show();
	}
	
	if (this.IsActive())
	{
		debug('slideshow: requesting next');
		this._RequestNext();		
	}
 };
 

 
 JphSlider_SlideShow.prototype._RequestNext	=	function()
 { 		
 	debug( 'slideshow: _RequestNext()');
	this.mSlideTimeout		=	set_timeout( this, '_RollSlideshow', '', SLIDESHOW_ROLL_TIMEOUT);	
 }
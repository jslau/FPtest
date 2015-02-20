 function JphUtil_Touches( container, prventDefaults)
 {
 	this.mhContainer		=	container;
	this.mPreventDefaults	=	prventDefaults && BLOCK_VERTICAL_SCROLL;
	
	implement_events( this);
 }

 JphUtil_Touches.prototype.Init	=	function()
 {
	if (this._IsTouchable())
	{
	 	attach_method( this.mhContainer, 'ontouchstart', this, '_OnTouchStart');	
	 	attach_method( this.mhContainer, 'ontouchend', this, '_OnTouchEnd');
	 	attach_method( this.mhContainer, 'ontouchmove', this, '_OnTouchMove');
	 	attach_method( this.mhContainer, 'ontouchcancel', this, '_OnTouchCancel');				
	}
	else
	{
		attach_method( this.mhContainer, 'onclick', this, '_OnTouchEnd');
	}

	
	this.mMoving		=	false;
	this.mTouching 		= 	false;
	
	this.mOriginalX		=	null;
	this.mCurrentX		=	null;
	this.mScrollX		=	null;
	
	this.mOriginalY		=	null;
	this.mCurrentY		=	null;
	this.mScrollY		=	null;
	
 }
 
 JphUtil_Touches.prototype._IsTouchable = function()
 {
	try
	{
		document.createEvent('TouchEvent');
	}
	catch (e)
	{
		return false;
	}
	
	return true;
 }
 
  
// EVENT HANDLERS
 JphUtil_Touches.prototype._OnTouchStart		=	function( e)
 {
	
	if (e.touches.length == 1) 
	{
		this.mMoving		=	false;
		this.mTouching 		= 	true;
		var touch 			= 	e.touches[0];
		// If they user tries clicking on a link
		if(touch.target.onclick) 
		{
			touch.target.onclick();
		}
		// The originating X-coord (point where finger first touched the screen)
		this.mOriginalX = touch.pageX;
		this.mCurrentX 	= this.mOriginalX;
		this.mScrollX 	= 0;
		
		this.mOriginalY = touch.pageY;
		this.mCurrentY 	= this.mOriginalY;
		this.mScrollY 	= 0;		
		
		this.FireEvent( 'TouchStart', e);
		
	}
	
 }


 JphUtil_Touches.prototype._OnTouchMove		=	function( e)
 {
	if (this.mPreventDefaults)
		e.preventDefault();

	if (e.touches.length == 1) 
	{
		var touch 		=	e.touches[0];
		this.mCurrentX 	= 	touch.pageX;
		this.mCurrentY 	= 	touch.pageY;
		this.mMoving	=	true;
		this.mTouching	=	false;
	}

 }
 
 JphUtil_Touches.prototype._OnTouchEnd			=	function( e)
 {
 	this.mScrollX 	= 	this.mOriginalX - this.mCurrentX;
	this.mScrollY 	= 	this.mOriginalY - this.mCurrentY;

 	if (this.mMoving) 
	{

		if (this.mOriginalX > this.mCurrentX) 
		{
			this.mScrollX 	= 	this.mOriginalX-this.mCurrentX;
			if (this.mScrollX > MIN_DISTANCE_TO_BE_A_DRAG) 
			{
				this.FireEvent( 'MovedLeft', e);
			}
		} 
		else 
		{
			this.mScrollX 	= 	this.mCurrentX-this.mOriginalX;
			if (this.mScrollX > MIN_DISTANCE_TO_BE_A_DRAG) 
			{
				this.FireEvent( 'MovedRight', e);
			}
		}
		
		if (this.mOriginalY > this.mCurrentY) 
		{
			this.mScrollY 	= 	this.mOriginalY-this.mCurrentY;
			if (this.mScrollY > MIN_DISTANCE_TO_BE_A_DRAG) 
			{
				this.FireEvent( 'MovedUp', e);
			}
		} 
		else 
		{
			this.mScrollY 	= 	this.mCurrentX-this.mOriginalY;
			if (this.mScrollY > MIN_DISTANCE_TO_BE_A_DRAG) 
			{
				this.FireEvent( 'MovedDown', e);
			}
		}
	}
	else 
	{
		this.FireEvent('TouchEnd', e);
	}

	this.mMoving		=	false;
 	this.mTouching 		= 	false;		
 }
  
 JphUtil_Touches.prototype._OnTouchCancel		=	function( e)
 {
 	this._OnTouchEnd( e)
 }
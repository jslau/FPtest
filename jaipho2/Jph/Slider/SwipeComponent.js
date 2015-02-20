
			
function JphSlider_SwipeComponent( container, preloader, queue, image)
{
	this.DEFAULT_CELL_COUNT		=	3;
	
	this.mrContainer	=	container;
	
	this.mrAnimation	=	null;
	
	this.mhTable		=	null;
	this.mPotention		=	0;
	
	this.mrActiveSlide	=	null;
	this.maSlides		=	{};
}

JphSlider_SwipeComponent.prototype.Init = function()
{
	var factory						=	new JphUtil_AnimationFactory( this.mhSliderTable);
	this.mrAnimation				=	factory.GetAnimation();
	
	for (i=0; i<this.DEFAULT_CELL_COUNT; i++)
	{
		this.maSlides[i]	=	new JphSlider_SwipeComponentCell( this, i);
		this.maSlides[i].Init();
	}
};
 
// NAVIATION
JphSlider_SwipeComponent.prototype.Next = function()
{
	this._ExpandRight( false);
	this._SwipeBack();
};

JphSlider_SwipeComponent.prototype.Previous = function()
{
	
};

JphSlider_SwipeComponent.prototype._ExpandRight = function( reverse)
{
	var row		=	this.mhTable.rows[0];
	var cell	=	row.cells[0];
	
	row.appendChild( cell);
	
	// table swap places
		// first td -> last
	// inverse potention
};

JphSlider_SwipeComponent.prototype._SwipeBack = function()
{
	this.mrAnimation.SlideTo( 0);
	// webkit padding animationa
};

// EVENTS
// end boundary
// start boundary
// 


JphSlider_SwipeComponent.prototype.toString	=	function()
{
	return '[JphSlider_SwipeComponent]';
};
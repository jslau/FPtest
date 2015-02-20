
function JphSlider_Animation( elem)
{
	this.mhElement	=	elem;
	this.mUse2d		=	false;
}

JphSlider_Animation.prototype.Init	=	function()
{
	this.mUse2d		=	this._ShouldUse2d();
};

JphSlider_Animation.prototype._ShouldUse2d = function()
{
	var android	=	navigator.userAgent.match(/Android/i);
	
	if(android)
		return true;
	return false;
};

JphSlider_Animation.prototype.SlideTo	=	function( position)
{
	this.mhElement.style.WebkitTransition	=	"-webkit-transform "+SLIDE_SCROLL_DURATION+" ease";
	this._Transform( position);
};

JphSlider_Animation.prototype.SetTo		=	function( position)
{
	this.mhElement.style.WebkitTransition	=	"";
	this._Transform( position);
};

JphSlider_Animation.prototype._Transform		=	function( position)
{
	if (this.mUse2d)
		this.mhElement.style.WebkitTransform	=	"translate( "+ position + "px,0)";
	else
		this.mhElement.style.WebkitTransform	=	"translate3d( "+ position + "px,0,0)";	
};
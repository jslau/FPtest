
function JphUtil_WebkitAnimation( elem)
{
	this.mhElement	=	elem;
	this.mUse2d		=	false;
}

JphUtil_WebkitAnimation.prototype.Init	=	function()
{
	this.mUse2d		=	this._ShouldUse2d();
};

JphUtil_WebkitAnimation.prototype._ShouldUse2d = function()
{
	var android	=	navigator.userAgent.match(/Android/i);
	
	if(android)
		return true;
	return false;
};

JphUtil_WebkitAnimation.prototype.SlideTo	=	function( position)
{
	this.mhElement.style.WebkitTransition	=	"-webkit-transform "+SLIDE_SCROLL_DURATION+" ease-out";
	this._Transform( position);
};

JphUtil_WebkitAnimation.prototype.SetTo		=	function( position)
{
	this.mhElement.style.WebkitTransition	=	"";
	this._Transform( position);
};

JphUtil_WebkitAnimation.prototype._Transform		=	function( position)
{
	if (this.mUse2d)
		this.mhElement.style.WebkitTransform	=	"translate( "+ position + "px,0)";
	else
		this.mhElement.style.WebkitTransform	=	"translate3d( "+ position + "px,0,0)";	
};
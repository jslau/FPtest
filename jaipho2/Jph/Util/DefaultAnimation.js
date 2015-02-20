
function JphUtil_DefaultAnimation( elem)
{
	this.mhElement	=	elem;
}

JphUtil_DefaultAnimation.prototype.Init	=	function()
{
};

JphUtil_DefaultAnimation.prototype.SlideTo	=	function( position)
{
	this.SetTo( position);
};

JphUtil_DefaultAnimation.prototype.SetTo		=	function( position)
{
	this.mhElement.style.marginLeft	=	position + 'px';
};


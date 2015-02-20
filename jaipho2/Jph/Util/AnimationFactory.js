
function JphUtil_AnimationFactory( elem)
{
	this.mhElement	=	elem;
	this.mUse2d		=	false;
}

JphUtil_AnimationFactory.prototype.GetAnimation	=	function()
{
	if (this._IsWebkit())
	{
		var animation	=	new JphUtil_WebkitAnimation( this.mhElement);
		animation.Init();
		return animation;
	}
	
	var animation	=	new JphUtil_DefaultAnimation( this.mhElement);
	animation.Init();
	return animation;
};

JphUtil_AnimationFactory.prototype._IsWebkit = function()
{	
	var ret	=	navigator.userAgent.match(/AppleWebKit/i);
	
	if(ret)
		return true;
	return false;
};

JphUtil_AnimationFactory.prototype._IsAndroid = function()
{
	var ret	=	navigator.userAgent.match(/Android/i);
	
	if(ret)
		return true;
	return false;
};

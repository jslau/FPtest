



function JphUtil_JaiphoContainerFactory()
{
}
 
JphUtil_JaiphoContainerFactory.prototype.GetContainer = function()
{
	if (this._IsIphoneSafari())
		var container	=	new JphUtil_IphoneSafariContainer();
	else
		var container	=	new JphUtil_DisplayContainer();
	
	container.Init();
	
	return container;
};

JphUtil_JaiphoContainerFactory.prototype._IsIphoneSafari = function()
{
	var iphone	=	navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPod/i);
	var safari	=	navigator.userAgent.match(/Safari/i);
	var chrome	=	navigator.userAgent.match(/CriOS/i);
	
	if(iphone && safari && !chrome)
		return true;
	return false;
};


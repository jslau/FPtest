



function JphUtil_DisplayContainer()
{
	debug('container: DisplayContainer()');
	
	this.mWidth		=	0;
	this.mHeight	=	0;
	
	implement_events( this);
}
 
JphUtil_DisplayContainer.prototype.Init = function()
{
	attach_method( window, 'onresize', this, '_OnResize');
	this._OnResize( null);
};


JphUtil_DisplayContainer.prototype._OnResize = function( e)
{
	debug( 'resize: _OnResize()');
	
	var width		=	document.documentElement.clientWidth;
	var height		=	document.documentElement.clientHeight;
	
	var changed		=	 width != this.mWidth || height != this.mHeight;
	
	this.mWidth		=	width;
	this.mHeight	=	height;
	
	if (changed)
	{
		debug( 'size: resized to width: ' + width + ', height: ' + height);
		this.FireEvent( 'ContainerResized');
	}
};

JphUtil_DisplayContainer.prototype.GetWidth = function()
{
	return this.mWidth;
};

JphUtil_DisplayContainer.prototype.GetHeight = function()
{
	return this.mHeight;
};

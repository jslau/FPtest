



function JphUtil_IphoneSafariContainer()
{
	debug('container: IphoneSafariContainer()');
	
	this.RESIZE_TIMEOUT	=	300; // miliseconds
	
	this.mWidth		=	0;
	this.mHeight	=	0;
	
	this.mResizeTimeout	=	null;
	
//	this.mhContainer	=	document;
	
	implement_events( this);
}
 
JphUtil_IphoneSafariContainer.prototype.Init = function()
{
	attach_method( window, 'onresize', this, '_OnResize');
	this._OnResize( null);
};


JphUtil_IphoneSafariContainer.prototype._OnResize = function( e)
{
	debug( 'resize: -------------------');
	debug( 'resize: _OnResize()');
	
	if (this.mResizeTimeout)
		clearTimeout( this.mResizeTimeout);
	
	this.mResizeTimeout	=	set_timeout( this, '_OnDelayedResize', null, this.RESIZE_TIMEOUT);
	
};

JphUtil_IphoneSafariContainer.prototype._OnDelayedResize = function()
{
	this.mResizeTimeout	=	null;
	
	var width		=	document.documentElement.clientWidth;
	
	if (width != this.mWidth)
		var height		=	this._GetForcedHeight();
	else
		var height		=	window.innerHeight;
	
	var changed		=	 width != this.mWidth || height != this.mHeight;
	
	this.mWidth		=	width;
	this.mHeight	=	height;
	
	if (changed)
	{
		debug( 'resize: resized to width: ' + width + ', height: ' + height);
		this.FireEvent( 'ContainerResized');
	}
};

JphUtil_IphoneSafariContainer.prototype._GetForcedHeight = function()
{
//	var height		=	document.documentElement.clientHeight;
	
	var start	=	window.innerHeight;	
	var max		=	start * 2;

	document.body.style.height	= max + 'px';
	scrollTo(0,0);
	debug_container_info();
	var height	=	window.innerHeight;
	debug('resize: new height = ' + height);
//	document.body.style.height	= null;
	document.body.style.height	= height + 'px';
	document.body.style.minHeight	= height + 'px';
	
	return height;
};

JphUtil_IphoneSafariContainer.prototype.GetWidth = function()
{
	return this.mWidth;
};

JphUtil_IphoneSafariContainer.prototype.GetHeight = function()
{
	return this.mHeight;
};


function debug_container_info()
{
//	document.body.style.height	=	'416px';
	
	debug('resize: document.documentElement.clientHeight: ' + document.documentElement.clientHeight); // browser viewport size excluding scrollbars
	debug('resize: window.innerHeight: ' + window.innerHeight); // browser viewport size including scrollbars
	debug('resize: window.pageYOffsett: ' + window.pageYOffset); // scrolled down size
	debug('resize: document.documentElement.offsetHeight: ' + document.documentElement.offsetHeight); // whole document
		
}

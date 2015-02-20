/******************************************************************************
 *	JAIPHO BETA, version 0.52.00
 *	(c) 2009 jaipho.com
 *
 *	JAIPHO is freely used under the terms of an LGPL license.
 *	For details, see the JAIPHO web site: http://www.jaipho.com/
 ******************************************************************************/
				
 var ORIENTATION_MODE_PORTRAIT		=	'portrait';
 var ORIENTATION_MODE_LANDSCAPE		=	'landscape';
 var ORIENTATION_MODE_HTML_ATTRIBUTE	=	'orient';

function JphUtil_OrientationManager( container)
{
	this.maListeners	=	new Array();
	
	this.mMode			=	null;
	this._mLastWidth	=	0;
	this.mrContainer	=	container;
	
	implement_events( this);
	
	this.mForceMode;
}
 
JphUtil_OrientationManager.prototype.ForceMode = function( mode)
{
	this.mForceMode	=	mode;
};


JphUtil_OrientationManager.prototype.Init = function()
{
	if (this.mForceMode)
	{
		this._SetMode( this.mForceMode);
		return;
	}
	
	this._Recheck();	
	set_interval(this, '_Recheck', '', CHECK_ORIENTATION_INTERVAL);
};
 
 // INTERVAL
JphUtil_OrientationManager.prototype._Recheck	=	function()
{
	var width	=	this.mrContainer.GetWidth();
	if (this._mLastWidth != width)
	{
		this._mLastWidth 	= 	width;
		var height			=	this.mrContainer.GetHeight();
		
		var mode 			=	(width <= height ? ORIENTATION_MODE_PORTRAIT : ORIENTATION_MODE_LANDSCAPE);
		
		this._SetMode( mode);
	}
};

 // ACCESSORS
JphUtil_OrientationManager.prototype.IsPortrait	=	function()
{
	if (this.mMode == ORIENTATION_MODE_PORTRAIT)
		return true;
};

JphUtil_OrientationManager.prototype._SetMode	=	function( mode)
{
	this.mMode 			=	mode;
	
	document.body.setAttribute( ORIENTATION_MODE_HTML_ATTRIBUTE, this.mMode);
	
	this.FireEvent( 'OrientationChanged');
};




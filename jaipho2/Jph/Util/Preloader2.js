function JphUtil_Preloader( maxActiveCount)
 {
 	this.mMaxActiveCount	=	maxActiveCount;
 	
 	this.mActiveCount		=	0;
 	this.mPaused			=	false;
	this.maAllImages		=	[];
	this.maQueue			=	new Array();
 }
 
 JphUtil_Preloader.prototype.Play		=	function()
 {
	this.mPaused			=	false;
	this._LoadNext();
 }
 
 JphUtil_Preloader.prototype.Pause		=	function()
 {
	this.mPaused			=	true;
 }


 JphUtil_Preloader.prototype.Load	=	function( img, src)
 {
 	
 	if (this.maAllImages[src] != undefined)
 	{
 		img.src	=	src;
 		this._ImageLoaded( src);
 		return;
 	}
 	
	var item				=	new JphUtil_PreloaderItem( img, src);
	this.maAllImages[src]	=	item;
	
	if (this.mActiveCount < this.mMaxActiveCount)
	{
		this._LoadItem( item);
	}
	else
	{
		this.maQueue[this.maQueue.length]	=	item;
	}
 }
   
  
 JphUtil_Preloader.prototype._LoadItem	=	function( item)
 {
 	
 	this.mActiveCount++;
	attach_method( item.mhImage, 'onload', this, '_ImageLoaded');
	attach_method( item.mhImage, 'onerror', this, '_ImageError');
	item.LoadImage();
 }
 
 JphUtil_Preloader.prototype._ImageError	=	function( e)
 {
 	if (!e) 
 		var e = window.event;
 	var target	=	e.target ? e.target : e.srcElement;
 	this.mActiveCount--;
 	delete this.maAllImages[target.src];
 	if (!this.mPaused)
 		this._LoadNext();
 }
 
 JphUtil_Preloader.prototype._ImageLoaded	=	function( e)
 {
 	if (typeof(e) == 'string')
 	{
 		var src	=	e;
 	}
 	else
 	{
	 	if (!e) 
	 		var e = window.event;
	 	var target	=	e.target ? e.target : e.srcElement;
	 	var src		=	target.src;
 	}
	this.mActiveCount--;
	if (!this.mPaused)
		this._LoadNext();
 }
 
 JphUtil_Preloader.prototype._LoadNext	=	function()
 {

	if (this.maQueue.length)
	{
		this._LoadItem( this.maQueue.shift());
	}
 }
 
 JphUtil_Preloader.prototype.toString	=	function()
 {
 	return '[JphUtil_Preloader [queue length='+this.maQueue.length+'][active count='+this.mActiveCount+']]';
 }
			
 function JphUtil_PreloaderItem( imageElement, src)
 {
	this.mhImage	=	imageElement;
	this.mSrc		=	src;
 }
 
 
 JphUtil_PreloaderItem.prototype.LoadImage	=	function()
 {
 	this.mhImage.src	=	this.mSrc;
 };
 
 JphUtil_PreloaderItem.prototype.toString	=	function()
 {
 	return 'JphUtil_PreloaderItem ['+this.mSrc+']['+this.mhImage.getAttribute("src")+']';
 };
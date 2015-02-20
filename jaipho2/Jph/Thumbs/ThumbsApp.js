
			
function JphThumbs_ThumbsApp( app)
 {
 	this.mrApp				=	app;
 	this.mrContainer		=	this.mrApp.mrContainer;
 	
 	this.mhThumbnails		=	null;
 	this.mhThumbsTopBar		=	null;
 	this.mhThumbsContainer	=	null;
 	this.mhThumbsCount		=	null;
	
 	this.mrBehavior			=	null;
	this.mrPreloader			=	null;
	
	this.mInitialzed		=	false;
	
	this.maThumbnails		=	new Array();
 }
 
 // INIT
 JphThumbs_ThumbsApp.prototype.Init		=	function()
 {
	this.mhThumbsTopBar		=	document.getElementById('thumbs-toolbar-top');
	this.mhThumbnails		=	document.getElementById('thumbs-images-container');
	this.mhThumbsContainer	=	document.getElementById('thumbs-container');
	this.mhThumbsCount		=	document.getElementById('thumbs-count-text');	
	
	this.mrBehavior			=	new JphThumbs_Behavior( this);
	this.mrBehavior.Init();
	
	for (var i in this.mrApp.mrDao.maImages)
	{
		this.maThumbnails[this.maThumbnails.length]	=	
				new JphThumbs_Item( this.mrApp, this.mrApp.mrDao.maImages[i]);
	} 	
	
	this.mrPreloader				=	new JphUtil_Preloader( MAX_CONCURENT_LOADING_THUMBNAILS);

	
 	this.mhThumbnails.innerHTML		=	this._HtmlThumbs();
	this.mhThumbsCount.innerHTML	=	this._HtmlCount();
	
	for (var i in this.maThumbnails)
	{
		this.maThumbnails[i].Init();
		
		var mover	= new JphUtil_Touches( this.maThumbnails[i].mhDiv, false);
		mover.AttachListener( 'TouchStart', this.mrBehavior, 'ThumbTouched', this.maThumbnails[i]);	
		mover.AttachListener( 'TouchEnd', this.mrBehavior, 'ThumbSelected', this.maThumbnails[i]);	
		mover.AttachListener( 'MoveCancel', this.mrBehavior, 'ThumbTouchMoved', this.maThumbnails[i]);	
		mover.Init();
	}
	
	this.mrContainer.AttachListener( 'ContainerResized', this, 'ContainerResized');
	this.ContainerResized();
	
	this.mInitialized	=	true;
 };

 
 JphThumbs_ThumbsApp.prototype._HtmlThumbs	=	function()
 {
 	var str	=	new Array();
	var cnt	=	0;
	
	for (var i in this.maThumbnails)
		str[cnt++]	=	this.maThumbnails[i].Html();
	
	return str.join('');
 }
 
 JphThumbs_ThumbsApp.prototype._HtmlCount		=	function()
 {
	var count	=	this.mrApp.mrDao.maImages.length;
	var text	=	count + ' photos';
	if (count == 1)
		text	=	count + ' photo';
			
	return text;
 }
 
//EVENT LISTENERS
 JphThumbs_ThumbsApp.prototype.ContainerResized	=	function( e)
 {
  	debug('thumbs-app: -------------');
  	debug('thumbs-app: ContainerResized()');
  	debug( 'resize: slider - ContainerResized()');
  	
  	
// 	this.mhThumbsContainer.style.width = this.mrContainer.GetWidth() + 'px';
 	this.mhThumbsContainer.style.minHeight = this.mrContainer.GetHeight() + 'px';
 };

 // ACTIONS
 JphThumbs_ThumbsApp.prototype.Show			=	function()
 {
	debug('thumbs: Show()');
	this.mhThumbsTopBar.style.display		=	'block';
	this.mhThumbnails.style.display			=	'block';
	this.mhThumbsContainer.style.display	=	'block';
	
	this.mrPreloader.Play();
 };
 
 
 JphThumbs_ThumbsApp.prototype.Hide			=	function()
 {
	debug('thumbs: Hide()');
	this.mhThumbsTopBar.style.display		=	'none';
	this.mhThumbnails.style.display			=	'none';
	this.mhThumbsContainer.style.display	=	'none';
	
	this.mrPreloader.Pause();
 };
 
 
 
 
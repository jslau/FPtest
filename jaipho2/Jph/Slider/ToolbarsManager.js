
	
function JphSlider_ToolbarsManager()
 {
	this.mDeactivation	=	null;
	this.maElements		=	new Array();
	
	this.mHidden		=	true;
 }
 
 JphSlider_ToolbarsManager.prototype.Register	=	function( elem)
 {
 	this.maElements[this.maElements.length]	=	elem;
 };
 
 JphSlider_ToolbarsManager.prototype.GetHeight	=	function()
 {
	 var height	=	0;
	 for (var i in this.maElements)
		 height += this.GetSingleHeight();
	 return height;
 };
 
 JphSlider_ToolbarsManager.prototype.GetSingleHeight	=	function()
 {
	 return 40;
 };
 
 // ACTIONS
 JphSlider_ToolbarsManager.prototype.Show	=	function()
 {
 	debug('toolbars: Show()');
	this._RemoveDeactivation();
		
 	for (var i in this.maElements)
		this.maElements[i].style.display	=	'block';
		
	this._SetDeactivation();
	
	this.mHidden	=	false;
 };
 
 JphSlider_ToolbarsManager.prototype.Hide	=	function()
 {
 	debug('toolbars: Hide()');
	this._DeactivateToolbars();
 };
  
 
 JphSlider_ToolbarsManager.prototype.IsHidden		=	function()
 {
	return this.mHidden;
 };
 
 JphSlider_ToolbarsManager.prototype._DeactivateToolbars	=	function()
 {
 	debug('toolbars: _DeactivateToolbars()');
	this._RemoveDeactivation();
	
 	for (var i in this.maElements)
		this.maElements[i].style.display	=	'none';
		
	this.mHidden	=	true;
 };
  
 JphSlider_ToolbarsManager.prototype.Toggle	=	function()
 {
 	debug('toolbars: Toggle()');
 	if (this.mHidden) 	
		this.Show();
	else
		this.Hide();
 };
 
 // TIMER
 JphSlider_ToolbarsManager.prototype._SetDeactivation	=	function()
 {
 	this.mDeactivation		=	set_timeout( this, '_DeactivateToolbars', '', TOOLBARS_HIDE_TIMEOUT);	
 };

 JphSlider_ToolbarsManager.prototype._RemoveDeactivation	=	function()
 {
 	if (this.mDeactivation)
		clearTimeout( this.mDeactivation);
		
	this.mDeactivation	=	null;
 };
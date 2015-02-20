
			
function JphSlider_SwipeComponentCell( table, index)
{
	this.mrTable		=	table;
	this.mIndex			=	index;
	
	this.mhContainer	=	null;
	this.mrImage		=	null;
}

JphSlider_SwipeComponentCell.prototype.Init = function()
{


};
 
JphSlider_SwipeComponentCell.prototype.SetImage = function( image)
{
	this.mrImage	=	image;
};

JphSlider_SwipeComponentCell.prototype.GetHtmlId = function( key)
{
	return this.mrTable.GetHtmlId( 'slide', this.mIndex);
};

JphSlider_SwipeComponentCell.prototype.toString	=	function()
{
	return 'JphSlider_SwipeComponentCell['+this.mIndex+']';
};
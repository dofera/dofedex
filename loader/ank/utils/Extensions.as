class ank.utils.Extensions
{
	static var bExtended = false;
	function Extensions()
	{
	}
	static function addExtensions()
	{
		if(ank.utils.Extensions.bExtended == true)
		{
			return true;
		}
		var var2 = ank.utils.extensions.MovieClipExtensions.prototype;
		var var3 = MovieClip.prototype;
		var3.attachClassMovie = var2.attachClassMovie;
		var3.alignOnPixel = var2.alignOnPixel;
		var3.playFirstChildren = var2.playFirstChildren;
		var3.getFirstParentProperty = var2.getFirstParentProperty;
		var3.getActionClip = var2.getActionClip;
		var3.end = var2.end;
		var3.playAll = var2.playAll;
		var3.stopAll = var2.stopAll;
		ank.utils.Extensions.bExtended = true;
		return true;
	}
}

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
		var loc2 = ank.utils.extensions.MovieClipExtensions.prototype;
		var loc3 = MovieClip.prototype;
		loc3.attachClassMovie = loc2.attachClassMovie;
		loc3.alignOnPixel = loc2.alignOnPixel;
		loc3.playFirstChildren = loc2.playFirstChildren;
		loc3.getFirstParentProperty = loc2.getFirstParentProperty;
		loc3.getActionClip = loc2.getActionClip;
		loc3.end = loc2.end;
		loc3.playAll = loc2.playAll;
		loc3.stopAll = loc2.stopAll;
		ank.utils.Extensions.bExtended = true;
		return true;
	}
}

class org.utils.Bitmap
{
	function Bitmap()
	{
	}
	static function loadBitmapSmoothed(loc2, loc3)
	{
		var loc4 = loc3.createEmptyMovieClip("bmc",loc3.getNextHighestDepth());
		var loc5 = new Object();
		loc5.tmc = loc3;
		loc5.onLoadInit = function(loc2)
		{
			loc2._visible = false;
			loc2.forceSmoothing = true;
			var loc3 = new flash.display.BitmapData(loc2._width,loc2._height,true);
			this.tmc.attachBitmap(loc3,this.tmc.getNextHighestDepth(),"auto",true);
			loc3.draw(loc2);
		};
		var loc6 = new MovieClipLoader();
		loc6.addListener(loc5);
		loc6.loadClip(loc2,loc4);
	}
}

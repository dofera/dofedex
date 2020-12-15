class eval(org).utils.Bitmap
{
	function Bitmap()
	{
	}
	static function loadBitmapSmoothed(var2, var3)
	{
		var var4 = var3.createEmptyMovieClip("bmc",var3.getNextHighestDepth());
		var var5 = new Object();
		var5.tmc = var3;
		var5.onLoadInit = function(var2)
		{
			var2._visible = false;
			var2.forceSmoothing = true;
			var var3 = new flash.display.BitmapData(var2._width,var2._height,true);
			this.tmc.attachBitmap(var3,this.tmc.getNextHighestDepth(),"auto",true);
			var3.draw(var2);
		};
		var var6 = new MovieClipLoader();
		var6.addListener(var5);
		var6.loadClip(var2,var4);
	}
}

class ank.battlefield.OverHeadHandler
{
	function OverHeadHandler(var3, var4)
	{
		this.initialize(var2,var3);
	}
	function initialize(var2, var3)
	{
		this._mcBattlefield = var2;
		this._mcContainer = var3;
	}
	function clear()
	{
		§§enumerate(this._mcContainer);
		while((var var0 = §§enumeration()) != null)
		{
			if(typeof this._mcContainer[k] == "movieclip")
			{
				this._mcContainer[k].swapDepths(0);
				this._mcContainer[k].removeMovieClip();
			}
		}
	}
	function addOverHeadItem(sID, nX, nY, §\n\x0e§, §\x1e\x10\x13§, §\x0e\x15§, §\x1e\x01§, §\x06\x0b§)
	{
		var var10 = this._mcContainer["oh" + sID];
		var var11 = this._mcBattlefield.getZoom();
		if(var10 == undefined)
		{
			var10 = this._mcContainer.attachClassMovie(ank.battlefield.mc.OverHead,"oh" + sID,var5.getDepth(),[var5,var11,this._mcBattlefield]);
		}
		var10._x = nX;
		var10._y = nY;
		if(var11 < 100)
		{
			var10._xscale = var10._yscale = 10000 / var11;
		}
		var10.addItem(var6,var7,var8,var9);
	}
	function removeOverHeadLayer(sID, §\x1e\x10\x13§)
	{
		var var4 = this._mcContainer["oh" + sID];
		var4.removeLayer(var3);
	}
	function removeOverHead(sID)
	{
		var var3 = this._mcContainer["oh" + sID];
		var3.remove();
	}
}

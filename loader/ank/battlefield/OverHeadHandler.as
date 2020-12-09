class ank.battlefield.OverHeadHandler
{
	function OverHeadHandler(§\x1d\x03§, §\x13\x14§)
	{
		this.initialize(var2,var3);
	}
	function initialize(§\x1d\x03§, §\x13\x14§)
	{
		this._mcBattlefield = var2;
		this._mcContainer = var3;
	}
	function clear()
	{
		for(var k in this._mcContainer)
		{
			if(typeof this._mcContainer[k] == "movieclip")
			{
				this._mcContainer[k].swapDepths(0);
				this._mcContainer[k].removeMovieClip();
			}
		}
	}
	function addOverHeadItem(sID, §\x1e\x1b\r§, §\x1e\x1b\x05§, §\n\x1b§, §\x1e\x11\x03§, §\x0f\x01§, §\x1e\x02§, §\x06\x18§)
	{
		var var10 = this._mcContainer["oh" + sID];
		var var11 = this._mcBattlefield.getZoom();
		if(var10 == undefined)
		{
			var10 = this._mcContainer.attachClassMovie(ank.battlefield.mc.OverHead,"oh" + sID,var5.getDepth(),[var5,var11,this._mcBattlefield]);
		}
		var10._x = var3;
		var10._y = var4;
		if(var11 < 100)
		{
			var10._xscale = var10._yscale = 10000 / var11;
		}
		var10.addItem(var6,var7,var8,var9);
	}
	function removeOverHeadLayer(sID, §\x1e\x11\x03§)
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

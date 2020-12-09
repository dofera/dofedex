class ank.battlefield.TextHandler
{
	static var BUBBLE_TYPE_CHAT = 1;
	static var BUBBLE_TYPE_THINK = 2;
	function TextHandler(§\x1d\x03§, §\x13\x14§, §\x11\x17§)
	{
		this.initialize(var2,var3,var4);
	}
	function initialize(§\x1d\x03§, §\x13\x14§, §\x11\x17§)
	{
		this._mcBattlefield = var2;
		this._mcContainer = var3;
		this._oDatacenter = var4;
	}
	function clear()
	{
		§§enumerate(this._mcContainer);
		while((var var0 = §§enumeration()) != null)
		{
			this._mcContainer[k].removeMovieClip();
		}
	}
	function addBubble(sID, §\x1e\x1b\r§, §\x1e\x1b\x05§, §\x1e\r\x02§, §\x1e\n\x1b§)
	{
		var var7 = (this._oDatacenter.Map.width - 1) * ank.battlefield.Constants.CELL_WIDTH;
		this.removeBubble(sID);
		var var8 = this._mcContainer.attachClassMovie(var6 != ank.battlefield.TextHandler.BUBBLE_TYPE_THINK?ank.battlefield.mc.Bubble:ank.battlefield.mc.BubbleThink,"bubble" + sID,this._mcContainer.getNextHighestDepth(),[var5,var3,var4,var7]);
		var var9 = this._mcBattlefield.getZoom();
		if(var9 < 100)
		{
			var8._xscale = var8._yscale = 10000 / var9;
		}
	}
	function removeBubble(sID)
	{
		var var3 = this._mcContainer["bubble" + sID];
		var3.remove();
	}
}

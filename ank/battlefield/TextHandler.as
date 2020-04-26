class ank.battlefield.TextHandler
{
	static var BUBBLE_TYPE_CHAT = 1;
	static var BUBBLE_TYPE_THINK = 2;
	function TextHandler(loc3, loc4, loc5)
	{
		this.initialize(loc2,loc3,loc4);
	}
	function initialize(loc2, loc3, loc4)
	{
		this._mcBattlefield = loc2;
		this._mcContainer = loc3;
		this._oDatacenter = loc4;
	}
	function clear()
	{
		for(var k in this._mcContainer)
		{
			this._mcContainer[k].removeMovieClip();
		}
	}
	function addBubble(sID, §\x1e\x1c\x13§, §\x1e\x1c\x0b§, §\x1e\x0e\x19§, §\x1e\f\x18§)
	{
		var loc7 = (this._oDatacenter.Map.width - 1) * ank.battlefield.Constants.CELL_WIDTH;
		this.removeBubble(sID);
		var loc8 = this._mcContainer.attachClassMovie(loc6 != ank.battlefield.TextHandler.BUBBLE_TYPE_THINK?ank.battlefield.mc.Bubble:ank.battlefield.mc.BubbleThink,"bubble" + sID,this._mcContainer.getNextHighestDepth(),[loc5,loc3,loc4,loc7]);
		var loc9 = this._mcBattlefield.getZoom();
		if(loc9 < 100)
		{
			loc8._xscale = loc8._yscale = 10000 / loc9;
		}
	}
	function removeBubble(sID)
	{
		var loc3 = this._mcContainer["bubble" + sID];
		loc3.remove();
	}
}

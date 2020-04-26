class ank.battlefield.OverHeadHandler
{
	function OverHeadHandler(loc3, loc4)
	{
		this.initialize(loc2,loc3);
	}
	function initialize(loc2, loc3)
	{
		this._mcBattlefield = loc2;
		this._mcContainer = loc3;
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
	function addOverHeadItem(sID, §\x1e\x1c\x13§, §\x1e\x1c\x0b§, §\x0b\x13§, §\x1e\x12\x0f§, §\x0f\x15§, §\x1e\x02§, §\x07\x16§)
	{
		var loc10 = this._mcContainer["oh" + sID];
		var loc11 = this._mcBattlefield.getZoom();
		if(loc10 == undefined)
		{
			loc10 = this._mcContainer.attachClassMovie(ank.battlefield.mc.OverHead,"oh" + sID,loc5.getDepth(),[loc5,loc11,this._mcBattlefield]);
		}
		loc10._x = loc3;
		loc10._y = loc4;
		if(loc11 < 100)
		{
			loc10._xscale = loc10._yscale = 10000 / loc11;
		}
		loc10.addItem(loc6,loc7,loc8,loc9);
	}
	function removeOverHeadLayer(sID, §\x1e\x12\x0f§)
	{
		var loc4 = this._mcContainer["oh" + sID];
		loc4.removeLayer(loc3);
	}
	function removeOverHead(sID)
	{
		var loc3 = this._mcContainer["oh" + sID];
		loc3.remove();
	}
}

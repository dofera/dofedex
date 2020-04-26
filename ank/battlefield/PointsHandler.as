class ank.battlefield.PointsHandler
{
	function PointsHandler(loc3, loc4, loc5)
	{
		this.initialize(loc2,loc3,loc4);
	}
	function initialize(loc2, loc3, loc4)
	{
		this._mcBattlefield = loc2;
		this._mcContainer = loc3;
		this._oDatacenter = loc4;
		this._oList = new Object();
	}
	function clear()
	{
		§§enumerate(this._mcContainer);
		while((var loc0 = §§enumeration()) != null)
		{
			this._mcContainer[k].removeMovieClip();
		}
	}
	function addPoints(sID, §\x1e\x1c\x13§, §\x1e\x1c\x0b§, §\x1e\x0e\x04§, §\b\t§)
	{
		var loc7 = this._mcContainer.getNextHighestDepth();
		var loc8 = this._mcContainer.attachClassMovie(ank.battlefield.mc.Points,"points" + loc7,loc7,[this,sID,loc4,loc5,loc6]);
		loc8._x = loc3;
		loc8._y = loc4;
		if(this._oList[sID] == undefined)
		{
			this._oList[sID] = new Array();
		}
		this._oList[sID].push(loc8);
		if(this._oList[sID].length == 1)
		{
			loc8.animate();
		}
	}
	function onAnimateFinished(sID)
	{
		var loc3 = this._oList[sID];
		loc3.shift();
		if(loc3.length != 0)
		{
			loc3[0].animate();
		}
	}
}

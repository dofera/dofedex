class ank.battlefield.PointsHandler
{
	function PointsHandler(var3, var4, var5)
	{
		this.initialize(var2,var3,var4);
	}
	function initialize(var2, var3, var4)
	{
		this._mcBattlefield = var2;
		this._mcContainer = var3;
		this._oDatacenter = var4;
		this._oList = new Object();
	}
	function clear()
	{
		§§enumerate(this._mcContainer);
		while((var var0 = §§enumeration()) != null)
		{
			this._mcContainer[k].removeMovieClip();
		}
	}
	function addPoints(sID, nX, nY, §\x1e\x0b\x19§, §\x06\x1d§)
	{
		var var7 = this._mcContainer.getNextHighestDepth();
		var var8 = this._mcContainer.attachClassMovie(ank.battlefield.mc.Points,"points" + var7,var7,[this,sID,nY,var5,var6]);
		var8._x = nX;
		var8._y = nY;
		if(this._oList[sID] == undefined)
		{
			this._oList[sID] = new Array();
		}
		this._oList[sID].push(var8);
		if(this._oList[sID].length == 1)
		{
			var8.animate();
		}
	}
	function onAnimateFinished(sID)
	{
		var var3 = this._oList[sID];
		var3.shift();
		if(var3.length != 0)
		{
			var3[0].animate();
		}
	}
}

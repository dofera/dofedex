class ank.battlefield.ZoneHandler
{
	function ZoneHandler(var3, var4)
	{
		this.initialize(var2,var3);
	}
	function initialize(var2, var3)
	{
		this._mcBattlefield = var2;
		this._mcContainer = var3;
		this.clear();
	}
	function clear(var2)
	{
		this._mcZones.removeMovieClip();
		this._mcZones = this._mcContainer.createEmptyMovieClip("zones",10);
		this._nNextLayerDepth = 0;
	}
	function clearZone(var2, var3, var4)
	{
		var2 = Number(var2);
		var3 = Number(var3);
		if(var2 < 0)
		{
			return undefined;
		}
		if(var2 > this._mcBattlefield.mapHandler.getCellCount())
		{
			return undefined;
		}
		var var5 = var2 * 1000 + var3 * 100;
		this._mcZones[var4]["zone" + var5].clear();
	}
	function clearZoneLayer(var2)
	{
		this._mcZones[var2].removeMovieClip();
	}
	function drawZone(var2, var3, var4, var5, var6, var7)
	{
		var2 = Number(var2);
		var3 = Number(var3);
		var4 = Number(var4);
		var6 = Number(var6);
		if(var2 < 0)
		{
			return undefined;
		}
		if(var2 > this._mcBattlefield.mapHandler.getCellCount())
		{
			return undefined;
		}
		if(_global.isNaN(var3) || _global.isNaN(var4))
		{
			return undefined;
		}
		var var8 = var2 * 1000 + var4 * 100;
		if(this._mcZones[var5] == undefined)
		{
			this._mcZones.createEmptyMovieClip(var5,this._nNextLayerDepth++);
		}
		this._mcZones[var5].__proto__ = MovieClip.prototype;
		this._mcZones[var5].cacheAsBitmap = this._mcZones.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["Zone/Zone"];
		var var9 = this._mcZones[var5].attachClassMovie(ank.battlefield.mc.Zone,"zone" + var8,var8,[this._mcBattlefield.mapHandler]);
		switch(var7)
		{
			case "C":
				if(var3 == 0)
				{
					var9.drawCircle(var4,var6,var2);
				}
				else
				{
					if(var3 > 0)
					{
						var3 = var3 - 1;
					}
					var9.drawRing(var3,var4,var6,var2);
				}
				break;
			case "X":
				if(var3 == 0)
				{
					var9.drawCross(var4,var6,var2);
				}
				else
				{
					var var10 = this._mcBattlefield.mapHandler;
					var var12 = var10.getWidth();
					var var13 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(var10,var2);
					var var11 = var2 - var12 * var3;
					if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(var10,var11).y == var13.y)
					{
						var9.drawLine(var4 - var3,var6,var11,var2,true);
					}
					var11 = var2 - (var12 - 1) * var3;
					if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(var10,var11).x == var13.x)
					{
						var9.drawLine(var4 - var3,var6,var11,var2,true);
					}
					var11 = var2 + var12 * var3;
					if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(var10,var11).y == var13.y)
					{
						var9.drawLine(var4 - var3,var6,var11,var2,true);
					}
					var11 = var2 + (var12 - 1) * var3;
					if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(var10,var11).x == var13.x)
					{
						var9.drawLine(var4 - var3,var6,var11,var2,true);
					}
				}
				break;
			default:
				var9.drawCircle(var4,var6,var2);
		}
		this.moveZoneTo(var9,var2);
	}
	function moveZoneTo(var2, var3)
	{
		var var4 = this._mcBattlefield.mapHandler.getCellData(var3);
		var2._x = var4.x;
		var2._y = var4.y + ank.battlefield.Constants.LEVEL_HEIGHT * (var4.groundLevel - 7);
	}
}

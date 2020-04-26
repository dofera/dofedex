class ank.battlefield.ZoneHandler
{
	function ZoneHandler(loc3, loc4)
	{
		this.initialize(loc2,loc3);
	}
	function initialize(loc2, loc3)
	{
		this._mcBattlefield = loc2;
		this._mcContainer = loc3;
		this.clear();
	}
	function clear(loc2)
	{
		this._mcZones.removeMovieClip();
		this._mcZones = this._mcContainer.createEmptyMovieClip("zones",10);
		this._nNextLayerDepth = 0;
	}
	function clearZone(loc2, loc3, loc4)
	{
		loc2 = Number(loc2);
		loc3 = Number(loc3);
		if(loc2 < 0)
		{
			return undefined;
		}
		if(loc2 > this._mcBattlefield.mapHandler.getCellCount())
		{
			return undefined;
		}
		var loc5 = loc2 * 1000 + loc3 * 100;
		this._mcZones[loc4]["zone" + loc5].clear();
	}
	function clearZoneLayer(loc2)
	{
		this._mcZones[loc2].removeMovieClip();
	}
	function drawZone(loc2, loc3, loc4, loc5, loc6, loc7)
	{
		loc2 = Number(loc2);
		loc3 = Number(loc3);
		loc4 = Number(loc4);
		loc6 = Number(loc6);
		if(loc2 < 0)
		{
			return undefined;
		}
		if(loc2 > this._mcBattlefield.mapHandler.getCellCount())
		{
			return undefined;
		}
		if(_global.isNaN(loc3) || _global.isNaN(loc4))
		{
			return undefined;
		}
		var loc8 = loc2 * 1000 + loc4 * 100;
		if(this._mcZones[loc5] == undefined)
		{
			this._mcZones.createEmptyMovieClip(loc5,this._nNextLayerDepth++);
		}
		this._mcZones[loc5].__proto__ = MovieClip.prototype;
		this._mcZones[loc5].cacheAsBitmap = this._mcZones.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["Zone/Zone"];
		var loc9 = this._mcZones[loc5].attachClassMovie(ank.battlefield.mc.Zone,"zone" + loc8,loc8,[this._mcBattlefield.mapHandler]);
		switch(loc7)
		{
			case "C":
				if(loc3 == 0)
				{
					loc9.drawCircle(loc4,loc6,loc2);
				}
				else
				{
					if(loc3 > 0)
					{
						loc3 = loc3 - 1;
					}
					loc9.drawRing(loc3,loc4,loc6,loc2);
				}
				break;
			case "X":
				if(loc3 == 0)
				{
					loc9.drawCross(loc4,loc6,loc2);
				}
				else
				{
					var loc10 = this._mcBattlefield.mapHandler;
					var loc12 = loc10.getWidth();
					var loc13 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(loc10,loc2);
					var loc11 = loc2 - loc12 * loc3;
					if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(loc10,loc11).y == loc13.y)
					{
						loc9.drawLine(loc4 - loc3,loc6,loc11,loc2,true);
					}
					loc11 = loc2 - (loc12 - 1) * loc3;
					if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(loc10,loc11).x == loc13.x)
					{
						loc9.drawLine(loc4 - loc3,loc6,loc11,loc2,true);
					}
					loc11 = loc2 + loc12 * loc3;
					if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(loc10,loc11).y == loc13.y)
					{
						loc9.drawLine(loc4 - loc3,loc6,loc11,loc2,true);
					}
					loc11 = loc2 + (loc12 - 1) * loc3;
					if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(loc10,loc11).x == loc13.x)
					{
						loc9.drawLine(loc4 - loc3,loc6,loc11,loc2,true);
					}
				}
				break;
			default:
				loc9.drawCircle(loc4,loc6,loc2);
		}
		this.moveZoneTo(loc9,loc2);
	}
	function moveZoneTo(loc2, loc3)
	{
		var loc4 = this._mcBattlefield.mapHandler.getCellData(loc3);
		loc2._x = loc4.x;
		loc2._y = loc4.y + ank.battlefield.Constants.LEVEL_HEIGHT * (loc4.groundLevel - 7);
	}
}

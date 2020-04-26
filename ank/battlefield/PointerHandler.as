class ank.battlefield.PointerHandler
{
	function PointerHandler(loc3, loc4)
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
		this.hide();
		this._aShapes = new Array();
	}
	function hide(loc2)
	{
		this._mcZones.removeMovieClip();
		this._mcZones = this._mcContainer.createEmptyMovieClip("zones",2);
		this._mcZones.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["Zone/Pointers"];
	}
	function addShape(loc2, loc3, loc4, loc5)
	{
		this._aShapes.push({shape:loc2,size:loc3,col:loc4,cellNumRef:loc5});
	}
	function draw(loc2)
	{
		var loc3 = this._aShapes;
		if(loc3.length == 0)
		{
			return undefined;
		}
		this.hide();
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			this._mcZones.__proto__ = MovieClip.prototype;
			var loc5 = this._mcZones.attachClassMovie(ank.battlefield.mc.Zone,"zone" + loc4,10 * loc4,[this._mcBattlefield.mapHandler]);
			if((var loc0 = loc3[loc4].shape) !== "P")
			{
				switch(null)
				{
					case "C":
						if(typeof loc3[loc4].size == "number")
						{
							loc5.drawCircle(loc3[loc4].size,loc3[loc4].col,loc2);
						}
						else if(loc3[loc4].size[0] == 0 && !_global.isNaN(Number(loc3[loc4].size[1])))
						{
							loc5.drawCircle(Number(loc3[loc4].size[1]),loc3[loc4].col,loc2);
						}
						else
						{
							var loc6 = 0;
							if(loc3[loc4].size[0] > 0)
							{
								loc6 = -1;
							}
							loc5.drawRing(loc3[loc4].size[0] + loc6,loc3[loc4].size[1],loc3[loc4].col,loc2);
						}
						break;
					case "D":
						var loc7 = -1;
						var loc8 = -1;
						if(typeof loc3[loc4].size == "number")
						{
							loc8 = Number(loc3[loc4].size);
							loc7 = loc8 % 2 != 0?0:1;
						}
						else
						{
							loc7 = Number(loc3[loc4].size[1]);
							loc8 = Number(loc3[loc4].size[0]);
						}
						var loc9 = loc7;
						while(loc9 < loc8)
						{
							loc5.drawRing(loc9 + 1,loc9,loc3[loc4].col,loc2);
							loc9 = loc9 + 2;
						}
						break;
					case "L":
						loc5.drawLine(loc3[loc4].size,loc3[loc4].col,loc2,loc3[loc4].cellNumRef);
						break;
					case "X":
						if(typeof loc3[loc4].size == "number")
						{
							loc5.drawCross(loc3[loc4].size,loc3[loc4].col,loc2);
						}
						else
						{
							var loc10 = this._mcBattlefield.mapHandler;
							var loc12 = loc10.getWidth();
							var loc13 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(loc10,loc2);
							var loc11 = loc2 - loc12 * loc3[loc4].size[0];
							if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(loc10,loc11).y == loc13.y)
							{
								loc5.drawLine(loc3[loc4].size[1] - loc3[loc4].size[0],loc3[loc4].col,loc11,loc2,true);
							}
							loc11 = loc2 - (loc12 - 1) * loc3[loc4].size[0];
							if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(loc10,loc11).x == loc13.x)
							{
								loc5.drawLine(loc3[loc4].size[1] - loc3[loc4].size[0],loc3[loc4].col,loc11,loc2,true);
							}
							loc11 = loc2 + loc12 * loc3[loc4].size[0];
							if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(loc10,loc11).y == loc13.y)
							{
								loc5.drawLine(loc3[loc4].size[1] - loc3[loc4].size[0],loc3[loc4].col,loc11,loc2,true);
							}
							loc11 = loc2 + (loc12 - 1) * loc3[loc4].size[0];
							if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(loc10,loc11).x == loc13.x)
							{
								loc5.drawLine(loc3[loc4].size[1] - loc3[loc4].size[0],loc3[loc4].col,loc11,loc2,true);
							}
						}
						break;
					default:
						switch(null)
						{
							case "T":
								loc5.drawLine(loc3[loc4].size,loc3[loc4].col,loc2,loc3[loc4].cellNumRef,false,true);
								break;
							case "R":
								loc5.drawRectangle(loc3[loc4].size[0],loc3[loc4].size[1],loc3[loc4].col,loc2);
								break;
							case "O":
								loc5.drawRing(loc3[loc4].size,loc3[loc4].size - 1,loc3[loc4].col,loc2);
						}
				}
			}
			else
			{
				loc5.drawCircle(0,loc3[loc4].col,loc2);
			}
			this.movePointerTo(loc5,loc2);
			loc4 = loc4 + 1;
		}
	}
	function movePointerTo(loc2, loc3)
	{
		var loc4 = this._mcBattlefield.mapHandler.getCellData(loc3);
		loc2._x = loc4.x;
		loc2._y = loc4.y + ank.battlefield.Constants.LEVEL_HEIGHT * (loc4.groundLevel - 7);
	}
}

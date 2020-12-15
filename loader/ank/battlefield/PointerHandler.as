class ank.battlefield.PointerHandler
{
	function PointerHandler(var3, var4)
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
		this.hide();
		this._aShapes = new Array();
	}
	function hide(var2)
	{
		this._mcZones.removeMovieClip();
		this._mcZones = this._mcContainer.createEmptyMovieClip("zones",2);
		this._mcZones.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["Zone/Pointers"];
	}
	function addShape(var2, var3, var4, var5)
	{
		this._aShapes.push({shape:var2,size:var3,col:var4,cellNumRef:var5});
	}
	function draw(var2)
	{
		var var3 = this._aShapes;
		if(var3.length == 0)
		{
			return undefined;
		}
		this.hide();
		var var4 = 0;
		while(var4 < var3.length)
		{
			this._mcZones.__proto__ = MovieClip.prototype;
			var var5 = this._mcZones.attachClassMovie(ank.battlefield.mc.Zone,"zone" + var4,10 * var4,[this._mcBattlefield.mapHandler]);
			if((var var0 = var3[var4].shape) !== "P")
			{
				switch(null)
				{
					case "C":
						if(typeof var3[var4].size == "number")
						{
							var5.drawCircle(var3[var4].size,var3[var4].col,var2);
						}
						else if(var3[var4].size[0] == 0 && !_global.isNaN(Number(var3[var4].size[1])))
						{
							var5.drawCircle(Number(var3[var4].size[1]),var3[var4].col,var2);
						}
						else
						{
							var var6 = 0;
							if(var3[var4].size[0] > 0)
							{
								var6 = -1;
							}
							var5.drawRing(var3[var4].size[0] + var6,var3[var4].size[1],var3[var4].col,var2);
						}
						break;
					case "D":
						var var7 = -1;
						var var8 = -1;
						if(typeof var3[var4].size == "number")
						{
							var8 = Number(var3[var4].size);
							var7 = var8 % 2 != 0?0:1;
						}
						else
						{
							var7 = Number(var3[var4].size[1]);
							var8 = Number(var3[var4].size[0]);
						}
						var var9 = var7;
						while(var9 < var8)
						{
							var5.drawRing(var9 + 1,var9,var3[var4].col,var2);
							var9 = var9 + 2;
						}
						break;
					case "L":
						var5.drawLine(var3[var4].size,var3[var4].col,var2,var3[var4].cellNumRef);
						break;
					case "X":
						if(typeof var3[var4].size == "number")
						{
							var5.drawCross(var3[var4].size,var3[var4].col,var2);
						}
						else
						{
							var var10 = this._mcBattlefield.mapHandler;
							var var12 = var10.getWidth();
							var var13 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(var10,var2);
							var var11 = var2 - var12 * var3[var4].size[0];
							if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(var10,var11).y == var13.y)
							{
								var5.drawLine(var3[var4].size[1] - var3[var4].size[0],var3[var4].col,var11,var2,true);
							}
							var11 = var2 - (var12 - 1) * var3[var4].size[0];
							if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(var10,var11).x == var13.x)
							{
								var5.drawLine(var3[var4].size[1] - var3[var4].size[0],var3[var4].col,var11,var2,true);
							}
							var11 = var2 + var12 * var3[var4].size[0];
							if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(var10,var11).y == var13.y)
							{
								var5.drawLine(var3[var4].size[1] - var3[var4].size[0],var3[var4].col,var11,var2,true);
							}
							var11 = var2 + (var12 - 1) * var3[var4].size[0];
							if(ank.battlefield.utils.Pathfinding.getCaseCoordonnee(var10,var11).x == var13.x)
							{
								var5.drawLine(var3[var4].size[1] - var3[var4].size[0],var3[var4].col,var11,var2,true);
							}
						}
						break;
					default:
						switch(null)
						{
							case "T":
								var5.drawLine(var3[var4].size,var3[var4].col,var2,var3[var4].cellNumRef,false,true);
								break;
							case "R":
								var5.drawRectangle(var3[var4].size[0],var3[var4].size[1],var3[var4].col,var2);
								break;
							case "O":
								var5.drawRing(var3[var4].size,var3[var4].size - 1,var3[var4].col,var2);
						}
				}
			}
			else
			{
				var5.drawCircle(0,var3[var4].col,var2);
			}
			this.movePointerTo(var5,var2);
			var4 = var4 + 1;
		}
	}
	function movePointerTo(var2, var3)
	{
		var var4 = this._mcBattlefield.mapHandler.getCellData(var3);
		var2._x = var4.x;
		var2._y = var4.y + ank.battlefield.Constants.LEVEL_HEIGHT * (var4.groundLevel - 7);
	}
}

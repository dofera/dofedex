class ank.battlefield.GridHandler
{
	function GridHandler(loc3, loc4)
	{
		this.initialize(loc2,loc3);
	}
	function initialize(loc2, loc3)
	{
		this._mcContainer = loc2;
		this._oDatacenter = loc3;
	}
	function draw(loc2)
	{
		this._mcGrid = this._mcContainer.createEmptyMovieClip("mcGrid",10);
		var loc3 = this._oDatacenter.Map.data;
		var loc4 = ank.battlefield.Constants.CELL_COORD;
		var loc6 = new Object();
		this._mcGrid.lineStyle(1,ank.battlefield.Constants.GRID_COLOR,ank.battlefield.Constants.GRID_ALPHA);
		for(var k in loc3)
		{
			var loc5 = loc3[k];
			if(!(!loc5.active && !loc2))
			{
				if(loc5.movement != 0 && loc5.lineOfSight || loc2)
				{
					this._mcGrid.moveTo(loc4[loc5.groundSlope][0][0] + loc5.x,loc4[loc5.groundSlope][0][1] + loc5.y);
					this._mcGrid.lineTo(loc4[loc5.groundSlope][1][0] + loc5.x,loc4[loc5.groundSlope][1][1] + loc5.y);
					this._mcGrid.lineTo(loc4[loc5.groundSlope][2][0] + loc5.x,loc4[loc5.groundSlope][2][1] + loc5.y);
				}
				else
				{
					loc6[k] = loc5;
				}
			}
		}
		var loc7 = this._oDatacenter.Map.width;
		var loc8 = [- loc7,- loc7 - 1];
		for(var k in loc6)
		{
			loc5 = loc6[k];
			var loc9 = 0;
			for(; loc9 < 2; loc9 = loc9 + 1)
			{
				var loc10 = Number(k) + loc8[loc9];
				if(loc6[loc10] == undefined)
				{
					if(!loc3[loc10].active && !loc2)
					{
						continue;
					}
					var loc11 = (loc9 + 1) % 4;
					this._mcGrid.moveTo(loc4[loc5.groundSlope][loc9][0] + loc5.x,loc4[loc5.groundSlope][loc9][1] + loc5.y);
					this._mcGrid.lineTo(loc4[loc5.groundSlope][loc11][0] + loc5.x,loc4[loc5.groundSlope][loc11][1] + loc5.y);
				}
			}
		}
		this.bGridVisible = true;
	}
	function clear(loc2)
	{
		this._mcGrid.removeMovieClip();
		this.bGridVisible = false;
	}
}

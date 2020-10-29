class ank.battlefield.GridHandler
{
	function GridHandler(var3, var4)
	{
		this.initialize(var2,var3);
	}
	function initialize(var2, var3)
	{
		this._mcContainer = var2;
		this._oDatacenter = var3;
	}
	function draw(var2)
	{
		this._mcGrid = this._mcContainer.createEmptyMovieClip("mcGrid",10);
		var var3 = this._oDatacenter.Map.data;
		var var4 = ank.battlefield.Constants.CELL_COORD;
		var var6 = new Object();
		this._mcGrid.lineStyle(1,ank.battlefield.Constants.GRID_COLOR,ank.battlefield.Constants.GRID_ALPHA);
		for(var var5 in var3)
		{
			if(!(!var5.active && !var2))
			{
				if(var5.movement != 0 && var5.lineOfSight || var2)
				{
					this._mcGrid.moveTo(var4[var5.groundSlope][0][0] + var5.x,var4[var5.groundSlope][0][1] + var5.y);
					this._mcGrid.lineTo(var4[var5.groundSlope][1][0] + var5.x,var4[var5.groundSlope][1][1] + var5.y);
					this._mcGrid.lineTo(var4[var5.groundSlope][2][0] + var5.x,var4[var5.groundSlope][2][1] + var5.y);
				}
				else
				{
					var6[k] = var5;
				}
			}
		}
		var var7 = this._oDatacenter.Map.width;
		var var8 = [- var7,- var7 - 1];
		for(var var5 in var6)
		{
			var var9 = 0;
			for(; var9 < 2; var9 = var9 + 1)
			{
				var var10 = Number(k) + var8[var9];
				if(var6[var10] == undefined)
				{
					if(!var3[var10].active && !var2)
					{
						continue;
					}
					var var11 = (var9 + 1) % 4;
					this._mcGrid.moveTo(var4[var5.groundSlope][var9][0] + var5.x,var4[var5.groundSlope][var9][1] + var5.y);
					this._mcGrid.lineTo(var4[var5.groundSlope][var11][0] + var5.x,var4[var5.groundSlope][var11][1] + var5.y);
				}
			}
		}
		this.bGridVisible = true;
	}
	function clear(var2)
	{
		this._mcGrid.removeMovieClip();
		this.bGridVisible = false;
	}
}

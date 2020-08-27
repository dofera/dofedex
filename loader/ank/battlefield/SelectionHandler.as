class ank.battlefield.SelectionHandler
{
	function SelectionHandler(var3, var4, var5)
	{
		this.initialize(var2,var3,var4);
	}
	function initialize(var2, var3, var4)
	{
		this._mcBattlefield = var2;
		this._oDatacenter = var4;
		this._mcContainer = var3;
		this.clear();
	}
	function clear(var2)
	{
		for(var k in this._mcContainer.Select)
		{
			var var3 = this._mcContainer.Select[k];
			if(var3 != undefined)
			{
				var var4 = var3.inObjectClips;
				for(var l in var4)
				{
					var4[l].removeMovieClip();
				}
			}
			var3.removeMovieClip();
		}
	}
	function clearLayer(var2)
	{
		if(var2 == undefined)
		{
			var2 = "default";
		}
		var var3 = this._mcContainer.Select[var2];
		if(var3 != undefined)
		{
			var var4 = var3.inObjectClips;
			§§enumerate(var4);
			while((var var0 = §§enumeration()) != null)
			{
				var4[k].removeMovieClip();
			}
		}
		var3.removeMovieClip();
	}
	function select(var2, var3, var4, var5, var6)
	{
		var var7 = this._mcBattlefield.mapHandler.getCellData(var3);
		if(var5 == undefined)
		{
			var5 = "default";
		}
		var var8 = this._mcContainer.Select[var5];
		if(var8 == undefined)
		{
			var8 = this._mcContainer.Select.createEmptyMovieClip(var5,this._mcContainer.Select.getNextHighestDepth());
			var8.inObjectClips = new Array();
		}
		if(var7 != undefined && var7.x != undefined)
		{
			var var9 = var7.movement > 1 && var7.layerObject2Num != 0;
			var var10 = "cell" + String(var3);
			if(var2)
			{
				if(var9)
				{
					var var12 = this._mcContainer.Object2["select" + var3];
					if(var12 == undefined)
					{
						var12 = this._mcContainer.Object2.createEmptyMovieClip("select" + var3,var3 * 100 + 2);
					}
					var var11 = var12[var5];
					if(var11 == undefined)
					{
						var11 = var12.attachMovie("s" + var7.groundSlope,var5,var12.getNextHighestDepth());
					}
					var8.inObjectClips.push(var11);
				}
				else
				{
					var11 = var8.attachMovie("s" + var7.groundSlope,var10,var3 * 100);
				}
				var11._x = var7.x;
				var11._y = var7.y;
				var var13 = new Color(var11);
				var13.setRGB(Number(var4));
				var11._alpha = var6 == undefined?100:var6;
			}
			else if(var9)
			{
				this._mcContainer.Object2["select" + var3][var5].unloadMovie();
				this._mcContainer.Object2["select" + var3][var5].removeMovieClip();
			}
			else
			{
				var8[var10].unloadMovie();
				var8[var10].removeMovieClip();
			}
		}
	}
	function selectMultiple(var2, var3, var4, var5, var6)
	{
		for(var i in var3)
		{
			this.select(var2,var3[i],var4,var5,var6);
		}
	}
	function getLayers()
	{
		var var2 = new Array();
		for(var k in this._mcContainer.Select)
		{
			var var3 = this._mcContainer.Select[k];
			if(var3 != undefined)
			{
				var2.push(var3._name);
			}
		}
		return var2;
	}
}

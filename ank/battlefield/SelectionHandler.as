class ank.battlefield.SelectionHandler
{
	function SelectionHandler(loc3, loc4, loc5)
	{
		this.initialize(loc2,loc3,loc4);
	}
	function initialize(loc2, loc3, loc4)
	{
		this._mcBattlefield = loc2;
		this._oDatacenter = loc4;
		this._mcContainer = loc3;
		this.clear();
	}
	function clear(loc2)
	{
		for(var loc3 in this._mcContainer.Select)
		{
			if(loc3 != undefined)
			{
				var loc4 = loc3.inObjectClips;
				§§enumerate(loc4);
				while((var loc0 = §§enumeration()) != null)
				{
					loc4[l].removeMovieClip();
				}
			}
			loc3.removeMovieClip();
		}
	}
	function clearLayer(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = "default";
		}
		var loc3 = this._mcContainer.Select[loc2];
		if(loc3 != undefined)
		{
			var loc4 = loc3.inObjectClips;
			§§enumerate(loc4);
			while((var loc0 = §§enumeration()) != null)
			{
				loc4[k].removeMovieClip();
			}
		}
		loc3.removeMovieClip();
	}
	function select(loc2, loc3, loc4, loc5, loc6)
	{
		var loc7 = this._mcBattlefield.mapHandler.getCellData(loc3);
		if(loc5 == undefined)
		{
			loc5 = "default";
		}
		var loc8 = this._mcContainer.Select[loc5];
		if(loc8 == undefined)
		{
			loc8 = this._mcContainer.Select.createEmptyMovieClip(loc5,this._mcContainer.Select.getNextHighestDepth());
			loc8.inObjectClips = new Array();
		}
		if(loc7 != undefined && loc7.x != undefined)
		{
			var loc9 = loc7.movement > 1 && loc7.layerObject2Num != 0;
			var loc10 = "cell" + String(loc3);
			if(loc2)
			{
				if(loc9)
				{
					var loc12 = this._mcContainer.Object2["select" + loc3];
					if(loc12 == undefined)
					{
						loc12 = this._mcContainer.Object2.createEmptyMovieClip("select" + loc3,loc3 * 100 + 2);
					}
					var loc11 = loc12[loc5];
					if(loc11 == undefined)
					{
						loc11 = loc12.attachMovie("s" + loc7.groundSlope,loc5,loc12.getNextHighestDepth());
					}
					loc8.inObjectClips.push(loc11);
				}
				else
				{
					loc11 = loc8.attachMovie("s" + loc7.groundSlope,loc10,loc3 * 100);
				}
				loc11._x = loc7.x;
				loc11._y = loc7.y;
				var loc13 = new Color(loc11);
				loc13.setRGB(Number(loc4));
				loc11._alpha = loc6 == undefined?100:loc6;
			}
			else if(loc9)
			{
				this._mcContainer.Object2["select" + loc3][loc5].unloadMovie();
				this._mcContainer.Object2["select" + loc3][loc5].removeMovieClip();
			}
			else
			{
				loc8[loc10].unloadMovie();
				loc8[loc10].removeMovieClip();
			}
		}
	}
	function selectMultiple(loc2, loc3, loc4, loc5, loc6)
	{
		§§enumerate(loc3);
		while((var loc0 = §§enumeration()) != null)
		{
			this.select(loc2,loc3[i],loc4,loc5,loc6);
		}
	}
	function getLayers()
	{
		var loc2 = new Array();
		for(var k in this._mcContainer.Select)
		{
			var loc3 = this._mcContainer.Select[k];
			if(loc3 != undefined)
			{
				loc2.push(loc3._name);
			}
		}
		return loc2;
	}
}

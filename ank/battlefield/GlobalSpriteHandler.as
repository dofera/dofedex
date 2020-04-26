class ank.battlefield.GlobalSpriteHandler
{
	function GlobalSpriteHandler()
	{
		this.initialize();
	}
	function initialize()
	{
		this._oSprites = new Object();
		this._mclLoader = new MovieClipLoader();
		this._mclLoader.addListener(this);
		this._aFrameToGo = new Array();
	}
	function setAccessoriesRoot(loc2)
	{
		this._sAccessoriesPath = loc2;
	}
	function addSprite(loc2, loc3)
	{
		this._oSprites[loc2._target] = {mc:loc2,data:loc3};
		this.garbageCollector();
	}
	function setColors(loc2, loc3, loc4, loc5)
	{
		var loc6 = this._oSprites[loc2._target].data;
		if(loc3 != -1)
		{
			loc6.color1 = loc3;
		}
		if(loc4 != -1)
		{
			loc6.color2 = loc4;
		}
		if(loc5 != -1)
		{
			loc6.color3 = loc5;
		}
	}
	function setAccessories(loc2, loc3)
	{
		var loc4 = this._oSprites[loc2._target].data;
		if(loc3 != undefined)
		{
			loc4.accessories = loc3;
		}
	}
	function applyColor(loc2, loc3, loc4)
	{
		var loc5 = this.getSpriteData(loc2);
		if(loc5 != undefined)
		{
			var loc6 = !(loc4 && loc5.mount != undefined)?loc5["color" + loc3]:loc5.mount["color" + loc3];
			if(loc6 != undefined && loc6 != -1)
			{
				var loc7 = (loc6 & 16711680) >> 16;
				var loc8 = (loc6 & 65280) >> 8;
				var loc9 = loc6 & 255;
				var loc10 = new Color(loc2);
				var loc11 = new Object();
				loc11 = {ra:"0",rb:loc7,ga:"0",gb:loc8,ba:"0",bb:loc9,aa:"100",ab:"0"};
				loc10.setTransform(loc11);
			}
		}
	}
	function applyAccessory(loc2, loc3, loc4, loc5, loc6)
	{
		if(loc6 == undefined)
		{
			loc6 = false;
		}
		var loc7 = this.getSpriteData(loc2);
		if(loc7 != undefined)
		{
			var loc8 = loc7.accessories[loc3].gfx;
			loc2.clip.removeMovieClip();
			if(loc6)
			{
				switch(loc7.direction)
				{
					default:
						if(loc0 === 7)
						{
							break;
						}
					case 3:
					case 4:
				}
				loc2._x = - loc2._x;
			}
			if(loc8 != undefined)
			{
				if(loc5 != undefined)
				{
					loc5.gotoAndStop(!(loc8.length == 0 || loc8 == "_")?2:1);
				}
				if(!ank.battlefield.Constants.USE_STREAMING_FILES || ank.battlefield.Constants.STREAMING_METHOD == "compact")
				{
					loc2.attachMovie(loc8,"clip",10);
					if(loc7.accessories[loc3].frame != undefined)
					{
						loc2.clip.gotoAndStop(loc4 + loc7.accessories[loc3].frame);
					}
					else
					{
						loc2.clip.gotoAndStop(loc4);
					}
				}
				else
				{
					var loc9 = loc8.split("_");
					if(loc9[0] == undefined || (_global.isNaN(Number(loc9[0])) || (loc9[1] == undefined || _global.isNaN(Number(loc9[1])))))
					{
						return undefined;
					}
					var loc10 = loc2.createEmptyMovieClip("clip",10);
					if(loc7.skin !== undefined)
					{
						this._aFrameToGo[loc10] = loc4 + loc7.skin;
					}
					else
					{
						this._aFrameToGo[loc10] = loc4;
					}
					this._mclLoader.loadClip(this._sAccessoriesPath + loc9.join("/") + ".swf",loc10);
				}
			}
		}
	}
	function applyAnim(loc2, loc3)
	{
		var loc4 = this.getSpriteData(loc2);
		if(loc4 != undefined)
		{
			if(loc4.bAnimLoop)
			{
				loc4.mc.saveLastAnimation(loc4.animation);
			}
			else
			{
				loc4.mc.setAnim(loc3);
			}
		}
	}
	function applyEnd(loc2)
	{
		var loc3 = this.getSpriteData(loc2);
		if(loc3 != undefined)
		{
			if(!loc3.bAnimLoop)
			{
				loc3.sequencer.onActionEnd();
			}
		}
	}
	function applySprite(loc2)
	{
		var loc3 = this.getSpriteData(loc2);
		if((var loc0 = loc3.direction) !== 0)
		{
			switch(null)
			{
				case 4:
					break;
				case 1:
				case 3:
					loc2.attachMovie(loc3.animation + "R","clip",1);
					break;
				case 2:
					loc2.attachMovie(loc3.animation + "F","clip",1);
					break;
				default:
					switch(null)
					{
						case 7:
							break;
						case 6:
							loc2.attachMovie(loc3.animation + "B","clip",1);
					}
					break;
				case 5:
					loc2.attachMovie(loc3.animation + "L","clip",1);
			}
		}
		loc2.attachMovie(loc3.animation + "S","clip",1);
	}
	function registerCarried(loc2)
	{
		var loc3 = this.getSpriteData(loc2);
		loc3.mc.mcCarried = loc2;
	}
	function registerChevauchor(loc2)
	{
		var loc3 = this.getSpriteData(loc2);
		loc3.mc.mcChevauchorPos = loc2;
		loc3.mc.updateChevauchorPosition();
	}
	function getSpriteData(loc2)
	{
		var loc3 = loc2._target;
		§§enumerate(this._oSprites);
		while((var loc0 = §§enumeration()) != null)
		{
			if(loc3.substring(0,name.length) == name)
			{
				if(loc3.charAt(name.length) != "/")
				{
					continue;
				}
				if(this._oSprites[name] != undefined)
				{
					return this._oSprites[name].data;
				}
			}
		}
	}
	function garbageCollector(loc2)
	{
		§§enumerate(this._oSprites);
		while((var loc0 = §§enumeration()) != null)
		{
			if(this._oSprites[o].mc._target == undefined)
			{
				delete this._oSprites.o;
			}
		}
	}
	function recursiveGotoAndStop(loc2, loc3)
	{
		loc2.stop();
		loc2.gotoAndStop(loc3);
		for(var i in loc2)
		{
			if(loc2[i] instanceof MovieClip)
			{
				this.recursiveGotoAndStop(loc2[i],loc3);
			}
		}
	}
	function onLoadInit(loc2)
	{
		this.recursiveGotoAndStop(loc2,this._aFrameToGo[loc2]);
		delete this._aFrameToGo.register2;
	}
}

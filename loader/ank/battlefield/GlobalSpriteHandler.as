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
	function setAccessoriesRoot(var2)
	{
		this._sAccessoriesPath = var2;
	}
	function addSprite(var2, var3)
	{
		this._oSprites[var2._target] = {mc:var2,data:var3};
		this.garbageCollector();
	}
	function setColors(var2, var3, var4, var5)
	{
		var var6 = this._oSprites[var2._target].data;
		if(var3 != -1)
		{
			var6.color1 = var3;
		}
		if(var4 != -1)
		{
			var6.color2 = var4;
		}
		if(var5 != -1)
		{
			var6.color3 = var5;
		}
	}
	function setAccessories(var2, var3)
	{
		var var4 = this._oSprites[var2._target].data;
		if(var3 != undefined)
		{
			var4.accessories = var3;
		}
	}
	function applyColor(var2, var3, var4)
	{
		var var5 = this.getSpriteData(var2);
		if(var5 != undefined)
		{
			var var6 = !(var4 && var5.mount != undefined)?var5["color" + var3]:var5.mount["color" + var3];
			if(var6 != undefined && var6 != -1)
			{
				var var7 = (var6 & 16711680) >> 16;
				var var8 = (var6 & 65280) >> 8;
				var var9 = var6 & 255;
				var var10 = new Color(var2);
				var var11 = new Object();
				var11 = {ra:"0",rb:var7,ga:"0",gb:var8,ba:"0",bb:var9,aa:"100",ab:"0"};
				var10.setTransform(var11);
			}
		}
	}
	function getColorIndex(var2, var3)
	{
		loop0:
		switch(var2)
		{
			case "10":
			case "11":
				switch(var3)
				{
					case 1:
						var var4 = 3;
						break;
					case 2:
						var4 = 1;
						break;
					default:
						if(var0 !== 3)
						{
							break;
						}
						var4 = 2;
						break;
				}
				break;
			case "20":
			case "21":
				switch(var3)
				{
					case 1:
						var4 = 2;
						break;
					case 2:
						var4 = 3;
						break;
					case 3:
						var4 = 1;
				}
				break;
			default:
				switch(null)
				{
					case "30":
					case "31":
						switch(var3)
						{
							case 1:
								var4 = 3;
								break;
							case 2:
								var4 = 1;
								break;
							case 3:
								var4 = 2;
						}
						break loop0;
					case "40":
					case "41":
						switch(var3)
						{
							case 1:
								var4 = 2;
							case 2:
								var4 = 3;
								break loop0;
							case 3:
								var4 = 1;
						}
					case "50":
					case "51":
						switch(var3)
						{
							case 1:
								var4 = 2;
								break;
							case 2:
								var4 = 3;
								break;
							default:
								if(var0 !== 3)
								{
									break;
								}
								var4 = 1;
								break;
						}
						break loop0;
					default:
						switch(null)
						{
							case "60":
								switch(var3)
								{
									case 1:
										var4 = 2;
										break;
									case 2:
										var4 = 3;
										break;
									case 3:
										var4 = 1;
								}
								break loop0;
							case "61":
								switch(var3)
								{
									case 1:
										var4 = 1;
										break;
									case 2:
										var4 = 3;
										break;
									case 3:
										var4 = 2;
								}
								break loop0;
							default:
								switch(null)
								{
									case "80":
									case "81":
									case "90":
									case "91":
										var4 = var3;
										break loop0;
									case "100":
										switch(var3)
										{
											case 1:
												var4 = 3;
												break;
											case 2:
												var4 = 2;
												break;
											case 3:
												var4 = 1;
										}
										break loop0;
									default:
										switch(null)
										{
											case "101":
												switch(var3)
												{
													case 1:
														var4 = 1;
														break;
													case 2:
														var4 = 3;
														break;
													case 3:
														var4 = 2;
												}
												break loop0;
											case "110":
											case "111":
												switch(var3)
												{
													case 1:
														var4 = 2;
														break;
													case 2:
														var4 = 3;
														break;
													default:
														if(var0 !== 3)
														{
															break;
														}
														var4 = 1;
														break;
												}
												break loop0;
											default:
												if(var0 !== "121")
												{
													break loop0;
												}
											case "120":
												switch(var3)
												{
													case 1:
														var4 = 1;
														break;
													case 2:
														var4 = 3;
														break;
													case 3:
														var4 = 2;
												}
										}
								}
							case "70":
							case "71":
								if((var0 = var3) !== 1)
								{
									switch(null)
									{
										case 2:
											var4 = 3;
											break;
										case 3:
											var4 = 1;
									}
								}
								else
								{
									var4 = 2;
								}
						}
				}
		}
		if(!var4)
		{
			var4 = -1;
		}
		return var4;
	}
	function applyBottomColor(var2)
	{
		var var3 = (ank.battlefield.datacenter.Sprite)this.getSpriteData(var2);
		if(var3 == undefined)
		{
			return undefined;
		}
		var var4 = this.getColorIndex(var3.gfxFileName,3);
		if(var4 == -1)
		{
			return undefined;
		}
		this.applyColor(var2,var4);
	}
	function applyBodyColor(var2)
	{
		var var3 = (ank.battlefield.datacenter.Sprite)this.getSpriteData(var2);
		if(var3 == undefined)
		{
			return undefined;
		}
		var var4 = this.getColorIndex(var3.gfxFileName,2);
		if(var4 == -1)
		{
			return undefined;
		}
		this.applyColor(var2,var4);
	}
	function applyHeadColor(var2)
	{
		var var3 = (ank.battlefield.datacenter.Sprite)this.getSpriteData(var2);
		if(var3 == undefined)
		{
			return undefined;
		}
		var var4 = this.getColorIndex(var3.gfxFileName,1);
		if(var4 == -1)
		{
			return undefined;
		}
		this.applyColor(var2,var4);
	}
	function applyAccessory(var2, var3, var4, var5, var6)
	{
		if(var6 == undefined)
		{
			var6 = false;
		}
		var var7 = this.getSpriteData(var2);
		if(var7 != undefined)
		{
			var var8 = var7.accessories[var3].gfx;
			var2.clip.removeMovieClip();
			if(var6)
			{
				switch(var7.direction)
				{
					default:
						if(var0 === 7)
						{
							break;
						}
					case 3:
					case 4:
				}
				var2._x = - var2._x;
			}
			if(var8 != undefined)
			{
				if(var5 != undefined)
				{
					var5.gotoAndStop(!(var8.length == 0 || var8 == "_")?2:1);
				}
				if(!ank.battlefield.Constants.USE_STREAMING_FILES || ank.battlefield.Constants.STREAMING_METHOD == "compact")
				{
					var2.attachMovie(var8,"clip",10);
					if(var7.accessories[var3].frame != undefined)
					{
						var2.clip.gotoAndStop(var4 + var7.accessories[var3].frame);
					}
					else
					{
						var2.clip.gotoAndStop(var4);
					}
				}
				else
				{
					var var9 = var8.split("_");
					if(var9[0] == undefined || (_global.isNaN(Number(var9[0])) || (var9[1] == undefined || _global.isNaN(Number(var9[1])))))
					{
						return undefined;
					}
					var var10 = var2.createEmptyMovieClip("clip",10);
					if(var7.skin !== undefined)
					{
						this._aFrameToGo[var10] = var4 + var7.skin;
					}
					else
					{
						this._aFrameToGo[var10] = var4;
					}
					this._mclLoader.loadClip(this._sAccessoriesPath + var9.join("/") + ".swf",var10);
				}
			}
		}
	}
	function applyAnim(var2, var3)
	{
		var var4 = this.getSpriteData(var2);
		if(var4 != undefined)
		{
			if(var4.bAnimLoop)
			{
				var4.mc.saveLastAnimation(var4.animation);
			}
			else
			{
				var4.mc.setAnim(var3);
			}
		}
	}
	function applyEnd(var2)
	{
		var var3 = this.getSpriteData(var2);
		if(var3 != undefined)
		{
			if(!var3.bAnimLoop)
			{
				var3.sequencer.onActionEnd();
			}
		}
	}
	function applySprite(var2)
	{
		var var3 = this.getSpriteData(var2);
		loop0:
		switch(var3.direction)
		{
			case 0:
			case 4:
				var2.attachMovie(var3.animation + "S","clip",1);
				break;
			default:
				switch(null)
				{
					case 1:
					case 3:
						var2.attachMovie(var3.animation + "R","clip",1);
						break loop0;
					case 2:
						var2.attachMovie(var3.animation + "F","clip",1);
						break loop0;
					case 5:
					case 7:
						var2.attachMovie(var3.animation + "L","clip",1);
						break loop0;
					default:
						if(var0 !== 6)
						{
							break loop0;
						}
						var2.attachMovie(var3.animation + "B","clip",1);
						break loop0;
				}
		}
	}
	function registerCarried(var2)
	{
		var var3 = this.getSpriteData(var2);
		var3.mc.mcCarried = var2;
	}
	function registerChevauchor(var2)
	{
		var var3 = this.getSpriteData(var2);
		var3.mc.mcChevauchorPos = var2;
		var3.mc.updateChevauchorPosition();
	}
	function getSpriteData(var2)
	{
		var var3 = var2._target;
		for(var name in this._oSprites)
		{
			if(var3.substring(0,name.length) == name)
			{
				if(var3.charAt(name.length) != "/")
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
	function garbageCollector(var2)
	{
		§§enumerate(this._oSprites);
		while((var var0 = §§enumeration()) != null)
		{
			if(this._oSprites[o].mc._target == undefined)
			{
				delete this._oSprites.o;
			}
		}
	}
	function recursiveGotoAndStop(var2, var3)
	{
		var2.stop();
		var2.gotoAndStop(var3);
		§§enumerate(var2);
		while((var var0 = §§enumeration()) != null)
		{
			if(var2[i] instanceof MovieClip)
			{
				this.recursiveGotoAndStop(var2[i],var3);
			}
		}
	}
	function onLoadInit(var2)
	{
		this.recursiveGotoAndStop(var2,this._aFrameToGo[var2]);
		delete this._aFrameToGo.register2;
	}
}

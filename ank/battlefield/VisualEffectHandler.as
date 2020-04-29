class ank.battlefield.VisualEffectHandler
{
	static var MAX_INDEX = 21;
	function VisualEffectHandler(var3, var4)
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
		this._incIndex = 0;
	}
	function addEffect(var2, var3, var4, var5, var6, var7)
	{
		if(displayType < 10)
		{
			return undefined;
		}
		var var8 = !var3.bInFrontOfSprite?-1:1;
		var var9 = this.getNextIndex() + ank.battlefield.Constants.MAX_SPRITES_ON_CELL / 2 + 1;
		this._mcContainer["eff" + var9].removeMovieClip();
		this._mcContainer.createEmptyMovieClip("eff" + var9,var4 * 100 + 50 + var8 * var9);
		var var10 = this._mcContainer["eff" + var9];
		var10.createEmptyMovieClip("mc",10);
		var10._visible = var7 != undefined?var7:true;
		var var11 = new MovieClipLoader();
		var11.addListener(this);
		var10.sprite = var2;
		var10.targetSprite = var6;
		var10.cellNum = var4;
		var10.displayType = displayType;
		var10.level = var3.level;
		var10.params = var3.params;
		if(var3.bTryToBypassContainerColor == true)
		{
			var var12 = new Color(var10);
			var12.setTransform({ra:200,rb:0,ga:200,gb:0,ba:200,bb:0});
		}
		var11.loadClip(var3.file,var10.mc);
		ank.utils.Timer.setTimer(var10,"battlefield",var10,var10.removeMovieClip,ank.battlefield.Constants.VISUAL_EFFECT_MAX_TIMER);
	}
	function onLoadInit(var2)
	{
		var var3 = var2._parent.sprite;
		var var4 = var2._parent.targetSprite;
		var var5 = var2._parent.cellNum;
		var displayType = var2._parent.displayType;
		var var6 = var2._parent.level;
		var var7 = var2._parent.params;
		var var8 = var2._parent.ignoreTargetInHeight;
		var var9 = var3.cellNum;
		var var10 = this._mcBattlefield.mapHandler.getCellData(var9);
		var var11 = this._mcBattlefield.mapHandler.getCellData(var5);
		var var12 = !!var3?{x:var3.mc._x,y:var3.mc._y}:{x:var10.x,y:var10.y};
		var var13 = !!var4?{x:var4.mc._x,y:var4.mc._y}:{x:var11.x,y:var11.y};
		var2.level = var6;
		var2.angle = Math.atan2(var13.y - var12.y,var13.x - var12.x) * 180 / Math.PI;
		var2.params = var7;
		loop0:
		switch(displayType)
		{
			case 10:
			case 12:
				var2._ACTION = var3;
				var2._x = var12.x;
				var2._y = var12.y;
				break;
			case 11:
				var2._ACTION = var3;
				var2._x = var13.x;
				var2._y = var13.y;
				break;
			default:
				switch(null)
				{
					case 21:
					case 30:
					case 31:
						var2._ACTION = var3;
						var2._x = var12.x;
						var2._y = var12.y - 10;
						var2.level = var6;
						var var18 = !(displayType == 31 || displayType == 33)?0.5:0.9;
						var speed = !(displayType == 31 || displayType == 33)?0.675:0.5;
						if(dofus.Constants.DOUBLEFRAMERATE)
						{
							speed = speed / 2;
						}
						var var19 = Math.PI / 2;
						var var20 = var13.x - var12.x;
						var var21 = var13.y - var12.y;
						var var22 = (Math.atan2(var21,Math.abs(var20)) + var19) * var18;
						var var23 = var22 - var19;
						var xDest = Math.abs(var20);
						var2.startangle = var23;
						if(var20 <= 0)
						{
							if(var20 == 0 && var21 < 0)
							{
								var2._yscale = - var2._yscale;
								yDest = - yDest;
							}
							var2._xscale = - var2._xscale;
						}
						var2.attachMovie("move","move",2);
						var vyi;
						var x;
						var y;
						var halfg = g / 2;
						var vx = Math.sqrt(Math.abs(halfg * Math.pow(xDest,2) / Math.abs(yDest - Math.tan(var23) * xDest)));
						var vy = Math.tan(var23) * vx;
						var2.onEnterFrame = function()
						{
							vyi = vy + g * t;
							x = t * vx;
							y = halfg * Math.pow(t,2) + vy * t;
							t = t + speed;
							if(Math.abs(y) >= Math.abs(yDest) && x >= xDest || x > xDest)
							{
								this.attachMovie("shoot","shoot",2);
								this.shoot._x = xDest;
								this.shoot._y = yDest;
								this.shoot._rotation = Math.atan(vyi / vx) * 180 / Math.PI;
								this.end();
								delete this.onEnterFrame;
							}
							else
							{
								this.move._x = x;
								this.move._y = y;
								this.move._rotation = Math.atan(vyi / vx) * 180 / Math.PI;
							}
						};
						break loop0;
					default:
						switch(null)
						{
							case 41:
								break;
							case 50:
							case 51:
								var2._ACTION = var3;
								var2.cellFrom = var12;
								var2.cellTo = var13;
						}
						break loop0;
					case 40:
						var2._ACTION = var3;
						var2._x = var12.x;
						var2._y = var12.y;
						var var24 = 20;
						if(dofus.Constants.DOUBLEFRAMERATE)
						{
							var24 = var24 / 2;
						}
						var xStart = var12.x;
						var yStart = var12.y;
						var xDest = var13.x;
						var yDest = var13.y;
						var rot = Math.atan2(yDest - yStart,xDest - xStart);
						var fullDist = Math.sqrt(Math.pow(xStart - xDest,2) + Math.pow(yStart - yDest,2));
						var interval = fullDist / Math.floor(fullDist / var24);
						var2.onEnterFrame = function()
						{
							dist = dist + interval;
							if(!dofus.Constants.DOUBLEFRAMERATE || !bNoDupliFrame)
							{
								if(dist > fullDist)
								{
									this.end();
									if(displayType == 41)
									{
										this.attachMovie("shoot","shoot",10);
										this.shoot._x = xDest - xStart;
										this.shoot._y = yDest - yStart;
									}
									delete this.onEnterFrame;
								}
								else
								{
									var var2 = this.attachMovie("duplicate","duplicate" + inc,inc);
									var2._x = dist * Math.cos(rot);
									var2._y = dist * Math.sin(rot);
									inc++;
								}
							}
							bNoDupliFrame = !bNoDupliFrame;
						};
				}
			case 20:
				var2._x = var12.x;
				var2._y = var12.y;
				var var14 = Math.PI / 2;
				var var15 = var13.x - var12.x;
				var var16 = var13.y - var12.y;
				var2.rotate._rotation = var2.angle;
				var var17 = var2.attachMovie("shoot","shoot",10);
				var17._x = var15;
				var17._y = var16;
		}
	}
	function getNextIndex(var2)
	{
		this._incIndex++;
		if(this._incIndex > ank.battlefield.VisualEffectHandler.MAX_INDEX)
		{
			this._incIndex = 0;
		}
		return this._incIndex;
	}
}

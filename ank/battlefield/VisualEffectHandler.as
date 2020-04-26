class ank.battlefield.VisualEffectHandler
{
	static var MAX_INDEX = 21;
	function VisualEffectHandler(loc3, loc4)
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
		this._incIndex = 0;
	}
	function addEffect(loc2, loc3, loc4, loc5, loc6, loc7)
	{
		if(displayType < 10)
		{
			return undefined;
		}
		var loc8 = !loc3.bInFrontOfSprite?-1:1;
		var loc9 = this.getNextIndex() + ank.battlefield.Constants.MAX_SPRITES_ON_CELL / 2 + 1;
		this._mcContainer["eff" + loc9].removeMovieClip();
		this._mcContainer.createEmptyMovieClip("eff" + loc9,loc4 * 100 + 50 + loc8 * loc9);
		var loc10 = this._mcContainer["eff" + loc9];
		loc10.createEmptyMovieClip("mc",10);
		loc10._visible = loc7 != undefined?loc7:true;
		var loc11 = new MovieClipLoader();
		loc11.addListener(this);
		loc10.sprite = loc2;
		loc10.targetSprite = loc6;
		loc10.cellNum = loc4;
		loc10.displayType = displayType;
		loc10.level = loc3.level;
		loc10.params = loc3.params;
		if(loc3.bTryToBypassContainerColor == true)
		{
			var loc12 = new Color(loc10);
			loc12.setTransform({ra:200,rb:0,ga:200,gb:0,ba:200,bb:0});
		}
		loc11.loadClip(loc3.file,loc10.mc);
		ank.utils.Timer.setTimer(loc10,"battlefield",loc10,loc10.removeMovieClip,ank.battlefield.Constants.VISUAL_EFFECT_MAX_TIMER);
	}
	function onLoadInit(loc2)
	{
		var loc3 = loc2._parent.sprite;
		var loc4 = loc2._parent.targetSprite;
		var loc5 = loc2._parent.cellNum;
		var displayType = loc2._parent.displayType;
		var loc6 = loc2._parent.level;
		var loc7 = loc2._parent.params;
		var loc8 = loc2._parent.ignoreTargetInHeight;
		var loc9 = loc3.cellNum;
		var loc10 = this._mcBattlefield.mapHandler.getCellData(loc9);
		var loc11 = this._mcBattlefield.mapHandler.getCellData(loc5);
		var loc12 = !!loc3?{x:loc3.mc._x,y:loc3.mc._y}:{x:loc10.x,y:loc10.y};
		var loc13 = !!loc4?{x:loc4.mc._x,y:loc4.mc._y}:{x:loc11.x,y:loc11.y};
		loc2.level = loc6;
		loc2.angle = Math.atan2(loc13.y - loc12.y,loc13.x - loc12.x) * 180 / Math.PI;
		loc2.params = loc7;
		switch(displayType)
		{
			case 10:
			case 12:
				loc2._ACTION = loc3;
				loc2._x = loc12.x;
				loc2._y = loc12.y;
				break;
			case 11:
				loc2._ACTION = loc3;
				loc2._x = loc13.x;
				loc2._y = loc13.y;
				break;
			case 20:
			case 21:
				loc2._x = loc12.x;
				loc2._y = loc12.y;
				var loc14 = Math.PI / 2;
				var loc15 = loc13.x - loc12.x;
				var loc16 = loc13.y - loc12.y;
				loc2.rotate._rotation = loc2.angle;
				var loc17 = loc2.attachMovie("shoot","shoot",10);
				loc17._x = loc15;
				loc17._y = loc16;
				break;
			default:
				switch(null)
				{
					case 30:
					case 31:
						loc2._ACTION = loc3;
						loc2._x = loc12.x;
						loc2._y = loc12.y - 10;
						loc2.level = loc6;
						var loc18 = !(displayType == 31 || displayType == 33)?0.5:0.9;
						var speed = !(displayType == 31 || displayType == 33)?0.5:0.4;
						if(dofus.Constants.DOUBLEFRAMERATE)
						{
							speed = speed / 2;
						}
						var loc19 = Math.PI / 2;
						var loc20 = loc13.x - loc12.x;
						var loc21 = loc13.y - loc12.y;
						var loc22 = (Math.atan2(loc21,Math.abs(loc20)) + loc19) * loc18;
						var loc23 = loc22 - loc19;
						var xDest = Math.abs(loc20);
						var yDest = loc21;
						loc2.startangle = loc23;
						if(loc20 <= 0)
						{
							if(loc20 == 0 && loc21 < 0)
							{
								loc2._yscale = - loc2._yscale;
								yDest = - yDest;
							}
							loc2._xscale = - loc2._xscale;
						}
						loc2.attachMovie("move","move",2);
						var vyi;
						var x;
						var y;
						var g = 9.81;
						var halfg = g / 2;
						var t = 0;
						var vx = Math.sqrt(Math.abs(halfg * Math.pow(xDest,2) / Math.abs(yDest - Math.tan(loc23) * xDest)));
						var vy = Math.tan(loc23) * vx;
						loc2.onEnterFrame = function()
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
						break;
					case 40:
					case 41:
						loc2._ACTION = loc3;
						loc2._x = loc12.x;
						loc2._y = loc12.y;
						var loc24 = 20;
						if(dofus.Constants.DOUBLEFRAMERATE)
						{
							loc24 = loc24 / 2;
						}
						var xStart = loc12.x;
						var yStart = loc12.y;
						var xDest = loc13.x;
						var yDest = loc13.y;
						var rot = Math.atan2(yDest - yStart,xDest - xStart);
						var fullDist = Math.sqrt(Math.pow(xStart - xDest,2) + Math.pow(yStart - yDest,2));
						var interval = fullDist / Math.floor(fullDist / loc24);
						var dist = 0;
						var inc = 1;
						var bNoDupliFrame = false;
						loc2.onEnterFrame = function()
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
									var loc2 = this.attachMovie("duplicate","duplicate" + inc,inc);
									loc2._x = dist * Math.cos(rot);
									loc2._y = dist * Math.sin(rot);
									inc++;
								}
							}
							bNoDupliFrame = !bNoDupliFrame;
						};
						break;
					case 50:
					case 51:
						loc2._ACTION = loc3;
						loc2.cellFrom = loc12;
						loc2.cellTo = loc13;
				}
		}
	}
	function getNextIndex(loc2)
	{
		this._incIndex++;
		if(this._incIndex > ank.battlefield.VisualEffectHandler.MAX_INDEX)
		{
			this._incIndex = 0;
		}
		return this._incIndex;
	}
}

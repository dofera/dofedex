class ank.battlefield.mc.Sprite extends MovieClip
{
	var _nLastAlphaValue = 100;
	var _bGfxLoaded = false;
	var _bChevauchorGfxLoaded = false;
	static var WALK_SPEEDS = [0.07,0.06,0.06,0.06,0.07,0.06,0.06,0.06];
	static var MOUNT_SPEEDS = [0.23,0.2,0.2,0.2,0.23,0.2,0.2,0.2];
	static var RUN_SPEEDS = [0.17,0.15,0.15,0.15,0.17,0.15,0.15,0.15];
	function Sprite(loc3, loc4, loc5)
	{
		super();
		this.initialize(loc3,loc4,loc5);
	}
	function __get__data()
	{
		return this._oData;
	}
	function __set__mcCarried(loc2)
	{
		this._mcCarried = loc2;
		return this.__get__mcCarried();
	}
	function __set__mcChevauchorPos(loc2)
	{
		this._mcChevauchorPos = loc2;
		return this.__get__mcChevauchorPos();
	}
	function __set__isHidden(loc2)
	{
		this.setHidden(loc2);
		return this.__get__isHidden();
	}
	function __get__isHidden()
	{
		return this._bHidden;
	}
	function initialize(loc2, loc3, loc4)
	{
		_global.GAC.addSprite(this,loc4);
		this._mcBattlefield = loc2;
		this._oSprites = loc3;
		this._oData = loc4;
		this._mvlLoader = new MovieClipLoader();
		this._mvlLoader.addListener(this);
		this.setPosition(this._oData.cellNum);
		this.draw();
		this._ACTION = loc4;
		this.api = _global.API;
	}
	function draw()
	{
		this._mcGfx.removeMovieClip();
		this.createEmptyMovieClip("_mcGfx",20);
		this.setHidden(this._bHidden);
		this._bGfxLoaded = false;
		this._bChevauchorGfxLoaded = false;
		this._mvlLoader.loadClip(!!this._oData.isMounting?this._oData.mount.gfxFile:this._oData.gfxFile,this._mcGfx);
	}
	function clear()
	{
		this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).removeSpriteOnID(this._oData.id);
		this._mcGfx.removeMovieClip();
		this._oData.direction = 1;
		this.removeExtraClip();
		this._oData.isClear = true;
	}
	function select(loc2)
	{
		var loc3 = new Object();
		if(loc2)
		{
			loc3 = {ra:60,rb:102,ga:60,gb:102,ba:60,bb:102};
		}
		else
		{
			loc3 = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
		}
		this.setColorTransform(loc3);
	}
	function addExtraClip(loc2, loc3, loc4)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		if(loc4 == undefined)
		{
			loc4 = false;
		}
		this.removeExtraClip(loc4);
		if(loc4)
		{
			var loc5 = new Object();
			loc5.file = loc2;
			loc5.color = loc3;
			this._oData.xtraClipTopParams = loc5;
			if(!this._bGfxLoaded)
			{
				return undefined;
			}
		}
		var loc6 = !loc4?this._mcXtraBack:this._mcXtraTop;
		if(loc3 != undefined)
		{
			var loc7 = new Color(loc6);
			loc7.setRGB(loc3);
		}
		loc6.loadMovie(loc2);
	}
	function removeExtraClip(loc2)
	{
		switch(loc2)
		{
			case true:
				this._mcXtraTop.removeMovieClip();
				this.createEmptyMovieClip("_mcXtraTop",30);
				break;
			case false:
				this._mcXtraBack.removeMovieClip();
				this.createEmptyMovieClip("_mcXtraBack",10);
				break;
			default:
				this._mcXtraTop.removeMovieClip();
				this._mcXtraBack.removeMovieClip();
				this.createEmptyMovieClip("_mcXtraTop",30);
				this.createEmptyMovieClip("_mcXtraBack",10);
		}
	}
	function setColorTransform(loc2)
	{
		var loc3 = new Color(this);
		loc3.setTransform(loc2);
	}
	function setNewCellNum(loc2)
	{
		this._oData.cellNum = Number(loc2);
	}
	function setDirection(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = this._oData.direction;
		}
		this._oData.direction = loc2;
		this.setAnim(this._oData.animation);
	}
	function setPosition(loc2)
	{
		this.updateMap(loc2,this._oData.isVisible);
		this.setDepth(loc2);
		if(loc2 == undefined)
		{
			loc2 = this._oData.cellNum;
		}
		else
		{
			this.setNewCellNum(loc2);
		}
		var loc3 = this._mcBattlefield.mapHandler.getCellData(loc2);
		var loc4 = this._mcBattlefield.mapHandler.getCellHeight(loc2);
		var loc5 = loc4 - Math.floor(loc4);
		this._x = loc3.x;
		this._y = loc3.y - loc5 * ank.battlefield.Constants.LEVEL_HEIGHT;
	}
	function setDepth(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = this._oData.cellNum;
		}
		var loc3 = ank.battlefield.utils.SpriteDepthFinder.getFreeDepthOnCell(this._mcBattlefield.mapHandler,this._oSprites,loc2,this._mcBattlefield.bGhostView);
		this.swapDepths(loc3);
		if(this._oData.hasCarriedChild())
		{
			this._oData.carriedChild.mc.setDepth(loc2);
		}
	}
	function setVisible(loc2)
	{
		this._oData.isVisible = loc2;
		this._visible = loc2;
		this.updateMap(this._oData.cellNum,loc2);
	}
	function setAlpha(loc2)
	{
		this._mcGfx._alpha = loc2;
	}
	function setHidden(loc2)
	{
		this._bHidden = loc2;
		if(this._bHidden)
		{
			this._mcGfx._x = this._mcGfx._y = -5000;
			this._mcGfx._visible = false;
		}
		else
		{
			this._mcGfx._x = this._mcGfx._y = 0;
			this._mcGfx._visible = true;
		}
	}
	function setGhostView(loc2)
	{
		this.setDepth();
		if(loc2)
		{
			this._nLastAlphaValue = this._mcGfx._alpha;
			this.setAlpha(ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
		}
		else
		{
			this.setAlpha(this._nLastAlphaValue);
		}
	}
	function moveToCell(loc2, loc3, loc4, loc5, loc6, loc7)
	{
		if(cellNum != this._oData.cellNum)
		{
			var loc8 = this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum);
			var loc9 = this._mcBattlefield.mapHandler.getCellData(cellNum);
			var loc10 = loc9.x;
			var loc11 = loc9.y;
			var loc12 = 0.01;
			if(loc9.groundSlope != 1)
			{
				loc11 = loc11 - ank.battlefield.Constants.HALF_LEVEL_HEIGHT;
			}
			if(loc6.toLowerCase() != "static")
			{
				this._oData.direction = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(loc8.x,loc8.rootY,loc10,loc9.rootY,true);
			}
			switch(loc5)
			{
				case "slide":
					var loc13 = 0.25;
					this.setAnim(loc6);
					break;
				case "walk":
				default:
					loc13 = ank.battlefield.mc.Sprite.WALK_SPEEDS[this._oData.direction];
					this.setAnim(loc6 != undefined?loc6:"walk",undefined,loc7);
					break;
				case "run":
					loc13 = !!this._oData.isMounting?ank.battlefield.mc.Sprite.MOUNT_SPEEDS[this._oData.direction]:ank.battlefield.mc.Sprite.RUN_SPEEDS[this._oData.direction];
					this.setAnim(loc6 != undefined?loc6:"run",undefined,loc7);
			}
			loc13 = loc13 * this._oData.speedModerator;
			if(loc9.groundLevel < loc8.groundLevel)
			{
				loc13 = loc13 + loc12;
			}
			else if(loc9.groundLevel > loc8.groundLevel)
			{
				loc13 = loc13 - loc12;
			}
			else if(loc8.groundSlope != loc9.groundSlope)
			{
				if(loc9.groundSlope == 1)
				{
					loc13 = loc13 + loc12;
				}
				else if(loc8.groundSlope == 1)
				{
					loc13 = loc13 - loc12;
				}
			}
			this._nDistance = Math.sqrt(Math.pow(this._x - loc10,2) + Math.pow(this._y - loc11,2));
			var loc14 = Math.atan2(loc11 - this._y,loc10 - this._x);
			var loc15 = Math.cos(loc14);
			var loc16 = Math.sin(loc14);
			this._nLastTimer = getTimer();
			var loc17 = Number(cellNum) > this._oData.cellNum;
			this.updateMap(cellNum,this._oData.isVisible,true);
			this.setNewCellNum(cellNum);
			this._oData.isInMove = true;
			if(this._oData.hasCarriedChild())
			{
				var loc18 = this._oData.carriedChild;
				var loc19 = loc18.mc;
				loc19.setDirection(this._oData.direction);
				loc19.updateMap(cellNum,loc18.isVisible);
				loc19.setNewCellNum(cellNum);
			}
			if(loc17)
			{
				this.setDepth(cellNum);
			}
			ank.utils.CyclicTimer.addFunction(this,this,this.basicMove,[loc13,loc15,loc16],this,this.basicMoveEnd,[loc2,loc10,loc11,cellNum,loc4,loc5 == "slide",!loc17]);
		}
		else
		{
			loc2.onActionEnd();
		}
	}
	function basicMove(speed, §\x13\x01§, §\x1e\x13\x04§)
	{
		var loc5 = getTimer() - this._nLastTimer;
		var loc6 = speed * (loc5 <= 50?loc5:50);
		this._x = this._x + loc6 * loc3;
		this._y = this._y + loc6 * loc4;
		this._nDistance = this._nDistance - loc6;
		this._nLastTimer = getTimer();
		if(this._nDistance <= loc6)
		{
			return false;
		}
		return true;
	}
	function basicMoveEnd(loc2, loc3, loc4, loc5, loc6, loc7, loc8)
	{
		if(this._nOldCellNum != undefined)
		{
			this._mcBattlefield.mapHandler.getCellData(this._nOldCellNum).removeSpriteOnID(this._oData.id);
			this._nOldCellNum = undefined;
		}
		if(loc6)
		{
			this._x = xDest;
			this._y = yDest;
			this.setAnim(this._oData.defaultAnimation);
			this._oData.isInMove = false;
			if(this.api.gfx.spriteHandler.isShowingMonstersTooltip && this.data instanceof dofus.datacenter.MonsterGroup)
			{
				this._rollOver();
			}
		}
		if(loc8)
		{
			this.setDepth(cellNum);
		}
		loc2.onActionEnd();
	}
	function saveLastAnimation(loc2)
	{
		if(!this._oData.isMounting)
		{
			this._mcGfx.mcAnim.lastAnimation = loc2;
		}
		else
		{
			this._mcChevauchor.mcAnim.lastAnimation = loc2;
			this._mcGfx.mcAnimFront.lastAnimation = loc2;
			this._mcGfx.mcAnimBack.lastAnimation = loc2;
		}
	}
	function setAnimTimer(loc2, loc3, loc4, loc5)
	{
		this.setAnim(loc2,loc3,loc4);
		if(_global.isNaN(Number(loc5)))
		{
			return undefined;
		}
		if(loc5 < 1)
		{
			return undefined;
		}
		ank.utils.Timer.setTimer(this,"battlefield",this,this.setAnim,loc5,[this._oData.defaultAnimation]);
	}
	function setAnim(loc2, loc3, loc4)
	{
		if(loc2 == undefined)
		{
			loc2 = this._oData.defaultAnimation;
		}
		loc2 = String(loc2).toLowerCase();
		if(loc3 == undefined)
		{
			loc3 = false;
		}
		if(loc4 == undefined)
		{
			loc4 = false;
		}
		var loc5 = this._oData.noFlip;
		this._oData.bAnimLoop = loc3;
		var loc6 = this._mcGfx;
		var loc7 = "";
		if(this._oData.hasCarriedChild())
		{
			loc7 = loc7 + "_C";
		}
		if((var loc0 = this._oData.direction) !== 0)
		{
			switch(null)
			{
				case 1:
					var loc10 = "R";
					var loc8 = loc2 + loc7 + loc10;
					var loc9 = "staticR";
					this._xscale = 100;
					break;
				case 2:
					loc10 = "F";
					loc8 = loc2 + loc7 + loc10;
					loc9 = "staticR";
					this._xscale = 100;
					break;
				case 3:
					loc10 = "R";
					loc8 = loc2 + loc7 + loc10;
					loc9 = "staticR";
					if(!loc5)
					{
						this._xscale = -100;
					}
					break;
				case 4:
					loc10 = "S";
					loc8 = loc2 + loc7 + loc10;
					loc9 = "staticL";
					if(!loc5)
					{
						this._xscale = -100;
					}
					break;
				case 5:
					loc10 = "L";
					loc8 = loc2 + loc7 + loc10;
					loc9 = "staticL";
					this._xscale = 100;
					break;
				default:
					switch(null)
					{
						case 6:
							loc10 = "B";
							loc8 = loc2 + loc7 + loc10;
							loc9 = "staticL";
							this._xscale = 100;
							break;
						case 7:
							loc10 = "L";
							loc8 = loc2 + loc7 + loc10;
							loc9 = "staticL";
							if(!loc5)
							{
								this._xscale = -100;
								break;
							}
					}
			}
		}
		else
		{
			loc10 = "S";
			loc8 = loc2 + loc7 + loc10;
			loc9 = "staticR";
			this._xscale = 100;
		}
		var loc11 = this._oData.fullAnimation;
		var loc12 = this._oData.animation;
		this._oData.animation = loc2;
		this._oData.fullAnimation = loc8;
		if(this._oData.xtraClipTopAnimations != undefined)
		{
			if(this._oData.xtraClipTopAnimations[loc8])
			{
				this.addExtraClip(this._oData.xtraClipTopParams.file,this._oData.xtraClipTopParams.color,true);
			}
			else if(this._mcXtraTop != undefined)
			{
				this.removeExtraClip(true);
			}
		}
		if(loc4 || loc8 != loc11)
		{
			if(!this._oData.isMounting)
			{
				loc6.mcAnim.removeMovieClip();
				if(loc6.attachMovie(loc8,"mcAnim",10,{lastAnimation:loc12}) == undefined)
				{
					loc6.attachMovie("static" + loc10,"mcAnim",10,{lastAnimation:loc12});
					ank.utils.Logger.err("L\'anim (" + loc8 + ") n\'existe pas !");
				}
				if(ank.battlefield.Battlefield.useCacheAsBitmapOnStaticAnim)
				{
					(MovieClip)loc6.mcAnim.cacheAsBitmap = (MovieClip)loc6.mcAnim._totalframes == 1;
				}
			}
			else
			{
				this._mcChevauchor.mcAnim.removeMovieClip();
				loc6.mcAnimFront.removeMovieClip();
				loc6.mcAnimBack.removeMovieClip();
				if(this._mcChevauchor.attachMovie(loc8,"mcAnim",1,{lastAnimation:loc12}) == undefined)
				{
					this._mcChevauchor.attachMovie("static" + loc10,"mcAnim",1,{lastAnimation:loc12});
				}
				if(loc6.attachMovie(loc8 + "_Front","mcAnimFront",30,{lastAnimation:loc12}) == undefined)
				{
					loc6.attachMovie("static" + loc10 + "_Front","mcAnimFront",30,{lastAnimation:loc12});
				}
				if(loc6.attachMovie(loc8 + "_Back","mcAnimBack",10,{lastAnimation:loc12}) == undefined)
				{
					loc6.attachMovie("static" + loc10 + "_Back","mcAnimBack",10,{lastAnimation:loc12});
				}
			}
		}
		if(this._oData.hasCarriedChild())
		{
			ank.utils.CyclicTimer.addFunction(this,this,this.updateCarriedPosition);
		}
		if(this._oData.isMounting)
		{
			this.chevauchorUpdater = this.createEmptyMovieClip("chevauchorUpdater",1000);
			this.chevauchorUpdater.sprite = this;
			this.chevauchorUpdater.onEnterFrame = function()
			{
				this.sprite.updateChevauchorPosition();
			};
		}
	}
	function updateCarriedPosition()
	{
		if(this._oData.hasCarriedChild())
		{
			if(this._mcCarried != undefined)
			{
				var loc2 = {x:this._mcCarried._x,y:this._mcCarried._y};
				this._mcCarried._parent.localToGlobal(loc2);
				this._mcBattlefield.container.globalToLocal(loc2);
				this._oData.carriedChild.mc._x = loc2.x;
				this._oData.carriedChild.mc._y = loc2.y;
			}
		}
		return this._oData.animation == "static"?false:true;
	}
	function updateChevauchorPosition()
	{
		if(this._oData.isMounting)
		{
			if(this._mcChevauchorPos != undefined)
			{
				var loc2 = {x:this._mcChevauchorPos._x,y:this._mcChevauchorPos._y};
				this._mcChevauchorPos._parent.localToGlobal(loc2);
				this._mcGfx.globalToLocal(loc2);
				this._mcChevauchor._x = loc2.x;
				this._mcChevauchor._y = loc2.y;
				this._mcChevauchor._rotation = this._mcChevauchorPos._rotation;
				this._mcChevauchor._xscale = this._mcChevauchorPos._xscale;
				this._mcChevauchor._yscale = this._mcChevauchorPos._yscale;
			}
		}
		if(this._oData.animation == "static")
		{
			this.chevauchorUpdater.removeMovieClip();
		}
		return true;
	}
	function updateMap(loc2, loc3, loc4)
	{
		var loc5 = this._mcBattlefield.mapHandler.getCellData(loc2);
		if(loc5 == undefined)
		{
			if(loc3)
			{
				this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).addSpriteOnID(this._oData.id);
			}
			else
			{
				this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).removeSpriteOnID(this._oData.id);
			}
			return undefined;
		}
		if(loc4 != true)
		{
			this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).removeSpriteOnID(this._oData.id);
		}
		else
		{
			this._nOldCellNum = this._oData.cellNum;
		}
		if(loc3)
		{
			loc5.addSpriteOnID(this._oData.id);
		}
	}
	function setScale(loc2, loc3)
	{
		this._mcGfx._xscale = loc2;
		this._mcGfx._yscale = loc3 == undefined?loc2:loc3;
	}
	function onLoadInit(loc2)
	{
		this.onEnterFrame = function()
		{
			if(!this._bGfxLoaded)
			{
				this._bGfxLoaded = true;
				if(this._oData.isMounting)
				{
					this._mcChevauchor = this._mcGfx.createEmptyMovieClip("chevauchor",20);
					this._mvlLoader.loadClip(this._oData.mount.chevauchorGfxFile,this._mcChevauchor);
				}
			}
			else
			{
				this._bChevauchorGfxLoaded = true;
			}
			if(this._bGfxLoaded && (!this._oData.isMounting || this._bChevauchorGfxLoaded))
			{
				if(_global.isNaN(Number(this._oData.startAnimationTimer)))
				{
					this.setAnim(this._oData.startAnimation,undefined,true);
				}
				else
				{
					this.setAnimTimer(this._oData.startAnimation,false,false,this._oData.startAnimationTimer);
				}
				delete this.onEnterFrame;
			}
		};
	}
	function _release(loc2)
	{
		this._mcBattlefield.onSpriteRelease(this);
	}
	function _rollOver(loc2)
	{
		this._mcBattlefield.onSpriteRollOver(this);
	}
	function _rollOut(loc2)
	{
		this._mcBattlefield.onSpriteRollOut(this);
	}
}

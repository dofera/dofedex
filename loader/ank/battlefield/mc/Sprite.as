class ank.battlefield.mc.Sprite extends MovieClip
{
	var _nLastAlphaValue = 100;
	var _bGfxLoaded = false;
	var _bChevauchorGfxLoaded = false;
	static var WALK_SPEEDS = [0.07,0.06,0.06,0.06,0.07,0.06,0.06,0.06];
	static var MOUNT_SPEEDS = [0.23,0.2,0.2,0.2,0.23,0.2,0.2,0.2];
	static var RUN_SPEEDS = [0.17,0.15,0.15,0.15,0.17,0.15,0.15,0.15];
	function Sprite(var3, var4, var5)
	{
		super();
		this.initialize(var3,var4,var5);
	}
	function __get__data()
	{
		return this._oData;
	}
	function __set__mcCarried(var2)
	{
		this._mcCarried = var2;
		return this.__get__mcCarried();
	}
	function __set__mcChevauchorPos(var2)
	{
		this._mcChevauchorPos = var2;
		return this.__get__mcChevauchorPos();
	}
	function __set__isHidden(var2)
	{
		this.setHidden(var2);
		return this.__get__isHidden();
	}
	function __get__isHidden()
	{
		return this._bHidden;
	}
	function initialize(var2, var3, var4)
	{
		_global.GAC.addSprite(this,var4);
		this._mcBattlefield = var2;
		this._oSprites = var3;
		this._oData = var4;
		this._mvlLoader = new MovieClipLoader();
		this._mvlLoader.addListener(this);
		this.setPosition(this._oData.cellNum);
		this.draw();
		this._ACTION = var4;
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
	function select(var2)
	{
		var var3 = new Object();
		if(var2)
		{
			var3 = {ra:60,rb:102,ga:60,gb:102,ba:60,bb:102};
		}
		else
		{
			var3 = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
		}
		this.setColorTransform(var3);
	}
	function addExtraClip(var2, var3, var4)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		if(var4 == undefined)
		{
			var4 = false;
		}
		this.removeExtraClip(var4);
		if(var4)
		{
			var var5 = new Object();
			var5.file = var2;
			var5.color = var3;
			this._oData.xtraClipTopParams = var5;
			if(!this._bGfxLoaded)
			{
				return undefined;
			}
		}
		var var6 = !var4?this._mcXtraBack:this._mcXtraTop;
		if(var3 != undefined)
		{
			var var7 = new Color(var6);
			var7.setRGB(var3);
		}
		var6.loadMovie(var2);
	}
	function removeExtraClip(var2)
	{
		switch(var2)
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
	function setColorTransform(var2)
	{
		var var3 = new Color(this);
		var3.setTransform(var2);
	}
	function setNewCellNum(var2)
	{
		this._oData.cellNum = Number(var2);
	}
	function setDirection(var2)
	{
		if(var2 == undefined)
		{
			var2 = this._oData.direction;
		}
		this._oData.direction = var2;
		this.setAnim(this._oData.animation);
	}
	function setPosition(var2)
	{
		this.updateMap(var2,this._oData.isVisible);
		this.setDepth(var2);
		if(var2 == undefined)
		{
			var2 = this._oData.cellNum;
		}
		else
		{
			this.setNewCellNum(var2);
		}
		var var3 = this._mcBattlefield.mapHandler.getCellData(var2);
		var var4 = this._mcBattlefield.mapHandler.getCellHeight(var2);
		var var5 = var4 - Math.floor(var4);
		this._x = var3.x;
		this._y = var3.y - var5 * ank.battlefield.Constants.LEVEL_HEIGHT;
	}
	function setDepth(var2)
	{
		if(var2 == undefined)
		{
			var2 = this._oData.cellNum;
		}
		var var3 = ank.battlefield.utils.SpriteDepthFinder.getFreeDepthOnCell(this._mcBattlefield.mapHandler,this._oSprites,var2,this._mcBattlefield.bGhostView);
		this.swapDepths(var3);
		if(this._oData.hasCarriedChild())
		{
			this._oData.carriedChild.mc.setDepth(var2);
		}
	}
	function setVisible(var2)
	{
		this._oData.isVisible = var2;
		this._visible = var2;
		this.updateMap(this._oData.cellNum,var2);
	}
	function setAlpha(var2)
	{
		this._mcGfx._alpha = var2;
	}
	function setHidden(var2)
	{
		this._bHidden = var2;
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
	function setGhostView(var2)
	{
		this.setDepth();
		if(var2)
		{
			this._nLastAlphaValue = this._mcGfx._alpha;
			this.setAlpha(ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
		}
		else
		{
			this.setAlpha(this._nLastAlphaValue);
		}
	}
	function moveToCell(var2, var3, var4, var5, var6, var7)
	{
		if(var3 != this._oData.cellNum)
		{
			var var8 = this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum);
			var var9 = this._mcBattlefield.mapHandler.getCellData(var3);
			var var10 = var9.x;
			var var11 = var9.y;
			var var12 = 0.01;
			if(var9.groundSlope != 1)
			{
				var11 = var11 - ank.battlefield.Constants.HALF_LEVEL_HEIGHT;
			}
			if(var6.toLowerCase() != "static")
			{
				this._oData.direction = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(var8.x,var8.rootY,var10,var9.rootY,true);
			}
			var var13 = this.api.electron.isWindowFocused;
			switch(var5)
			{
				case "slide":
					var var14 = 0.25;
					if(var13)
					{
						this.setAnim(var6);
					}
					else
					{
						this.setAnim("static");
					}
					break;
				case "walk":
				default:
					var14 = ank.battlefield.mc.Sprite.WALK_SPEEDS[this._oData.direction];
					if(var13)
					{
						this.setAnim(var6 != undefined?var6:"walk",undefined,var7);
					}
					else
					{
						this.setAnim("static");
					}
					break;
				case "run":
					var14 = !!this._oData.isMounting?ank.battlefield.mc.Sprite.MOUNT_SPEEDS[this._oData.direction]:ank.battlefield.mc.Sprite.RUN_SPEEDS[this._oData.direction];
					if(var13)
					{
						this.setAnim(var6 != undefined?var6:"run",undefined,var7);
						break;
					}
					this.setAnim("static");
					break;
			}
			var14 = var14 * this._oData.speedModerator;
			if(var9.groundLevel < var8.groundLevel)
			{
				var14 = var14 + var12;
			}
			else if(var9.groundLevel > var8.groundLevel)
			{
				var14 = var14 - var12;
			}
			else if(var8.groundSlope != var9.groundSlope)
			{
				if(var9.groundSlope == 1)
				{
					var14 = var14 + var12;
				}
				else if(var8.groundSlope == 1)
				{
					var14 = var14 - var12;
				}
			}
			this._nDistance = Math.sqrt(Math.pow(this._x - var10,2) + Math.pow(this._y - var11,2));
			var var15 = Math.atan2(var11 - this._y,var10 - this._x);
			var var16 = Math.cos(var15);
			var var17 = Math.sin(var15);
			this._nLastTimer = getTimer();
			var var18 = Number(var3) > this._oData.cellNum;
			this.updateMap(var3,this._oData.isVisible,true);
			this.setNewCellNum(var3);
			this._oData.isInMove = true;
			this._oData.moveSpeedType = var5;
			this._oData.moveAnimation = var6;
			if(this._oData.hasCarriedChild())
			{
				var var19 = this._oData.carriedChild;
				var var20 = var19.mc;
				var20.setDirection(this._oData.direction);
				var20.updateMap(var3,var19.isVisible);
				var20.setNewCellNum(var3);
			}
			if(var18)
			{
				this.setDepth(var3);
			}
			ank.utils.CyclicTimer.getInstance().addFunction(this,this,this.basicMove,[var14,var16,var17],this,this.basicMoveEnd,[var2,var10,var11,var3,var4,var5 == "slide",!var18]);
		}
		else
		{
			var2.onActionEnd();
		}
	}
	function basicMove(speed, §\x12\x02§, §\x1e\x11\f§)
	{
		var var5 = getTimer() - this._nLastTimer;
		var var6 = speed * (var5 <= 125?var5:125);
		this._x = this._x + var6 * var3;
		this._y = this._y + var6 * var4;
		this._nDistance = this._nDistance - var6;
		this._nLastTimer = getTimer();
		if(this._nDistance <= var6)
		{
			return false;
		}
		return true;
	}
	function basicMoveEnd(var2, var3, var4, var5, var6, var7, var8)
	{
		if(this._nOldCellNum != undefined)
		{
			this._mcBattlefield.mapHandler.getCellData(this._nOldCellNum).removeSpriteOnID(this._oData.id);
			this._nOldCellNum = undefined;
		}
		if(var6)
		{
			this._x = xDest;
			this._y = yDest;
			this._oData.isInMove = false;
			this.setAnim(this._oData.defaultAnimation);
			if(this.api.gfx.spriteHandler.isShowingMonstersTooltip && this.data instanceof dofus.datacenter.MonsterGroup)
			{
				this._rollOver();
			}
		}
		if(var8)
		{
			this.setDepth(var5);
		}
		var2.onActionEnd();
	}
	function saveLastAnimation(var2)
	{
		if(!this._oData.isMounting)
		{
			this._mcGfx.mcAnim.lastAnimation = var2;
		}
		else
		{
			this._mcChevauchor.mcAnim.lastAnimation = var2;
			this._mcGfx.mcAnimFront.lastAnimation = var2;
			this._mcGfx.mcAnimBack.lastAnimation = var2;
		}
	}
	function setAnimTimer(var2, var3, var4, var5)
	{
		this.setAnim(var2,var3,var4);
		if(_global.isNaN(Number(var5)))
		{
			return undefined;
		}
		if(var5 < 1)
		{
			return undefined;
		}
		ank.utils.Timer.setTimer(this,"battlefield",this,this.setAnim,var5,[this._oData.defaultAnimation]);
	}
	function setAnim(var2, var3, var4)
	{
		if(var2 == undefined)
		{
			var2 = this._oData.defaultAnimation;
		}
		var2 = String(var2).toLowerCase();
		if(var3 == undefined)
		{
			var3 = false;
		}
		if(var4 == undefined)
		{
			var4 = false;
		}
		var var5 = this._oData.noFlip;
		this._oData.bAnimLoop = var3;
		var var6 = this._mcGfx;
		var var7 = "";
		if(this._oData.hasCarriedChild())
		{
			var7 = var7 + "_C";
		}
		loop0:
		switch(this._oData.direction)
		{
			case 0:
				var var10 = "S";
				var var8 = var2 + var7 + var10;
				var var9 = "staticR";
				this._xscale = 100;
				break;
			case 1:
				var10 = "R";
				var8 = var2 + var7 + var10;
				var9 = "staticR";
				this._xscale = 100;
				break;
			default:
				switch(null)
				{
					case 2:
						var10 = "F";
						var8 = var2 + var7 + var10;
						var9 = "staticR";
						this._xscale = 100;
						break loop0;
					case 3:
						var10 = "R";
						var8 = var2 + var7 + var10;
						var9 = "staticR";
						if(!var5)
						{
							this._xscale = -100;
						}
						break loop0;
					case 4:
						var10 = "S";
						var8 = var2 + var7 + var10;
						var9 = "staticL";
						if(!var5)
						{
							this._xscale = -100;
						}
						break loop0;
					case 5:
						var10 = "L";
						var8 = var2 + var7 + var10;
						var9 = "staticL";
						this._xscale = 100;
						break loop0;
					case 6:
						var10 = "B";
						var8 = var2 + var7 + var10;
						var9 = "staticL";
						this._xscale = 100;
						break loop0;
					default:
						if(var0 !== 7)
						{
							break loop0;
						}
						var10 = "L";
						var8 = var2 + var7 + var10;
						var9 = "staticL";
						if(!var5)
						{
							this._xscale = -100;
							break loop0;
						}
						break loop0;
				}
		}
		var var11 = this._oData.fullAnimation;
		var var12 = this._oData.animation;
		this._oData.animation = var2;
		this._oData.fullAnimation = var8;
		if(this._oData.xtraClipTopAnimations != undefined)
		{
			if(this._oData.xtraClipTopAnimations[var8])
			{
				this.addExtraClip(this._oData.xtraClipTopParams.file,this._oData.xtraClipTopParams.color,true);
			}
			else if(this._mcXtraTop != undefined)
			{
				this.removeExtraClip(true);
			}
		}
		if(var4 || var8 != var11)
		{
			if(!this._oData.isMounting)
			{
				var6.mcAnim.removeMovieClip();
				if(var6.attachMovie(var8,"mcAnim",10,{lastAnimation:var12}) == undefined)
				{
					var6.attachMovie("static" + var10,"mcAnim",10,{lastAnimation:var12});
					ank.utils.Logger.err("L\'anim (" + var8 + ") n\'existe pas !");
				}
				if(ank.battlefield.Battlefield.useCacheAsBitmapOnStaticAnim)
				{
					(MovieClip)var6.mcAnim.cacheAsBitmap = (MovieClip)var6.mcAnim._totalframes == 1;
				}
			}
			else
			{
				this._mcChevauchor.mcAnim.removeMovieClip();
				var6.mcAnimFront.removeMovieClip();
				var6.mcAnimBack.removeMovieClip();
				if(this._mcChevauchor.attachMovie(var8,"mcAnim",1,{lastAnimation:var12}) == undefined)
				{
					this._mcChevauchor.attachMovie("static" + var10,"mcAnim",1,{lastAnimation:var12});
				}
				if(var6.attachMovie(var8 + "_Front","mcAnimFront",30,{lastAnimation:var12}) == undefined)
				{
					var6.attachMovie("static" + var10 + "_Front","mcAnimFront",30,{lastAnimation:var12});
				}
				if(var6.attachMovie(var8 + "_Back","mcAnimBack",10,{lastAnimation:var12}) == undefined)
				{
					var6.attachMovie("static" + var10 + "_Back","mcAnimBack",10,{lastAnimation:var12});
				}
			}
		}
		if(this._oData.hasCarriedChild())
		{
			ank.utils.CyclicTimer.getInstance().addFunction(this,this,this.updateCarriedPosition);
		}
		if(this._oData.isMounting)
		{
			ank.utils.CyclicTimer.getInstance().addFunction(this,this,this.updateChevauchorPosition);
		}
	}
	function updateCarriedPosition()
	{
		if(this._oData.hasCarriedChild())
		{
			if(this._mcCarried != undefined)
			{
				var var2 = {x:this._mcCarried._x,y:this._mcCarried._y};
				this._mcCarried._parent.localToGlobal(var2);
				this._mcBattlefield.container.globalToLocal(var2);
				this._oData.carriedChild.mc._x = var2.x;
				this._oData.carriedChild.mc._y = var2.y;
			}
		}
		return this._oData.animation != "static" || this._oData.isInMove;
	}
	function updateChevauchorPosition()
	{
		if(this._oData.isMounting)
		{
			if(this._mcChevauchorPos != undefined)
			{
				var var2 = {x:this._mcChevauchorPos._x,y:this._mcChevauchorPos._y};
				this._mcChevauchorPos._parent.localToGlobal(var2);
				this._mcGfx.globalToLocal(var2);
				this._mcChevauchor._x = var2.x;
				this._mcChevauchor._y = var2.y;
				this._mcChevauchor._rotation = this._mcChevauchorPos._rotation;
				this._mcChevauchor._xscale = this._mcChevauchorPos._xscale;
				this._mcChevauchor._yscale = this._mcChevauchorPos._yscale;
			}
		}
		return this._oData.animation != "static" || this._oData.isInMove;
	}
	function updateMap(var2, var3, var4)
	{
		var var5 = this._mcBattlefield.mapHandler.getCellData(var2);
		if(var5 == undefined)
		{
			if(var3)
			{
				this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).addSpriteOnID(this._oData.id);
			}
			else
			{
				this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).removeSpriteOnID(this._oData.id);
			}
			return undefined;
		}
		if(var4 != true)
		{
			this._mcBattlefield.mapHandler.getCellData(this._oData.cellNum).removeSpriteOnID(this._oData.id);
		}
		else
		{
			this._nOldCellNum = this._oData.cellNum;
		}
		if(var3)
		{
			var5.addSpriteOnID(this._oData.id);
		}
	}
	function setScale(var2, var3)
	{
		this._mcGfx._xscale = var2;
		this._mcGfx._yscale = var3 == undefined?var2:var3;
	}
	function onLoadInit(var2)
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
	function _release(var2)
	{
		this._mcBattlefield.onSpriteRelease(this);
	}
	function _rollOver(var2)
	{
		this._mcBattlefield.onSpriteRollOver(this);
	}
	function _rollOut(var2)
	{
		this._mcBattlefield.onSpriteRollOut(this);
	}
}

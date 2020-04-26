class dofus.graphics.gapi.controls.SpriteViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "SpriteViewer";
	var REFRESH_DELAY = 500;
	var SPRITE_ANIMS = ["StaticF","StaticR","StaticL","WalkF","RunF","Anim2R","Anim2L"];
	var _bEnableBlur = true;
	var _nZoom = 200;
	var _bAllowAnimations = true;
	var _bUseSingleLoader = false;
	var _bNoDelay = false;
	var _nSpriteAnimIndex = 0;
	var _bCurrentSprite = false;
	var _nAttempts = 10;
	function SpriteViewer()
	{
		super();
	}
	function __get__spriteData()
	{
		return this._oSpriteData;
	}
	function __set__spriteData(loc2)
	{
		this._oSpriteData = loc2;
		if(this.initialized)
		{
			this.addSpriteListeners();
			this.refreshDisplay();
		}
		return this.__get__spriteData();
	}
	function __get__enableBlur()
	{
		return this._bEnableBlur;
	}
	function __set__enableBlur(loc2)
	{
		this._bEnableBlur = loc2;
		this._mcSpriteA.onEnterFrame = this._mcSpriteB.onEnterFrame = undefined;
		!this._bCurrentSprite?this._mcSpriteB:this._mcSpriteA._alpha = 100;
		!!this._bCurrentSprite?this._mcSpriteB:this._mcSpriteA._alpha = 0;
		return this.__get__enableBlur();
	}
	function __get__zoom()
	{
		return this._nZoom;
	}
	function __set__zoom(loc2)
	{
		this._nZoom = loc2;
		if(this.initialized)
		{
			this.refreshDisplay();
		}
		return this.__get__zoom();
	}
	function __get__allowAnimations()
	{
		return this._bAllowAnimations;
	}
	function __set__allowAnimations(loc2)
	{
		this._bAllowAnimations = loc2;
		this._mcInteraction._visible = loc2;
		return this.__get__allowAnimations();
	}
	function __get__noDelay()
	{
		return this._bNoDelay;
	}
	function __set__noDelay(loc2)
	{
		this._bNoDelay = loc2;
		return this.__get__noDelay();
	}
	function __get__spriteAnims()
	{
		return this.SPRITE_ANIMS;
	}
	function __set__spriteAnims(loc2)
	{
		this.SPRITE_ANIMS = loc2;
		return this.__get__spriteAnims();
	}
	function __get__refreshDelay()
	{
		return this.REFRESH_DELAY;
	}
	function __set__refreshDelay(loc2)
	{
		this.REFRESH_DELAY = loc2;
		return this.__get__refreshDelay();
	}
	function __get__useSingleLoader()
	{
		return this._bUseSingleLoader;
	}
	function __set__useSingleLoader(loc2)
	{
		this._bUseSingleLoader = loc2;
		return this.__get__useSingleLoader();
	}
	function refreshDisplay()
	{
		if(this._nInterval > 0)
		{
			_global.clearInterval(this._nInterval);
		}
		if(this._bNoDelay)
		{
			this.beginDisplay();
		}
		else
		{
			this._nInterval = _global.setInterval(this,"beginDisplay",this.REFRESH_DELAY);
		}
	}
	function getColor(loc2)
	{
		return this._oSpriteData["color" + loc2] != undefined?this._oSpriteData["color" + loc2]:-1;
	}
	function setColor(loc2, loc3)
	{
		this._oSpriteData["color" + loc2] = loc3;
		this.updateSprite();
	}
	function setColors(loc2)
	{
		this._oSpriteData.color1 = loc2.color1;
		this._oSpriteData.color2 = loc2.color2;
		this._oSpriteData.color3 = loc2.color3;
		this.updateSprite();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.SpriteViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.refreshDisplay});
	}
	function addListeners()
	{
		this._ldrSpriteA.addEventListener("initialization",this);
		this._ldrSpriteB.addEventListener("initialization",this);
		this.addSpriteListeners();
		this._mcInteraction.onRelease = function()
		{
			this._parent.click({target:this});
		};
	}
	function addSpriteListeners()
	{
		this._oSpriteData.addEventListener("gfxFileChanged",this);
		this._oSpriteData.addEventListener("accessoriesChanged",this);
	}
	function beginDisplay()
	{
		_global.clearInterval(this._nInterval);
		this._nInterval = 0;
		if(this._oSpriteData == undefined)
		{
			return undefined;
		}
		if(this._bEnableBlur && !this._bUseSingleLoader)
		{
			var loc2 = !this._bCurrentSprite?this._ldrSpriteB:this._ldrSpriteA;
			this._bCurrentSprite = !this._bCurrentSprite;
			var loc3 = !this._bCurrentSprite?this._mcSpriteB:this._mcSpriteA;
		}
		else if(this._bUseSingleLoader)
		{
			loc2 = this._ldrSpriteA;
			this._bCurrentSprite = false;
		}
		else
		{
			loc2 = !this._bCurrentSprite?this._ldrSpriteB:this._ldrSpriteA;
		}
		loc2.forceReload = true;
		loc2.contentPath = this._oSpriteData.gfxFile;
	}
	function attachAnimation(loc2)
	{
		var loc3 = this._mcSpriteA != undefined?!!this._mcSpriteA.attachMovie(this.SPRITE_ANIMS[loc2],"mcAnim",10):true;
		var loc4 = this._mcSpriteB != undefined?!!this._mcSpriteB.attachMovie(this.SPRITE_ANIMS[loc2],"mcAnim",10):true;
		return loc3 && loc4;
	}
	function applyZoom()
	{
		if(this._mcSpriteA != undefined)
		{
			this._mcSpriteA._xscale = this._mcSpriteA._yscale = this._nZoom;
		}
		if(this._mcSpriteB != undefined)
		{
			this._mcSpriteB._xscale = this._mcSpriteB._yscale = this._nZoom;
		}
	}
	function playNextAnim(loc2)
	{
		if(loc2 == undefined || _global.isNaN(loc2))
		{
			loc2 = this._nSpriteAnimIndex;
		}
		this._nSpriteAnimIndex = loc2;
		this._mcSpriteA.mcAnim.removeMovieClip();
		this._mcSpriteB.mcAnim.removeMovieClip();
		var loc3 = this.attachAnimation(this._nSpriteAnimIndex);
		if(!loc3 && --this._nAttempts)
		{
			this.addToQueue({object:this,method:this.playNextAnim,params:[this._nSpriteAnimIndex]});
			return undefined;
		}
		this._nSpriteAnimIndex++;
		if(this._nSpriteAnimIndex > this.SPRITE_ANIMS.length)
		{
			this._nSpriteAnimIndex = 0;
		}
		this._nAttempts = 10;
		if(!loc3)
		{
			this.playNextAnim(this._nSpriteAnimIndex);
			return undefined;
		}
		this.applyZoom();
	}
	function updateSprite()
	{
		this._mcSpriteA.mcAnim.removeMovieClip();
		this._mcSpriteB.mcAnim.removeMovieClip();
		this.attachAnimation(this._nSpriteAnimIndex - 1);
		this.applyZoom();
	}
	function destroy()
	{
		_global.clearInterval(this._nInterval);
		this._nInterval = 0;
	}
	function initialization(loc2)
	{
		switch(loc2.target._name)
		{
			case "_ldrSpriteA":
				this._mcSpriteA = loc0 = loc2.clip;
				this._mcCurrentSprite = loc0;
				this._mcOtherSprite = this._mcSpriteB;
				break;
			case "_ldrSpriteB":
				this._mcSpriteB = loc0 = loc2.clip;
				this._mcCurrentSprite = loc0;
				this._mcOtherSprite = this._mcSpriteA;
		}
		this.api.colors.addSprite(loc2.target,this._oSpriteData);
		this.applyZoom();
		if(this._bEnableBlur)
		{
			this._mcOtherSprite._alpha = 100;
			this._mcCurrentSprite._alpha = 0;
			this._mcCurrentSprite.mcOther = this._mcOtherSprite;
			this._mcCurrentSprite.onEnterFrame = function()
			{
				this._alpha = this._alpha + 10;
				this.mcOther._alpha = this.mcOther._alpha - 30;
				if(this._alpha >= 100 && this.mcOther._alpha <= 0)
				{
					this._alpha = 100;
					this.mcOther._alpha = 0;
					this.onEnterFrame = undefined;
				}
			};
		}
		else
		{
			this._mcCurrentSprite._alpha = 100;
			if(this._mcOtherSprite != undefined)
			{
				this._mcOtherSprite._alpha = 0;
			}
		}
		this.addToQueue({object:this,method:this.playNextAnim,params:[this._nSpriteAnimIndex - 1]});
	}
	function click(loc2)
	{
		this.playNextAnim();
	}
	function gfxFileChanged(loc2)
	{
		this.refreshDisplay();
	}
	function accessoriesChanged(loc2)
	{
		this.refreshDisplay();
	}
}

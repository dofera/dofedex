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
	function __set__spriteData(var2)
	{
		this._oSpriteData = var2;
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
	function __set__enableBlur(var2)
	{
		this._bEnableBlur = var2;
		this._mcSpriteA.onEnterFrame = this._mcSpriteB.onEnterFrame = undefined;
		!this._bCurrentSprite?this._mcSpriteB:this._mcSpriteA._alpha = 100;
		!!this._bCurrentSprite?this._mcSpriteB:this._mcSpriteA._alpha = 0;
		return this.__get__enableBlur();
	}
	function __get__zoom()
	{
		return this._nZoom;
	}
	function __set__zoom(var2)
	{
		this._nZoom = var2;
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
	function __set__allowAnimations(var2)
	{
		this._bAllowAnimations = var2;
		this._mcInteraction._visible = var2;
		return this.__get__allowAnimations();
	}
	function __get__noDelay()
	{
		return this._bNoDelay;
	}
	function __set__noDelay(var2)
	{
		this._bNoDelay = var2;
		return this.__get__noDelay();
	}
	function __get__spriteAnims()
	{
		return this.SPRITE_ANIMS;
	}
	function __set__spriteAnims(var2)
	{
		this.SPRITE_ANIMS = var2;
		return this.__get__spriteAnims();
	}
	function __get__refreshDelay()
	{
		return this.REFRESH_DELAY;
	}
	function __set__refreshDelay(var2)
	{
		this.REFRESH_DELAY = var2;
		return this.__get__refreshDelay();
	}
	function __get__useSingleLoader()
	{
		return this._bUseSingleLoader;
	}
	function __set__useSingleLoader(var2)
	{
		this._bUseSingleLoader = var2;
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
	function getColor(var2)
	{
		return this._oSpriteData["color" + var2] != undefined?this._oSpriteData["color" + var2]:-1;
	}
	function setColor(var2, var3)
	{
		this._oSpriteData["color" + var2] = var3;
		this.updateSprite();
	}
	function setColors(var2)
	{
		this._oSpriteData.color1 = var2.color1;
		this._oSpriteData.color2 = var2.color2;
		this._oSpriteData.color3 = var2.color3;
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
			var var2 = !this._bCurrentSprite?this._ldrSpriteB:this._ldrSpriteA;
			this._bCurrentSprite = !this._bCurrentSprite;
			var var3 = !this._bCurrentSprite?this._mcSpriteB:this._mcSpriteA;
		}
		else if(this._bUseSingleLoader)
		{
			var2 = this._ldrSpriteA;
			this._bCurrentSprite = false;
		}
		else
		{
			var2 = !this._bCurrentSprite?this._ldrSpriteB:this._ldrSpriteA;
		}
		var2.forceReload = true;
		var2.contentPath = this._oSpriteData.gfxFile;
	}
	function attachAnimation(var2)
	{
		var var3 = this._mcSpriteA != undefined?!!this._mcSpriteA.attachMovie(this.SPRITE_ANIMS[var2],"mcAnim",10):true;
		var var4 = this._mcSpriteB != undefined?!!this._mcSpriteB.attachMovie(this.SPRITE_ANIMS[var2],"mcAnim",10):true;
		return var3 && var4;
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
	function playNextAnim(var2)
	{
		if(var2 == undefined || _global.isNaN(var2))
		{
			var2 = this._nSpriteAnimIndex;
		}
		this._nSpriteAnimIndex = var2;
		this._mcSpriteA.mcAnim.removeMovieClip();
		this._mcSpriteB.mcAnim.removeMovieClip();
		var var3 = this.attachAnimation(this._nSpriteAnimIndex);
		if(!var3 && --this._nAttempts)
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
		if(!var3)
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
	function initialization(var2)
	{
		switch(var2.target._name)
		{
			case "_ldrSpriteA":
				this._mcSpriteA = var0 = var2.clip;
				this._mcCurrentSprite = var0;
				this._mcOtherSprite = this._mcSpriteB;
				break;
			case "_ldrSpriteB":
				this._mcSpriteB = var0 = var2.clip;
				this._mcCurrentSprite = var0;
				this._mcOtherSprite = this._mcSpriteA;
		}
		this.api.colors.addSprite(var2.target,this._oSpriteData);
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
	function click(var2)
	{
		this.playNextAnim();
	}
	function gfxFileChanged(var2)
	{
		this.refreshDisplay();
	}
	function accessoriesChanged(var2)
	{
		this.refreshDisplay();
	}
}

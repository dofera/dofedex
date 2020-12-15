class dofus.graphics.gapi.controls.ClassSelector extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ClassSelector";
	static var MAXIMUM_ZONES = 3;
	var _xRay = 330;
	var _yRay = 95;
	var _minScale = -120;
	var _maxScale = 100;
	var _minAlpha = -100;
	var _maxAlpha = 100;
	var _bAnimation = true;
	var _nAnimationSpeed = 10;
	var _aClipList = new Array();
	var _bMoving = false;
	var _nCurrentPosition = 0;
	var _nCurrentIndex = 0;
	var _aClips = new Array();
	var _aLoaders = new Array();
	var _nLoaded = 0;
	var _aRegisteredColors = new Array();
	var _aUpdateOnLoaded = new Array();
	function ClassSelector()
	{
		super();
	}
	function __get__xRay()
	{
		return this._xRay;
	}
	function __set__xRay(var2)
	{
		this._xRay = var2;
		return this.__get__xRay();
	}
	function __get__yRay()
	{
		return this._yRay;
	}
	function __set__yRay(var2)
	{
		this._yRay = var2;
		return this.__get__yRay();
	}
	function __get__minScale()
	{
		return this._minScale;
	}
	function __set__minScale(var2)
	{
		this._minScale = var2;
		return this.__get__minScale();
	}
	function __get__maxScale()
	{
		return this._maxScale;
	}
	function __set__maxScale(var2)
	{
		this._maxScale = var2;
		return this.__get__maxScale();
	}
	function __get__minAlpha()
	{
		return this._minAlpha;
	}
	function __set__minAlpha(var2)
	{
		this._minAlpha = var2;
		return this.__get__minAlpha();
	}
	function __get__maxAlpha()
	{
		return this._maxAlpha;
	}
	function __set__maxAlpha(var2)
	{
		this._maxAlpha = var2;
		return this.__get__maxAlpha();
	}
	function __get__clipsList()
	{
		return this._aClipList;
	}
	function __set__clipsList(var2)
	{
		if(this._aClipList.length == var2.length)
		{
			this._nLoaded = 0;
			var var3 = 0;
			while(var3 < var2.length)
			{
				this._aLoaders[var3] = new MovieClipLoader();
				this._aLoaders[var3].addListener(this);
				this._aLoaders[var3].loadClip(var2[var3 != 0?var2.length - var3:0],this._aClips[var3]);
				this._aClips[var3]._visible = false;
				var3 = var3 + 1;
			}
		}
		this._aClipList = var2;
		return this.__get__clipsList();
	}
	function __get__animation()
	{
		return this._bAnimation;
	}
	function __set__animation(var2)
	{
		this._bAnimation = var2;
		return this.__get__animation();
	}
	function __get__animationSpeed()
	{
		return this._nAnimationSpeed;
	}
	function __set__animationSpeed(var2)
	{
		this._nAnimationSpeed = var2;
		return this.__get__animationSpeed();
	}
	function __get__currentIndex()
	{
		return this._nCurrentIndex != this._aClipList.length?this._nCurrentIndex:0;
	}
	function __set__currentIndex(var2)
	{
		this.swapTo(var2,true);
		return this.__get__currentIndex();
	}
	function __get__clips()
	{
		return this._aClips;
	}
	function initialize(var2)
	{
		this._aClipList = var2;
		this.drawComponent();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ClassSelector.CLASS_NAME);
	}
	function createChildren()
	{
	}
	function drawComponent()
	{
		var var2 = Math.PI / 180 * 90;
		this._nLoaded = 0;
		var var3 = 0;
		while(var3 < this._aClipList.length)
		{
			this._aClips[var3] = this.createEmptyMovieClip("node" + (this._aClipList.length - var3),this._aClipList.length - var3);
			this._aLoaders[var3] = new MovieClipLoader();
			this._aLoaders[var3].addListener(this);
			this._aLoaders[var3].loadClip(this._aClipList[var3 != 0?this._aClipList.length - var3:0],this._aClips[var3]);
			this._aClips[var3]._visible = false;
			var3 = var3 + 1;
		}
	}
	function update()
	{
		var var2 = Math.PI / 180 * 90;
		var var3 = 0;
		while(var3 < this._aClips.length)
		{
			this._aClips[var3]._x = Math.cos(var2 + this._nCurrentPosition) * this._xRay;
			this._aClips[var3]._y = Math.sin(var2 + this._nCurrentPosition) * this._yRay;
			var var4 = (this._aClips[var3]._y + this._yRay) / (this._yRay * 2) * (this._maxScale - this._minScale) + this._minScale;
			this._aClips[var3]._xscale = this._aClips[var3]._yscale = var4 > 0?var4:1;
			this._aClips[var3]._alpha = (this._aClips[var3]._y + this._yRay) / (this._yRay * 2) * (this._maxAlpha - this._minAlpha) + this._minAlpha;
			this._aClips[var3]._visible = this._aClips[var3]._y > 0;
			if(this._aClips[var3]._visible)
			{
				var var5 = Math.floor((var2 + this._nCurrentPosition) * 180 / Math.PI % 360);
				var var6 = Math.floor(360 / this._aClips.length);
				this._aClips[var3].slideIter = - Math.ceil((var5 - 90) / var6);
				var ref = this;
				this._aClips[var3].onRelease = function()
				{
					ref.slide(this.slideIter);
				};
			}
			var2 = var2 + Math.PI / 180 * (360 / this._aClips.length);
			var3 = var3 + 1;
		}
	}
	function garbageCollector()
	{
		var var2 = new Array();
		var var3 = 0;
		while(var3 < this._aRegisteredColors.length)
		{
			if(this._aRegisteredColors[var3].mc != undefined)
			{
				var2.push(this._aRegisteredColors[var3]);
			}
			var3 = var3 + 1;
		}
		this._aRegisteredColors = var2;
	}
	function registerColor(var2, var3)
	{
		this._aRegisteredColors.push({mc:var2,z:var3});
		this.garbageCollector();
	}
	function updateColor(var2, var3)
	{
		if(this._nLoaded < this._aClipList.length)
		{
			this._aUpdateOnLoaded[var2] = var3;
		}
		else
		{
			var var4 = 0;
			while(var4 < this._aRegisteredColors.length)
			{
				if(this._aRegisteredColors[var4].z == var2)
				{
					this.applyColor(this._aRegisteredColors[var4].mc,this._aRegisteredColors[var4].z,var3);
				}
				var4 = var4 + 1;
			}
		}
	}
	function applyColor(var2, var3, var4)
	{
		if(var4 == -1 || var4 == undefined)
		{
			var var5 = new Color(var2);
			var5.setTransform({ra:100,ga:100,ba:100,rb:0,gb:0,bb:0});
			return undefined;
		}
		var var6 = (var4 & 16711680) >> 16;
		var var7 = (var4 & 65280) >> 8;
		var var8 = var4 & 255;
		var var9 = new Color(var2);
		var var10 = new Object();
		var10 = {ra:0,ga:0,ba:0,rb:var6,gb:var7,bb:var8};
		var9.setTransform(var10);
	}
	function swapTo(var2, var3)
	{
		if(var2 > this._aClipList.length)
		{
			return undefined;
		}
		this._bMoving = false;
		delete this.onEnterFrame;
		var var4 = Math.PI / 180 * 360 / this._aClipList.length;
		this._nCurrentIndex = var2;
		this.setPosition(var4 * var2);
		this.onMoveEnd(var3);
	}
	function slide(var2)
	{
		if(this._bMoving)
		{
			return undefined;
		}
		if(this._nCurrentIndex + var2 > this._aClipList.length)
		{
			this._nCurrentIndex = this._nCurrentIndex + var2 - this._aClipList.length;
		}
		else if(this._nCurrentIndex + var2 < 0)
		{
			this._nCurrentIndex = this._nCurrentIndex + var2 + this._aClipList.length;
		}
		else
		{
			this._nCurrentIndex = this._nCurrentIndex + var2;
		}
		if(!this._bAnimation)
		{
			this.swapTo(this._nCurrentIndex);
			return undefined;
		}
		this._bMoving = true;
		var var3 = Math.PI / 180 * 360 / this._aClipList.length;
		var b = this._nCurrentPosition;
		var c = this._nCurrentPosition + var3 * var2 - this._nCurrentPosition;
		var d = Math.abs(var2) * this._nAnimationSpeed;
		this.onEnterFrame = function()
		{
			r.setPosition(r.ease(t++,b,c,d));
			if(t > d)
			{
				delete this.onEnterFrame;
				r.onMoveEnd();
			}
		};
	}
	function setPosition(var2)
	{
		this._nCurrentPosition = var2;
		this.update();
	}
	function ease(var2, var3, var4, var5)
	{
		return var4 * var2 / var5 + var3;
	}
	function onMoveEnd(var2)
	{
		this._bMoving = false;
		if(!var2)
		{
			this.dispatchEvent({type:"change",value:this.currentIndex});
		}
	}
	function onLoadComplete(var2)
	{
		this.onSubclipLoaded(var2);
	}
	function onLoadError(var2)
	{
		this.onSubclipLoaded(var2);
	}
	function onSubclipLoaded(var2)
	{
		this._nLoaded++;
		delete this._aLoaders[Number(var2._name.substr(4))];
		var ref = this;
		var2.registerColor = function(var2, var3)
		{
			ref.registerColor(var2,var3);
		};
		if(this._nLoaded == this._aClipList.length)
		{
			var var3 = 1;
			while(var3 <= dofus.graphics.gapi.controls.ClassSelector.MAXIMUM_ZONES)
			{
				this.addToQueue({object:this,method:this.updateColor,params:[var3,this._aUpdateOnLoaded[var3]]});
				var3 = var3 + 1;
			}
			this.update();
		}
	}
}

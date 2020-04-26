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
	function __set__xRay(loc2)
	{
		this._xRay = loc2;
		return this.__get__xRay();
	}
	function __get__yRay()
	{
		return this._yRay;
	}
	function __set__yRay(loc2)
	{
		this._yRay = loc2;
		return this.__get__yRay();
	}
	function __get__minScale()
	{
		return this._minScale;
	}
	function __set__minScale(loc2)
	{
		this._minScale = loc2;
		return this.__get__minScale();
	}
	function __get__maxScale()
	{
		return this._maxScale;
	}
	function __set__maxScale(loc2)
	{
		this._maxScale = loc2;
		return this.__get__maxScale();
	}
	function __get__minAlpha()
	{
		return this._minAlpha;
	}
	function __set__minAlpha(loc2)
	{
		this._minAlpha = loc2;
		return this.__get__minAlpha();
	}
	function __get__maxAlpha()
	{
		return this._maxAlpha;
	}
	function __set__maxAlpha(loc2)
	{
		this._maxAlpha = loc2;
		return this.__get__maxAlpha();
	}
	function __get__clipsList()
	{
		return this._aClipList;
	}
	function __set__clipsList(loc2)
	{
		if(this._aClipList.length == loc2.length)
		{
			this._nLoaded = 0;
			var loc3 = 0;
			while(loc3 < loc2.length)
			{
				this._aLoaders[loc3] = new MovieClipLoader();
				this._aLoaders[loc3].addListener(this);
				this._aLoaders[loc3].loadClip(loc2[loc3 != 0?loc2.length - loc3:0],this._aClips[loc3]);
				this._aClips[loc3]._visible = false;
				loc3 = loc3 + 1;
			}
		}
		this._aClipList = loc2;
		return this.__get__clipsList();
	}
	function __get__animation()
	{
		return this._bAnimation;
	}
	function __set__animation(loc2)
	{
		this._bAnimation = loc2;
		return this.__get__animation();
	}
	function __get__animationSpeed()
	{
		return this._nAnimationSpeed;
	}
	function __set__animationSpeed(loc2)
	{
		this._nAnimationSpeed = loc2;
		return this.__get__animationSpeed();
	}
	function __get__currentIndex()
	{
		return this._nCurrentIndex != this._aClipList.length?this._nCurrentIndex:0;
	}
	function __set__currentIndex(loc2)
	{
		this.swapTo(loc2,true);
		return this.__get__currentIndex();
	}
	function __get__clips()
	{
		return this._aClips;
	}
	function initialize(loc2)
	{
		this._aClipList = loc2;
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
		var loc2 = Math.PI / 180 * 90;
		this._nLoaded = 0;
		var loc3 = 0;
		while(loc3 < this._aClipList.length)
		{
			this._aClips[loc3] = this.createEmptyMovieClip("node" + (this._aClipList.length - loc3),this._aClipList.length - loc3);
			this._aLoaders[loc3] = new MovieClipLoader();
			this._aLoaders[loc3].addListener(this);
			this._aLoaders[loc3].loadClip(this._aClipList[loc3 != 0?this._aClipList.length - loc3:0],this._aClips[loc3]);
			this._aClips[loc3]._visible = false;
			loc3 = loc3 + 1;
		}
	}
	function update()
	{
		var loc2 = Math.PI / 180 * 90;
		var loc3 = 0;
		while(loc3 < this._aClips.length)
		{
			this._aClips[loc3]._x = Math.cos(loc2 + this._nCurrentPosition) * this._xRay;
			this._aClips[loc3]._y = Math.sin(loc2 + this._nCurrentPosition) * this._yRay;
			var loc4 = (this._aClips[loc3]._y + this._yRay) / (this._yRay * 2) * (this._maxScale - this._minScale) + this._minScale;
			this._aClips[loc3]._xscale = this._aClips[loc3]._yscale = loc4 > 0?loc4:1;
			this._aClips[loc3]._alpha = (this._aClips[loc3]._y + this._yRay) / (this._yRay * 2) * (this._maxAlpha - this._minAlpha) + this._minAlpha;
			this._aClips[loc3]._visible = this._aClips[loc3]._y > 0;
			if(this._aClips[loc3]._visible)
			{
				var loc5 = Math.floor((loc2 + this._nCurrentPosition) * 180 / Math.PI % 360);
				var loc6 = Math.floor(360 / this._aClips.length);
				this._aClips[loc3].slideIter = - Math.ceil((loc5 - 90) / loc6);
				var ref = this;
				this._aClips[loc3].onRelease = function()
				{
					ref.slide(this.slideIter);
				};
			}
			loc2 = loc2 + Math.PI / 180 * (360 / this._aClips.length);
			loc3 = loc3 + 1;
		}
	}
	function garbageCollector()
	{
		var loc2 = new Array();
		var loc3 = 0;
		while(loc3 < this._aRegisteredColors.length)
		{
			if(this._aRegisteredColors[loc3].mc != undefined)
			{
				loc2.push(this._aRegisteredColors[loc3]);
			}
			loc3 = loc3 + 1;
		}
		this._aRegisteredColors = loc2;
	}
	function registerColor(loc2, loc3)
	{
		this._aRegisteredColors.push({mc:loc2,z:loc3});
		this.garbageCollector();
	}
	function updateColor(loc2, loc3)
	{
		if(this._nLoaded < this._aClipList.length)
		{
			this._aUpdateOnLoaded[loc2] = loc3;
		}
		else
		{
			var loc4 = 0;
			while(loc4 < this._aRegisteredColors.length)
			{
				if(this._aRegisteredColors[loc4].z == loc2)
				{
					this.applyColor(this._aRegisteredColors[loc4].mc,this._aRegisteredColors[loc4].z,loc3);
				}
				loc4 = loc4 + 1;
			}
		}
	}
	function applyColor(loc2, loc3, loc4)
	{
		if(loc4 == -1 || loc4 == undefined)
		{
			var loc5 = new Color(loc2);
			loc5.setTransform({ra:100,ga:100,ba:100,rb:0,gb:0,bb:0});
			return undefined;
		}
		var loc6 = (loc4 & 16711680) >> 16;
		var loc7 = (loc4 & 65280) >> 8;
		var loc8 = loc4 & 255;
		var loc9 = new Color(loc2);
		var loc10 = new Object();
		loc10 = {ra:0,ga:0,ba:0,rb:loc6,gb:loc7,bb:loc8};
		loc9.setTransform(loc10);
	}
	function swapTo(loc2, loc3)
	{
		if(loc2 > this._aClipList.length)
		{
			return undefined;
		}
		this._bMoving = false;
		delete this.onEnterFrame;
		var loc4 = Math.PI / 180 * 360 / this._aClipList.length;
		this._nCurrentIndex = loc2;
		this.setPosition(loc4 * loc2);
		this.onMoveEnd(loc3);
	}
	function slide(loc2)
	{
		if(this._bMoving)
		{
			return undefined;
		}
		if(this._nCurrentIndex + loc2 > this._aClipList.length)
		{
			this._nCurrentIndex = this._nCurrentIndex + loc2 - this._aClipList.length;
		}
		else if(this._nCurrentIndex + loc2 < 0)
		{
			this._nCurrentIndex = this._nCurrentIndex + loc2 + this._aClipList.length;
		}
		else
		{
			this._nCurrentIndex = this._nCurrentIndex + loc2;
		}
		if(!this._bAnimation)
		{
			this.swapTo(this._nCurrentIndex);
			return undefined;
		}
		this._bMoving = true;
		var loc3 = Math.PI / 180 * 360 / this._aClipList.length;
		var t = 0;
		var b = this._nCurrentPosition;
		var c = this._nCurrentPosition + loc3 * loc2 - this._nCurrentPosition;
		var d = Math.abs(loc2) * this._nAnimationSpeed;
		var r = this;
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
	function setPosition(loc2)
	{
		this._nCurrentPosition = loc2;
		this.update();
	}
	function ease(loc2, loc3, loc4, loc5)
	{
		return loc4 * loc2 / loc5 + loc3;
	}
	function onMoveEnd(loc2)
	{
		this._bMoving = false;
		if(!loc2)
		{
			this.dispatchEvent({type:"change",value:this.currentIndex});
		}
	}
	function onLoadComplete(loc2)
	{
		this.onSubclipLoaded(loc2);
	}
	function onLoadError(loc2)
	{
		this.onSubclipLoaded(loc2);
	}
	function onSubclipLoaded(loc2)
	{
		this._nLoaded++;
		delete this._aLoaders[Number(loc2._name.substr(4))];
		var ref = this;
		loc2.registerColor = function(loc2, loc3)
		{
			ref.registerColor(loc2,loc3);
		};
		if(this._nLoaded == this._aClipList.length)
		{
			var loc3 = 1;
			while(loc3 <= dofus.graphics.gapi.controls.ClassSelector.MAXIMUM_ZONES)
			{
				this.addToQueue({object:this,method:this.updateColor,params:[loc3,this._aUpdateOnLoaded[loc3]]});
				loc3 = loc3 + 1;
			}
			this.update();
		}
	}
}

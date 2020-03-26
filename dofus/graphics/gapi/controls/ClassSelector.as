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
   function __set__xRay(n)
   {
      this._xRay = n;
      return this.__get__xRay();
   }
   function __get__yRay()
   {
      return this._yRay;
   }
   function __set__yRay(n)
   {
      this._yRay = n;
      return this.__get__yRay();
   }
   function __get__minScale()
   {
      return this._minScale;
   }
   function __set__minScale(n)
   {
      this._minScale = n;
      return this.__get__minScale();
   }
   function __get__maxScale()
   {
      return this._maxScale;
   }
   function __set__maxScale(n)
   {
      this._maxScale = n;
      return this.__get__maxScale();
   }
   function __get__minAlpha()
   {
      return this._minAlpha;
   }
   function __set__minAlpha(n)
   {
      this._minAlpha = n;
      return this.__get__minAlpha();
   }
   function __get__maxAlpha()
   {
      return this._maxAlpha;
   }
   function __set__maxAlpha(n)
   {
      this._maxAlpha = n;
      return this.__get__maxAlpha();
   }
   function __get__clipsList()
   {
      return this._aClipList;
   }
   function __set__clipsList(a)
   {
      if(this._aClipList.length == a.length)
      {
         this._nLoaded = 0;
         var _loc3_ = 0;
         while(_loc3_ < a.length)
         {
            this._aLoaders[_loc3_] = new MovieClipLoader();
            this._aLoaders[_loc3_].addListener(this);
            this._aLoaders[_loc3_].loadClip(a[_loc3_ != 0?a.length - _loc3_:0],this._aClips[_loc3_]);
            this._aClips[_loc3_]._visible = false;
            _loc3_ = _loc3_ + 1;
         }
      }
      this._aClipList = a;
      return this.__get__clipsList();
   }
   function __get__animation()
   {
      return this._bAnimation;
   }
   function __set__animation(b)
   {
      this._bAnimation = b;
      return this.__get__animation();
   }
   function __get__animationSpeed()
   {
      return this._nAnimationSpeed;
   }
   function __set__animationSpeed(n)
   {
      this._nAnimationSpeed = n;
      return this.__get__animationSpeed();
   }
   function __get__currentIndex()
   {
      return this._nCurrentIndex != this._aClipList.length?this._nCurrentIndex:0;
   }
   function __set__currentIndex(n)
   {
      this.swapTo(n,true);
      return this.__get__currentIndex();
   }
   function __get__clips()
   {
      return this._aClips;
   }
   function initialize(newList)
   {
      this._aClipList = newList;
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
      var _loc2_ = Math.PI / 180 * 90;
      this._nLoaded = 0;
      var _loc3_ = 0;
      while(_loc3_ < this._aClipList.length)
      {
         this._aClips[_loc3_] = this.createEmptyMovieClip("node" + (this._aClipList.length - _loc3_),this._aClipList.length - _loc3_);
         this._aLoaders[_loc3_] = new MovieClipLoader();
         this._aLoaders[_loc3_].addListener(this);
         this._aLoaders[_loc3_].loadClip(this._aClipList[_loc3_ != 0?this._aClipList.length - _loc3_:0],this._aClips[_loc3_]);
         this._aClips[_loc3_]._visible = false;
         _loc3_ = _loc3_ + 1;
      }
   }
   function update()
   {
      var _loc2_ = Math.PI / 180 * 90;
      var _loc3_ = 0;
      while(_loc3_ < this._aClips.length)
      {
         this._aClips[_loc3_]._x = Math.cos(_loc2_ + this._nCurrentPosition) * this._xRay;
         this._aClips[_loc3_]._y = Math.sin(_loc2_ + this._nCurrentPosition) * this._yRay;
         var _loc4_ = (this._aClips[_loc3_]._y + this._yRay) / (this._yRay * 2) * (this._maxScale - this._minScale) + this._minScale;
         this._aClips[_loc3_]._xscale = this._aClips[_loc3_]._yscale = _loc4_ > 0?_loc4_:1;
         this._aClips[_loc3_]._alpha = (this._aClips[_loc3_]._y + this._yRay) / (this._yRay * 2) * (this._maxAlpha - this._minAlpha) + this._minAlpha;
         this._aClips[_loc3_]._visible = this._aClips[_loc3_]._y > 0;
         if(this._aClips[_loc3_]._visible)
         {
            var _loc5_ = Math.floor((_loc2_ + this._nCurrentPosition) * 180 / Math.PI % 360);
            var _loc6_ = Math.floor(360 / this._aClips.length);
            this._aClips[_loc3_].slideIter = - Math.ceil((_loc5_ - 90) / _loc6_);
            var ref = this;
            this._aClips[_loc3_].onRelease = function()
            {
               ref.slide(this.slideIter);
            };
         }
         _loc2_ = _loc2_ + Math.PI / 180 * (360 / this._aClips.length);
         _loc3_ = _loc3_ + 1;
      }
   }
   function garbageCollector()
   {
      var _loc2_ = new Array();
      var _loc3_ = 0;
      while(_loc3_ < this._aRegisteredColors.length)
      {
         if(this._aRegisteredColors[_loc3_].mc != undefined)
         {
            _loc2_.push(this._aRegisteredColors[_loc3_]);
         }
         _loc3_ = _loc3_ + 1;
      }
      this._aRegisteredColors = _loc2_;
   }
   function registerColor(mc, c)
   {
      this._aRegisteredColors.push({mc:mc,z:c});
      this.garbageCollector();
   }
   function updateColor(zone, color)
   {
      if(this._nLoaded < this._aClipList.length)
      {
         this._aUpdateOnLoaded[zone] = color;
      }
      else
      {
         var _loc4_ = 0;
         while(_loc4_ < this._aRegisteredColors.length)
         {
            if(this._aRegisteredColors[_loc4_].z == zone)
            {
               this.applyColor(this._aRegisteredColors[_loc4_].mc,this._aRegisteredColors[_loc4_].z,color);
            }
            _loc4_ = _loc4_ + 1;
         }
      }
   }
   function applyColor(mc, zone, color)
   {
      if(color == -1 || color == undefined)
      {
         var _loc5_ = new Color(mc);
         _loc5_.setTransform({ra:100,ga:100,ba:100,rb:0,gb:0,bb:0});
         return undefined;
      }
      var _loc6_ = (color & 16711680) >> 16;
      var _loc7_ = (color & 65280) >> 8;
      var _loc8_ = color & 255;
      var _loc9_ = new Color(mc);
      var _loc10_ = new Object();
      _loc10_ = {ra:0,ga:0,ba:0,rb:_loc6_,gb:_loc7_,bb:_loc8_};
      _loc9_.setTransform(_loc10_);
   }
   function swapTo(nIndex, bNoEvent)
   {
      if(nIndex > this._aClipList.length)
      {
         return undefined;
      }
      this._bMoving = false;
      delete this.onEnterFrame;
      var _loc4_ = Math.PI / 180 * 360 / this._aClipList.length;
      this._nCurrentIndex = nIndex;
      this.setPosition(_loc4_ * nIndex);
      this.onMoveEnd(bNoEvent);
   }
   function slide(nIndex)
   {
      if(this._bMoving)
      {
         return undefined;
      }
      if(this._nCurrentIndex + nIndex > this._aClipList.length)
      {
         this._nCurrentIndex = this._nCurrentIndex + nIndex - this._aClipList.length;
      }
      else if(this._nCurrentIndex + nIndex < 0)
      {
         this._nCurrentIndex = this._nCurrentIndex + nIndex + this._aClipList.length;
      }
      else
      {
         this._nCurrentIndex = this._nCurrentIndex + nIndex;
      }
      if(!this._bAnimation)
      {
         this.swapTo(this._nCurrentIndex);
         return undefined;
      }
      this._bMoving = true;
      var _loc3_ = Math.PI / 180 * 360 / this._aClipList.length;
      var t = 0;
      var b = this._nCurrentPosition;
      var c = this._nCurrentPosition + _loc3_ * nIndex - this._nCurrentPosition;
      var d = Math.abs(nIndex) * this._nAnimationSpeed;
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
   function setPosition(n)
   {
      this._nCurrentPosition = n;
      this.update();
   }
   function ease(t, b, c, d)
   {
      return c * t / d + b;
   }
   function onMoveEnd(bNoEvent)
   {
      this._bMoving = false;
      if(!bNoEvent)
      {
         this.dispatchEvent({type:"change",value:this.currentIndex});
      }
   }
   function onLoadComplete(mc)
   {
      this.onSubclipLoaded(mc);
   }
   function onLoadError(mc)
   {
      this.onSubclipLoaded(mc);
   }
   function onSubclipLoaded(mc)
   {
      this._nLoaded = this._nLoaded + 1;
      delete this._aLoaders[Number(mc._name.substr(4))];
      var ref = this;
      mc.registerColor = function(tmp, n)
      {
         ref.registerColor(tmp,n);
      };
      if(this._nLoaded == this._aClipList.length)
      {
         var _loc3_ = 1;
         while(_loc3_ <= dofus.graphics.gapi.controls.ClassSelector.MAXIMUM_ZONES)
         {
            this.addToQueue({object:this,method:this.updateColor,params:[_loc3_,this._aUpdateOnLoaded[_loc3_]]});
            _loc3_ = _loc3_ + 1;
         }
         this.update();
      }
   }
}

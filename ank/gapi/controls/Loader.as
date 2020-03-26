class ank.gapi.controls.Loader extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "Loader";
   var _bEnabled = false;
   var _bAutoLoad = true;
   var _bScaleContent = false;
   var _bCenterContent = false;
   var _sURL = "";
   var _bForceReload = false;
   function Loader()
   {
      super();
   }
   function __set__enabled(bEnabled)
   {
      super.__set__enabled(bEnabled);
      return this.__get__enabled();
   }
   function __set__scaleContent(bScaleContent)
   {
      this._bScaleContent = bScaleContent;
      return this.__get__scaleContent();
   }
   function __get__scaleContent()
   {
      return this._bScaleContent;
   }
   function __set__autoLoad(bAutoLoad)
   {
      this._bAutoLoad = bAutoLoad;
      return this.__get__autoLoad();
   }
   function __get__autoLoad()
   {
      return this._bAutoLoad;
   }
   function __set__centerContent(bCenterContent)
   {
      this._bCenterContent = bCenterContent;
      return this.__get__centerContent();
   }
   function __get__centerContent()
   {
      return this._bCenterContent;
   }
   function __set__contentParams(oParams)
   {
      this._oParams = oParams;
      if(this._oParams.frame)
      {
         this.frame = this._oParams.frame;
      }
      return this.__get__contentParams();
   }
   function __get__contentParams()
   {
      return this._oParams;
   }
   function __set__contentPath(sURL)
   {
      this._sURL = sURL;
      if(this._bAutoLoad)
      {
         this.load();
      }
      return this.__get__contentPath();
   }
   function __get__contentPath()
   {
      return this._sURL;
   }
   function __set__forceReload(bForce)
   {
      this._bForceReload = bForce;
      return this.__get__forceReload();
   }
   function __get__forceReload()
   {
      return this._bForceReload;
   }
   function __get__bytesLoaded()
   {
      return this._nBytesLoaded;
   }
   function __get__bytesTotal()
   {
      return this._nBytesTotal;
   }
   function __get__percentLoaded()
   {
      var _loc2_ = Math.round(this.bytesLoaded / this.bytesTotal * 100);
      _loc2_ = !_global.isNaN(_loc2_)?_loc2_:0;
      return _loc2_;
   }
   function __get__content()
   {
      return this.holder_mc.content_mc;
   }
   function __get__holder()
   {
      return this.holder_mc;
   }
   function __get__loaded()
   {
      return this._bLoaded;
   }
   function __set__frame(sFrame)
   {
      this._sFrame = sFrame;
      this.content.gotoAndStop(sFrame);
      this.size();
      return this.__get__frame();
   }
   function forceNextLoad()
   {
      delete this._sPrevURL;
   }
   function init()
   {
      super.init(false,ank.gapi.controls.Loader.CLASS_NAME);
      if(this._bScaleContent == undefined)
      {
         this._bScaleContent = true;
      }
      this._bInited = true;
      this._nBytesLoaded = 0;
      this._nBytesTotal = 0;
      this._bLoaded = false;
      this._mvlLoader = new MovieClipLoader();
      this._mvlLoader.addListener(this);
   }
   function createChildren()
   {
      this.createEmptyMovieClip("holder_mc",10);
      if(this._bAutoLoad && this._sURL != undefined)
      {
         this.load();
      }
   }
   function size()
   {
      super.size();
      if(this.holder_mc.content_mc != undefined)
      {
         if(this._sFrame != undefined && this._sFrame != "")
         {
            this.frame = this._sFrame;
         }
         if(this._bScaleContent)
         {
            var _loc3_ = this.holder_mc.content_mc._width;
            var _loc4_ = this.holder_mc.content_mc._height;
            var _loc5_ = _loc3_ / _loc4_;
            var _loc6_ = this.__width / this.__height;
            if(_loc5_ == _loc6_)
            {
               this.holder_mc._width = this.__width;
               this.holder_mc._height = this.__height;
            }
            else if(_loc5_ > _loc6_)
            {
               this.holder_mc._width = this.__width;
               this.holder_mc._height = this.__width / _loc5_;
            }
            else
            {
               this.holder_mc._width = this.__height * _loc5_;
               this.holder_mc._height = this.__height;
            }
            var _loc7_ = this.holder_mc.content_mc.getBounds();
            this.holder_mc.content_mc._x = - _loc7_.xMin;
            this.holder_mc.content_mc._y = - _loc7_.yMin;
            this.holder_mc._x = (this.__width - this.holder_mc._width) / 2;
            this.holder_mc._y = (this.__height - this.holder_mc._height) / 2;
         }
         if(this._bCenterContent)
         {
            this.holder_mc._x = this.__width / 2;
            this.holder_mc._y = this.__height / 2;
         }
      }
   }
   function setEnabled()
   {
      if(this._bEnabled)
      {
         this.onRelease = function()
         {
            this.dispatchEvent({type:"click"});
         };
      }
      else
      {
         delete this.onRelease;
      }
   }
   function load()
   {
      if(this._sPrevURL == undefined && this._sURL == "")
      {
         return undefined;
      }
      if(!this._bForceReload && (this._sPrevURL == this._sURL || this._sURL == undefined || this.holder_mc == undefined))
      {
         return undefined;
      }
      this._visible = false;
      this._bLoaded = false;
      this._sPrevURL = this._sURL;
      if(this._sURL == "")
      {
         this.holder_mc.content_mc.removeMovieClip();
         return undefined;
      }
      if(this._sURL.toLowerCase().indexOf(".swf") != -1)
      {
         if(this.holder_mc.content_mc == undefined)
         {
            this.holder_mc.createEmptyMovieClip("content_mc",1);
         }
         this._mvlLoader.loadClip(this._sURL,this.holder_mc.content_mc);
      }
      else
      {
         this.holder_mc.attachMovie(this._sURL,"content_mc",1,this._oParams);
         this.onLoadComplete(this.holder_mc.content_mc);
         this.onLoadInit(this.holder_mc.content_mc);
      }
   }
   function onLoadError(mc)
   {
      this.dispatchEvent({type:"error",target:this,clip:mc});
   }
   function onLoadProgress(mc, bl, bt)
   {
      this._nBytesLoaded = bl;
      this._nBytesTotal = bt;
      this.dispatchEvent({type:"progress",target:this,clip:mc});
   }
   function onLoadComplete(mc)
   {
      this._bLoaded = true;
      this.dispatchEvent({type:"complete",clip:mc});
   }
   function onLoadInit(mc)
   {
      this.size();
      this._visible = true;
      this.dispatchEvent({type:"initialization",clip:mc});
   }
}

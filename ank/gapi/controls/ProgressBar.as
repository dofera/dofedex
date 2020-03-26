class ank.gapi.controls.ProgressBar extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "ProgressBar";
   var _sRenderer = "ProgressBarDefaultRenderer";
   var _nValue = 0;
   var _nMinimum = 0;
   var _nMaximum = 100;
   function ProgressBar()
   {
      super();
   }
   function __set__renderer(sRenderer)
   {
      if(this._bInitialized)
      {
         return undefined;
      }
      this._sRenderer = sRenderer;
      return this.__get__renderer();
   }
   function __set__minimum(nMinimum)
   {
      this._nMinimum = Number(nMinimum);
      return this.__get__minimum();
   }
   function __get__minimum()
   {
      return this._nMinimum;
   }
   function __set__maximum(nMaximum)
   {
      this._nMaximum = Number(nMaximum);
      return this.__get__maximum();
   }
   function __get__maximum()
   {
      return this._nMaximum;
   }
   function __set__value(nValue)
   {
      if(nValue > this._nMaximum)
      {
         nValue = this._nMaximum;
      }
      if(nValue < this._nMinimum)
      {
         nValue = this._nMinimum;
      }
      this._nValue = Number(nValue);
      this.addToQueue({object:this,method:this.applyValue});
      return this.__get__value();
   }
   function __get__value()
   {
      return this._nValue;
   }
   function init()
   {
      super.init(false,ank.gapi.controls.ProgressBar.CLASS_NAME);
   }
   function createChildren()
   {
      this.attachMovie(this._sRenderer,"_mcRenderer",10);
      this.hideUp(true);
   }
   function size()
   {
      super.size();
   }
   function arrange()
   {
      this._mcRenderer._mcBgLeft._height = this._mcRenderer._mcBgMiddle._height = this._mcRenderer._mcBgRight._height = this.__height;
      var _loc2_ = this._mcRenderer._mcBgLeft._yscale;
      this._mcRenderer._mcBgLeft._xscale = this._mcRenderer._mcUpLeft._xscale = this._mcRenderer._mcUpLeft._yscale = _loc2_;
      this._mcRenderer._mcBgRight._xscale = this._mcRenderer._mcUpRight._xscale = this._mcRenderer._mcUpRight._yscale = _loc2_;
      this._mcRenderer._mcUpMiddle._yscale = _loc2_;
      var _loc3_ = this._mcRenderer._mcBgLeft._width;
      var _loc4_ = this._mcRenderer._mcBgLeft._width;
      this._mcRenderer._mcBgLeft._x = this._mcRenderer._mcBgLeft._y = this._mcRenderer._mcBgMiddle._y = this._mcRenderer._mcBgRight._y = 0;
      this._mcRenderer._mcUpLeft._x = this._mcRenderer._mcUpLeft._y = this._mcRenderer._mcUpMiddle._y = this._mcRenderer._mcUpRight._y = 0;
      this._mcRenderer._mcBgMiddle._x = this._mcRenderer._mcUpMiddle._x = _loc3_;
      this._mcRenderer._mcBgRight._x = this.__width - _loc4_;
      this._mcRenderer._mcBgMiddle._width = this.__width - _loc3_ - _loc4_;
   }
   function draw()
   {
      var _loc3_ = this.getStyle();
      var _loc2_ = this._mcRenderer._mcBgLeft;
      for(var k in _loc2_)
      {
         var _loc4_ = k.split("_")[0];
         this.setMovieClipColor(_loc2_[k],_loc3_[_loc4_ + "color"]);
      }
      _loc2_ = this._mcRenderer._mcBgMiddle;
      for(var k in _loc2_)
      {
         var _loc5_ = k.split("_")[0];
         this.setMovieClipColor(_loc2_[k],_loc3_[_loc5_ + "color"]);
      }
      _loc2_ = this._mcRenderer._mcBgRight;
      for(var k in _loc2_)
      {
         var _loc6_ = k.split("_")[0];
         this.setMovieClipColor(_loc2_[k],_loc3_[_loc6_ + "color"]);
      }
      _loc2_ = this._mcRenderer._mcUpLeft;
      for(var k in _loc2_)
      {
         var _loc7_ = k.split("_")[0];
         this.setMovieClipColor(_loc2_[k],_loc3_[_loc7_ + "color"]);
      }
      _loc2_ = this._mcRenderer._mcUpMiddle;
      for(var k in _loc2_)
      {
         var _loc8_ = k.split("_")[0];
         this.setMovieClipColor(_loc2_[k],_loc3_[_loc8_ + "color"]);
      }
      _loc2_ = this._mcRenderer._mcUpRight;
      for(var k in _loc2_)
      {
         var _loc9_ = k.split("_")[0];
         this.setMovieClipColor(_loc2_[k],_loc3_[_loc9_ + "color"]);
      }
   }
   function hideUp(bHide)
   {
      this._mcRenderer._mcUpLeft._visible = !bHide;
      this._mcRenderer._mcUpMiddle._visible = !bHide;
      this._mcRenderer._mcUpRight._visible = !bHide;
   }
   function applyValue()
   {
      var _loc2_ = this._mcRenderer._mcBgLeft._width;
      var _loc3_ = this._mcRenderer._mcBgLeft._width;
      var _loc4_ = this._nValue - this._nMinimum;
      if(_loc4_ == 0)
      {
         this.hideUp(true);
      }
      else
      {
         this.hideUp(false);
         var _loc5_ = this._nMaximum - this._nMinimum;
         var _loc6_ = this.__width - _loc2_ - _loc3_;
         var _loc7_ = Math.floor(_loc4_ / _loc5_ * _loc6_);
         this._mcRenderer._mcUpMiddle._width = _loc7_;
         this._mcRenderer._mcUpRight._x = _loc7_ + _loc2_;
      }
   }
   function setEnabled()
   {
      if(this._bEnabled)
      {
         this.onRollOver = function()
         {
            this.dispatchEvent({type:"over"});
         };
         this.onRollOut = function()
         {
            this.dispatchEvent({type:"out"});
         };
      }
      else
      {
         this.onRollOver = undefined;
         this.onRollOut = undefined;
      }
   }
}

class ank.gapi.controls.VolumeSlider extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "VolumeSlider";
   var _nMin = 0;
   var _nMax = 100;
   var _nValue = 0;
   var _nMarkerCount = 5;
   var _nMarkerWidthRatio = 0.7;
   var _sMarkerSkin = "VolumeSliderMarkerDefault";
   function VolumeSlider()
   {
      super();
   }
   function __set__min(nMin)
   {
      this._nMin = Number(nMin);
      return this.__get__min();
   }
   function __get__min()
   {
      return this._nMin;
   }
   function __set__max(nMax)
   {
      this._nMax = Number(nMax);
      return this.__get__max();
   }
   function __get__max()
   {
      return this._nMax;
   }
   function __set__value(nValue)
   {
      nValue = Number(nValue);
      if(_global.isNaN(nValue))
      {
         return undefined;
      }
      if(nValue > this.max)
      {
         nValue = this.max;
      }
      if(nValue < this.min)
      {
         nValue = this.min;
      }
      this._nValue = nValue;
      if(this._bInitialized)
      {
         var _loc3_ = Math.floor((this._nMarkerCount - 1) * (nValue - this._nMin) / (this._nMax - this._nMin));
         this.setValueByIndex(_loc3_);
      }
      return this.__get__value();
   }
   function __get__value()
   {
      return this._nValue;
   }
   function __set__markerCount(nMarkerCount)
   {
      if(Number(nMarkerCount) > 0)
      {
         this._nMarkerCount = Number(nMarkerCount);
      }
      else
      {
         ank.utils.Logger.err("[markerCount] ne peut être < à 0");
      }
      return this.__get__markerCount();
   }
   function __get__markerWidth()
   {
      return this._nMarkerCount;
   }
   function __set__markerWidthRatio(nMarkerWidthRatio)
   {
      if(Number(nMarkerWidthRatio) >= 0 && Number(nMarkerWidthRatio) <= 1)
      {
         this._nMarkerWidthRatio = Number(nMarkerWidthRatio);
      }
      else
      {
         ank.utils.Logger.err("[markerCount] ne peut être < à 0 et > 1");
      }
      return this.__get__markerWidthRatio();
   }
   function __get__markerWidthRatio()
   {
      return this._nMarkerWidthRatio;
   }
   function __set__markerSkin(sMarkerSkin)
   {
      this._sMarkerSkin = sMarkerSkin;
      return this.__get__markerSkin();
   }
   function __get__markerSkin()
   {
      return this._sMarkerSkin;
   }
   function redraw()
   {
      this.createMarkers();
      this.arrange();
   }
   function init()
   {
      super.init(false,ank.gapi.controls.VolumeSlider.CLASS_NAME);
   }
   function createChildren()
   {
      this.createMarkers();
   }
   function arrange()
   {
      var _loc2_ = this.__height;
      var _loc3_ = this.__height / 2;
      var _loc4_ = this.__width / this._nMarkerCount;
      var _loc5_ = (this.__width + _loc4_ * (1 - this._nMarkerWidthRatio)) / this._nMarkerCount;
      var _loc6_ = 0;
      while(_loc6_ < this._nMarkerCount)
      {
         var _loc7_ = this._mcMarkers["mcMarker" + _loc6_];
         var _loc8_ = this._mcOvers["mcOver" + _loc6_];
         var _loc9_ = _loc8_.index;
         var _loc10_ = _loc9_ / this._nMarkerCount;
         _loc7_._width = _loc5_ * this._nMarkerWidthRatio;
         _loc8_._width = _loc5_;
         _loc7_._height = _loc3_ + _loc10_ * (_loc2_ - _loc3_);
         _loc8_._height = this.__height;
         _loc7_._x = _loc9_ * _loc5_;
         _loc7_._y = this.__height;
         _loc8_._x = _loc9_ * _loc5_;
         _loc8_._y = 0;
         _loc6_ = _loc6_ + 1;
      }
   }
   function draw()
   {
      this.addToQueue({object:this,method:function()
      {
         this.value = this._nValue;
      }});
   }
   function createMarkers()
   {
      this._mcMarkers.removeMovieClip();
      this.createEmptyMovieClip("_mcOvers",10);
      this.createEmptyMovieClip("_mcMarkers",20);
      var _loc2_ = 0;
      while(_loc2_ < this._nMarkerCount)
      {
         var _loc3_ = this._mcMarkers.attachMovie(this._sMarkerSkin,"mcMarker" + _loc2_,_loc2_);
         var _loc4_ = this._mcOvers.createEmptyMovieClip("mcOver" + _loc2_,_loc2_);
         this.drawRoundRect(_loc4_,0,0,1,1,0,16711935,0);
         _loc4_.index = _loc2_;
         this.setMovieClipColor(_loc3_,this.getStyle().offcolor);
         _loc4_.trackAsMenu = true;
         _loc4_.onDragOver = function()
         {
            this._parent._parent.dragOver({target:this});
         };
         _loc4_.onPress = function()
         {
            this._parent._parent.press({target:this});
         };
         _loc2_ = _loc2_ + 1;
      }
   }
   function setValueByIndex(nIndex)
   {
      if(nIndex > this._nMarkerCount - 1)
      {
         return undefined;
      }
      if(nIndex < 0)
      {
         return undefined;
      }
      if(nIndex == undefined)
      {
         return undefined;
      }
      var _loc3_ = this.getStyle().oncolor;
      var _loc4_ = this.getStyle().offcolor;
      var _loc5_ = 0;
      while(_loc5_ <= nIndex)
      {
         this.setMovieClipColor(this._mcMarkers["mcMarker" + _loc5_],_loc3_);
         _loc5_ = _loc5_ + 1;
      }
      var _loc6_ = nIndex + 1;
      while(_loc6_ < this._nMarkerCount)
      {
         this.setMovieClipColor(this._mcMarkers["mcMarker" + _loc6_],_loc4_);
         _loc6_ = _loc6_ + 1;
      }
   }
   function getValueByIndex(nIndex)
   {
      return nIndex * (this._nMax - this._nMin) / (this._nMarkerCount - 1) + this._nMin;
   }
   function dragOver(oEvent)
   {
      this.value = this.getValueByIndex(oEvent.target.index);
      this.dispatchEvent({type:"change"});
   }
   function press(oEvent)
   {
      this.value = this.getValueByIndex(oEvent.target.index);
      this.dispatchEvent({type:"change"});
   }
}

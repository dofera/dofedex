class ank.gapi.controls.ColorPicker extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "ColorPicker";
   static var MATRIX_V = {matrixType:"box",x:0,y:0,w:1,h:1,r:0};
   static var MATRIX_H = {matrixType:"box",x:0,y:0,w:1,h:1,r:Math.PI / 2};
   static var COLORS_V = [16711680,16776960,65280,65535,255,16711935,16711680];
   static var ALPHAS_V = [100,100,100,100,100,100,100];
   static var RATIOS_V = [0,42.5,85,127.5,170,212.5,255];
   static var COLORS_H = [8421504,8421504];
   static var ALPHAS_H = [0,100];
   static var RATIOS_H = [0,255];
   static var COLORS_SLIDER = [16711680,16711680,16711680];
   static var ALPHAS_SLIDER = [0,100,0];
   static var RATIOS_SLIDER = [0,127.5,255];
   var _nSliderOutWidth = 30;
   var _nSliderInWidth = 10;
   var _bMoveColorsCross = false;
   var _bMoveSliderCross = false;
   function ColorPicker()
   {
      super();
   }
   function __set__sliderOutWidth(nSliderOutWidth)
   {
      this._nSliderOutWidth = Number(nSliderOutWidth);
      return this.__get__sliderOutWidth();
   }
   function __get__sliderOutWidth()
   {
      return this._nSliderOutWidth;
   }
   function __set__sliderInWidth(nSliderInWidth)
   {
      this._nSliderInWidth = Number(nSliderInWidth);
      return this.__get__sliderInWidth();
   }
   function __get__sliderInWidth()
   {
      return this._nSliderInWidth;
   }
   function init()
   {
      super.init(false,ank.gapi.controls.ColorPicker.CLASS_NAME);
   }
   function createChildren()
   {
      this.createEmptyMovieClip("_mcColorsV",10);
      this.createEmptyMovieClip("_mcColorsH",20);
      this.createEmptyMovieClip("_mcSlider",30);
      this.createEmptyMovieClip("_mcSliderUp",40);
      this._cSliderUpColor = new Color(this._mcSliderUp);
      this.attachMovie("ColorPickerColorsCross","_mcColorsCross",50);
      this.attachMovie("ColorPickerSliderCross","_mcSliderCross",60);
      this._mcColorsV.onPress = function()
      {
         this._parent.onStartColorsCrossMove();
      };
      this._mcColorsV.onRelease = this._mcColorsV.onReleaseOutside = function()
      {
         this._parent.onStopColorsCrossMove();
      };
      this._mcSlider.onPress = function()
      {
         this._parent.onStartSliderCrossMove();
      };
      this._mcSlider.onRelease = this._mcSlider.onReleaseOutside = function()
      {
         this._parent.onStopSliderCrossMove();
      };
   }
   function arrange()
   {
      this._mcColorsV._width = this._mcColorsH._width = this.__width - this._nSliderOutWidth;
      this._mcColorsV._height = this._mcColorsH._height = this.__height;
      this._mcSlider._x = this._mcSliderUp._x = this.__width - (this._nSliderOutWidth + this._nSliderInWidth) / 2;
      this._mcSlider._width = this._mcSliderUp._width = this._nSliderInWidth;
      this._mcSlider._height = this._mcSliderUp._height = this.__height;
      this._nColorsWidth = this.__width - 30;
      this._nSliderCenterX = this.__width - this._nSliderOutWidth / 2;
      this.placeSliderCross(this._nSliderCenterX,this.__height / 2);
   }
   function draw()
   {
      this.drawRoundRect(this._mcColorsV,0,0,1,1,0,ank.gapi.controls.ColorPicker.COLORS_V,ank.gapi.controls.ColorPicker.ALPHAS_V,ank.gapi.controls.ColorPicker.MATRIX_V,"linear",ank.gapi.controls.ColorPicker.RATIOS_V);
      this.drawRoundRect(this._mcColorsH,0,0,1,1,0,ank.gapi.controls.ColorPicker.COLORS_H,ank.gapi.controls.ColorPicker.ALPHAS_H,ank.gapi.controls.ColorPicker.MATRIX_H,"linear",ank.gapi.controls.ColorPicker.RATIOS_H);
      this.drawRoundRect(this._mcSlider,0,0,1,0.5,0,16777215);
      this.drawRoundRect(this._mcSlider,0,0.5,1,0.5,0,0);
      this.drawRoundRect(this._mcSliderUp,0,0,1,1,0,ank.gapi.controls.ColorPicker.COLORS_SLIDER,ank.gapi.controls.ColorPicker.ALPHAS_SLIDER,ank.gapi.controls.ColorPicker.MATRIX_H,"linear",ank.gapi.controls.ColorPicker.RATIOS_SLIDER);
   }
   function getGradientColor()
   {
      var _loc2_ = this._mcColorsCross._x / Math.floor(this._nColorsWidth);
      var _loc3_ = Math.floor(_loc2_ * (ank.gapi.controls.ColorPicker.RATIOS_V.length - 1));
      _loc2_ = _loc2_ * 255;
      var _loc4_ = 255 * (1 - (ank.gapi.controls.ColorPicker.RATIOS_V[_loc3_ + 1] - _loc2_) / (ank.gapi.controls.ColorPicker.RATIOS_V[_loc3_ + 1] - ank.gapi.controls.ColorPicker.RATIOS_V[_loc3_]));
      var _loc5_ = ank.gapi.controls.ColorPicker.COLORS_V[_loc3_];
      var _loc6_ = ank.gapi.controls.ColorPicker.COLORS_V[_loc3_ + 1];
      var _loc7_ = _loc5_ & 16711680;
      var _loc8_ = _loc5_ & 65280;
      var _loc9_ = _loc5_ & 255;
      var _loc10_ = _loc6_ & 16711680;
      var _loc11_ = _loc6_ & 65280;
      var _loc12_ = _loc6_ & 255;
      if(_loc7_ != _loc10_)
      {
         var _loc13_ = Math.round(_loc7_ <= _loc10_?_loc4_:255 - _loc4_);
      }
      else
      {
         _loc13_ = _loc7_ >> 16;
      }
      if(_loc8_ != _loc11_)
      {
         var _loc14_ = Math.round(_loc8_ <= _loc11_?_loc4_:255 - _loc4_);
      }
      else
      {
         _loc14_ = _loc8_ >> 8;
      }
      if(_loc9_ != _loc12_)
      {
         var _loc15_ = Math.round(_loc9_ <= _loc12_?_loc4_:255 - _loc4_);
      }
      else
      {
         _loc15_ = _loc9_;
      }
      var _loc16_ = this._mcColorsCross._y / this.__height * 255;
      _loc13_ = _loc13_ + (127 - _loc13_) * _loc16_ / 255;
      _loc14_ = _loc14_ + (127 - _loc14_) * _loc16_ / 255;
      _loc15_ = _loc15_ + (127 - _loc15_) * _loc16_ / 255;
      return (_loc13_ << 16) + (_loc14_ << 8) + _loc15_;
   }
   function placeColorsCross(nX, nY)
   {
      this._mcColorsCross._x = nX;
      this._mcColorsCross._y = nY;
   }
   function placeSliderCross(nX, nY)
   {
      this._mcSliderCross._x = nX;
      this._mcSliderCross._y = nY;
   }
   function setColor(nColor)
   {
      var _loc3_ = ((nColor & 16711680) >> 16) / 255;
      var _loc4_ = ((nColor & 65280) >> 8) / 255;
      var _loc5_ = (nColor & 255) / 255;
      var _loc6_ = Math.min(Math.min(_loc3_,_loc4_),_loc5_);
      var _loc7_ = Math.max(Math.max(_loc3_,_loc4_),_loc5_);
      var _loc8_ = _loc7_ - _loc6_;
      var _loc9_ = Math.acos((_loc3_ - _loc4_ + (_loc3_ - _loc5_)) / 2 / Math.sqrt(Math.pow(_loc3_ - _loc4_,2) + (_loc3_ - _loc5_) * (_loc4_ - _loc5_)));
      var _loc10_ = (_loc7_ + _loc6_) / 2;
      var _loc11_ = _loc10_ >= 0.5?_loc8_ / (2 - _loc7_ - _loc6_):_loc8_ / (_loc7_ + _loc6_);
      if(_loc5_ > _loc4_)
      {
         _loc9_ = 2 * Math.PI - _loc9_;
      }
      var _loc12_ = Math.floor(_loc9_ / (2 * Math.PI) * this._nColorsWidth);
      var _loc13_ = Math.floor((1 - Math.abs(_loc11_)) * this.__height);
      var _loc14_ = Math.floor((1 - _loc10_) * this.__height);
      if(_global.isNaN(_loc12_))
      {
         _loc12_ = 0;
      }
      this.placeColorsCross(_loc12_,_loc13_);
      this.placeSliderCross(this._nSliderCenterX,_loc14_);
      var _loc15_ = this.getGradientColor();
      this._cSliderUpColor.setRGB(_loc15_);
      this._nLastGradiantColor = _loc15_;
   }
   function getColor()
   {
      var _loc2_ = 255 * (1 - this._mcSliderCross._y / Math.floor(this.__height) * 2);
      var _loc3_ = (this._nLastGradiantColor & 16711680) >> 16;
      var _loc4_ = (this._nLastGradiantColor & 65280) >> 8;
      var _loc5_ = this._nLastGradiantColor & 255;
      if(_loc2_ >= 0)
      {
         var _loc6_ = _loc2_ * (255 - _loc3_) / 255 + _loc3_;
         var _loc7_ = _loc2_ * (255 - _loc4_) / 255 + _loc4_;
         var _loc8_ = _loc2_ * (255 - _loc5_) / 255 + _loc5_;
      }
      else
      {
         _loc2_ = _loc2_ * -1;
         _loc6_ = Math.round(_loc3_ - _loc3_ * _loc2_ / 255);
         _loc7_ = Math.round(_loc4_ - _loc4_ * _loc2_ / 255);
         _loc8_ = Math.round(_loc5_ - _loc5_ * _loc2_ / 255);
      }
      return Math.round((_loc6_ << 16) + (_loc7_ << 8) + _loc8_);
   }
   function onStartColorsCrossMove()
   {
      this._bMoveColorsCross = true;
      this.placeColorsCross(this._xmouse,this._ymouse);
      this._mcColorsCross.startDrag(true,0,0,this._nColorsWidth - 1,this.__height);
      this._nLastGradiantColor = this.getGradientColor();
      this._cSliderUpColor.setRGB(this._nLastGradiantColor);
      this.dispatchEvent({type:"change",value:this.getColor()});
   }
   function onStopColorsCrossMove()
   {
      this._bMoveColorsCross = false;
      this._mcColorsCross.stopDrag();
   }
   function onStartSliderCrossMove()
   {
      this._bMoveSliderCross = true;
      this.placeSliderCross(this._nSliderCenterX,this._ymouse);
      this._mcSliderCross.startDrag(true,this._nSliderCenterX,0,this._nSliderCenterX,this.__height);
      this._nLastGradiantColor = this.getGradientColor();
      this.dispatchEvent({type:"change",value:this.getColor()});
   }
   function onStopSliderCrossMove()
   {
      this._bMoveSliderCross = false;
      this._mcSliderCross.stopDrag();
   }
   function onMouseMove()
   {
      if(this._bMoveColorsCross)
      {
         var _loc2_ = this.getGradientColor();
         this._cSliderUpColor.setRGB(_loc2_);
         this._nLastGradiantColor = _loc2_;
         this.dispatchEvent({type:"change",value:this.getColor()});
      }
      if(this._bMoveSliderCross)
      {
         this.dispatchEvent({type:"change",value:this.getColor()});
      }
   }
}

class dofus.graphics.gapi.controls.ColorSelector extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ColorSelector";
   static var MAXIMUM_COLOR_INDEX = 3;
   var _nSelectedColorIndex = 1;
   static var HEX_CHARS = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
   function ColorSelector()
   {
      super();
   }
   function __set__colors(aColors)
   {
      this.addToQueue({object:this,method:this.applyColor,params:[aColors[0],1]});
      this.addToQueue({object:this,method:this.applyColor,params:[aColors[1],2]});
      this.addToQueue({object:this,method:this.applyColor,params:[aColors[2],3]});
      return this.__get__colors();
   }
   function __set__breed(nBreed)
   {
      this._nBreed = nBreed;
      return this.__get__breed();
   }
   function __set__sex(nSex)
   {
      this._nSex = nSex;
      return this.__get__sex();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.ColorSelector.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.addListeners});
   }
   function initData()
   {
      this._oColors = {color1:-1,color2:-1,color3:-1};
      this._oBakColors = {color1:-1,color2:-1,color3:-1};
   }
   function addListeners()
   {
      this._btnColor1.addEventListener("click",this);
      this._btnColor2.addEventListener("click",this);
      this._btnColor3.addEventListener("click",this);
      this._btnColor1.addEventListener("over",this);
      this._btnColor2.addEventListener("over",this);
      this._btnColor3.addEventListener("over",this);
      this._btnColor1.addEventListener("out",this);
      this._btnColor2.addEventListener("out",this);
      this._btnColor3.addEventListener("out",this);
      this._cpColorPicker.addEventListener("change",this);
      this._btnReset.addEventListener("click",this);
      this._btnReset.addEventListener("over",this);
      this._btnReset.addEventListener("out",this);
      var ref = this;
      this._mcRandomColor1.onPress = function()
      {
         ref.click({target:this});
      };
      this._mcRandomColor2.onPress = function()
      {
         ref.click({target:this});
      };
      this._mcRandomColor3.onPress = function()
      {
         ref.click({target:this});
      };
      this._mcRandomAll.onPress = function()
      {
         ref.click({target:this});
      };
      this._mcRandomColor1.onRollOver = function()
      {
         ref.over({target:this});
      };
      this._mcRandomColor2.onRollOver = function()
      {
         ref.over({target:this});
      };
      this._mcRandomColor3.onRollOver = function()
      {
         ref.over({target:this});
      };
      this._mcRandomAll.onRollOver = function()
      {
         ref.over({target:this});
      };
      this._mcRandomColor1.onRollOut = function()
      {
         ref.out({target:this});
      };
      this._mcRandomColor2.onRollOut = function()
      {
         ref.out({target:this});
      };
      this._mcRandomColor3.onRollOut = function()
      {
         ref.out({target:this});
      };
      this._mcRandomAll.onRollOut = function()
      {
         ref.out({target:this});
      };
   }
   function setColorIndex(nIndex)
   {
      var _loc3_ = this["_btnColor" + this._nSelectedColorIndex];
      var _loc4_ = this["_btnColor" + nIndex];
      _loc3_.selected = false;
      _loc4_.selected = true;
      this._nSelectedColorIndex = nIndex;
   }
   function applyColor(nColor, nIndex)
   {
      if(nIndex == undefined)
      {
         nIndex = this._nSelectedColorIndex;
      }
      var _loc4_ = {ColoredButton:{bgcolor:(nColor != -1?nColor:16711680),highlightcolor:(nColor != -1?nColor:16777215),bgdowncolor:(nColor != -1?nColor:16711680),highlightdowncolor:(nColor != -1?nColor:16777215)}};
      ank.gapi.styles.StylesManager.loadStylePackage(_loc4_);
      this["_btnColor" + nIndex].styleName = "ColoredButton";
      this._oColors["color" + nIndex] = nColor;
      this._oBakColors["color" + nIndex] = nColor;
   }
   function selectColor(nIndex)
   {
      var _loc3_ = this._oBakColors["color" + nIndex];
      if(_loc3_ != -1)
      {
         this._cpColorPicker.setColor(_loc3_);
      }
      this.setColorIndex(nIndex);
   }
   static function d2h(d)
   {
      if(d > 255)
      {
         d = 255;
      }
      return dofus.graphics.gapi.controls.ColorSelector.HEX_CHARS[Math.floor(d / 16)] + dofus.graphics.gapi.controls.ColorSelector.HEX_CHARS[d % 16];
   }
   function displayColorCode(nIndex)
   {
      this.selectColor(nIndex);
      var _loc3_ = (this._oColors["color" + nIndex] & 16711680) >> 16;
      var _loc4_ = (this._oColors["color" + nIndex] & 65280) >> 8;
      var _loc5_ = this._oColors["color" + nIndex] & 255;
      var _loc6_ = dofus.graphics.gapi.controls.ColorSelector.d2h(_loc3_) + dofus.graphics.gapi.controls.ColorSelector.d2h(_loc4_) + dofus.graphics.gapi.controls.ColorSelector.d2h(_loc5_);
      if(this._oColors["color" + nIndex] == undefined || this._oColors["color" + nIndex] == -1)
      {
         _loc6_ = "";
      }
      var _loc7_ = this.gapi.loadUIComponent("PopupHexa","PopupHexa",{value:_loc6_,params:{targetType:"colorCode",colorIndex:nIndex}});
      _loc7_.addEventListener("validate",this);
   }
   function setColor(nIndex, nValue)
   {
      this.setColorIndex(nIndex);
      this.change({target:this._cpColorPicker,value:nValue});
      this.click({target:this["_btnColor" + nIndex]});
   }
   function hueVariation(nColor, nVariation, bNoBalance)
   {
      var _loc5_ = this.rgb2hsl(nColor);
      if(_loc5_.h < 0.5 && !bNoBalance)
      {
         nVariation = - nVariation;
      }
      _loc5_.h = _loc5_.h + nVariation;
      if(_loc5_.h > 1)
      {
         _loc5_.h = _loc5_.h - 1;
      }
      if(_loc5_.h < 0)
      {
         _loc5_.h = _loc5_.h + 1;
      }
      return this.hsl2rgb(_loc5_.h,_loc5_.s,_loc5_.l);
   }
   function lightVariation(nColor, nVariation)
   {
      var _loc4_ = this.rgb2hsl(nColor);
      _loc4_.l = _loc4_.l + nVariation;
      if(_loc4_.l > 1)
      {
         _loc4_.l = 1;
      }
      if(_loc4_.l < 0)
      {
         _loc4_.l = 0;
      }
      return this.hsl2rgb(_loc4_.h,_loc4_.s,_loc4_.l);
   }
   function complementaryColor(nColor)
   {
      var _loc3_ = this.rgb2hsl(nColor);
      var _loc4_ = _loc3_.h + 0.5;
      if(_loc4_ > 1)
      {
         _loc4_ = _loc4_ - 1;
      }
      return this.hsl2rgb(_loc4_,_loc3_.s,_loc3_.l);
   }
   function hsl2rgb(h, s, l)
   {
      if(s == 0)
      {
         var _loc5_ = l * 255;
         var _loc6_ = l * 255;
         var _loc7_ = l * 255;
      }
      else
      {
         if(l < 0.5)
         {
            var _loc8_ = l * (1 + s);
         }
         else
         {
            _loc8_ = l + s - s * l;
         }
         var _loc9_ = 2 * l - _loc8_;
         _loc5_ = 255 * this.h2rgb(_loc9_,_loc8_,h + 1 / 3);
         _loc6_ = 255 * this.h2rgb(_loc9_,_loc8_,h);
         _loc7_ = 255 * this.h2rgb(_loc9_,_loc8_,h - 1 / 3);
      }
      return Number("0x" + dofus.graphics.gapi.controls.ColorSelector.d2h(Math.round(_loc5_)) + dofus.graphics.gapi.controls.ColorSelector.d2h(Math.round(_loc6_)) + dofus.graphics.gapi.controls.ColorSelector.d2h(Math.round(_loc7_)));
   }
   function rgb2hsl(nColor)
   {
      var _loc3_ = ((nColor & 16711680) >> 16) / 255;
      var _loc4_ = ((nColor & 65280) >> 8) / 255;
      var _loc5_ = (nColor & 255) / 255;
      var _loc6_ = this.min(_loc3_,_loc4_,_loc5_);
      var _loc7_ = this.max(_loc3_,_loc4_,_loc5_);
      var _loc8_ = _loc7_ - _loc6_;
      var _loc9_ = (_loc7_ + _loc6_) / 2;
      if(_loc8_ == 0)
      {
         var _loc10_ = 0;
         var _loc11_ = 0;
      }
      else
      {
         if(_loc9_ < 0.5)
         {
            _loc11_ = _loc8_ / (_loc7_ + _loc6_);
         }
         else
         {
            _loc11_ = _loc8_ / (2 - _loc7_ - _loc6_);
         }
         var _loc12_ = ((_loc7_ - _loc3_) / 6 + _loc8_ / 2) / _loc8_;
         var _loc13_ = ((_loc7_ - _loc4_) / 6 + _loc8_ / 2) / _loc8_;
         var _loc14_ = ((_loc7_ - _loc5_) / 6 + _loc8_ / 2) / _loc8_;
         if(_loc3_ == _loc7_)
         {
            _loc10_ = _loc14_ - _loc13_;
         }
         else if(_loc4_ == _loc7_)
         {
            _loc10_ = 1 / 3 + _loc12_ - _loc14_;
         }
         else if(_loc5_ == _loc7_)
         {
            _loc10_ = 2 / 3 + _loc13_ - _loc12_;
         }
         if(_loc10_ < 0)
         {
            _loc10_ = _loc10_ + 1;
         }
         if(_loc10_ > 1)
         {
            _loc10_ = _loc10_ - 1;
         }
      }
      return {h:_loc10_,s:_loc11_,l:_loc9_};
   }
   function h2rgb(v1, v2, h)
   {
      if(h < 0)
      {
         h = h + 1;
      }
      if(h > 1)
      {
         h = h - 1;
      }
      if(6 * h < 1)
      {
         return v1 + (v2 - v1) * 6 * h;
      }
      if(2 * h < 1)
      {
         return v2;
      }
      if(3 * h < 2)
      {
         return v1 + (v2 - v1) * ((2 / 3 - h) * 6);
      }
      return v1;
   }
   function min()
   {
      var _loc2_ = Number.POSITIVE_INFINITY;
      var _loc3_ = 0;
      while(_loc3_ < arguments.length)
      {
         if(!_global.isNaN(Number(arguments[_loc3_])) && _loc2_ > Number(arguments[_loc3_]))
         {
            _loc2_ = Number(arguments[_loc3_]);
         }
         _loc3_ = _loc3_ + 1;
      }
      return _loc2_;
   }
   function max()
   {
      var _loc2_ = Number.NEGATIVE_INFINITY;
      var _loc3_ = 0;
      while(_loc3_ < arguments.length)
      {
         if(!_global.isNaN(Number(arguments[_loc3_])) && _loc2_ < Number(arguments[_loc3_]))
         {
            _loc2_ = Number(arguments[_loc3_]);
         }
         _loc3_ = _loc3_ + 1;
      }
      return _loc2_;
   }
   function isSkin(nIndex)
   {
      return dofus.Constants.BREED_SKIN_INDEXES[this._nSex][this._nBreed - 1] == nIndex;
   }
   function randomSkin()
   {
      return this.lightVariation(dofus.Constants.BREED_SKIN_BASE_COLOR[this._nSex][this._nBreed - 1],Math.random() * 0.2 * (Math.random() <= 0.5?-1:1));
   }
   function click(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnColor1:
         case this._btnColor2:
         case this._btnColor3:
            var _loc3_ = Number(oEvent.target._name.substr(9));
            if(Key.isDown(Key.SHIFT))
            {
               this.displayColorCode(_loc3_);
            }
            else if(Key.isDown(Key.CONTROL))
            {
               this.applyColor(-1,_loc3_);
            }
            else
            {
               this.selectColor(_loc3_);
            }
            break;
         case this._mcRandomColor1:
         case this._mcRandomColor2:
         case this._mcRandomColor3:
            var _loc4_ = Number(oEvent.target._name.substr(14));
            this.setColor(_loc4_,Math.round(Math.random() * 16777215));
            break;
         case this._mcRandomAll:
            var _loc5_ = Math.floor(Math.random() * dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX);
            var _loc6_ = Math.ceil(Math.random() * 16777215);
            this.setColor(_loc5_,!this.isSkin(_loc5_)?_loc6_:this.randomSkin());
            _loc5_ = _loc5_ + 1;
            if(_loc5_ > dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX)
            {
               _loc5_ = _loc5_ - dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX;
            }
            this.setColor(_loc5_,!this.isSkin(_loc5_)?this.complementaryColor(_loc6_):this.randomSkin());
            _loc5_ = _loc5_ + 1;
            if(_loc5_ > dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX)
            {
               _loc5_ = _loc5_ - dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX;
            }
            this.setColor(_loc5_,!this.isSkin(_loc5_)?this.hueVariation(_loc6_,Math.random()):this.randomSkin());
            break;
         case this._btnReset:
            var _loc7_ = 1;
            while(_loc7_ <= dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX)
            {
               this.applyColor(-1,_loc7_);
               _loc7_ = _loc7_ + 1;
            }
            this.dispatchEvent({type:"change",value:this._oColors});
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnColor1:
         case this._btnColor2:
         case this._btnColor3:
            var _loc3_ = Number(oEvent.target._name.substr(9));
            this.dispatchEvent({type:"over",index:_loc3_});
            break;
         case this._btnReset:
            this.gapi.showTooltip(this.api.lang.getText("REINIT_WORD"),oEvent.target,-20);
            break;
         case this._mcRandomColor1:
         case this._mcRandomColor2:
         case this._mcRandomColor3:
            this.gapi.showTooltip(this.api.lang.getText("RANDOM_COLOR"),_root._xmouse,_root._ymouse - 20);
            break;
         case this._mcRandomAll:
            this.gapi.showTooltip(this.api.lang.getText("RANDOM_ALL_COLORS"),_root._xmouse,_root._ymouse - 20);
      }
   }
   function out(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnColor1:
         case this._btnColor2:
         case this._btnColor3:
            var _loc3_ = Number(oEvent.target._name.substr(9));
            this.dispatchEvent({type:"out",index:_loc3_});
            break;
         default:
            this.gapi.hideTooltip();
      }
   }
   function change(oEvent)
   {
      if((var _loc0_ = oEvent.target) === this._cpColorPicker)
      {
         this.applyColor(oEvent.value);
         this.dispatchEvent({type:"change",value:this._oColors});
      }
   }
   function validate(oEvent)
   {
      if((var _loc0_ = oEvent.params.targetType) === "colorCode")
      {
         if(!(_global.isNaN(oEvent.value) || (oEvent.value > 16777215 || oEvent.value == undefined)))
         {
            this.setColor(oEvent.params.colorIndex,oEvent.value);
         }
      }
   }
}

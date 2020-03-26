class dofus.graphics.gapi.ui.Indicator extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Indicator";
   static var SHADOW_OFFSET = 3;
   static var SHADOW_TRANSFORM = {ra:0,rb:0,ga:0,gb:0,ba:0,bb:0,aa:40,ab:0};
   var _bRotate = true;
   var _nOffset = 0;
   function Indicator()
   {
      super();
   }
   function __set__rotate(bRotate)
   {
      this._bRotate = bRotate;
      return this.__get__rotate();
   }
   function __set__coordinates(aCoordinates)
   {
      this._aCoordinates = aCoordinates;
      return this.__get__coordinates();
   }
   function __set__offset(nOffset)
   {
      this._nOffset = nOffset;
      return this.__get__offset();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Indicator.CLASS_NAME);
   }
   function createChildren()
   {
      var _loc2_ = this._aCoordinates[0];
      var _loc3_ = this._aCoordinates[1];
      if(this._bRotate)
      {
         var _loc5_ = this.gapi.screenWidth / 2;
         var _loc6_ = this.gapi.screenHeight / 2;
         var _loc7_ = Math.atan2(this._aCoordinates[1] - _loc6_,this._aCoordinates[0] - _loc5_);
         var _loc4_ = _loc7_ * 180 / Math.PI - 90;
         _loc2_ = _loc2_ - (this._nOffset != undefined?this._nOffset * Math.cos(_loc7_):0);
         _loc3_ = _loc3_ - (this._nOffset != undefined?this._nOffset * Math.sin(_loc7_):0);
      }
      else
      {
         _loc3_ = _loc3_ - (this._nOffset != undefined?this._nOffset:0);
      }
      this.attachMovie("UI_Indicatorlight","_mcLight",10,{_x:_loc2_,_y:_loc3_});
      var _loc8_ = "UI_IndicatorArrow";
      if(_global.doubleFramerate)
      {
         _loc8_ = _loc8_ + "_DoubleFramerate";
      }
      this.attachMovie(_loc8_,"_mcArrowShadow",20,{_x:_loc2_ + dofus.graphics.gapi.ui.Indicator.SHADOW_OFFSET,_y:_loc3_ + dofus.graphics.gapi.ui.Indicator.SHADOW_OFFSET});
      this.attachMovie(_loc8_,"_mcArrow",30,{_x:_loc2_,_y:_loc3_});
      var _loc9_ = new Color(this._mcArrowShadow);
      _loc9_.setTransform(dofus.graphics.gapi.ui.Indicator.SHADOW_TRANSFORM);
      if(this._bRotate)
      {
         this._mcLight._rotation = _loc4_;
         this._mcArrow._rotation = _loc4_;
         this._mcArrowShadow._rotation = _loc4_;
      }
   }
}

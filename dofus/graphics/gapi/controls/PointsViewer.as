class dofus.graphics.gapi.controls.PointsViewer extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "PointsViewer";
   function PointsViewer()
   {
      super();
   }
   function __set__background(sBackground)
   {
      this._sBackgroundLink = sBackground;
      return this.__get__background();
   }
   function __set__textColor(nTextColor)
   {
      this._nTextColor = nTextColor;
      return this.__get__textColor();
   }
   function __set__value(nValue)
   {
      nValue = Number(nValue);
      if(_global.isNaN(nValue))
      {
         return undefined;
      }
      this._nValue = nValue;
      this.applyValue();
      this.useHandCursor = false;
      return this.__get__value();
   }
   function __get__value()
   {
      return this._nValue;
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.PointsViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this.attachMovie(this._sBackgroundLink,"_mcBg",this._txtValue.getDepth() - 1);
      this._txtValue.textColor = this._nTextColor;
   }
   function applyValue()
   {
      this._txtValue.text = String(this._nValue);
   }
   function onRollOver()
   {
      this.dispatchEvent({type:"over"});
   }
   function onRollOut()
   {
      this.dispatchEvent({type:"out"});
   }
}

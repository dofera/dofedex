class ank.gapi.controls.Clock extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "Clock";
   var _bHoursLoaded = false;
   var _bMinutesLoaded = false;
   function Clock()
   {
      super();
   }
   function __set__background(sBackground)
   {
      this._sBackground = sBackground;
      return this.__get__background();
   }
   function __get__background()
   {
      return this._sBackground;
   }
   function __set__arrowHours(sArrowHours)
   {
      this._sArrowHours = sArrowHours;
      return this.__get__arrowHours();
   }
   function __get__arrowHours()
   {
      return this._sArrowHours;
   }
   function __set__arrowMinutes(sArrowMinutes)
   {
      this._sArrowMinutes = sArrowMinutes;
      return this.__get__arrowMinutes();
   }
   function __get__arrowMinutes()
   {
      return this._sArrowMinutes;
   }
   function __set__hours(nHours)
   {
      this._nHours = nHours % 12;
      if(this.initialized)
      {
         this.layoutContent();
      }
      return this.__get__hours();
   }
   function __get__hours()
   {
      return this._nHours;
   }
   function __set__minutes(nMinutes)
   {
      this._nMinutes = nMinutes % 59;
      if(this.initialized)
      {
         this.layoutContent();
      }
      return this.__get__minutes();
   }
   function __get__minutes()
   {
      return this._nMinutes;
   }
   function __set__updateFunction(oUpdateFunction)
   {
      this._oUpdateFunction = oUpdateFunction;
      return this.__get__updateFunction();
   }
   function init()
   {
      super.init(false,ank.gapi.controls.Clock.CLASS_NAME);
   }
   function createChildren()
   {
      this.attachMovie("Loader","_ldrBack",10,{contentPath:this._sBackground,centerContent:false,scaleContent:true});
      this.attachMovie("Loader","_ldrArrowHours",20,{contentPath:this._sArrowHours,centerContent:false,scaleContent:true});
      this.attachMovie("Loader","_ldrArrowMinutes",30,{contentPath:this._sArrowMinutes,centerContent:false,scaleContent:true});
      this._ldrArrowHours._visible = false;
      this._ldrArrowMinutes._visible = false;
      this.addToQueue({object:this,method:this.layoutContent});
   }
   function size()
   {
      super.size();
      this.arrange();
   }
   function arrange()
   {
      this._ldrBack.setSize(this.__width,this.__height);
      this._ldrArrowHours.setSize(this.__width,this.__height);
      this._ldrArrowMinutes.setSize(this.__width,this.__height);
   }
   function layoutContent()
   {
      if(this._oUpdateFunction != undefined)
      {
         var _loc2_ = this._oUpdateFunction.method.apply(this._oUpdateFunction.object);
         ank.utils.Timer.setTimer(this,"clock",this,this.layoutContent,30000);
         this._nHours = _loc2_[0];
         this._nMinutes = _loc2_[1];
      }
      var _loc3_ = 30 * this._nHours + 6 * this._nMinutes / 12 - 90;
      var _loc4_ = 6 * this._nMinutes - 90;
      this._ldrArrowHours.content._rotation = _loc3_;
      this._ldrArrowMinutes.content._rotation = _loc4_;
      this._ldrArrowHours._visible = true;
      this._ldrArrowMinutes._visible = true;
   }
   function onRelease()
   {
      this.dispatchEvent({type:"click"});
   }
   function onReleaseOutside()
   {
      this.onRollOut();
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

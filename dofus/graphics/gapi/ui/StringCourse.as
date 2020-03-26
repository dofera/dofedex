class dofus.graphics.gapi.ui.StringCourse extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "StringCourse";
   function StringCourse()
   {
      super();
   }
   function __set__name(sName)
   {
      this._sName = sName;
      return this.__get__name();
   }
   function __set__level(sLevel)
   {
      this._sLevel = sLevel;
      return this.__get__level();
   }
   function __set__gfx(sGfx)
   {
      this._sGfx = sGfx;
      return this.__get__gfx();
   }
   function __set__colors(aColors)
   {
      this._colors = aColors;
      return this.__get__colors();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.StringCourse.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.loadContent});
   }
   function loadContent()
   {
      this._ldrStringCourse.addEventListener("error",this);
      this._ldrStringCourse.addEventListener("complete",this);
      this._ldrStringCourse.contentPath = this._sGfx;
   }
   function unloadContent()
   {
      this._ldrStringCourse.contentPath = "";
      this._lblName.text = "";
      this._lblLevel.text = "";
   }
   function applyColor(mc, zone)
   {
      var _loc4_ = this._colors[zone];
      if(_loc4_ == -1 || _loc4_ == undefined)
      {
         return undefined;
      }
      var _loc5_ = (_loc4_ & 16711680) >> 16;
      var _loc6_ = (_loc4_ & 65280) >> 8;
      var _loc7_ = _loc4_ & 255;
      var _loc8_ = new Color(mc);
      var _loc9_ = new Object();
      _loc9_ = {ra:0,ga:0,ba:0,rb:_loc5_,gb:_loc6_,bb:_loc7_};
      _loc8_.setTransform(_loc9_);
   }
   function complete(oEvent)
   {
      this._lblName.text = this._sName;
      this._lblLevel.text = this._sLevel;
      var ref = this;
      this._ldrStringCourse.content.stringCourseColor = function(mc, z)
      {
         ref.applyColor(mc,z);
      };
      this._mcAnim.play();
   }
   function error(oEvent)
   {
      this.unloadThis();
   }
}

class ank.gapi.controls.StylizedRectangle extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "StylizedRectangle";
   function StylizedRectangle()
   {
      super();
   }
   function init()
   {
      super.init(false,ank.gapi.controls.StylizedRectangle.CLASS_NAME);
   }
   function createChildren()
   {
      this.createEmptyMovieClip("_mcBackground",10);
   }
   function size()
   {
      super.size();
      this.arrange();
   }
   function arrange()
   {
      if(this._bInitialized)
      {
         this.draw();
      }
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      var _loc3_ = _loc2_.cornerradius;
      var _loc4_ = _loc2_.bgcolor;
      var _loc5_ = _loc2_.alpha;
      this._mcBackground.clear();
      this.drawRoundRect(this._mcBackground,0,0,this.__width,this.__height,_loc3_,_loc4_,_loc5_);
   }
}

class ank.gapi.controls.BackgroundHidder extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "BackgroundHidder";
   function BackgroundHidder()
   {
      super();
   }
   function __set__handCursor(bHandCursor)
   {
      this.useHandCursor = bHandCursor;
      return this.__get__handCursor();
   }
   function init()
   {
      super.init(false,ank.gapi.controls.BackgroundHidder.CLASS_NAME);
   }
   function createChildren()
   {
      this.createEmptyMovieClip("hidden_mc",10);
      this.onRelease = function()
      {
         this.dispatchEvent({type:"click"});
      };
   }
   function arrange()
   {
      this.hidden_mc._width = this.__width;
      this.hidden_mc._height = this.__height;
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      var _loc3_ = _loc2_.backgroundcolor != undefined?_loc2_.backgroundcolor:0;
      var _loc4_ = _loc2_.backgroundalpha != undefined?_loc2_.backgroundalpha:10;
      this.hidden_mc.clear();
      this.drawRoundRect(this.hidden_mc,0,0,1,1,0,_loc3_,_loc4_);
   }
}

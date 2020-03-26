class ank.gapi.controls.common.DefaultHighlight extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "DefaultHighlight";
   function DefaultHighlight()
   {
      super();
   }
   function init()
   {
      super.init(false,ank.gapi.controls.common.DefaultHighlight.CLASS_NAME);
   }
   function createChildren()
   {
      this.createEmptyMovieClip("_mcHighlight",10);
   }
   function size()
   {
      super.size();
      this.arrange();
   }
   function arrange()
   {
      this._mcHighlight._width = this.__width;
      this._mcHighlight._height = this.__height;
   }
   function draw()
   {
      this.drawRoundRect(this._mcHighlight,0,0,1,1,0,0,50);
   }
}

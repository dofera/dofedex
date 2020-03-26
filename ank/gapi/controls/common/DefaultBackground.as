class ank.gapi.controls.common.DefaultBackground extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "DefaultBackground";
   function DefaultBackground()
   {
      super();
   }
   function init()
   {
      super.init(false,ank.gapi.controls.common.DefaultBackground.CLASS_NAME);
   }
   function createChildren()
   {
   }
   function size()
   {
      super.size();
      this.arrange();
   }
   function arrange()
   {
      this.draw();
   }
   function draw()
   {
      this.drawBorder();
   }
}

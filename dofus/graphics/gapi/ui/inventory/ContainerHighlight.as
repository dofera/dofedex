class dofus.graphics.gapi.ui.inventory.ContainerHighlight extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "ContainerHighlight";
   function ContainerHighlight()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.inventory.ContainerHighlight.CLASS_NAME);
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
      this._mcBg._width = this.__width;
      this._mcBg._height = this.__height;
      this._mcL._height = this._mcR._height = this.__height;
      this._mcT._width = this._mcB._width = this.__width;
      this._mcL._x = this._mcT._x = this._mcL._y = this._mcT._y = this._mcB._x = this._mcR._y = 0;
      this._mcB._y = this.__height - this._mcL._width;
      this._mcR._x = this.__width - this._mcR._width;
   }
}

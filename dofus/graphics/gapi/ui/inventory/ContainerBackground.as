class dofus.graphics.gapi.ui.inventory.ContainerBackground extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "ContainerBackground";
   function ContainerBackground()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.inventory.ContainerBackground.CLASS_NAME);
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
      this._mcBg._width = this.__width - this._mcR._width;
      this._mcBg._height = this.__height - this._mcB._height;
      this._mcBg._x = this._mcL._width;
      this._mcBg._y = this._mcT._height;
      this._mcL._height = this._mcR._height = this.__height;
      this._mcT._width = this._mcB._width = this.__width;
      this._mcL._x = this._mcT._x = this._mcL._y = this._mcT._y = this._mcB._x = this._mcR._y = 0;
      this._mcB._y = this.__height - this._mcL._width;
      this._mcR._x = this.__width - this._mcR._width;
      this._mcTL._x = this._mcTL._y = this._mcBL._x = this._mcTR._y = 0;
      this._mcTR._x = this._mcBR._x = this.__width - (this._mcL._width + this._mcR._width) / 2;
      this._mcBR._y = this._mcBL._y = this.__height - (this._mcB._height + this._mcT._height) / 2;
   }
}

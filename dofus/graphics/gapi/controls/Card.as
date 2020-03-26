class dofus.graphics.gapi.controls.Card extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Card";
   function Card()
   {
      super();
   }
   function __set__name(sName)
   {
      this._sName = sName;
      return this.__get__name();
   }
   function __set__background(nBackground)
   {
      this._nBackground = nBackground;
      return this.__get__background();
   }
   function __set__gfxFile(sGfxFile)
   {
      this._sGfxFile = sGfxFile;
      return this.__get__gfxFile();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.Card.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initData});
   }
   function initData()
   {
      this._lblName.text = this._sName;
      this._ldrBack.contentPath = dofus.Constants.CARDS_PATH + this._nBackground + ".swf";
      this._ldrGfx.contentPath = this._sGfxFile;
   }
}

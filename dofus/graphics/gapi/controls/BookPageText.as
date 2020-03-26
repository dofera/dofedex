class dofus.graphics.gapi.controls.BookPageText extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "BookPageText";
   function BookPageText()
   {
      super();
   }
   function __set__page(oPage)
   {
      this._oPage = oPage;
      if(this.initialized)
      {
         this.updateData();
      }
      return this.__get__page();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.BookPageText.CLASS_NAME);
   }
   function createChildren()
   {
      this._txtPage.wordWrap = true;
      this._txtPage.multiline = true;
      this._txtPage.embedFonts = true;
      this.addToQueue({object:this,method:this.updateData});
   }
   function updateData()
   {
      this.setCssStyle(this._oPage.cssFile);
   }
   function setCssStyle(sCssFile)
   {
      var _loc3_ = new TextField.StyleSheet();
      _loc3_.owner = this;
      _loc3_.onLoad = function()
      {
         this.owner.layoutContent(this);
      };
      _loc3_.load(sCssFile);
   }
   function layoutContent(ssStyle)
   {
      this._txtPage.styleSheet = ssStyle;
      this._txtPage.htmlText = this._oPage.text;
   }
}

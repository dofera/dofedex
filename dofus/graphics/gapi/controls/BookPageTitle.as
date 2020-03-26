class dofus.graphics.gapi.controls.BookPageTitle extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "BookPageTitle";
   function BookPageTitle()
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
      super.init(false,dofus.graphics.gapi.controls.BookPageTitle.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.updateData});
   }
   function updateData()
   {
      this._txtTitle.text = this._oPage.title != undefined?this._oPage.title:"";
      this._lblSubTitle.text = this._oPage.subtitle != undefined?this._oPage.subtitle:"";
      this._lblAuthor.text = this._oPage.author != undefined?this._oPage.author:"";
   }
}

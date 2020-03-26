class dofus.graphics.gapi.ui.knownledgebase.KnownledgeBaseCategoryItem extends ank.gapi.core.UIBasicComponent
{
   function KnownledgeBaseCategoryItem()
   {
      super();
      this._mcPicto._visible = false;
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._lblCategory.text = oItem.n;
         this._mcPicto._visible = true;
      }
      else if(this._lblCategory.text != undefined)
      {
         this._lblCategory.text = "";
         this._mcPicto._visible = false;
      }
   }
   function init()
   {
      super.init(false);
   }
}

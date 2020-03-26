class dofus.graphics.gapi.ui.login.LoginNewsItem extends ank.gapi.core.UIBasicComponent
{
   function LoginNewsItem()
   {
      super();
   }
   function __set__list(mcList)
   {
      this._mcList = mcList;
      return this.__get__list();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._oItem = oItem;
         this._lblDate.text = oItem.getPubDateStr(_global.API.lang.getConfigText("LONG_DATE_FORMAT"),_global.API.config.language);
         this._lblTitle.bDisplayDebug = true;
         this._lblTitle.text = oItem.getTitle();
         this._ldrImage.contentPath = oItem.getIcon();
         this._mcSeparator._visible = true;
      }
      else if(this._lblDate.text != undefined)
      {
         this._lblDate.text = "";
         this._lblTitle.text = "";
         this._ldrImage.contentPath = "";
         this._mcSeparator._visible = false;
      }
   }
   function init()
   {
      super.init(false);
      this._mcSeparator._visible = false;
   }
}

class dofus.graphics.gapi.ui.quests.QuestsObjectiveItem extends ank.gapi.core.UIBasicComponent
{
   function QuestsObjectiveItem()
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
         this._txtDescription.text = oItem.description;
         this._txtDescription.styleName = !oItem.isFinished?"BrownLeftSmallTextArea":"GreyLeftSmallTextArea";
         this._mcCheckFinished._visible = oItem.isFinished;
         this._mcCompass._visible = oItem.x != undefined && oItem.y != undefined && !oItem.isFinished;
      }
      else if(this._txtDescription.text != undefined)
      {
         this._txtDescription.text = "";
         this._mcCheckFinished._visible = false;
         this._mcCompass._visible = false;
      }
   }
   function init()
   {
      super.init(false);
      this._mcCheckFinished._visible = false;
      this._mcCompass._visible = false;
   }
}

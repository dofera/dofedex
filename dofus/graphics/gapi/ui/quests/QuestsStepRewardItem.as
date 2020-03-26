class dofus.graphics.gapi.ui.quests.QuestsStepRewardItem extends ank.gapi.core.UIBasicComponent
{
   function QuestsStepRewardItem()
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
         this._lblName.text = oItem.label;
         this._ldrIcon.contentPath = oItem.iconFile;
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._ldrIcon.contentPath = "";
      }
   }
}

class dofus.graphics.gapi.ui.quests.QuestsQuestItem extends ank.gapi.core.UIBasicComponent
{
   function QuestsQuestItem()
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
         this._lblName.text = oItem.name;
         this._mcCheckFinished._visible = oItem.isFinished;
         this._mcCurrent._visible = !oItem.isFinished;
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._mcCheckFinished._visible = false;
         this._mcCurrent._visible = false;
      }
   }
   function init()
   {
      super.init(false);
      this._mcCurrent._visible = false;
      this._mcCheckFinished._visible = false;
   }
}

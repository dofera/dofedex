class dofus.graphics.gapi.controls.conqueststatsviewer.ConquestStatsViewerItem extends ank.gapi.core.UIBasicComponent
{
   function ConquestStatsViewerItem()
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
         this._lblType.text = this._oItem.type;
         this._lblBonus.text = this._oItem.bonus;
         this._lblMalus.text = this._oItem.malus;
      }
      else if(this._lblType.text != undefined)
      {
         this._lblType.text = "";
         this._lblBonus.text = "";
         this._lblMalus.text = "";
      }
   }
}

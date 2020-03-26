class dofus.graphics.gapi.ui.fightsinfos.FightsInfosPlayerItem extends ank.gapi.core.UIBasicComponent
{
   function FightsInfosPlayerItem()
   {
      super();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._lblName.text = oItem.name;
         this._lblLevel.text = oItem.level;
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._lblLevel.text = "";
      }
   }
   function init()
   {
      super.init(false);
   }
}

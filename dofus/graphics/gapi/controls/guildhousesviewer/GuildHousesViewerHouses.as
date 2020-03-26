class dofus.graphics.gapi.controls.guildhousesviewer.GuildHousesViewerHouses extends ank.gapi.core.UIBasicComponent
{
   function GuildHousesViewerHouses()
   {
      super();
      this._mcIcon._visible = false;
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._oItem = (dofus.datacenter.House)oItem;
         this._lblName.text = this._oItem.name;
         this._lblOwner.text = this._oItem.ownerName;
         this._mcIcon._visible = true;
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._lblOwner.text = "";
         this._mcIcon._visible = false;
      }
   }
   function init()
   {
      super.init(false);
   }
}

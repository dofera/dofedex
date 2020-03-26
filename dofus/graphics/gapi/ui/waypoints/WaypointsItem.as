class dofus.graphics.gapi.ui.waypoints.WaypointsItem extends ank.gapi.core.UIBasicComponent
{
   function WaypointsItem()
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
         this._lblCost.text = oItem.cost != 0?oItem.cost + "k":"-";
         this._lblCoords.text = oItem.coordinates;
         this._lblName.text = oItem.name;
         this._mcRespawn._visible = oItem.isRespawn;
         this._mcCurrent._visible = oItem.isCurrent;
         this._btnLocate._visible = true;
      }
      else if(this._lblCost.text != undefined)
      {
         this._lblCost.text = "";
         this._lblCoords.text = "";
         this._lblName.text = "";
         this._mcRespawn._visible = false;
         this._mcCurrent._visible = false;
         this._btnLocate._visible = false;
      }
   }
   function init()
   {
      super.init(false);
      this._mcRespawn._visible = false;
      this._mcCurrent._visible = false;
      this._btnLocate._visible = false;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._btnLocate.addEventListener("click",this);
   }
   function click(oEvent)
   {
      this._mcList.gapi.loadUIAutoHideComponent("MapExplorer","MapExplorer",{mapID:this._oItem.id});
   }
}

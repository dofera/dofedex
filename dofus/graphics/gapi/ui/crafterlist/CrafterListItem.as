class dofus.graphics.gapi.ui.crafterlist.CrafterListItem extends ank.gapi.core.UIBasicComponent
{
   function CrafterListItem()
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
         oItem.sortName = oItem.name;
         oItem.sortLevel = oItem.job.level;
         oItem.sortIsNotFree = oItem.job.options.isNotFree;
         oItem.sortMinSlots = Number(oItem.job.options.minSlots);
         oItem.sortSubarea = oItem.subarea != undefined?oItem.subarea:"-";
         var _loc5_ = oItem.coord;
         oItem.sortCoord = _loc5_ == undefined?"-":_loc5_.x + "," + _loc5_.y;
         oItem.sortInWorkshop = oItem.inWorkshop;
         this._lblName.text = oItem.sortName;
         this._lblLevel.text = oItem.sortLevel.toString();
         this._lblPlace.text = oItem.subarea != undefined?oItem.subarea:" ";
         var _loc6_ = this._mcList._parent._parent.api;
         this._lblWorkshop.text = !oItem.sortInWorkshop?_loc6_.lang.getText("NO"):_loc6_.lang.getText("YES");
         this._lblCoord.text = oItem.sortCoord;
         this._lblNotFree.text = !oItem.sortIsNotFree?_loc6_.lang.getText("NO"):_loc6_.lang.getText("YES");
         this._lblMinSlot.text = oItem.sortMinSlots.toString();
         this._ldrGuild.contentPath = oItem.gfxBreedFile;
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._lblLevel.text = "";
         this._lblPlace.text = "";
         this._lblWorkshop.text = "";
         this._lblCoord.text = "";
         this._lblNotFree.text = "";
         this._lblMinSlot.text = "";
         this._ldrGuild.contentPath = "";
      }
   }
   function init()
   {
      super.init(false);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._btnProfil.addEventListener("click",this);
   }
   function click(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "_btnProfil")
      {
         this._mcList.gapi.loadUIComponent("CrafterCard","CrafterCard",{crafter:this._oItem});
      }
   }
}

class dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerVillageItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   function ConquestZonesViewerVillageItem()
   {
      super();
      this.api = _global.API;
      this._ldrAlignment._alpha = 0;
      this._mcNotAligned._alpha = 0;
      this._mcAlignmentInteractivity._alpha = 0;
      this._mcDoorClose._alpha = 0;
      this._mcDoorOpen._alpha = 0;
      this._mcDoorInteractivity._alpha = 0;
      this._mcPrismClose._alpha = 0;
      this._mcPrismOpen._alpha = 0;
      this._mcPrismInteractivity._alpha = 0;
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
         this._lblVillage.text = this.api.lang.getMapAreaText(oItem.id).n;
         if(oItem.alignment == -1)
         {
            this._ldrAlignment._alpha = 0;
            this._mcNotAligned._alpha = 100;
         }
         else
         {
            this._mcNotAligned._alpha = 0;
            this._ldrAlignment._alpha = 100;
            this._ldrAlignment.contentPath = dofus.Constants.ALIGNMENTS_MINI_PATH + oItem.alignment + ".swf";
         }
         if(oItem.door)
         {
            this._mcDoorClose._alpha = 0;
            this._mcDoorOpen._alpha = 100;
         }
         else
         {
            this._mcDoorClose._alpha = 100;
            this._mcDoorOpen._alpha = 0;
         }
         if(oItem.prism)
         {
            this._mcPrismClose._alpha = 0;
            this._mcPrismOpen._alpha = 100;
         }
         else
         {
            this._mcPrismClose._alpha = 100;
            this._mcPrismOpen._alpha = 0;
         }
         var ref = this;
         this._mcAlignmentInteractivity.onRollOver = function()
         {
            ref.over({target:this});
         };
         this._mcAlignmentInteractivity.onRollOut = function()
         {
            ref.out({target:this});
         };
         this._mcDoorInteractivity.onRollOver = function()
         {
            ref.over({target:this});
         };
         this._mcDoorInteractivity.onRollOut = function()
         {
            ref.out({target:this});
         };
         this._mcPrismInteractivity.onRollOver = function()
         {
            ref.over({target:this});
         };
         this._mcPrismInteractivity.onRollOut = function()
         {
            ref.out({target:this});
         };
      }
      else if(this._lblVillage.text != undefined)
      {
         this._lblVillage.text = "";
         this._ldrAlignment._alpha = 0;
         this._ldrAlignment.contentPath = undefined;
         this._mcNotAligned._alpha = 0;
         this._mcAlignmentInteractivity._alpha = 0;
         this._mcDoorClose._alpha = 0;
         this._mcDoorOpen._alpha = 0;
         this._mcDoorInteractivity._alpha = 0;
         this._mcPrismClose._alpha = 0;
         this._mcPrismOpen._alpha = 0;
         this._mcPrismInteractivity._alpha = 0;
      }
   }
   function over(event)
   {
      switch(event.target)
      {
         case this._mcAlignmentInteractivity:
            this.api.ui.showTooltip(this.api.lang.getText("ALIGNMENT") + ": " + (this._oItem.alignment <= 0?this._oItem.alignment != -1?this.api.lang.getText("NEUTRAL_WORD"):this.api.lang.getText("NON_ALIGNED"):new dofus.datacenter.Alignment(this._oItem.alignment,1).name),_root._xmouse,_root._ymouse - 20);
            break;
         case this._mcDoorInteractivity:
            this.api.ui.showTooltip(!this._oItem.door?this.api.lang.getText("CONQUEST_VILLAGE_DOOR_CLOSE"):this.api.lang.getText("CONQUEST_VILLAGE_DOOR_OPEN"),_root._xmouse,_root._ymouse - 20);
            break;
         case this._mcPrismInteractivity:
            this.api.ui.showTooltip(!this._oItem.prism?this.api.lang.getText("CONQUEST_VILLAGE_PRISM_CLOSE"):this.api.lang.getText("CONQUEST_VILLAGE_PRISM_OPEN"),_root._xmouse,_root._ymouse - 20);
      }
   }
   function out(event)
   {
      this.api.ui.hideTooltip();
   }
}

class dofus.graphics.gapi.controls.guildmountparkviewer.MountParksViewerItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   function MountParksViewerItem()
   {
      super();
      this.api = _global.API;
   }
   function __set__list(mcList)
   {
      this._mcList = mcList;
      return this.__get__list();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      this._bUsed = bUsed;
      if(bUsed)
      {
         this._oItem = oItem;
         var _loc5_ = this.api.lang.getMapText(Number(oItem.map)).x;
         var _loc6_ = this.api.lang.getMapText(Number(oItem.map)).y;
         this._lblSubArea.text = this.api.kernel.MapsServersManager.getMapName(oItem.map) + " (" + _loc5_ + ", " + _loc6_ + ")";
         oItem.sortLocalisation = this._lblSubArea.text;
         this._lblItems.text = this.api.lang.getText("MOUNTPARKS_MAX_ITEMS",[oItem.items]);
         this._lblMounts.text = this.api.lang.getText("MOUNTPARKS_CURRENT_MOUNTS",[oItem.mounts.length,oItem.size]);
         oItem.sortMounts = oItem.mounts.length;
         this._btnTeleport._visible = true;
         this._btnTeleport.onRollOver = function()
         {
            this._parent.gapi.showTooltip(this._parent.api.lang.getText("GUILD_FARM_TELEPORT_TOOLTIP"),this,-20);
         };
         this._btnTeleport.onRollOut = function()
         {
            this._parent.gapi.hideTooltip();
         };
      }
      else
      {
         this._btnTeleport._visible = false;
         if(this._lblArea.text != undefined)
         {
            this._lblArea.text = "";
            this._lblSubArea.text = "";
            this._lblItems.text = "-";
            this._lblMounts.text = "";
         }
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
      this._lblMounts.onRollOver = function()
      {
         this._parent.over({target:this});
      };
      this._lblMounts.onRollOut = function()
      {
         this._parent.out({target:this});
      };
      this._btnTeleport.addEventListener("click",this);
   }
   function over(oEvent)
   {
      var _loc3_ = this._mcList._parent._parent.api;
      if((var _loc0_ = oEvent.target) === this._lblMounts)
      {
         var _loc4_ = "";
         var _loc5_ = this._oItem.mounts;
         var _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(_loc6_ > 0)
            {
               _loc4_ = _loc4_ + "\n\n";
            }
            var _loc7_ = _loc5_[_loc6_];
            _loc4_ = _loc4_ + (_loc3_.lang.getText("MOUNT_OF",[_loc7_.ownerName]) + " : " + _loc7_.name + "\n(" + _loc7_.modelName + ")");
            _loc6_ = _loc6_ + 1;
         }
         if(_loc4_ != "")
         {
            _loc3_.ui.showTooltip(_loc4_,oEvent.target,-30,{bXLimit:true,bYLimit:false});
         }
      }
   }
   function click(oEvent)
   {
      if((var _loc0_ = oEvent.target) === this._btnTeleport)
      {
         if(!this._bUsed)
         {
            return undefined;
         }
         this.api.network.Guild.teleportToGuildFarm(this._oItem.map);
      }
   }
   function out(oEvent)
   {
      var _loc3_ = this._mcList._parent._parent.api;
      _loc3_.ui.hideTooltip();
   }
}

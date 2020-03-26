class dofus.graphics.gapi.ui.Mount extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Mount";
   function Mount()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Mount.CLASS_NAME);
   }
   function destroy()
   {
      this.gapi.hideTooltip();
   }
   function callClose()
   {
      this.unloadThis();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.mountChanged,params:[{mount:this.api.datacenter.Player.mount}]});
   }
   function addListeners()
   {
      this._btnNameValid.addEventListener("click",this);
      this._btnName.addEventListener("click",this);
      this._btnName.addEventListener("over",this);
      this._btnName.addEventListener("out",this);
      this._btnXP.addEventListener("click",this);
      this._btnXP.addEventListener("over",this);
      this._btnXP.addEventListener("out",this);
      this._btnRide.addEventListener("click",this);
      this._btnRide.addEventListener("over",this);
      this._btnRide.addEventListener("out",this);
      this._btnInventory.addEventListener("click",this);
      this._btnInventory.addEventListener("over",this);
      this._btnInventory.addEventListener("out",this);
      this._btnAction.addEventListener("click",this);
      this._btnAction.addEventListener("over",this);
      this._btnAction.addEventListener("out",this);
      this.api.datacenter.Player.addEventListener("mountXPPercentChanged",this);
      this.api.datacenter.Player.addEventListener("mountChanged",this);
      this._btnClose.addEventListener("click",this);
   }
   function initData()
   {
      this.mountChanged();
   }
   function initTexts()
   {
      this._win.title = this.api.lang.getText("MY_MOUNT");
      this._lblName.text = this.api.lang.getText("NAME_BIG");
      this._lblPercentXP.text = this.api.lang.getText("MOUNT_PERCENT_XP");
      this._lblInventory.text = this.api.lang.getText("MOUNT_INVENTORY_2");
   }
   function editName(bEdit)
   {
      this._tiName._visible = bEdit;
      this._btnNameValid._visible = bEdit;
      this._mcTextInputBackground._visible = bEdit;
      this._lblNameValue._visible = !bEdit;
      this._btnName._visible = !bEdit;
   }
   function mountXPPercentChanged(oEvent)
   {
      this._lblPercentXPValue.text = this.api.datacenter.Player.mountXPPercent + "%";
   }
   function click(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnNameValid:
            if(this._tiName.text != "")
            {
               this.api.network.Mount.rename(this._tiName.text);
            }
            break;
         case this._btnName:
            this.editName(true);
            break;
         case this._btnXP:
            var _loc3_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:this.api.datacenter.Player.mountXPPercent,max:90});
            _loc3_.addEventListener("validate",this);
            break;
         case this._btnClose:
            this.callClose();
            break;
         case this._btnRide:
            this.api.network.Mount.ride();
            break;
         case this._btnInventory:
            this.api.network.Exchange.request(15);
            break;
         case this._btnAction:
            var _loc4_ = this.api.ui.createPopupMenu();
            var _loc5_ = this.api.datacenter.Player.mount;
            _loc4_.addStaticItem(_loc5_.name);
            _loc4_.addItem(this.api.lang.getText("MOUNT_CASTRATE_TOOLTIP"),this,this.castrateMount);
            _loc4_.addItem(this.api.lang.getText("MOUNT_KILL_TOOLTIP"),this,this.killMount);
            _loc4_.show(_root._xmouse,_root._ymouse);
      }
   }
   function castrateMount()
   {
      this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_CASTRATE_YOUR_MOUNT"),"CAUTION_YESNO",{name:"CastrateMount",listener:this});
   }
   function killMount()
   {
      this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_KILL_YOUR_MOUNT"),"CAUTION_YESNO",{name:"KillMount",listener:this});
   }
   function nameChanged(oEvent)
   {
      var _loc3_ = this.api.datacenter.Player.mount;
      this._lblNameValue.text = _loc3_.name;
      this._tiName.text = _loc3_.name;
      this.editName(false);
   }
   function mountChanged(oEvent)
   {
      var _loc3_ = this.api.datacenter.Player.mount;
      if(_loc3_ != undefined)
      {
         _loc3_.addEventListener("nameChanged",this);
         this._mvMountViewer.mount = _loc3_;
         this.mountXPPercentChanged();
         this.nameChanged();
      }
      else
      {
         this.callClose();
      }
   }
   function validate(oEvent)
   {
      var _loc3_ = oEvent.value;
      if(_global.isNaN(_loc3_))
      {
         return undefined;
      }
      if(_loc3_ > 90)
      {
         return undefined;
      }
      if(_loc3_ < 0)
      {
         return undefined;
      }
      this.api.network.Mount.setXP(_loc3_);
   }
   function over(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnName:
            this.gapi.showTooltip(this.api.lang.getText("MOUNT_RENAME_TOOLTIP"),oEvent.target,-30,{bXLimit:true,bYLimit:false});
            break;
         case this._btnInventory:
            this.gapi.showTooltip(this.api.lang.getText("MOUNT_INVENTORY_ACCES"),oEvent.target,-30,{bXLimit:true,bYLimit:false});
            break;
         case this._btnRide:
            this.gapi.showTooltip(this.api.lang.getText("MOUNT_RIDE_TOOLTIP"),oEvent.target,-30,{bXLimit:true,bYLimit:false});
            break;
         case this._btnAction:
            this.gapi.showTooltip(this.api.lang.getText("MOUNT_ACTION_TOOLTIP"),oEvent.target,-30,{bXLimit:true,bYLimit:false});
            break;
         case this._btnXP:
            this.gapi.showTooltip(this.api.lang.getText("MOUNT_XP_PERCENT_TOOLTIP"),oEvent.target,-30,{bXLimit:true,bYLimit:false});
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function yes(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "AskYesNoKillMount":
            this.api.network.Mount.kill();
            break;
         case "AskYesNoCastrateMount":
            this.api.network.Mount.castrate();
      }
   }
}

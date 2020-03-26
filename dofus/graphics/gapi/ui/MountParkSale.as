class dofus.graphics.gapi.ui.MountParkSale extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "MountParkSale";
   function MountParkSale()
   {
      super();
   }
   function __get__isMine()
   {
      return this._oMountPark.isMine(this.api);
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.MountParkSale.CLASS_NAME);
   }
   function callClose()
   {
      this.api.network.Mount.leave();
      return true;
   }
   function createChildren()
   {
      this._oMountPark = this.api.datacenter.Map.mountPark;
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.initTexts});
      this._btnCancel._visible = false;
      this._txtPrice.tabIndex = 0;
      this._txtPrice.restrict = "0-9";
      this._txtPrice.onSetFocus = function()
      {
         this._parent.onSetFocus();
      };
      this._txtPrice.onKillFocus = function()
      {
         this._parent.onKillFocus();
      };
   }
   function addListeners()
   {
      this._btnCancel.addEventListener("click",this);
      this._btnValidate.addEventListener("click",this);
      this._btnClose.addEventListener("click",this);
      this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
   }
   function initData()
   {
      this._txtDescription.text = this.api.lang.getText("MOUNTPARK_DESCRIPTION",[this._oMountPark.size,this._oMountPark.items]);
      if(this.isMine)
      {
         this._txtPrice.text = String(this._oMountPark.price == 0?this.defaultPrice:this._oMountPark.price);
         this._btnCancel._visible = this._oMountPark.price != 0;
         this._mcPrice._visible = true;
         Selection.setFocus(this._txtPrice);
      }
      else
      {
         this._txtPrice.text = String(this._oMountPark.price);
         this._txtPrice.editable = false;
         this._txtPrice.selectable = false;
         this._mcPrice._visible = false;
      }
   }
   function initTexts()
   {
      this._lblPrice.text = this.api.lang.getText("PRICE") + " :";
      if(this.isMine)
      {
         this._winBackground.title = this.api.lang.getText("MOUNTPARK_SALE");
         this._btnCancel.label = this.api.lang.getText("CANCEL_THE_SALE");
         this._btnValidate.label = this.api.lang.getText("VALIDATE");
      }
      else
      {
         this._winBackground.title = this.api.lang.getText("MOUNTPARK_PURCHASE");
         this._btnValidate.label = this.api.lang.getText("BUY");
      }
   }
   function onShortcut(sShortcut)
   {
      if(sShortcut == "ACCEPT_CURRENT_DIALOG" && eval(Selection.getFocus())._name == "_txtPrice")
      {
         this.click({target:this._btnValidate});
         return false;
      }
      return true;
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnCancel":
            if(this.isMine)
            {
               this.api.network.Mount.mountParkSell(0);
            }
            break;
         case "_btnValidate":
            if(this.isMine)
            {
               this.api.network.Mount.mountParkSell(Number(this._txtPrice.text));
            }
            else
            {
               if(this._oMountPark.price <= 0)
               {
                  return undefined;
               }
               if(this._oMountPark.price > this.api.datacenter.Player.Kama)
               {
                  this.gapi.loadUIComponent("AskOk","AskOkNotRich",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("NOT_ENOUGH_RICH")});
               }
               else
               {
                  var _loc3_ = this.gapi.loadUIComponent("AskYesNo","AskYesNoBuy",{title:this.api.lang.getText("MOUNTPARK_PURCHASE"),text:this.api.lang.getText("DO_U_BUY_MOUNTPARK",[this._oMountPark.price])});
                  _loc3_.addEventListener("yes",this);
               }
            }
            break;
         case "_btnClose":
            this.callClose();
      }
   }
   function yes()
   {
      this.api.network.Mount.mountParkBuy(this._oMountPark.price);
   }
   function onSetFocus()
   {
      getURL("FSCommand:" add "trapallkeys","false");
   }
   function onKillFocus()
   {
      getURL("FSCommand:" add "trapallkeys","true");
   }
}

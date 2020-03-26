class dofus.graphics.gapi.ui.PlayerShopModifier extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "PlayerShopModifier";
   function PlayerShopModifier()
   {
      super();
   }
   function __set__data(oData)
   {
      this._oData = oData;
      return this.__get__data();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.PlayerShopModifier.CLASS_NAME);
   }
   function callClose()
   {
      this.gapi.hideTooltip();
      this.api.network.Exchange.leave();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.initTexts});
      this.hideItemViewer(true);
      this.setAddMode(false);
      this.setModifyMode(false);
      this._txtQuantity.restrict = "0-9";
      this._txtPrice.restrict = "0-9";
      this._txtQuantity.onSetFocus = function()
      {
         this._parent.onSetFocus();
      };
      this._txtQuantity.onKillFocus = function()
      {
         this._parent.onKillFocus();
      };
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
      this._livInventory.addEventListener("selectedItem",this);
      this._livInventory2.addEventListener("selectedItem",this);
      this._btnAdd.addEventListener("click",this);
      this._btnRemove.addEventListener("click",this);
      this._btnModify.addEventListener("click",this);
      this._btnClose.addEventListener("click",this);
      this._btnOffline.addEventListener("click",this);
      this._btnOffline.addEventListener("over",this);
      this._btnOffline.addEventListener("out",this);
      if(this._oData != undefined)
      {
         this._oData.addEventListener("modelChanged",this);
      }
      else
      {
         ank.utils.Logger.err("[PlayerShop] il n\'y a pas de data");
      }
      this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
   }
   function initTexts()
   {
      this._btnAdd.label = this.api.lang.getText("PUT_ON_SELL");
      this._btnRemove.label = this.api.lang.getText("REMOVE");
      this._btnModify.label = this.api.lang.getText("MODIFY");
      this._lblQuantity.text = this.api.lang.getText("QUANTITY") + " :";
      this._lblPrice.text = this.api.lang.getText("UNIT_PRICE") + " :";
      this._winInventory.title = this.api.datacenter.Player.data.name;
      this._winInventory2.title = this.api.lang.getText("SHOP_STOCK");
   }
   function initData()
   {
      this._livInventory.dataProvider = this.api.datacenter.Player.Inventory;
      this._livInventory.kamasProvider = this.api.datacenter.Player;
      this.modelChanged();
   }
   function hideItemViewer(bHide)
   {
      this._itvItemViewer._visible = !bHide;
      this._winItemViewer._visible = !bHide;
      this._mcQuantity._visible = !bHide;
      this._mcPrice._visible = !bHide;
      this._lblQuantity._visible = !bHide;
      this._lblPrice._visible = !bHide;
      this._txtQuantity._visible = !bHide;
      this._txtPrice._visible = !bHide;
      if(bHide)
      {
         this._oSelectedItem = undefined;
      }
   }
   function setAddMode(bActive)
   {
      this._btnAdd._visible = bActive;
      this._mcSellArrow._visible = bActive;
      this._mcQuantity._visible = bActive;
      this._txtQuantity.editable = true;
      this._txtQuantity.selectable = true;
      this._txtPrice.tabIndex = 0;
      this._txtQuantity.tabIndex = 1;
      this._oDefaultButton = this._btnAdd;
   }
   function setModifyMode(bActive)
   {
      this._btnRemove._visible = bActive;
      this._btnModify._visible = bActive;
      this._mcBuyArrow._visible = bActive;
      this._mcQuantity._visible = false;
      this._txtQuantity.editable = false;
      this._txtQuantity.selectable = false;
      this._txtPrice.tabIndex = 0;
      this._txtQuantity.tabIndex = undefined;
      this._oDefaultButton = this._btnModify;
   }
   function addToShop(oItem, nQuantity, nPrice)
   {
      this.api.network.Exchange.movementItem(true,oItem.ID,nQuantity,nPrice);
   }
   function remove(oItem)
   {
      this.api.network.Exchange.movementItem(false,oItem.ID,oItem.Quantity);
   }
   function modify(oItem, nPrice)
   {
      this.api.network.Exchange.movementItem(true,oItem.ID,0,nPrice);
   }
   function onShortcut(sShortcut)
   {
      if(sShortcut == "ACCEPT_CURRENT_DIALOG" && this._oSelectedItem != undefined)
      {
         this.click({target:this._oDefaultButton});
         return false;
      }
      return true;
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnRemove":
            this.remove(this._oSelectedItem);
            this.hideItemViewer(true);
            this.setModifyMode(false);
            break;
         case "_btnModify":
            var _loc3_ = Number(this._txtPrice.text);
            if(_global.isNaN(_loc3_))
            {
               this.gapi.loadUIComponent("AskOk","AksOkBadPrice",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_PRICE")});
            }
            else
            {
               this.modify(this._oSelectedItem,_loc3_);
               this.hideItemViewer(true);
               this.setModifyMode(false);
            }
            break;
         case "_btnAdd":
            var _loc4_ = Number(this._txtPrice.text);
            var _loc5_ = Number(this._txtQuantity.text);
            if(_global.isNaN(_loc4_))
            {
               this.gapi.loadUIComponent("AskOk","AksOkBadPrice",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_PRICE")});
            }
            else if(_global.isNaN(_loc5_) || _loc5_ == 0)
            {
               this.gapi.loadUIComponent("AskOk","AksOkBadQuantity",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_QUANTITY")});
            }
            else
            {
               _loc5_ = Math.min(this._oSelectedItem.Quantity,_loc5_);
               this.addToShop(this._oSelectedItem,_loc5_,_loc4_);
               this.hideItemViewer(true);
               this.setAddMode(false);
            }
            break;
         case "_btnClose":
            this.callClose();
            break;
         case "_btnOffline":
            this.callClose();
            this.api.kernel.GameManager.offlineExchange();
      }
   }
   function over(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "_btnOffline")
      {
         this.gapi.showTooltip(this.api.lang.getText("MERCHANT_MODE"),oEvent.target,-20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function selectedItem(oEvent)
   {
      if(oEvent.item == undefined)
      {
         this.hideItemViewer(true);
         this.setAddMode(false);
         this.setModifyMode(false);
      }
      else
      {
         this._oSelectedItem = oEvent.item;
         this.hideItemViewer(false);
         this._itvItemViewer.itemData = oEvent.item;
         switch(oEvent.target._name)
         {
            case "_livInventory":
               this._txtQuantity.text = oEvent.item.Quantity;
               this._txtPrice.text = "";
               this.setModifyMode(false);
               this.setAddMode(true);
               this._livInventory2.setFilter(this._livInventory.currentFilterID);
               break;
            case "_livInventory2":
               this._txtQuantity.text = oEvent.item.Quantity;
               this._txtPrice.text = oEvent.item.price;
               this.setAddMode(false);
               this.setModifyMode(true);
               this._livInventory.setFilter(this._livInventory2.currentFilterID);
         }
         Selection.setFocus(this._txtPrice);
      }
   }
   function modelChanged(oEvent)
   {
      this._livInventory2.dataProvider = this._oData.inventory;
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

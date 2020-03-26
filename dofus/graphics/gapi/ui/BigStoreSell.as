class dofus.graphics.gapi.ui.BigStoreSell extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "BigStoreSell";
   function BigStoreSell()
   {
      super();
   }
   function __set__data(oData)
   {
      this._oData = oData;
      return this.__get__data();
   }
   function setMiddlePrice(nUnicID, nPrice)
   {
      if(this._itvItemViewer.itemData.unicID == nUnicID && this._itvItemViewer.itemData != undefined)
      {
         this._lblMiddlePrice.text = this.api.lang.getText("BIGSTORE_MIDDLEPRICE",[nPrice]);
      }
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.BigStoreSell.CLASS_NAME);
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
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.populateComboBox});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.setAddMode,params:[false]});
      this.addToQueue({object:this,method:this.setRemoveMode,params:[false]});
      this.hideItemViewer(true);
   }
   function addListeners()
   {
      this._livInventory.addEventListener("selectedItem",this);
      this._livInventory2.addEventListener("selectedItem",this);
      this._btnAdd.addEventListener("click",this);
      this._btnRemove.addEventListener("click",this);
      this._btnClose.addEventListener("click",this);
      this._btnSwitchToBuy.addEventListener("click",this);
      this._btnTypes.addEventListener("over",this);
      this._btnTypes.addEventListener("out",this);
      this._btnFilterSell.addEventListener("click",this);
      this._btnFilterSell.addEventListener("over",this);
      this._btnFilterSell.addEventListener("out",this);
      this._tiPrice.addEventListener("change",this);
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
      this._btnSwitchToBuy.label = this.api.lang.getText("BIGSTORE_MODE_BUY");
      this._lblQuantity.text = this.api.lang.getText("SET_QUANTITY") + " :";
      this._lblPrice.text = this.api.lang.getText("SET_PRICE") + " :";
      this._lblFilterSell.text = this.api.lang.getText("BIGSTORE_FILTER");
      this._winInventory.title = this.api.datacenter.Player.data.name;
      this._winInventory2.title = this.api.lang.getText("SHOP_STOCK");
   }
   function populateComboBox(nQuantity)
   {
      var _loc3_ = new ank.utils.ExtendedArray();
      if(nQuantity >= this._oData.quantity1)
      {
         _loc3_.push({label:"x" + this._oData.quantity1,index:1});
      }
      if(nQuantity >= this._oData.quantity2)
      {
         _loc3_.push({label:"x" + this._oData.quantity2,index:2});
      }
      if(nQuantity >= this._oData.quantity3)
      {
         _loc3_.push({label:"x" + this._oData.quantity3,index:3});
      }
      this._cbQuantity.dataProvider = _loc3_;
   }
   function initData()
   {
      this.enableFilter(this.api.kernel.OptionsManager.getOption("BigStoreSellFilter"));
      this._livInventory.dataProvider = this.api.datacenter.Player.Inventory;
      this._livInventory.kamasProvider = this.api.datacenter.Player;
      this.modelChanged();
   }
   function enableFilter(bEnable)
   {
      if(bEnable)
      {
         var _loc3_ = new Array();
         for(var i in this._oData.typesObj)
         {
            _loc3_.push(i);
         }
         this._livInventory.customInventoryFilter = new dofus.graphics.gapi.ui.bigstore.BigStoreSellFilter(Number(this._oData.maxLevel),_loc3_);
      }
      else
      {
         this._livInventory.customInventoryFilter = null;
      }
      this._btnFilterSell.selected = bEnable;
      this.api.kernel.OptionsManager.setOption("BigStoreSellFilter",bEnable);
   }
   function hideItemViewer(bHide)
   {
      this._itvItemViewer._visible = !bHide;
      this._winItemViewer._visible = !bHide;
      this._mcItemViewerDescriptionBack._visible = !bHide;
      this._srBottom._visible = !bHide;
      this._mcPrice._visible = !bHide;
      this._mcKamaSymbol._visible = !bHide;
      this._lblQuantity._visible = !bHide;
      this._lblQuantityValue._visible = !bHide;
      this._lblPrice._visible = !bHide;
      this._lblTaxTime._visible = !bHide;
      this._lblTaxTimeValue._visible = !bHide;
      this._cbQuantity._visible = !bHide;
      this._tiPrice._visible = !bHide;
      this._mcMiddlePrice._visible = !bHide;
      this._lblMiddlePrice._visible = !bHide;
      if(bHide)
      {
         this._oSelectedItem = undefined;
      }
   }
   function setAddMode(bActive)
   {
      this._btnAdd._visible = bActive;
      this._mcSellArrow._visible = bActive;
      this._mcPrice._visible = bActive;
      this._cbQuantity._visible = bActive;
      this._lblQuantityValue._visible = false;
      this._tiPrice.tabIndex = 0;
      this._tiPrice.enabled = bActive;
      this._oDefaultButton = this._btnAdd;
      this._mcKamaSymbol._visible = bActive;
      this._lblTaxTime.text = this.api.lang.getText("BIGSTORE_TAX") + " :";
      if(this._lblTaxTimeValue.text != undefined)
      {
         this._lblTaxTimeValue.text = "";
      }
      if(this._txtBadType.text != undefined)
      {
         this._txtBadType.text = "";
      }
      this._lblTaxTime._visible = bActive;
      this._lblQuantity._visible = bActive;
      this._lblPrice._visible = bActive;
      this._srBottom._visible = bActive;
      this._lblTaxTimeValue._visible = bActive;
      this._tiPrice._visible = bActive;
   }
   function setRemoveMode(bActive)
   {
      this._btnRemove._visible = bActive;
      this._mcBuyArrow._visible = bActive;
      this._mcPrice._visible = false;
      this._cbQuantity._visible = false;
      this._lblQuantityValue._visible = bActive;
      this._tiPrice.tabIndex = 0;
      this._tiPrice.enabled = !bActive;
      this._oDefaultButton = this._btnRemove;
      this._mcKamaSymbol._visible = false;
      this._lblTaxTime.text = this.api.lang.getText("BIGSTORE_TIME") + " :";
      if(this._lblTaxTimeValue.text != undefined)
      {
         this._lblTaxTimeValue.text = "";
      }
      if(this._txtBadType.text != undefined)
      {
         this._txtBadType.text = "";
      }
      this._lblTaxTime._visible = bActive;
      this._lblQuantity._visible = bActive;
      this._lblPrice._visible = bActive;
      this._srBottom._visible = bActive;
      this._lblTaxTimeValue._visible = bActive;
      this._tiPrice._visible = bActive;
   }
   function setBadItemMode(sMessage)
   {
      this._btnRemove._visible = false;
      this._mcBuyArrow._visible = false;
      this._mcPrice._visible = false;
      this._cbQuantity._visible = false;
      this._lblQuantityValue._visible = false;
      this._tiPrice.tabIndex = 0;
      this._tiPrice.enabled = false;
      this._oDefaultButton = undefined;
      this._mcKamaSymbol._visible = false;
      this._txtBadType.text = sMessage;
      this._lblTaxTime._visible = false;
      this._lblQuantity._visible = false;
      this._lblPrice._visible = false;
      this._srBottom._visible = false;
      this._lblTaxTimeValue._visible = false;
      this._tiPrice._visible = false;
   }
   function remove(oItem)
   {
      this.api.network.Exchange.movementItem(false,oItem.ID,oItem.Quantity);
   }
   function calculateTax()
   {
      if(this._oData.tax == 0)
      {
         this._lblTaxTimeValue.text = "0";
         return undefined;
      }
      var _loc2_ = Number(this._tiPrice.text);
      var _loc3_ = Math.max(1,Math.round(_loc2_ * this._oData.tax / 100));
      this._lblTaxTimeValue.text = String(!_global.isNaN(_loc3_)?_loc3_:0);
   }
   function updateItemCount()
   {
      this._winInventory2.title = this.api.lang.getText("SHOP_STOCK") + " (" + this._oData.inventory.length + "/" + this._oData.maxItemCount + ")";
   }
   function askSell(oItem, nQuantityIndex, nPrice)
   {
      var _loc5_ = this._oData["quantity" + nQuantityIndex];
      var _loc6_ = this.gapi.loadUIComponent("AskYesNo","AskYesNoSell",{title:this.api.lang.getText("BIGSTORE"),text:this.api.lang.getText("DO_U_SELL_ITEM_BIGSTORE",["x" + _loc5_ + " " + oItem.name,nPrice]),params:{itemID:oItem.ID,itemQuantity:oItem.Quantity,quantity:_loc5_,quantityIndex:nQuantityIndex,price:nPrice}});
      _loc6_.addEventListener("yes",this);
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
            this.setRemoveMode(false);
            break;
         case "_btnAdd":
            var _loc3_ = Number(this._tiPrice.text);
            var _loc4_ = Number(this._cbQuantity.selectedItem.index);
            if(_global.isNaN(_loc3_) || _loc3_ == 0)
            {
               this.gapi.loadUIComponent("AskOk","AksOkBadPrice",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_PRICE")});
            }
            else if(_global.isNaN(_loc4_) || _loc4_ == 0)
            {
               this.gapi.loadUIComponent("AskOk","AksOkBadQuantity",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_QUANTITY")});
            }
            else
            {
               this.askSell(this._oSelectedItem,_loc4_,_loc3_);
            }
            break;
         case "_btnClose":
            this.callClose();
            break;
         case "_btnSwitchToBuy":
            this.api.network.Exchange.request(11,this._oData.npcID);
            break;
         case "_btnFilterSell":
            this.enableFilter(this._btnFilterSell.selected);
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnTypes:
            var _loc3_ = this.api.lang.getText("BIGSTORE_MAX_LEVEL") + " : " + this._oData.maxLevel;
            _loc3_ = _loc3_ + ("\n" + this.api.lang.getText("BIGSTORE_TAX") + " : " + this._oData.tax + "%");
            _loc3_ = _loc3_ + ("\n" + this.api.lang.getText("BIGSTORE_MAX_ITEM_PER_ACCOUNT") + " : " + this._oData.maxItemCount);
            _loc3_ = _loc3_ + ("\n" + this.api.lang.getText("BIGSTORE_MAX_SELL_TIME") + " : " + this._oData.maxSellTime + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",this._oData.maxSellTime < 2));
            _loc3_ = _loc3_ + ("\n\n" + this.api.lang.getText("BIGSTORE_TYPES") + " :");
            var _loc4_ = this._oData.types;
            for(var k in _loc4_)
            {
               _loc3_ = _loc3_ + ("\n - " + this.api.lang.getItemTypeText(_loc4_[k]).n);
            }
            this.gapi.showTooltip(_loc3_,oEvent.target,20);
            break;
         case this._btnFilterSell:
            this.gapi.showTooltip(this.api.lang.getText("BIGSTORE_SELL_FILTER_OVER"),oEvent.target,20);
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
         this.setRemoveMode(false);
      }
      else
      {
         this._oSelectedItem = oEvent.item;
         this.hideItemViewer(false);
         this._itvItemViewer.itemData = oEvent.item;
         this.populateComboBox(oEvent.item.Quantity);
         var _loc3_ = oEvent.item.type;
         if(this._lblMiddlePrice.text != undefined)
         {
            this._lblMiddlePrice.text = "";
         }
         if(!this._oData.typesObj[_loc3_])
         {
            this.setAddMode(false);
            this.setRemoveMode(false);
            this.setBadItemMode(this.api.lang.getText("BIGSTORE_BAD_TYPE"));
         }
         else if(oEvent.item.level > this._oData.maxLevel)
         {
            this.setAddMode(false);
            this.setRemoveMode(false);
            this.setBadItemMode(this.api.lang.getText("BIGSTORE_BAD_LEVEL"));
         }
         else
         {
            switch(oEvent.target._name)
            {
               case "_livInventory":
                  if(this._nQuantityIndex != undefined && this._cbQuantity.dataProvider.length >= this._nQuantityIndex)
                  {
                     this._cbQuantity.selectedIndex = this._nQuantityIndex - 1;
                  }
                  else
                  {
                     this._nQuantityIndex = undefined;
                     this._cbQuantity.selectedIndex = 0;
                  }
                  this.setRemoveMode(false);
                  this.setAddMode(true);
                  if(this._tiPrice.text != undefined)
                  {
                     if(!_global.isNaN(this._nLastPrice))
                     {
                        this._tiPrice.text = String(this._nLastPrice);
                     }
                     else
                     {
                        this._tiPrice.text = "";
                     }
                  }
                  this._livInventory2.setFilter(this._livInventory.currentFilterID);
                  this._tiPrice.setFocus();
                  break;
               case "_livInventory2":
                  this._lblQuantityValue.text = "x" + String(oEvent.item.Quantity);
                  this.setAddMode(false);
                  this.setRemoveMode(true);
                  this._tiPrice.text = oEvent.item.price;
                  this._livInventory.setFilter(this._livInventory2.currentFilterID);
                  this._lblTaxTimeValue.text = oEvent.item.remainingHours + "h";
            }
            this.api.network.Exchange.getItemMiddlePriceInBigStore(oEvent.item.unicID);
         }
      }
   }
   function modelChanged(oEvent)
   {
      this._livInventory2.dataProvider = this._oData.inventory;
      this.updateItemCount();
   }
   function change(oEvent)
   {
      if(this._btnAdd._visible)
      {
         this._nLastPrice = Number(this._tiPrice.text);
         this.calculateTax();
      }
   }
   function yes(oEvent)
   {
      this._nQuantityIndex = oEvent.target.params.quantityIndex;
      this.api.network.Exchange.movementItem(true,oEvent.target.params.itemID,oEvent.target.params.quantityIndex,oEvent.target.params.price);
      if(oEvent.target.params.itemQuantity - oEvent.target.params.quantity < oEvent.target.params.quantity)
      {
         this.setAddMode(false);
         this.hideItemViewer(true);
      }
      else
      {
         this.populateComboBox(oEvent.target.params.itemQuantity - oEvent.target.params.quantity);
      }
   }
}

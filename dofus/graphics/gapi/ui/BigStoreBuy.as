class dofus.graphics.gapi.ui.BigStoreBuy extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "BigStoreBuy";
   var _sDefaultSearch = "";
   function BigStoreBuy()
   {
      super();
   }
   function __set__data(oData)
   {
      this._oData = oData;
      return this.__get__data();
   }
   function __set__defaultSearch(sText)
   {
      this._sDefaultSearch = sText;
      return this.__get__defaultSearch();
   }
   function applyFullSoulFilter(eaPrices)
   {
      if(this._sFullSoulMonster == "")
      {
         this._dgPrices.dataProvider = eaPrices;
         return undefined;
      }
      var _loc3_ = new ank.utils.ExtendedArray();
      var _loc4_ = this._sFullSoulMonster.toUpperCase();
      var _loc5_ = 0;
      while(_loc5_ < eaPrices.length)
      {
         var _loc6_ = eaPrices[_loc5_];
         var _loc7_ = _loc6_.item;
         for(var j in _loc7_._aEffects)
         {
            var _loc8_ = _loc7_._aEffects[j];
            if(_loc8_[0] == 623)
            {
               var _loc9_ = _loc8_[3];
               var _loc10_ = this.api.lang.getMonstersText(_loc9_).n.toUpperCase();
               if(_loc10_.indexOf(_loc4_) != -1)
               {
                  _loc3_.push(_loc6_);
                  break;
               }
            }
         }
         _loc5_ = _loc5_ + 1;
      }
      this._dgPrices.dataProvider = _loc3_;
   }
   function setButtons(btnPrice, btnBuy)
   {
      this._btnSelectedPrice.selected = false;
      this._btnSelectedPrice = btnPrice;
      this._btnSelectedBuy.enabled = false;
      this._btnSelectedBuy = btnBuy;
   }
   function selectPrice(oItem, nQuantityIndex, btnPrice, btnBuy)
   {
      if(btnPrice != this._btnSelectedPrice)
      {
         this._nSelectedPriceItemID = oItem.id;
         this._nSelectedPriceIndex = nQuantityIndex;
         this.setButtons(btnPrice,btnBuy);
      }
      else
      {
         delete this._nSelectedPriceItemID;
         delete this._nSelectedPriceIndex;
         delete this._btnSelectedPrice;
         delete this._btnSelectedBuy;
      }
   }
   function isThisPriceSelected(nItemID, nQuantityIndex)
   {
      return nItemID == this._nSelectedPriceItemID && this._nSelectedPriceIndex == nQuantityIndex;
   }
   function askBuy(oItem, nQuantityIndex, nPrice)
   {
      if(oItem != undefined && (nQuantityIndex != undefined && !_global.isNaN(nPrice)))
      {
         if(nPrice > this.api.datacenter.Player.Kama)
         {
            this.gapi.loadUIComponent("AskOk","AskOkNotRich",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("NOT_ENOUGH_RICH")});
         }
         else
         {
            var _loc5_ = this.gapi.loadUIComponent("AskYesNo","AskYesNoBuy",{title:this.api.lang.getText("BIGSTORE"),text:this.api.lang.getText("DO_U_BUY_ITEM_BIGSTORE",["x" + this._oData["quantity" + nQuantityIndex] + " " + oItem.name,nPrice]),params:{id:oItem.ID,quantityIndex:nQuantityIndex,price:nPrice}});
            _loc5_.addEventListener("yes",this);
         }
      }
   }
   function setType(nType)
   {
      var _loc3_ = this._oData.types;
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         if(_loc3_[_loc4_] == nType)
         {
            this._cbTypes.selectedIndex = _loc4_;
            return undefined;
         }
         _loc4_ = _loc4_ + 1;
      }
   }
   function setItem(nUnicID)
   {
      var _loc3_ = this._oData.inventory;
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         if(_loc3_[_loc4_].unicID == nUnicID)
         {
            if(this._lstItems.selectedIndex != _loc4_)
            {
               this._lstItems.selectedIndex = _loc4_;
               this._lstItems.setVPosition(_loc4_);
            }
            break;
         }
         _loc4_ = _loc4_ + 1;
      }
      this.updateItem(new dofus.datacenter.Item(0,nUnicID),true);
   }
   function askMiddlePrice(oItem)
   {
      this.api.network.Exchange.getItemMiddlePriceInBigStore(oItem.unicID);
   }
   function setMiddlePrice(nUnicID, nPrice)
   {
      if(this._oCurrentItem.unicID == nUnicID && this._oCurrentItem != undefined)
      {
         this._lblPrices.text = this.api.lang.getText("BIGSTORE_MIDDLEPRICE",[nPrice]);
      }
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.BigStoreBuy.CLASS_NAME);
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
      this.addToQueue({object:this,method:this.setQuantityHeader});
      this.addToQueue({object:this,method:this.updateData});
      this.hideItemViewer(true);
      this.addToQueue({object:this,method:this.showHelpSelectType,params:[true]});
      this.showArrowAnim(false);
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnClose2.addEventListener("click",this);
      this._btnSearch.addEventListener("click",this);
      this._btnTypes.addEventListener("over",this);
      this._btnTypes.addEventListener("out",this);
      this._btnSwitchToSell.addEventListener("click",this);
      this._cbTypes.addEventListener("itemSelected",this);
      this._lstItems.addEventListener("itemSelected",this);
      this._dgPrices.addEventListener("itemSelected",this);
      if(this._oData != undefined)
      {
         this._oData.addEventListener("modelChanged",this);
         this._oData.addEventListener("modelChanged2",this);
      }
      else
      {
         ank.utils.Logger.err("[BigStoreBuy] il n\'y a pas de data");
      }
      this.api.datacenter.Player.addEventListener("kamaChanged",this);
   }
   function initTexts()
   {
      this._winBackground.title = this.api.lang.getText("BIGSTORE") + (this._oData != undefined?" (" + this.api.lang.getText("BIGSTORE_MAX_LEVEL") + " : " + this._oData.maxLevel + ")":"");
      this._lblItems.text = this.api.lang.getText("BIGSTORE_ITEM_LIST");
      this._lblTypes.text = this.api.lang.getText("ITEM_TYPE");
      this._lblKamas.text = this.api.lang.getText("WALLET") + " :";
      this._btnClose2.label = this.api.lang.getText("CLOSE");
      this._btnSearch.label = this.api.lang.getText("SEARCH");
      this._btnSwitchToSell.label = this.api.lang.getText("BIGSTORE_MODE_SELL");
   }
   function updateData()
   {
      this.modelChanged();
      this.modelChanged2();
      this.kamaChanged({value:this.api.datacenter.Player.Kama});
   }
   function populateComboBox()
   {
      var _loc2_ = this._oData.types;
      var _loc3_ = new ank.utils.ExtendedArray();
      var _loc4_ = 0;
      while(_loc4_ < _loc2_.length)
      {
         var _loc5_ = Number(_loc2_[_loc4_]);
         _loc3_.push({label:this.api.lang.getItemTypeText(_loc5_).n,id:_loc5_});
         _loc4_ = _loc4_ + 1;
      }
      _loc3_.sortOn("label");
      this._oData.types = new Array();
      var _loc6_ = 0;
      while(_loc6_ < _loc2_.length)
      {
         this._oData.types.push(_loc3_[_loc6_].id);
         _loc6_ = _loc6_ + 1;
      }
      this._cbTypes.dataProvider = _loc3_;
   }
   function setQuantityHeader()
   {
      this._dgPrices.columnsNames = ["","x" + this._oData.quantity1,"x" + this._oData.quantity2,"x" + this._oData.quantity3];
   }
   function hideItemViewer(bHide)
   {
      this._itvItemViewer._visible = !bHide;
      this._mcItemViewerDescriptionBack._visible = !bHide;
      this._mcSpacer._visible = !bHide;
      if(!bHide)
      {
         this.showHelpSelectType(false);
         this.showHelpSelectPrice(false);
         this.showHelpSelectPrice(false);
      }
   }
   function updateType(nTypeID)
   {
      this._lstItems.selectedIndex = -1;
      this.updateItem();
      this.showHelpSelectItem(true);
      this.api.network.Exchange.bigStoreType(nTypeID);
   }
   function updateItem(oItem, bDoNotTouchList)
   {
      this._oCurrentItem = oItem;
      this.hideItemViewer(true);
      this.showHelpSelectPrice(true);
      this._dgPrices.selectedIndex = -1;
      delete this._nSelectedPriceItemID;
      delete this._nSelectedPriceIndex;
      delete this._btnSelectedPrice;
      delete this._btnSelectedBuy;
      if(bDoNotTouchList != true)
      {
         if(oItem != undefined)
         {
            this.api.network.Exchange.bigStoreItemList(oItem.unicID);
         }
         else
         {
            this._dgPrices.dataProvider = new ank.utils.ExtendedArray();
         }
         this._bFullSoul = oItem.type == 85;
         this._sFullSoulMonster = "";
      }
   }
   function showHelpSelectType(bShow)
   {
      this._mcBottomArrow._visible = false;
      this._mcBottomArrow.stop();
      this._mcLeftArrow._visible = bShow;
      this._mcLeftArrow.play();
      this._mcLeft2Arrow._visible = false;
      this._mcLeft2Arrow.stop();
      this._lblNoItem.text = !bShow?"":this.api.lang.getText("BIGSTORE_HELP_SELECT_TYPE");
   }
   function showHelpSelectPrice(bShow)
   {
      this._mcBottomArrow._visible = bShow;
      this._mcBottomArrow.play();
      this._mcLeftArrow._visible = false;
      this._mcLeftArrow.stop();
      this._mcLeft2Arrow._visible = false;
      this._mcLeft2Arrow.stop();
      this._lblNoItem.text = !bShow?"":this.api.lang.getText("BIGSTORE_HELP_SELECT_PRICE");
   }
   function showHelpSelectItem(bShow)
   {
      this._mcBottomArrow._visible = false;
      this._mcBottomArrow.stop();
      this._mcLeftArrow._visible = false;
      this._mcLeftArrow.stop();
      this._mcLeft2Arrow._visible = bShow;
      this._mcLeft2Arrow.play();
      this._lblNoItem.text = !bShow?"":this.api.lang.getText("BIGSTORE_HELP_SELECT_ITEM");
   }
   function showArrowAnim(bShow)
   {
      if(bShow)
      {
         this._mcArrowAnim._visible = true;
         this._mcArrowAnim.play();
         ank.utils.Timer.setTimer(this,"bigstore",this,this.showArrowAnim,800,[false]);
      }
      else
      {
         this._mcArrowAnim._visible = false;
         this._mcArrowAnim.stop();
      }
   }
   function onSearchResult(bSuccess)
   {
      if(bSuccess)
      {
         this.api.ui.unloadUIComponent("BigStoreSearch");
      }
      else
      {
         this.api.kernel.showMessage(this.api.lang.getText("BIGSTORE"),this.api.lang.getText("ITEM_NOT_IN_BIGSTORE"),"ERROR_BOX");
      }
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClose":
         case "_btnClose2":
            this.callClose();
            break;
         case "_btnSearch":
            if(this._bFullSoul)
            {
               this.api.ui.loadUIComponent("BigStoreSearchFullSoul","BigStoreSearchFullSoul",{oParent:this});
            }
            else
            {
               this.api.ui.loadUIComponent("BigStoreSearch","BigStoreSearch",{types:this._oData.types,defaultSearch:this._sDefaultSearch,oParent:this});
            }
            break;
         case "_btnSwitchToSell":
            this.api.network.Exchange.request(10,this._oData.npcID);
      }
   }
   function itemSelected(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_cbTypes":
            this.updateType(this._cbTypes.selectedItem.id);
            break;
         case "_lstItems":
            if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && oEvent.row.item != undefined)
            {
               this.api.kernel.GameManager.insertItemInChat(oEvent.row.item);
               return undefined;
            }
            if(this._lblPrices.text != undefined)
            {
               this._lblPrices.text = "";
            }
            this.askMiddlePrice(oEvent.row.item);
            this.updateItem(oEvent.row.item);
            break;
         case "_dgPrices":
            if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && oEvent.row.item.item != undefined)
            {
               this.api.kernel.GameManager.insertItemInChat(oEvent.row.item.item);
               return undefined;
            }
            this._itvItemViewer.itemData = oEvent.row.item.item;
            this.hideItemViewer(false);
            this.showArrowAnim(true);
            break;
      }
   }
   function modelChanged(oEvent)
   {
      var _loc3_ = this._oData.inventory;
      _loc3_.bubbleSortOn("level",Array.DESCENDING);
      _loc3_.reverse();
      this._lstItems.dataProvider = _loc3_;
      if(_loc3_ != 0 && _loc3_ != undefined)
      {
         this._lblItemsCount.text = _loc3_.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"),"m",_loc3_.length < 2);
      }
      else
      {
         this._lblItemsCount.text = this.api.lang.getText("NO_BIGSTORE_RESULT");
      }
   }
   function fullSoulItemsMovement()
   {
      if(this._bFullSoul && this._sFullSoulMonster != "")
      {
         this.modelChanged2();
      }
   }
   function modelChanged2(oEvent)
   {
      var _loc3_ = oEvent.eventName != "updateOne"?null:this._nSelectedPriceItemID;
      var _loc4_ = oEvent.eventName != "updateOne"?null:this._nSelectedPriceIndex;
      delete this._nSelectedPriceItemID;
      delete this._nSelectedPriceIndex;
      delete this._btnSelectedPrice;
      delete this._btnSelectedBuy;
      this._btnSelectedPrice.selected = false;
      this._btnSelectedBuy.enabled = false;
      if(_loc3_ != undefined)
      {
         var _loc5_ = this._oData.inventory2;
         var _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(_loc5_[_loc6_].id == _loc3_)
            {
               this._nSelectedPriceItemID = _loc3_;
               this._nSelectedPriceIndex = _loc4_;
               break;
            }
            _loc6_ = _loc6_ + 1;
         }
      }
      if(this._nSelectedPriceItemID == undefined)
      {
         this.hideItemViewer(true);
      }
      var _loc7_ = this._oData.inventory2;
      _loc7_.bubbleSortOn("priceSet1",Array.DESCENDING);
      _loc7_.reverse();
      if(this._bFullSoul)
      {
         this.applyFullSoulFilter(_loc7_);
      }
      else
      {
         this._dgPrices.dataProvider = _loc7_;
      }
   }
   function yes(oEvent)
   {
      this.api.network.Exchange.bigStoreBuy(oEvent.target.params.id,oEvent.target.params.quantityIndex,oEvent.target.params.price);
      this.hideItemViewer(true);
      this.showHelpSelectPrice(true);
   }
   function kamaChanged(oEvent)
   {
      this._lblKamasValue.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
   }
   function over(oEvent)
   {
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
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}

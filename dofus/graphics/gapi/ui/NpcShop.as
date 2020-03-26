class dofus.graphics.gapi.ui.NpcShop extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "NpcShop";
   function NpcShop()
   {
      super();
   }
   function __set__data(oData)
   {
      this._oData = oData;
      return this.__get__data();
   }
   function __set__colors(aColors)
   {
      this._colors = aColors;
      return this.__get__colors();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.NpcShop.CLASS_NAME);
   }
   function callClose()
   {
      this.api.network.Exchange.leave();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.initTexts});
      this.hideItemViewer(true);
      this.setSellMode(false);
      this.setBuyMode(false);
      this.gapi.unloadLastUIAutoHideComponent();
   }
   function addListeners()
   {
      this._livInventory.addEventListener("selectedItem",this);
      this._livInventory2.addEventListener("selectedItem",this);
      this._btnSell.addEventListener("click",this);
      this._btnBuy.addEventListener("click",this);
      this._btnClose.addEventListener("click",this);
      this._ldrArtwork.addEventListener("complete",this);
      if(this._oData != undefined)
      {
         this._oData.addEventListener("modelChanged",this);
      }
      else
      {
         ank.utils.Logger.err("[NpcShop] il n\'y a pas de data");
      }
   }
   function initTexts()
   {
      this._btnSell.label = this.api.lang.getText("SELL");
      this._btnBuy.label = this.api.lang.getText("BUY");
      this._winInventory.title = this.api.datacenter.Player.data.name;
      this._winInventory2.title = this._oData.name;
   }
   function initData()
   {
      this._livInventory.dataProvider = this.api.datacenter.Player.Inventory;
      this._livInventory.kamasProvider = this.api.datacenter.Player;
      this._ldrArtwork.contentPath = dofus.Constants.ARTWORKS_BIG_PATH + this._oData.gfx + ".swf";
      this.modelChanged();
   }
   function hideItemViewer(bHide)
   {
      this._itvItemViewer._visible = !bHide;
      this._winItemViewer._visible = !bHide;
      if(bHide)
      {
         this._oSelectedItem = undefined;
      }
   }
   function setSellMode(bActive)
   {
      this._btnSell._visible = bActive;
      this._mcSellArrow._visible = bActive;
   }
   function setBuyMode(bActive)
   {
      this._btnBuy._visible = bActive;
      this._mcBuyArrow._visible = bActive;
   }
   function askQuantity(sType, nQty, nPrice, nWeight)
   {
      var _loc6_ = 0;
      if(sType == "buy")
      {
         _loc6_ = Math.floor(this.api.datacenter.Player.Kama / nPrice);
         if(nWeight != undefined)
         {
            var _loc7_ = this.api.datacenter.Player.maxWeight - this.api.datacenter.Player.currentWeight;
            var _loc8_ = Math.floor(_loc7_ / nWeight);
            if(_loc6_ > _loc8_)
            {
               _loc6_ = _loc8_;
            }
         }
      }
      else
      {
         _loc6_ = nQty;
      }
      var _loc9_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:_loc6_,min:1,params:{type:sType}});
      _loc9_.addEventListener("validate",this);
   }
   function validateBuy(nQuantity)
   {
      if(nQuantity <= 0)
      {
         return undefined;
      }
      if(this.api.datacenter.Player.Kama < this._oSelectedItem.price * nQuantity)
      {
         this.gapi.loadUIComponent("AskOk","AskOkRich",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("NOT_ENOUGH_RICH")});
         return undefined;
      }
      this.api.network.Exchange.buy(this._oSelectedItem.unicID,nQuantity);
   }
   function validateSell(nQuantity)
   {
      if(nQuantity <= 0)
      {
         return undefined;
      }
      if(nQuantity > this._oSelectedItem.Quantity)
      {
         nQuantity = this._oSelectedItem.Quantity;
      }
      this.api.network.Exchange.sell(this._oSelectedItem.ID,nQuantity);
      this.hideItemViewer(true);
      this.setSellMode(false);
      this.setBuyMode(false);
   }
   function applyColor(mc, zone)
   {
      var _loc4_ = this._colors[zone];
      if(_loc4_ == -1 || _loc4_ == undefined)
      {
         return undefined;
      }
      var _loc5_ = (_loc4_ & 16711680) >> 16;
      var _loc6_ = (_loc4_ & 65280) >> 8;
      var _loc7_ = _loc4_ & 255;
      var _loc8_ = new Color(mc);
      var _loc9_ = new Object();
      _loc9_ = {ra:0,ga:0,ba:0,rb:_loc5_,gb:_loc6_,bb:_loc7_};
      _loc8_.setTransform(_loc9_);
   }
   function modelChanged(oEvent)
   {
      this._livInventory2.dataProvider = this._oData.inventory;
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnBuy":
            this.askQuantity("buy",1,this._oSelectedItem.price,this._oSelectedItem.weight);
            break;
         case "_btnSell":
            if(this._oSelectedItem.Quantity > 1)
            {
               this.askQuantity("sell",this._oSelectedItem.Quantity);
            }
            else
            {
               this.validateSell(1);
            }
            break;
         case "_btnClose":
            this.callClose();
      }
   }
   function selectedItem(oEvent)
   {
      if(oEvent.item == undefined)
      {
         this.hideItemViewer(true);
         this.setSellMode(false);
         this.setBuyMode(false);
      }
      else
      {
         this._oSelectedItem = oEvent.item;
         this.hideItemViewer(false);
         this._itvItemViewer.itemData = oEvent.item;
         switch(oEvent.target._name)
         {
            case "_livInventory":
               this.setSellMode(true);
               this.setBuyMode(false);
               this._livInventory2.setFilter(this._livInventory.currentFilterID);
               break;
            case "_livInventory2":
               this.setSellMode(false);
               this.setBuyMode(true);
               this._livInventory.setFilter(this._livInventory2.currentFilterID);
         }
      }
   }
   function validate(oEvent)
   {
      switch(oEvent.params.type)
      {
         case "sell":
            this.validateSell(oEvent.value);
            break;
         case "buy":
            this.validateBuy(oEvent.value);
      }
   }
   function complete(oEvent)
   {
      var ref = this;
      this._ldrArtwork.content.stringCourseColor = function(mc, z)
      {
         ref.applyColor(mc,z);
      };
   }
}

class dofus.graphics.gapi.ui.PlayerShop extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "PlayerShop";
   function PlayerShop()
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
      super.init(false,dofus.graphics.gapi.ui.PlayerShop.CLASS_NAME);
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
      this.setBuyMode(false);
   }
   function addListeners()
   {
      this._livInventory.addEventListener("selectedItem",this);
      this._livInventory2.addEventListener("selectedItem",this);
      this._btnBuy.addEventListener("click",this);
      this._btnClose.addEventListener("click",this);
      this._ldrArtwork.addEventListener("complete",this);
      if(this._oData != undefined)
      {
         this._oData.addEventListener("modelChanged",this);
      }
      else
      {
         ank.utils.Logger.err("[PlayerShop] il n\'y a pas de data");
      }
   }
   function initTexts()
   {
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
   function setBuyMode(bActive)
   {
      this._btnBuy._visible = bActive;
      this._mcBuyArrow._visible = bActive;
   }
   function askQuantity(nQte, nPrice)
   {
      var _loc4_ = Math.floor(this.api.datacenter.Player.Kama / nPrice);
      if(_loc4_ > nQte)
      {
         _loc4_ = nQte;
      }
      var _loc5_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:_loc4_,min:1});
      _loc5_.addEventListener("validate",this);
   }
   function validateBuy(nQuantity)
   {
      if(nQuantity <= 0)
      {
         return undefined;
      }
      nQuantity = Math.min(this._oSelectedItem.Quantity,nQuantity);
      if(this.api.datacenter.Player.Kama < this._oSelectedItem.price * nQuantity)
      {
         this.gapi.loadUIComponent("AskOk","AskOkRich",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("NOT_ENOUGH_RICH")});
         return undefined;
      }
      this.api.network.Exchange.buy(this._oSelectedItem.ID,nQuantity);
      this.hideItemViewer(true);
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
            if(this._oSelectedItem.Quantity > 1)
            {
               this.askQuantity(this._oSelectedItem.Quantity,this._oSelectedItem.price);
            }
            else
            {
               this.validateBuy(1);
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
               this.setBuyMode(false);
               this._livInventory2.setFilter(this._livInventory.currentFilterID);
               break;
            case "_livInventory2":
               this.setBuyMode(true);
               this._livInventory.setFilter(this._livInventory2.currentFilterID);
         }
      }
   }
   function validate(oEvent)
   {
      this.validateBuy(oEvent.value);
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

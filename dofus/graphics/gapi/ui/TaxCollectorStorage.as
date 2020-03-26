class dofus.graphics.gapi.ui.TaxCollectorStorage extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "TaxCollectorStorage";
   function TaxCollectorStorage()
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
      super.init(false,dofus.graphics.gapi.ui.TaxCollectorStorage.CLASS_NAME);
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
      this.setGetItemMode(false);
   }
   function addListeners()
   {
      this._livInventory.addEventListener("selectedItem",this);
      this._livInventory2.addEventListener("selectedItem",this);
      this._livInventory2.addEventListener("itemdblClick",this);
      this._btnGetItem.addEventListener("click",this);
      this._btnGetKamas.addEventListener("click",this);
      this._btnClose.addEventListener("click",this);
      if(this._oData != undefined)
      {
         this._oData.addEventListener("modelChanged",this);
         this._oData.addEventListener("kamaChanged",this);
      }
      else
      {
         ank.utils.Logger.err("[TaxCollectorShop] il n\'y a pas de data");
      }
   }
   function initTexts()
   {
      this._btnGetItem.label = this.api.lang.getText("GET_ITEM");
      this._winInventory.title = this.api.datacenter.Player.data.name;
      this._winInventory2.title = this._oData.name;
   }
   function initData()
   {
      this._livInventory.dataProvider = this.api.datacenter.Player.Inventory;
      this._livInventory.kamasProvider = this.api.datacenter.Player;
      this._livInventory2.kamasProvider = this._oData;
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
   function setGetItemMode(bActive)
   {
      var _loc3_ = false;
      var _loc4_ = this.api.datacenter.Player.guildInfos.playerRights;
      if((var _loc0_ = this._oSelectedItem.superType) !== 9)
      {
         _loc3_ = _loc4_.canCollectObjects;
      }
      else
      {
         _loc3_ = _loc4_.canCollectResources;
      }
      this._btnGetItem._visible = bActive && _loc3_;
      this._mcBuyArrow._visible = bActive;
   }
   function askQuantity(nQuantity, oParams)
   {
      var _loc4_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:nQuantity,max:nQuantity,params:oParams});
      _loc4_.addEventListener("validate",this);
   }
   function validateGetItem(nQuantity)
   {
      if(nQuantity <= 0)
      {
         return undefined;
      }
      nQuantity = Math.min(this._oSelectedItem.Quantity,nQuantity);
      this.api.network.Exchange.movementItem(false,this._oSelectedItem.ID,nQuantity);
      this.hideItemViewer(true);
      this.setGetItemMode(false);
   }
   function validateKamas(nQuantity)
   {
      if(nQuantity <= 0)
      {
         return undefined;
      }
      nQuantity = Math.min(this._oData.Kama,nQuantity);
      this.api.network.Exchange.movementKama(- nQuantity);
      this.hideItemViewer(true);
      this.setGetItemMode(false);
   }
   function getItems()
   {
      if(this._oSelectedItem.Quantity > 1)
      {
         this.askQuantity(this._oSelectedItem.Quantity,{type:"item"});
      }
      else
      {
         this.validateGetItem(1);
      }
   }
   function modelChanged(oEvent)
   {
      this._livInventory2.dataProvider = this._oData.inventory;
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnGetItem":
            if(this._oSelectedItem.Quantity > 1)
            {
               this.askQuantity(this._oSelectedItem.Quantity,{type:"item"});
            }
            else
            {
               this.validateGetItem(1);
            }
            break;
         case "_btnGetKamas":
            if(this.api.datacenter.Player.guildInfos.playerRights.canCollect)
            {
               if(this._oData.Kama > 0)
               {
                  this.askQuantity(this._oData.Kama,{type:"kamas"});
               }
            }
            break;
         case "_btnClose":
            this.callClose();
      }
   }
   function itemdblClick(oEvent)
   {
      if(!Key.isDown(Key.CONTROL))
      {
         if(this._oSelectedItem.Quantity > 1)
         {
            this.askQuantity(this._oSelectedItem.Quantity,{type:"item"});
         }
         else
         {
            this.validateGetItem(1);
         }
      }
      else
      {
         this.validateGetItem(this._oSelectedItem.Quantity);
      }
   }
   function selectedItem(oEvent)
   {
      if(oEvent.item == undefined)
      {
         this.hideItemViewer(true);
         this.setGetItemMode(false);
      }
      else
      {
         this._oSelectedItem = oEvent.item;
         this.hideItemViewer(false);
         this._itvItemViewer.itemData = oEvent.item;
         switch(oEvent.target._name)
         {
            case "_livInventory":
               this.setGetItemMode(false);
               this._livInventory2.setFilter(this._livInventory.currentFilterID);
               break;
            case "_livInventory2":
               this.setGetItemMode(true);
               this._livInventory.setFilter(this._livInventory2.currentFilterID);
         }
      }
   }
   function validate(oEvent)
   {
      switch(oEvent.target.params.type)
      {
         case "item":
            this.validateGetItem(oEvent.value);
            break;
         case "kamas":
            this.validateKamas(oEvent.value);
      }
   }
}

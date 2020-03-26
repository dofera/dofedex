class dofus.graphics.gapi.ui.Storage extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Storage";
   function Storage()
   {
      super();
   }
   function __set__data(oData)
   {
      this._oData = oData;
      return this.__get__data();
   }
   function __set__isMount(bMount)
   {
      this._bMount = bMount;
      return this.__get__isMount();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Storage.CLASS_NAME);
   }
   function callClose()
   {
      if(this._bMount == true)
      {
         this.api.ui.loadUIComponent("Mount","Mount");
      }
      this.api.network.Exchange.leave();
      return true;
   }
   function createChildren()
   {
      if(this._bMount != true)
      {
         this._pbPods._visible = false;
      }
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.initTexts});
      this.hideItemViewer(true);
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._ivInventoryViewer.addEventListener("selectedItem",this);
      this._ivInventoryViewer.addEventListener("dblClickItem",this);
      this._ivInventoryViewer.addEventListener("dropItem",this);
      this._ivInventoryViewer.addEventListener("dragKama",this);
      this._ivInventoryViewer2.addEventListener("selectedItem",this);
      this._ivInventoryViewer2.addEventListener("dblClickItem",this);
      this._ivInventoryViewer2.addEventListener("dropItem",this);
      this._ivInventoryViewer2.addEventListener("dragKama",this);
      if(this._oData != undefined)
      {
         this._oData.addEventListener("modelChanged",this);
      }
      else
      {
         ank.utils.Logger.err("[Storage] il n\'y a pas de data");
      }
   }
   function initTexts()
   {
      this._winInventory.title = this.api.datacenter.Player.data.name;
      if(this._bMount != true)
      {
         this._winInventory2.title = this.api.lang.getText("STORAGE");
      }
      else
      {
         this._winInventory2.title = this.api.lang.getText("MY_MOUNT");
      }
   }
   function initData()
   {
      if(this._bMount == true)
      {
         this._ivInventoryViewer.showKamas = false;
         this._ivInventoryViewer2.showKamas = false;
      }
      this._ivInventoryViewer.dataProvider = this.api.datacenter.Player.Inventory;
      this._ivInventoryViewer.kamasProvider = this.api.datacenter.Player;
      this._ivInventoryViewer2.kamasProvider = this._oData;
      this.modelChanged();
   }
   function hideItemViewer(bHide)
   {
      this._itvItemViewer._visible = !bHide;
      this._winItemViewer._visible = !bHide;
   }
   function click(oEvent)
   {
      this.callClose();
      var _loc0_ = oEvent.target;
   }
   function selectedItem(oEvent)
   {
      if(oEvent.item == undefined)
      {
         this.hideItemViewer(true);
      }
      else
      {
         this.hideItemViewer(false);
         this._itvItemViewer.itemData = oEvent.item;
         switch(oEvent.target._name)
         {
            case "_ivInventoryViewer":
               this._ivInventoryViewer2.setFilter(this._ivInventoryViewer.currentFilterID);
               break;
            case "_ivInventoryViewer2":
               this._ivInventoryViewer.setFilter(this._ivInventoryViewer2.currentFilterID);
         }
      }
   }
   function dblClickItem(oEvent)
   {
      var _loc3_ = oEvent.item;
      if(_loc3_ == undefined)
      {
         return undefined;
      }
      if(Key.isDown(Key.ALT) && false)
      {
         var _loc4_ = new ank.utils.ExtendedArray();
         var _loc5_ = oEvent.index;
         if(oEvent.target._name == "_ivInventoryViewer")
         {
            _loc4_ = this._ivInventoryViewer.dataProvider;
            var _loc6_ = this._ivInventoryViewer.selectedItem;
            var _loc7_ = true;
         }
         if(oEvent.target._name == "_ivInventoryViewer2")
         {
            _loc4_ = this._ivInventoryViewer2.dataProvider;
            _loc6_ = this._ivInventoryViewer2.selectedItem;
            _loc7_ = false;
         }
         if(_loc5_ == undefined || _loc6_ == undefined)
         {
            return undefined;
         }
         if(_loc5_ > _loc6_)
         {
            var _loc8_ = _loc5_;
            _loc5_ = _loc6_;
            _loc6_ = _loc8_;
         }
         var _loc10_ = new Array();
         var _loc12_ = _loc5_;
         while(_loc12_ <= _loc6_)
         {
            var _loc9_ = _loc4_[_loc12_];
            var _loc11_ = _loc9_.Quantity;
            if(!(_loc11_ < 1 || _loc11_ == undefined))
            {
               _loc10_.push({Add:_loc7_,ID:_loc9_.ID,Quantity:_loc11_});
            }
            _loc12_ = _loc12_ + 1;
         }
         this.api.network.Exchange.movementItems(_loc10_);
      }
      else
      {
         var _loc13_ = !Key.isDown(Key.CONTROL)?1:_loc3_.Quantity;
         switch(oEvent.target._name)
         {
            case "_ivInventoryViewer":
               this.api.network.Exchange.movementItem(true,oEvent.item.ID,_loc13_);
               break;
            case "_ivInventoryViewer2":
               this.api.network.Exchange.movementItem(false,oEvent.item.ID,_loc13_);
         }
      }
   }
   function modelChanged(oEvent)
   {
      this._ivInventoryViewer2.dataProvider = this._oData.inventory;
   }
   function dropItem(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_ivInventoryViewer":
            this.api.network.Exchange.movementItem(false,oEvent.item.ID,oEvent.quantity);
            break;
         case "_ivInventoryViewer2":
            this.api.network.Exchange.movementItem(true,oEvent.item.ID,oEvent.quantity);
      }
   }
   function dragKama(oEvent)
   {
      switch(oEvent.target)
      {
         case this._ivInventoryViewer:
            this.api.network.Exchange.movementKama(oEvent.quantity);
            break;
         case this._ivInventoryViewer2:
            this.api.network.Exchange.movementKama(- oEvent.quantity);
      }
   }
}

class dofus.graphics.gapi.controls.InventoryViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "InventoryViewer";
   static var FILTER_ID_EQUIPEMENT = 0;
   static var FILTER_EQUIPEMENT = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false];
   static var FILTER_ID_NONEQUIPEMENT = 1;
   static var FILTER_NONEQUIPEMENT = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false];
   static var FILTER_ID_RESSOURECES = 2;
   static var FILTER_RESSOURECES = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false];
   var _bAutoFilter = true;
   var _bFilterAtStart = true;
   var _nSelectedTypeID = 0;
   var _nLastProviderLen = 0;
   var _nLastFilterID = -1;
   function InventoryViewer()
   {
      super();
   }
   function __set__dataProvider(eaDataProvider)
   {
      this._eaDataProvider.removeEventListener("modelChanged",this);
      this._eaDataProvider = eaDataProvider;
      this._eaDataProvider.addEventListener("modelChanged",this);
      if(this.initialized)
      {
         this.modelChanged();
      }
      return this.__get__dataProvider();
   }
   function __get__dataProvider()
   {
      return this._eaDataProvider;
   }
   function __set__kamasProvider(oKamasProvider)
   {
      oKamasProvider.removeEventListener("kamaChanged",this);
      this._oKamasProvider = oKamasProvider;
      oKamasProvider.addEventListener("kamaChanged",this);
      if(this.initialized)
      {
         this.kamaChanged();
      }
      return this.__get__kamasProvider();
   }
   function __set__autoFilter(bAutoFilter)
   {
      this._bAutoFilter = bAutoFilter;
      return this.__get__autoFilter();
   }
   function __set__filterAtStart(bFilterAtStart)
   {
      this._bFilterAtStart = bFilterAtStart;
      return this.__get__filterAtStart();
   }
   function __get__currentFilterID()
   {
      return this._nCurrentFilterID;
   }
   function __get__customInventoryFilter()
   {
      return this._iifFilter;
   }
   function __set__customInventoryFilter(iif)
   {
      this._iifFilter = iif;
      if(this.initialized)
      {
         this.modelChanged();
      }
      return this.__get__customInventoryFilter();
   }
   function __get__selectedItem()
   {
      return this._oDataViewer.selectedIndex;
   }
   function setFilter(nFilter)
   {
      if(nFilter == this._nCurrentFilterID)
      {
         return undefined;
      }
      switch(nFilter)
      {
         case dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT:
            this.click({target:this._btnFilterEquipement});
            this._btnFilterEquipement.selected = true;
            break;
         case dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_NONEQUIPEMENT:
            this.click({target:this._btnFilterNonEquipement});
            this._btnFilterNonEquipement.selected = true;
            break;
         case dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_RESSOURECES:
            this.click({target:this._btnFilterRessoureces});
            this._btnFilterRessoureces.selected = true;
      }
   }
   function createChildren()
   {
      if(this._bFilterAtStart)
      {
         if(this._bAutoFilter)
         {
            this.addToQueue({object:this,method:this.setPreferedFilter});
         }
         else
         {
            this.addToQueue({object:this,method:this.setFilter,params:[this.getDefaultFilter()]});
         }
      }
   }
   function addListeners()
   {
      this._btnFilterEquipement.addEventListener("click",this);
      this._btnFilterNonEquipement.addEventListener("click",this);
      this._btnFilterRessoureces.addEventListener("click",this);
      this._btnMoreChoice.addEventListener("click",this);
      this._btnFilterEquipement.addEventListener("over",this);
      this._btnFilterNonEquipement.addEventListener("over",this);
      this._btnFilterRessoureces.addEventListener("over",this);
      this._btnMoreChoice.addEventListener("over",this);
      this._btnFilterEquipement.addEventListener("out",this);
      this._btnFilterNonEquipement.addEventListener("out",this);
      this._btnFilterRessoureces.addEventListener("out",this);
      this._btnMoreChoice.addEventListener("out",this);
      this._cbTypes.addEventListener("itemSelected",this);
   }
   function getDefaultFilter()
   {
      return dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT;
   }
   function setPreferedFilter()
   {
      var _loc2_ = new Array({count:0,id:dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT},{count:0,id:dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_NONEQUIPEMENT},{count:0,id:dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_RESSOURECES});
      for(var k in this._eaDataProvider)
      {
         var _loc3_ = this._eaDataProvider[k].superType;
         if(dofus.graphics.gapi.controls.InventoryViewer.FILTER_EQUIPEMENT[_loc3_])
         {
            _loc2_[0].count = _loc2_[0].count + 1;
         }
         if(dofus.graphics.gapi.controls.InventoryViewer.FILTER_NONEQUIPEMENT[_loc3_])
         {
            _loc2_[1].count = _loc2_[1].count + 1;
         }
         if(dofus.graphics.gapi.controls.InventoryViewer.FILTER_RESSOURECES[_loc3_])
         {
            _loc2_[2].count = _loc2_[2].count + 1;
         }
      }
      _loc2_.sortOn("count");
      this.setFilter(_loc2_[2].id);
   }
   function updateData()
   {
      var _loc2_ = this.api.datacenter.Basics[dofus.graphics.gapi.controls.InventoryViewer.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name + "_" + this._name];
      this._nSelectedTypeID = _loc2_ != undefined?_loc2_:0;
      var _loc3_ = new ank.utils.ExtendedArray();
      var _loc4_ = new ank.utils.ExtendedArray();
      var _loc5_ = new Object();
      for(var k in this._eaDataProvider)
      {
         var _loc6_ = this._eaDataProvider[k];
         var _loc7_ = _loc6_.position;
         if(_loc7_ == -1 && this._aSelectedSuperTypes[_loc6_.superType])
         {
            if(_loc6_.type == this._nSelectedTypeID || this._nSelectedTypeID == 0)
            {
               if(this._iifFilter == null || this._iifFilter == undefined || this._iifFilter.isItemListed(_loc6_))
               {
                  _loc3_.push(_loc6_);
               }
            }
            var _loc8_ = _loc6_.type;
            if(_loc5_[_loc8_] != true)
            {
               _loc4_.push({label:this.api.lang.getItemTypeText(_loc8_).n,id:_loc8_});
               _loc5_[_loc8_] = true;
            }
         }
      }
      _loc4_.sortOn("label");
      _loc4_.splice(0,0,{label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
      this._cbTypes.dataProvider = _loc4_;
      this.setType(this._nSelectedTypeID);
      this._oDataViewer.dataProvider = _loc3_;
      this.sortInventory(this._sCurrentSort);
   }
   function setType(nTypeID)
   {
      var _loc3_ = this._cbTypes.dataProvider;
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         if(_loc3_[_loc4_].id == nTypeID)
         {
            this._cbTypes.selectedIndex = _loc4_;
            return undefined;
         }
         _loc4_ = _loc4_ + 1;
      }
      this._nSelectedTypeID = 0;
      this._cbTypes.selectedIndex = this._nSelectedTypeID;
   }
   function showSearch()
   {
      var _loc2_ = this.gapi.loadUIComponent("InventorySearch","InventorySearch",{_oDataProvider:this._oDataViewer.dataProvider});
      _loc2_.addEventListener("select",this);
   }
   function sortInventory(sField)
   {
      if(!sField)
      {
         return undefined;
      }
      this._oDataViewer.dataProvider.sortOn(sField,Array.NUMERIC);
      this._sCurrentSort = sField;
      this._nLastProviderLen = this._oDataViewer.dataProvider.length;
      this._nLastFilterID = this._nCurrentFilterID;
      this._oDataViewer.modelChanged();
   }
   function modelChanged()
   {
      this.updateData();
   }
   function kamaChanged(oEvent)
   {
      if(oEvent.value == undefined)
      {
         this._lblKama.text = "0";
      }
      else
      {
         this._lblKama.text = new ank.utils.ExtendedString(oEvent.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
      }
   }
   function click(oEvent)
   {
      if(oEvent.target == this._btnMoreChoice)
      {
         var _loc3_ = this.api.ui.createPopupMenu();
         _loc3_.addItem(this.api.lang.getText("INVENTORY_SEARCH"),this,this.showSearch);
         _loc3_.addItem(this.api.lang.getText("INVENTORY_DATE_SORT"),this,this.sortInventory,["_itemDateId"]);
         _loc3_.addItem(this.api.lang.getText("INVENTORY_NAME_SORT"),this,this.sortInventory,["_itemName"]);
         _loc3_.addItem(this.api.lang.getText("INVENTORY_TYPE_SORT"),this,this.sortInventory,["_itemType"]);
         _loc3_.addItem(this.api.lang.getText("INVENTORY_LEVEL_SORT"),this,this.sortInventory,["_itemLevel"]);
         _loc3_.addItem(this.api.lang.getText("INVENTORY_POD_SORT"),this,this.sortInventory,["_itemWeight"]);
         _loc3_.addItem(this.api.lang.getText("INVENTORY_QTY_SORT"),this,this.sortInventory,["_nQuantity"]);
         _loc3_.show(_root._xmouse,_root._ymouse);
         return undefined;
      }
      if(oEvent.target != this._btnSelectedFilterButton)
      {
         this._btnSelectedFilterButton.selected = false;
         this._btnSelectedFilterButton = oEvent.target;
         switch(oEvent.target._name)
         {
            case "_btnFilterEquipement":
               this._aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewer.FILTER_EQUIPEMENT;
               this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
               this._nCurrentFilterID = dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_EQUIPEMENT;
               break;
            case "_btnFilterNonEquipement":
               this._aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewer.FILTER_NONEQUIPEMENT;
               this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
               this._nCurrentFilterID = dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_NONEQUIPEMENT;
               break;
            case "_btnFilterRessoureces":
               this._aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewer.FILTER_RESSOURECES;
               this._lblFilter.text = this.api.lang.getText("RESSOURECES");
               this._nCurrentFilterID = dofus.graphics.gapi.controls.InventoryViewer.FILTER_ID_RESSOURECES;
         }
         this.updateData();
      }
      else
      {
         oEvent.target.selected = true;
      }
   }
   function select(oEvent)
   {
      var _loc3_ = oEvent.value;
      var _loc4_ = 0;
      while(_loc4_ < this._oDataViewer.dataProvider.length)
      {
         if(_loc3_ == this._oDataViewer.dataProvider[_loc4_].unicID)
         {
            this._oDataViewer.setVPosition(Math.floor(_loc4_ / this._oDataViewer.visibleColumnCount));
            this._oDataViewer.selectedIndex = _loc4_;
         }
         _loc4_ = _loc4_ + 1;
      }
   }
   function itemSelected(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "_cbTypes")
      {
         this._nSelectedTypeID = this._cbTypes.selectedItem.id;
         this.api.datacenter.Basics[dofus.graphics.gapi.controls.InventoryViewer.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name + "_" + this._name] = this._nSelectedTypeID;
         this.updateData();
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnFilterEquipement:
            this.api.ui.showTooltip(this.api.lang.getText("EQUIPEMENT"),oEvent.target,-20);
            break;
         case this._btnFilterNonEquipement:
            this.api.ui.showTooltip(this.api.lang.getText("NONEQUIPEMENT"),oEvent.target,-20);
            break;
         case this._btnFilterRessoureces:
            this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),oEvent.target,-20);
            break;
         case this._btnMoreChoice:
            this.api.ui.showTooltip(this.api.lang.getText("SEARCH_AND_SORT"),oEvent.target,-20);
      }
   }
   function out(oEvent)
   {
      this.api.ui.hideTooltip();
   }
}

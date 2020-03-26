class dofus.graphics.gapi.ui.ItemSummoner extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ItemSummoner";
   function ItemSummoner()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.ItemSummoner.CLASS_NAME);
   }
   function callClose()
   {
      this.unloadThis();
      return true;
   }
   function createChildren()
   {
      this.hideItemViewer(true);
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
   }
   function initTexts()
   {
      this._winBg.title = "Liste des objets";
      this._lblSearch.text = this.api.lang.getText("BIGSTORE_SEARCH_ITEM_NAME");
      this._lblType.text = this.api.lang.getText("TYPE");
      this._lblQuantity.text = this.api.lang.getText("QUANTITY");
      this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
      this._btnSelect.label = this.api.lang.getText("VALIDATE");
      this._tiSearch.setFocus();
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnCancel.addEventListener("click",this);
      this._btnSelect.addEventListener("click",this);
      this._tiSearch.addEventListener("change",this);
      this._cbType.addEventListener("itemSelected",this);
      this._lst.addEventListener("itemSelected",this);
      this._lst.addEventListener("itemRollOver",this);
      this._lst.addEventListener("itemRollOut",this);
      this._lst.addEventListener("itemDrag",this);
      this._cgGrid.addEventListener("dropItem",this);
      this._cgGrid.addEventListener("selectItem",this);
      this._cgGrid.addEventListener("dragItem",this);
   }
   function initData()
   {
      this._eaItems = new ank.utils.ExtendedArray();
      this._tiQuantity.restrict = "0-9";
      this._tiQuantity.text = "1";
      var _loc2_ = new ank.utils.ExtendedArray();
      var _loc3_ = this.api.lang.getAllItemTypes();
      for(var a in _loc3_)
      {
         _loc2_.push({label:_loc3_[a].n,id:a});
      }
      _loc2_.sortOn("label");
      _loc2_.push({label:"All",id:-1});
      this._cbType.dataProvider = _loc2_;
      this._eaGridItems = new ank.utils.ExtendedArray();
      this._cgGrid.dataProvider = this._eaGridItems;
   }
   function hideItemViewer(bHide)
   {
      this._winItemViewer._visible = !bHide;
      this._itvItemViewer._visible = !bHide;
   }
   function generateIndexes(b)
   {
      var _loc3_ = new Object();
      for(var k in this._aTypes)
      {
         _loc3_[this._aTypes[k]] = true;
      }
      var _loc4_ = this.api.lang.getItemUnics();
      this._eaItems = new ank.utils.ExtendedArray();
      this._eaItemsOriginal = new ank.utils.ExtendedArray();
      for(var k in _loc4_)
      {
         var _loc5_ = _loc4_[k];
         if(!(_loc5_.ep != undefined && _loc5_.ep > this.api.datacenter.Basics.aks_current_regional_version))
         {
            if(_loc3_[_loc5_.t])
            {
               var _loc6_ = _loc5_.n;
               this._eaItems.push({id:k,name:_loc6_.toUpperCase()});
               this._eaItemsOriginal.push(new dofus.datacenter.Item(0,Number(k)));
            }
         }
      }
      this._lblNumber.text = this._eaItemsOriginal.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"),"m",this._eaItemsOriginal.length < 2);
   }
   function searchItem(sText)
   {
      var _loc3_ = sText.split(" ");
      var _loc4_ = new ank.utils.ExtendedArray();
      var _loc5_ = new Object();
      var _loc6_ = 0;
      var _loc7_ = 0;
      while(_loc7_ < this._eaItems.length)
      {
         var _loc8_ = this._eaItems[_loc7_];
         var _loc9_ = this.searchWordsInName(_loc3_,_loc8_.name,_loc6_);
         if(_loc9_ != 0)
         {
            _loc5_[_loc8_.id] = _loc9_;
            _loc6_ = _loc9_;
         }
         _loc7_ = _loc7_ + 1;
      }
      for(var k in _loc5_)
      {
         if(_loc5_[k] >= _loc6_)
         {
            _loc4_.push(new dofus.datacenter.Item(0,Number(k)));
         }
      }
      this._lst.dataProvider = _loc4_;
   }
   function searchWordsInName(aWords, sName, nMaxWordsCount)
   {
      var _loc5_ = 0;
      var _loc6_ = aWords.length;
      while(_loc6_ >= 0)
      {
         var _loc7_ = aWords[_loc6_];
         if(sName.indexOf(_loc7_) != -1)
         {
            _loc5_ = _loc5_ + 1;
         }
         else if(_loc5_ + _loc6_ < nMaxWordsCount)
         {
            return 0;
         }
         _loc6_ = _loc6_ - 1;
      }
      return _loc5_;
   }
   function validateDrop(iItem, nQuantity)
   {
      var _loc4_ = false;
      for(var i in this._eaGridItems)
      {
         if(iItem.equals(this._eaGridItems[i]))
         {
            this._eaGridItems[i].Quantity = this._eaGridItems[i].Quantity + nQuantity;
            this._cgGrid.modelChanged();
            _loc4_ = true;
            break;
         }
      }
      if(!_loc4_)
      {
         iItem.Quantity = nQuantity;
         this._eaGridItems.push(iItem);
      }
   }
   function summonItems()
   {
      for(var i in this._eaGridItems)
      {
         var _loc2_ = (dofus.datacenter.Item)this._eaGridItems[i];
         this.api.network.Basics.autorisedCommand("!getitem " + _loc2_.unicID + " " + _loc2_.Quantity);
      }
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClose":
         case "_btnCancel":
            this.dispatchEvent({type:"cancel"});
            this.callClose();
         case "_btnSelect":
            if(this._eaGridItems.length == 0)
            {
               this.dispatchEvent({type:"cancel"});
               this.callClose();
            }
            this.summonItems();
            this.callClose();
      }
   }
   function change(oEvent)
   {
      if(this._tiSearch.text.length > 3)
      {
         this.searchItem(this._tiSearch.text.toUpperCase());
      }
      else if(this._lst.dataProvider != this._eaItemsOriginal)
      {
         this._lst.dataProvider = this._eaItemsOriginal;
      }
   }
   function itemSelected(oEvent)
   {
      switch(oEvent.target)
      {
         case this._cbType:
            this._aTypes = new Array();
            if(this._cbType.selectedItem.id != -1)
            {
               this._aTypes.push(this._cbType.selectedItem.id);
            }
            else
            {
               var _loc3_ = 0;
               while(_loc3_ < this._cbType.dataProvider.length)
               {
                  if(this._cbType.dataProvider[_loc3_].id != -1)
                  {
                     this._aTypes.push(this._cbType.dataProvider[_loc3_].id);
                  }
                  _loc3_ = _loc3_ + 1;
               }
            }
            this.generateIndexes();
            this.change();
            break;
         case this._lst:
            var _loc4_ = this._lst.selectedItem;
            if(_loc4_ == undefined)
            {
               this.hideItemViewer(true);
            }
            else
            {
               if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY))
               {
                  this.api.kernel.GameManager.insertItemInChat(_loc4_);
                  return undefined;
               }
               this.hideItemViewer(false);
               this._itvItemViewer.itemData = _loc4_;
            }
      }
   }
   function itemRollOver(oEvent)
   {
      this.gapi.showTooltip(oEvent.row.item.name + " (" + oEvent.row.item.unicID + ")",oEvent.row,20,{bXLimit:true,bYLimit:false});
   }
   function itemRollOut(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function itemDrag(oEvent)
   {
      if(oEvent.row.item == undefined)
      {
         return undefined;
      }
      this.gapi.removeCursor();
      this.gapi.setCursor(oEvent.row.item);
   }
   function dragItem(oEvent)
   {
      this.gapi.removeCursor();
      if(oEvent.target.contentData == undefined)
      {
         return undefined;
      }
      this.gapi.setCursor(oEvent.target.contentData);
   }
   function dropItem(oEvent)
   {
      var _loc3_ = (dofus.datacenter.Item)this.gapi.getCursor();
      if(_loc3_ == undefined)
      {
         return undefined;
      }
      if(String(oEvent.target).indexOf("_cgGrid") > -1)
      {
         if(Key.isDown(Key.CONTROL))
         {
            var _loc4_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:99,params:{targetType:"validateDrop",item:_loc3_}});
            _loc4_.addEventListener("validate",this);
         }
         else
         {
            this.validateDrop(_loc3_,1);
         }
      }
      this.gapi.removeCursor();
   }
   function validate(oEvent)
   {
      if((var _loc0_ = oEvent.params.targetType) === "validateDrop")
      {
         this.validateDrop((dofus.datacenter.Item)oEvent.params.item,oEvent.value);
      }
   }
   function selectItem(oEvent)
   {
      var _loc3_ = (dofus.datacenter.Item)oEvent.target.contentData;
      if(_loc3_ == undefined)
      {
         this.hideItemViewer(true);
      }
      else
      {
         if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY))
         {
            this.api.kernel.GameManager.insertItemInChat(_loc3_);
            return undefined;
         }
         if(Key.isDown(Key.CONTROL))
         {
            var _loc4_ = new ank.utils.ExtendedArray();
            for(var i in this._eaGridItems)
            {
               if(this._eaGridItems[i].unicID != _loc3_.unicID)
               {
                  _loc4_.push(this._eaGridItems[i]);
               }
            }
            this._eaGridItems = _loc4_;
            this._cgGrid.modelChanged();
         }
         else
         {
            this.hideItemViewer(false);
            this._itvItemViewer.itemData = _loc3_;
         }
      }
   }
}

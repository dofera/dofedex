class dofus.graphics.gapi.controls.GridInventoryViewer extends dofus.graphics.gapi.controls.InventoryViewer
{
   static var CLASS_NAME = "GridInventoryViewer";
   var _bShowKamas = true;
   function GridInventoryViewer()
   {
      super();
   }
   function __set__showKamas(bShowKamas)
   {
      this._bShowKamas = bShowKamas;
      this._btnDragKama._visible = this._lblKama._visible = this._mcKamaSymbol._visible = this._mcKamaSymbol2._visible = bShowKamas;
      return this.__get__showKamas();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.GridInventoryViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this._oDataViewer = this._cgGrid;
      this.addToQueue({object:this,method:this.addListeners});
      super.createChildren();
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.initTexts});
   }
   function addListeners()
   {
      super.addListeners();
      this._cgGrid.addEventListener("dropItem",this);
      this._cgGrid.addEventListener("dragItem",this);
      this._cgGrid.addEventListener("selectItem",this);
      this._cgGrid.addEventListener("overItem",this);
      this._cgGrid.addEventListener("outItem",this);
      this._cgGrid.addEventListener("dblClickItem",this);
      this._btnDragKama.onRelease = function()
      {
         this._parent.askKamaQuantity();
      };
   }
   function initTexts()
   {
      this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
   }
   function initData()
   {
      this.modelChanged();
      this.kamaChanged({value:this._oKamasProvider.Kama});
   }
   function validateDrop(targetGrid, oItem, nQuantity)
   {
      nQuantity = Number(nQuantity);
      if(nQuantity < 1 || _global.isNaN(nQuantity))
      {
         return undefined;
      }
      if(nQuantity > oItem.Quantity)
      {
         nQuantity = oItem.Quantity;
      }
      this.dispatchEvent({type:"dropItem",item:oItem,quantity:nQuantity});
   }
   function validateKama(nQuantity)
   {
      nQuantity = Number(nQuantity);
      if(nQuantity < 1 || _global.isNaN(nQuantity))
      {
         return undefined;
      }
      if(nQuantity > this._oKamasProvider.Kama)
      {
         nQuantity = this._oKamasProvider.Kama;
      }
      this.dispatchEvent({type:"dragKama",quantity:nQuantity});
   }
   function askKamaQuantity()
   {
      var _loc2_ = this._oKamasProvider.Kama == undefined?0:Number(this._oKamasProvider.Kama);
      var _loc3_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:_loc2_,max:_loc2_,params:{targetType:"kama"}});
      _loc3_.addEventListener("validate",this);
   }
   function showOneItem(nUnicID)
   {
      var _loc3_ = 0;
      while(_loc3_ < this._cgGrid.dataProvider.length)
      {
         if(nUnicID == this._cgGrid.dataProvider[_loc3_].unicID)
         {
            this._cgGrid.setVPosition(_loc3_ / this._cgGrid.visibleColumnCount);
            this._cgGrid.selectedIndex = _loc3_;
            return true;
         }
         _loc3_ = _loc3_ + 1;
      }
      return false;
   }
   function dragItem(oEvent)
   {
      if(oEvent.target.contentData == undefined)
      {
         return undefined;
      }
      this.gapi.removeCursor();
      this.gapi.setCursor(oEvent.target.contentData);
   }
   function dropItem(oEvent)
   {
      var _loc3_ = this.gapi.getCursor();
      if(_loc3_ == undefined)
      {
         return undefined;
      }
      this.gapi.removeCursor();
      if(_loc3_.Quantity > 1)
      {
         var _loc4_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:_loc3_.Quantity,params:{targetType:"item",oItem:_loc3_}});
         _loc4_.addEventListener("validate",this);
      }
      else
      {
         this.validateDrop(this._cgGrid,_loc3_,1);
      }
   }
   function selectItem(oEvent)
   {
      if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && oEvent.target.contentData != undefined)
      {
         this.api.kernel.GameManager.insertItemInChat(oEvent.target.contentData);
         return undefined;
      }
      this.dispatchEvent({type:"selectedItem",item:oEvent.target.contentData});
   }
   function overItem(oEvent)
   {
      this.gapi.showTooltip(oEvent.target.contentData.name,oEvent.target,-20,undefined,oEvent.target.contentData.style + "ToolTip");
   }
   function outItem(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function dblClickItem(oEvent)
   {
      this.dispatchEvent({type:oEvent.type,item:oEvent.target.contentData,target:this,index:oEvent.target.id});
   }
   function validate(oEvent)
   {
      switch(oEvent.params.targetType)
      {
         case "item":
            this.validateDrop(this._cgGrid,oEvent.params.oItem,oEvent.value);
            break;
         case "kama":
            this.validateKama(oEvent.value);
      }
   }
}

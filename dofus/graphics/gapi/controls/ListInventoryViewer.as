class dofus.graphics.gapi.controls.ListInventoryViewer extends dofus.graphics.gapi.controls.InventoryViewerWithAllFilter
{
   static var CLASS_NAME = "ListInventoryViewer";
   var _bDisplayKama = true;
   var _bDisplayPrices = true;
   function ListInventoryViewer()
   {
      super();
   }
   function __set__displayKamas(bDisplayKama)
   {
      this._bDisplayKama = bDisplayKama;
      if(this.initialized)
      {
         this.showKamas(bDisplayKama);
      }
      return this.__get__displayKamas();
   }
   function __set__displayPrices(bDisplayPrices)
   {
      if(this.initialized)
      {
         ank.utils.Logger.err("[displayPrices] impossible après init");
         return undefined;
      }
      this._bDisplayPrices = bDisplayPrices;
      return this.__get__displayPrices();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.ListInventoryViewer.CLASS_NAME);
   }
   function createChildren()
   {
      var _loc3_ = !this._bDisplayPrices?"ListInventoryViewerItemNoPrice":"ListInventoryViewerItem";
      this.attachMovie("List","_lstInventory",10,{styleName:"LightBrownList",cellRenderer:_loc3_,rowHeight:20});
      this._lstInventory.move(this._mcLstPlacer._x,this._mcLstPlacer._y);
      this._lstInventory.setSize(this._mcLstPlacer._width,this._mcLstPlacer._height);
      this._oDataViewer = this._lstInventory;
      this.showKamas(this._bDisplayKama);
      this.addToQueue({object:this,method:this.addListeners});
      super.createChildren();
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.initTexts});
   }
   function addListeners()
   {
      super.addListeners();
      this._lstInventory.addEventListener("itemSelected",this);
      this._lstInventory.addEventListener("itemdblClick",this);
   }
   function initTexts()
   {
      this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
   }
   function initData()
   {
      this.kamaChanged({value:this._oKamasProvider.Kama});
   }
   function showKamas(bShow)
   {
      this._lblKama._visible = bShow;
      this._mcKamaSymbol._visible = bShow;
   }
   function itemSelected(oEvent)
   {
      super.itemSelected(oEvent);
      if(oEvent.target != this._cbTypes)
      {
         if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && oEvent.row.item != undefined)
         {
            this.api.kernel.GameManager.insertItemInChat(oEvent.row.item);
            return undefined;
         }
         this.dispatchEvent({type:"selectedItem",item:oEvent.row.item});
      }
   }
   function itemdblClick(oEvent)
   {
      this.dispatchEvent({type:"itemdblClick",item:oEvent.row.item});
   }
}

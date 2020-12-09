class dofus.graphics.gapi.controls.ListInventoryViewer extends dofus.graphics.gapi.controls.InventoryViewerWithAllFilter
{
	static var CLASS_NAME = "ListInventoryViewer";
	var _bDisplayKama = true;
	var _bDisplayPrices = true;
	function ListInventoryViewer()
	{
		super();
	}
	function __get__currentOverItem()
	{
		return this._oOverItem;
	}
	function __get__lstInventory()
	{
		return this._lstInventory;
	}
	function __set__displayKamas(§\x1b\x06§)
	{
		this._bDisplayKama = var2;
		if(this.initialized)
		{
			this.showKamas(var2);
		}
		return this.__get__displayKamas();
	}
	function __set__displayPrices(§\x1b\x04§)
	{
		if(this.initialized)
		{
			ank.utils.Logger.err("[displayPrices] impossible après init");
			return undefined;
		}
		this._bDisplayPrices = var2;
		return this.__get__displayPrices();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ListInventoryViewer.CLASS_NAME);
	}
	function createChildren()
	{
		var var3 = !this._bDisplayPrices?"ListInventoryViewerItemNoPrice":"ListInventoryViewerItem";
		this.attachMovie("List","_lstInventory",10,{styleName:"LightBrownList",cellRenderer:var3,rowHeight:20});
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
		this._lstInventory.addEventListener("itemRollOver",this);
		this._lstInventory.addEventListener("itemRollOut",this);
	}
	function initTexts()
	{
		this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
	}
	function initData()
	{
		this.kamaChanged({value:this._oKamasProvider.Kama});
	}
	function showKamas(§\x15\x13§)
	{
		this._lblKama._visible = var2;
		this._mcKamaSymbol._visible = var2;
	}
	function itemSelected(§\x1e\x19\x18§)
	{
		super.itemSelected(var3);
		if(var3.target != this._cbTypes)
		{
			if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && var3.row.item != undefined)
			{
				this.api.kernel.GameManager.insertItemInChat(var3.row.item);
				return undefined;
			}
			this.dispatchEvent({type:"selectedItem",item:var3.row.item,targets:var3.targets});
		}
	}
	function itemdblClick(§\x1e\x19\x18§)
	{
		this.dispatchEvent({type:"itemdblClick",item:var2.row.item,targets:var2.targets});
	}
	function itemRollOver(§\x1e\x19\x18§)
	{
		var var3 = var2.row.item;
		this._oOverItem = var3;
		this.dispatchEvent({type:"rollOverItem",item:var2.row.item,targets:var2.targets});
	}
	function itemRollOut(§\x1e\x19\x18§)
	{
		this._oOverItem = undefined;
		var var3 = var2.row.item;
		this.dispatchEvent({type:"rollOutItem",item:var2.row.item,targets:var2.targets});
	}
}

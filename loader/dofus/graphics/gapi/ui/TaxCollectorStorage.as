class dofus.graphics.gapi.ui.TaxCollectorStorage extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "TaxCollectorStorage";
	function TaxCollectorStorage()
	{
		super();
	}
	function __set__data(var2)
	{
		this._oData = var2;
		return this.__get__data();
	}
	function __get__currentOverItem()
	{
		if(this._livInventory != undefined && this._livInventory.currentOverItem != undefined)
		{
			return this._livInventory.currentOverItem;
		}
		if(this._livInventory2 != undefined && this._livInventory2.currentOverItem != undefined)
		{
			return this._livInventory2.currentOverItem;
		}
		return undefined;
	}
	function __get__itemViewer()
	{
		return this._itvItemViewer;
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
		this._livInventory2.addEventListener("rollOverItem",this);
		this._livInventory2.addEventListener("rollOutItem",this);
		this._livInventory2.lstInventory.multipleSelection = true;
		this._btnGetItem.addEventListener("click",this);
		this._btnClose.addEventListener("click",this);
		if(this._oData != undefined)
		{
			this._oData.addEventListener("modelChanged",this);
		}
		else
		{
			ank.utils.Logger.err("[TaxCollectorShop] il n\'y a pas de data");
		}
	}
	function initTexts()
	{
		this.refreshGetItemButton();
		this._winInventory.title = this.api.datacenter.Player.data.name;
		this._winInventory2.title = this._oData.name;
	}
	function initData()
	{
		this._livInventory.dataProvider = this.api.datacenter.Player.Inventory;
		this._ldrArtwork.contentPath = dofus.Constants.ARTWORKS_BIG_PATH + this._oData.gfx + ".swf";
		this.modelChanged();
	}
	function refreshGetItemButton(var2)
	{
		var var3 = this.api.datacenter.Player.guildInfos.playerRights;
		var var4 = var3.canCollect;
		if(!var4)
		{
			this._btnGetItem._visible = false;
			return undefined;
		}
		if(var2 == undefined)
		{
			var2 = this._livInventory2.lstInventory.getSelectedItems().length;
		}
		if(this._sGetItemText == undefined)
		{
			this._sGetItemText = this.api.lang.getText("GET_ITEM");
		}
		this._btnGetItem.enabled = var2 != undefined && (var2 <= 1 && (this._oSelectedItem != undefined && this._mcBuyArrow._visible) || var2 > 1);
		if(var2 == undefined || var2 <= 1)
		{
			this._btnGetItem.label = this._sGetItemText;
		}
		else
		{
			this._btnGetItem.label = this._sGetItemText + " (" + var2 + ")";
		}
	}
	function hideItemViewer(var2)
	{
		this._itvItemViewer._visible = !var2;
		this._winItemViewer._visible = !var2;
		if(var2)
		{
			this._oSelectedItem = undefined;
		}
	}
	function setGetItemMode(var2)
	{
		this._mcBuyArrow._visible = var2;
	}
	function askQuantity(var2, var3)
	{
		var var4 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:var2,max:var2,params:var3});
		var4.addEventListener("validate",this);
	}
	function validateGetItems(var2)
	{
		var var3 = new Array();
		var var4 = 0;
		while(var4 < var2.length)
		{
			var var5 = var2[var4];
			var3.push({Add:false,ID:var5.ID,Quantity:var5.Quantity});
			var4 = var4 + 1;
		}
		this.api.network.Exchange.movementItems(var3);
		this.hideItemViewer(true);
		this.setGetItemMode(false);
	}
	function validateGetItem(var2)
	{
		if(var2 <= 0)
		{
			return undefined;
		}
		var2 = Math.min(this._oSelectedItem.Quantity,var2);
		this.api.network.Exchange.movementItem(false,this._oSelectedItem,var2);
		this.hideItemViewer(true);
		this.setGetItemMode(false);
	}
	function modelChanged(var2)
	{
		this._livInventory2.dataProvider = this._oData.inventory;
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnGetItem":
				var var3 = this._livInventory2.lstInventory.getSelectedItems();
				if(var3.length > 1)
				{
					this.validateGetItems(var3);
					break;
				}
				if(this._oSelectedItem == undefined)
				{
					break;
				}
				if(this._oSelectedItem.Quantity > 1)
				{
					this.askQuantity(this._oSelectedItem.Quantity);
				}
				else
				{
					this.validateGetItem(1);
				}
				break;
			case "_btnClose":
				this.callClose();
		}
	}
	function rollOverItem(var2)
	{
		var var3 = var2.targets.length;
		this.refreshGetItemButton(var3);
	}
	function rollOutItem(var2)
	{
		var var3 = var2.targets.length;
		this.refreshGetItemButton(var3);
	}
	function selectedItem(var2)
	{
		if(var2.item == undefined)
		{
			this.hideItemViewer(true);
			this.setGetItemMode(false);
		}
		else
		{
			this._oSelectedItem = var2.item;
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = var2.item;
			switch(var2.target._name)
			{
				case "_livInventory":
					this.setGetItemMode(false);
					this._livInventory2.setFilter(this._livInventory.currentFilterID);
					this.refreshGetItemButton();
					break;
				case "_livInventory2":
					this.setGetItemMode(true);
					this._livInventory.setFilter(this._livInventory2.currentFilterID);
					var var3 = var2.targets.length;
					this.refreshGetItemButton(var3);
			}
		}
	}
	function validate(var2)
	{
		this.validateGetItem(var2.value);
	}
}

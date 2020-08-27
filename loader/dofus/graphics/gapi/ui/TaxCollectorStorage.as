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
		var var3 = false;
		var var4 = this.api.datacenter.Player.guildInfos.playerRights;
		var3 = var4.canCollect;
		this._btnGetItem._visible = var2 && var3;
		this._mcBuyArrow._visible = var2;
	}
	function askQuantity(var2, var3)
	{
		var var4 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:var2,max:var2,params:var3});
		var4.addEventListener("validate",this);
	}
	function validateGetItem(var2)
	{
		if(var2 <= 0)
		{
			return undefined;
		}
		var2 = Math.min(this._oSelectedItem.Quantity,var2);
		this.api.network.Exchange.movementItem(false,this._oSelectedItem.ID,var2);
		this.hideItemViewer(true);
		this.setGetItemMode(false);
	}
	function validateKamas(var2)
	{
		if(var2 <= 0)
		{
			return undefined;
		}
		var2 = Math.min(this._oData.Kama,var2);
		this.api.network.Exchange.movementKama(- var2);
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
	function modelChanged(var2)
	{
		this._livInventory2.dataProvider = this._oData.inventory;
	}
	function click(var2)
	{
		switch(var2.target._name)
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
			default:
				if(var0 !== "_btnClose")
				{
					break;
				}
				this.callClose();
				break;
		}
	}
	function itemdblClick(var2)
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
			if((var var0 = var2.target._name) !== "_livInventory")
			{
				if(var0 === "_livInventory2")
				{
					this.setGetItemMode(true);
					this._livInventory.setFilter(this._livInventory2.currentFilterID);
				}
			}
			else
			{
				this.setGetItemMode(false);
				this._livInventory2.setFilter(this._livInventory.currentFilterID);
			}
		}
	}
	function validate(var2)
	{
		switch(var2.target.params.type)
		{
			case "item":
				this.validateGetItem(var2.value);
				break;
			case "kamas":
				this.validateKamas(var2.value);
		}
	}
}

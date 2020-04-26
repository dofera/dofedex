class dofus.graphics.gapi.ui.TaxCollectorStorage extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "TaxCollectorStorage";
	function TaxCollectorStorage()
	{
		super();
	}
	function __set__data(loc2)
	{
		this._oData = loc2;
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
	function hideItemViewer(loc2)
	{
		this._itvItemViewer._visible = !loc2;
		this._winItemViewer._visible = !loc2;
		if(loc2)
		{
			this._oSelectedItem = undefined;
		}
	}
	function setGetItemMode(loc2)
	{
		var loc3 = false;
		var loc4 = this.api.datacenter.Player.guildInfos.playerRights;
		loc3 = loc4.canCollect;
		this._btnGetItem._visible = loc2 && loc3;
		this._mcBuyArrow._visible = loc2;
	}
	function askQuantity(loc2, loc3)
	{
		var loc4 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:loc2,max:loc2,params:loc3});
		loc4.addEventListener("validate",this);
	}
	function validateGetItem(loc2)
	{
		if(loc2 <= 0)
		{
			return undefined;
		}
		loc2 = Math.min(this._oSelectedItem.Quantity,loc2);
		this.api.network.Exchange.movementItem(false,this._oSelectedItem.ID,loc2);
		this.hideItemViewer(true);
		this.setGetItemMode(false);
	}
	function validateKamas(loc2)
	{
		if(loc2 <= 0)
		{
			return undefined;
		}
		loc2 = Math.min(this._oData.Kama,loc2);
		this.api.network.Exchange.movementKama(- loc2);
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
	function modelChanged(loc2)
	{
		this._livInventory2.dataProvider = this._oData.inventory;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
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
	function itemdblClick(loc2)
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
	function selectedItem(loc2)
	{
		if(loc2.item == undefined)
		{
			this.hideItemViewer(true);
			this.setGetItemMode(false);
		}
		else
		{
			this._oSelectedItem = loc2.item;
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = loc2.item;
			switch(loc2.target._name)
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
	function validate(loc2)
	{
		switch(loc2.target.params.type)
		{
			case "item":
				this.validateGetItem(loc2.value);
				break;
			case "kamas":
				this.validateKamas(loc2.value);
		}
	}
}

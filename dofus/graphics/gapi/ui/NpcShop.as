class dofus.graphics.gapi.ui.NpcShop extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "NpcShop";
	function NpcShop()
	{
		super();
	}
	function __set__data(loc2)
	{
		this._oData = loc2;
		return this.__get__data();
	}
	function __set__colors(loc2)
	{
		this._colors = loc2;
		return this.__get__colors();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.NpcShop.CLASS_NAME);
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
		this.setSellMode(false);
		this.setBuyMode(false);
		this.gapi.unloadLastUIAutoHideComponent();
	}
	function addListeners()
	{
		this._livInventory.addEventListener("selectedItem",this);
		this._livInventory2.addEventListener("selectedItem",this);
		this._btnSell.addEventListener("click",this);
		this._btnBuy.addEventListener("click",this);
		this._btnClose.addEventListener("click",this);
		this._ldrArtwork.addEventListener("complete",this);
		if(this._oData != undefined)
		{
			this._oData.addEventListener("modelChanged",this);
		}
		else
		{
			ank.utils.Logger.err("[NpcShop] il n\'y a pas de data");
		}
	}
	function initTexts()
	{
		this._btnSell.label = this.api.lang.getText("SELL");
		this._btnBuy.label = this.api.lang.getText("BUY");
		this._winInventory.title = this.api.datacenter.Player.data.name;
		this._winInventory2.title = this._oData.name;
	}
	function initData()
	{
		this._livInventory.dataProvider = this.api.datacenter.Player.Inventory;
		this._livInventory.kamasProvider = this.api.datacenter.Player;
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
	function setSellMode(loc2)
	{
		this._btnSell._visible = loc2;
		this._mcSellArrow._visible = loc2;
	}
	function setBuyMode(loc2)
	{
		this._btnBuy._visible = loc2;
		this._mcBuyArrow._visible = loc2;
	}
	function askQuantity(loc2, loc3, loc4, loc5)
	{
		var loc6 = 0;
		if(loc2 == "buy")
		{
			loc6 = Math.floor(this.api.datacenter.Player.Kama / loc4);
			if(loc5 != undefined)
			{
				var loc7 = this.api.datacenter.Player.maxWeight - this.api.datacenter.Player.currentWeight;
				var loc8 = Math.floor(loc7 / loc5);
				if(loc6 > loc8)
				{
					loc6 = loc8;
				}
			}
		}
		else
		{
			loc6 = loc3;
		}
		var loc9 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:loc6,min:1,params:{type:loc2}});
		loc9.addEventListener("validate",this);
	}
	function validateBuy(loc2)
	{
		if(loc2 <= 0)
		{
			return undefined;
		}
		if(this.api.datacenter.Player.Kama < this._oSelectedItem.price * loc2)
		{
			this.gapi.loadUIComponent("AskOk","AskOkRich",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("NOT_ENOUGH_RICH")});
			return undefined;
		}
		this.api.network.Exchange.buy(this._oSelectedItem.unicID,loc2);
	}
	function validateSell(loc2)
	{
		if(loc2 <= 0)
		{
			return undefined;
		}
		if(loc2 > this._oSelectedItem.Quantity)
		{
			loc2 = this._oSelectedItem.Quantity;
		}
		this.api.network.Exchange.sell(this._oSelectedItem.ID,loc2);
		this.hideItemViewer(true);
		this.setSellMode(false);
		this.setBuyMode(false);
	}
	function applyColor(loc2, loc3)
	{
		var loc4 = this._colors[loc3];
		if(loc4 == -1 || loc4 == undefined)
		{
			return undefined;
		}
		var loc5 = (loc4 & 16711680) >> 16;
		var loc6 = (loc4 & 65280) >> 8;
		var loc7 = loc4 & 255;
		var loc8 = new Color(loc2);
		var loc9 = new Object();
		loc9 = {ra:0,ga:0,ba:0,rb:loc5,gb:loc6,bb:loc7};
		loc8.setTransform(loc9);
	}
	function modelChanged(loc2)
	{
		this._livInventory2.dataProvider = this._oData.inventory;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnBuy":
				this.askQuantity("buy",1,this._oSelectedItem.price,this._oSelectedItem.weight);
				break;
			case "_btnSell":
				if(this._oSelectedItem.Quantity > 1)
				{
					this.askQuantity("sell",this._oSelectedItem.Quantity);
				}
				else
				{
					this.validateSell(1);
				}
				break;
			case "_btnClose":
				this.callClose();
		}
	}
	function selectedItem(loc2)
	{
		if(loc2.item == undefined)
		{
			this.hideItemViewer(true);
			this.setSellMode(false);
			this.setBuyMode(false);
		}
		else
		{
			this._oSelectedItem = loc2.item;
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = loc2.item;
			switch(loc2.target._name)
			{
				case "_livInventory":
					this.setSellMode(true);
					this.setBuyMode(false);
					this._livInventory2.setFilter(this._livInventory.currentFilterID);
					break;
				case "_livInventory2":
					this.setSellMode(false);
					this.setBuyMode(true);
					this._livInventory.setFilter(this._livInventory2.currentFilterID);
			}
		}
	}
	function validate(loc2)
	{
		switch(loc2.params.type)
		{
			case "sell":
				this.validateSell(loc2.value);
				break;
			case "buy":
				this.validateBuy(loc2.value);
		}
	}
	function complete(loc2)
	{
		var ref = this;
		this._ldrArtwork.content.stringCourseColor = function(loc2, loc3)
		{
			ref.applyColor(loc2,loc3);
		};
	}
}

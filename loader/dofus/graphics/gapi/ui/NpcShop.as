class dofus.graphics.gapi.ui.NpcShop extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "NpcShop";
	function NpcShop()
	{
		super();
	}
	function __set__data(§\x1e\x1a\x02§)
	{
		this._oData = var2;
		return this.__get__data();
	}
	function __set__colors(§\f§)
	{
		this._colors = var2;
		return this.__get__colors();
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
	function hideItemViewer(§\x19\x0e§)
	{
		this._itvItemViewer._visible = !var2;
		this._winItemViewer._visible = !var2;
		if(var2)
		{
			this._oSelectedItem = undefined;
		}
	}
	function setSellMode(§\x1c\x1c§)
	{
		this._btnSell._visible = var2;
		this._mcSellArrow._visible = var2;
	}
	function setBuyMode(§\x1c\x1c§)
	{
		this._btnBuy._visible = var2;
		this._mcBuyArrow._visible = var2;
	}
	function askQuantity(§\x1e\f\x14§, §\x01\x0f§, §\x01\x14§, §\x1e\x1b\x10§)
	{
		var var6 = 0;
		if(var2 == "buy")
		{
			var6 = Math.floor(this.api.datacenter.Player.Kama / var4);
			if(var5 != undefined)
			{
				var var7 = this.api.datacenter.Player.maxWeight - this.api.datacenter.Player.currentWeight;
				var var8 = Math.floor(var7 / var5);
				if(var6 > var8)
				{
					var6 = var8;
				}
			}
		}
		else
		{
			var6 = var3;
		}
		var var9 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:var6,min:1,params:{type:var2}});
		var9.addEventListener("validate",this);
	}
	function validateBuy(§\x01\x0e§)
	{
		if(var2 <= 0)
		{
			return undefined;
		}
		if(this.api.datacenter.Player.Kama < this._oSelectedItem.price * var2)
		{
			this.gapi.loadUIComponent("AskOk","AskOkRich",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("NOT_ENOUGH_RICH")});
			return undefined;
		}
		this.api.network.Exchange.buy(this._oSelectedItem.unicID,var2);
	}
	function validateSell(§\x01\x0e§)
	{
		if(var2 <= 0)
		{
			return undefined;
		}
		if(var2 > this._oSelectedItem.Quantity)
		{
			var2 = this._oSelectedItem.Quantity;
		}
		this.api.network.Exchange.sell(this._oSelectedItem.ID,var2);
		this.hideItemViewer(true);
		this.setSellMode(false);
		this.setBuyMode(false);
	}
	function applyColor(§\x0b\r§, §\x1e\t\x10§)
	{
		var var4 = this._colors[var3];
		if(var4 == -1 || var4 == undefined)
		{
			return undefined;
		}
		var var5 = (var4 & 16711680) >> 16;
		var var6 = (var4 & 65280) >> 8;
		var var7 = var4 & 255;
		var var8 = new Color(var2);
		var var9 = new Object();
		var9 = {ra:0,ga:0,ba:0,rb:var5,gb:var6,bb:var7};
		var8.setTransform(var9);
	}
	function modelChanged(§\x1e\x19\x18§)
	{
		this._livInventory2.dataProvider = this._oData.inventory;
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
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
			default:
				if(var0 !== "_btnClose")
				{
					break;
				}
				this.callClose();
				break;
		}
	}
	function selectedItem(§\x1e\x19\x18§)
	{
		if(var2.item == undefined)
		{
			this.hideItemViewer(true);
			this.setSellMode(false);
			this.setBuyMode(false);
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
					this.setSellMode(false);
					this.setBuyMode(true);
					this._livInventory.setFilter(this._livInventory2.currentFilterID);
				}
			}
			else
			{
				this.setSellMode(true);
				this.setBuyMode(false);
				this._livInventory2.setFilter(this._livInventory.currentFilterID);
			}
		}
	}
	function validate(§\x1e\x19\x18§)
	{
		switch(var2.params.type)
		{
			case "sell":
				this.validateSell(var2.value);
				break;
			case "buy":
				this.validateBuy(var2.value);
		}
	}
	function complete(§\x1e\x19\x18§)
	{
		this._ldrArtwork.content.stringCourseColor = function(§\x0b\r§, §\x1e\t\x14§)
		{
			ref.applyColor(var2,var3);
		};
	}
}

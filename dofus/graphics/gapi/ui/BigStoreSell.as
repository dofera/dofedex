class dofus.graphics.gapi.ui.BigStoreSell extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "BigStoreSell";
	function BigStoreSell()
	{
		super();
	}
	function __set__data(loc2)
	{
		this._oData = loc2;
		return this.__get__data();
	}
	function setMiddlePrice(loc2, loc3)
	{
		if(this._itvItemViewer.itemData.unicID == loc2 && this._itvItemViewer.itemData != undefined)
		{
			this._lblMiddlePrice.text = this.api.lang.getText("BIGSTORE_MIDDLEPRICE",[loc3]);
		}
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.BigStoreSell.CLASS_NAME);
	}
	function callClose()
	{
		this.gapi.hideTooltip();
		this.api.network.Exchange.leave();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.populateComboBox});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.setAddMode,params:[false]});
		this.addToQueue({object:this,method:this.setRemoveMode,params:[false]});
		this.hideItemViewer(true);
	}
	function addListeners()
	{
		this._livInventory.addEventListener("selectedItem",this);
		this._livInventory2.addEventListener("selectedItem",this);
		this._btnAdd.addEventListener("click",this);
		this._btnRemove.addEventListener("click",this);
		this._btnClose.addEventListener("click",this);
		this._btnSwitchToBuy.addEventListener("click",this);
		this._btnTypes.addEventListener("over",this);
		this._btnTypes.addEventListener("out",this);
		this._btnFilterSell.addEventListener("click",this);
		this._btnFilterSell.addEventListener("over",this);
		this._btnFilterSell.addEventListener("out",this);
		this._tiPrice.addEventListener("change",this);
		if(this._oData != undefined)
		{
			this._oData.addEventListener("modelChanged",this);
		}
		else
		{
			ank.utils.Logger.err("[PlayerShop] il n\'y a pas de data");
		}
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function initTexts()
	{
		this._btnAdd.label = this.api.lang.getText("PUT_ON_SELL");
		this._btnRemove.label = this.api.lang.getText("REMOVE");
		this._btnSwitchToBuy.label = this.api.lang.getText("BIGSTORE_MODE_BUY");
		this._lblQuantity.text = this.api.lang.getText("SET_QUANTITY") + " :";
		this._lblPrice.text = this.api.lang.getText("SET_PRICE") + " :";
		this._lblFilterSell.text = this.api.lang.getText("BIGSTORE_FILTER");
		this._winInventory.title = this.api.datacenter.Player.data.name;
		this._winInventory2.title = this.api.lang.getText("SHOP_STOCK");
	}
	function populateComboBox(loc2)
	{
		var loc3 = new ank.utils.();
		if(loc2 >= this._oData.quantity1)
		{
			loc3.push({label:"x" + this._oData.quantity1,index:1});
		}
		if(loc2 >= this._oData.quantity2)
		{
			loc3.push({label:"x" + this._oData.quantity2,index:2});
		}
		if(loc2 >= this._oData.quantity3)
		{
			loc3.push({label:"x" + this._oData.quantity3,index:3});
		}
		this._cbQuantity.dataProvider = loc3;
	}
	function initData()
	{
		this.enableFilter(this.api.kernel.OptionsManager.getOption("BigStoreSellFilter"));
		this._livInventory.dataProvider = this.api.datacenter.Player.Inventory;
		this._livInventory.kamasProvider = this.api.datacenter.Player;
		this.modelChanged();
	}
	function enableFilter(loc2)
	{
		if(loc2)
		{
			var loc3 = new Array();
			for(var i in this._oData.typesObj)
			{
				loc3.push(i);
			}
			this._livInventory.customInventoryFilter = new dofus.graphics.gapi.ui.bigstore.BigStoreSellFilter(Number(this._oData.maxLevel),loc3);
		}
		else
		{
			this._livInventory.customInventoryFilter = null;
		}
		this._btnFilterSell.selected = loc2;
		this.api.kernel.OptionsManager.setOption("BigStoreSellFilter",loc2);
	}
	function hideItemViewer(loc2)
	{
		this._itvItemViewer._visible = !loc2;
		this._winItemViewer._visible = !loc2;
		this._mcItemViewerDescriptionBack._visible = !loc2;
		this._srBottom._visible = !loc2;
		this._mcPrice._visible = !loc2;
		this._mcKamaSymbol._visible = !loc2;
		this._lblQuantity._visible = !loc2;
		this._lblQuantityValue._visible = !loc2;
		this._lblPrice._visible = !loc2;
		this._lblTaxTime._visible = !loc2;
		this._lblTaxTimeValue._visible = !loc2;
		this._cbQuantity._visible = !loc2;
		this._tiPrice._visible = !loc2;
		this._mcMiddlePrice._visible = !loc2;
		this._lblMiddlePrice._visible = !loc2;
		if(loc2)
		{
			this._oSelectedItem = undefined;
		}
	}
	function setAddMode(loc2)
	{
		this._btnAdd._visible = loc2;
		this._mcSellArrow._visible = loc2;
		this._mcPrice._visible = loc2;
		this._cbQuantity._visible = loc2;
		this._lblQuantityValue._visible = false;
		this._tiPrice.tabIndex = 0;
		this._tiPrice.enabled = loc2;
		this._oDefaultButton = this._btnAdd;
		this._mcKamaSymbol._visible = loc2;
		this._lblTaxTime.text = this.api.lang.getText("BIGSTORE_TAX") + " :";
		if(this._lblTaxTimeValue.text != undefined)
		{
			this._lblTaxTimeValue.text = "";
		}
		if(this._txtBadType.text != undefined)
		{
			this._txtBadType.text = "";
		}
		this._lblTaxTime._visible = loc2;
		this._lblQuantity._visible = loc2;
		this._lblPrice._visible = loc2;
		this._srBottom._visible = loc2;
		this._lblTaxTimeValue._visible = loc2;
		this._tiPrice._visible = loc2;
	}
	function setRemoveMode(loc2)
	{
		this._btnRemove._visible = loc2;
		this._mcBuyArrow._visible = loc2;
		this._mcPrice._visible = false;
		this._cbQuantity._visible = false;
		this._lblQuantityValue._visible = loc2;
		this._tiPrice.tabIndex = 0;
		this._tiPrice.enabled = !loc2;
		this._oDefaultButton = this._btnRemove;
		this._mcKamaSymbol._visible = false;
		this._lblTaxTime.text = this.api.lang.getText("BIGSTORE_TIME") + " :";
		if(this._lblTaxTimeValue.text != undefined)
		{
			this._lblTaxTimeValue.text = "";
		}
		if(this._txtBadType.text != undefined)
		{
			this._txtBadType.text = "";
		}
		this._lblTaxTime._visible = loc2;
		this._lblQuantity._visible = loc2;
		this._lblPrice._visible = loc2;
		this._srBottom._visible = loc2;
		this._lblTaxTimeValue._visible = loc2;
		this._tiPrice._visible = loc2;
	}
	function setBadItemMode(loc2)
	{
		this._btnRemove._visible = false;
		this._mcBuyArrow._visible = false;
		this._mcPrice._visible = false;
		this._cbQuantity._visible = false;
		this._lblQuantityValue._visible = false;
		this._tiPrice.tabIndex = 0;
		this._tiPrice.enabled = false;
		this._oDefaultButton = undefined;
		this._mcKamaSymbol._visible = false;
		this._txtBadType.text = loc2;
		this._lblTaxTime._visible = false;
		this._lblQuantity._visible = false;
		this._lblPrice._visible = false;
		this._srBottom._visible = false;
		this._lblTaxTimeValue._visible = false;
		this._tiPrice._visible = false;
	}
	function remove(loc2)
	{
		this.api.network.Exchange.movementItem(false,loc2.ID,loc2.Quantity);
	}
	function calculateTax()
	{
		if(this._oData.tax == 0)
		{
			this._lblTaxTimeValue.text = "0";
			return undefined;
		}
		var loc2 = Number(this._tiPrice.text);
		var loc3 = Math.max(1,Math.round(loc2 * this._oData.tax / 100));
		this._lblTaxTimeValue.text = String(!_global.isNaN(loc3)?loc3:0);
	}
	function updateItemCount()
	{
		this._winInventory2.title = this.api.lang.getText("SHOP_STOCK") + " (" + this._oData.inventory.length + "/" + this._oData.maxItemCount + ")";
	}
	function askSell(loc2, loc3, loc4)
	{
		var loc5 = this._oData["quantity" + loc3];
		var loc6 = this.gapi.loadUIComponent("AskYesNo","AskYesNoSell",{title:this.api.lang.getText("BIGSTORE"),text:this.api.lang.getText("DO_U_SELL_ITEM_BIGSTORE",["x" + loc5 + " " + loc2.name,loc4]),params:{itemID:loc2.ID,itemQuantity:loc2.Quantity,quantity:loc5,quantityIndex:loc3,price:loc4}});
		loc6.addEventListener("yes",this);
	}
	function onShortcut(loc2)
	{
		if(loc2 == "ACCEPT_CURRENT_DIALOG" && this._oSelectedItem != undefined)
		{
			this.click({target:this._oDefaultButton});
			return false;
		}
		return true;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnRemove":
				this.remove(this._oSelectedItem);
				this.hideItemViewer(true);
				this.setRemoveMode(false);
				break;
			case "_btnAdd":
				var loc3 = Number(this._tiPrice.text);
				var loc4 = Number(this._cbQuantity.selectedItem.index);
				if(_global.isNaN(loc3) || loc3 == 0)
				{
					this.gapi.loadUIComponent("AskOk","AksOkBadPrice",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_PRICE")});
				}
				else if(_global.isNaN(loc4) || loc4 == 0)
				{
					this.gapi.loadUIComponent("AskOk","AksOkBadQuantity",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_QUANTITY")});
				}
				else
				{
					this.askSell(this._oSelectedItem,loc4,loc3);
				}
				break;
			case "_btnClose":
				this.callClose();
				break;
			default:
				switch(null)
				{
					case "_btnSwitchToBuy":
						this.api.network.Exchange.request(11,this._oData.npcID);
						break;
					case "_btnFilterSell":
						this.enableFilter(this._btnFilterSell.selected);
				}
		}
	}
	function over(loc2)
	{
		switch(loc2.target)
		{
			case this._btnTypes:
				var loc3 = this.api.lang.getText("BIGSTORE_MAX_LEVEL") + " : " + this._oData.maxLevel;
				loc3 = loc3 + ("\n" + this.api.lang.getText("BIGSTORE_TAX") + " : " + this._oData.tax + "%");
				loc3 = loc3 + ("\n" + this.api.lang.getText("BIGSTORE_MAX_ITEM_PER_ACCOUNT") + " : " + this._oData.maxItemCount);
				loc3 = loc3 + ("\n" + this.api.lang.getText("BIGSTORE_MAX_SELL_TIME") + " : " + this._oData.maxSellTime + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",this._oData.maxSellTime < 2));
				loc3 = loc3 + ("\n\n" + this.api.lang.getText("BIGSTORE_TYPES") + " :");
				var loc4 = this._oData.types;
				for(var k in loc4)
				{
					loc3 = loc3 + ("\n - " + this.api.lang.getItemTypeText(loc4[k]).n);
				}
				this.gapi.showTooltip(loc3,loc2.target,20);
				break;
			case this._btnFilterSell:
				this.gapi.showTooltip(this.api.lang.getText("BIGSTORE_SELL_FILTER_OVER"),loc2.target,20);
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
	function selectedItem(loc2)
	{
		if(loc2.item == undefined)
		{
			this.hideItemViewer(true);
			this.setAddMode(false);
			this.setRemoveMode(false);
		}
		else
		{
			this._oSelectedItem = loc2.item;
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = loc2.item;
			this.populateComboBox(loc2.item.Quantity);
			var loc3 = loc2.item.type;
			if(this._lblMiddlePrice.text != undefined)
			{
				this._lblMiddlePrice.text = "";
			}
			if(!this._oData.typesObj[loc3])
			{
				this.setAddMode(false);
				this.setRemoveMode(false);
				this.setBadItemMode(this.api.lang.getText("BIGSTORE_BAD_TYPE"));
			}
			else if(loc2.item.level > this._oData.maxLevel)
			{
				this.setAddMode(false);
				this.setRemoveMode(false);
				this.setBadItemMode(this.api.lang.getText("BIGSTORE_BAD_LEVEL"));
			}
			else
			{
				switch(loc2.target._name)
				{
					case "_livInventory":
						if(this._nQuantityIndex != undefined && this._cbQuantity.dataProvider.length >= this._nQuantityIndex)
						{
							this._cbQuantity.selectedIndex = this._nQuantityIndex - 1;
						}
						else
						{
							this._nQuantityIndex = undefined;
							this._cbQuantity.selectedIndex = 0;
						}
						this.setRemoveMode(false);
						this.setAddMode(true);
						if(this._tiPrice.text != undefined)
						{
							if(!_global.isNaN(this._nLastPrice))
							{
								this._tiPrice.text = String(this._nLastPrice);
							}
							else
							{
								this._tiPrice.text = "";
							}
						}
						this._livInventory2.setFilter(this._livInventory.currentFilterID);
						this._tiPrice.setFocus();
						break;
					case "_livInventory2":
						this._lblQuantityValue.text = "x" + String(loc2.item.Quantity);
						this.setAddMode(false);
						this.setRemoveMode(true);
						this._tiPrice.text = loc2.item.price;
						this._livInventory.setFilter(this._livInventory2.currentFilterID);
						this._lblTaxTimeValue.text = loc2.item.remainingHours + "h";
				}
				this.api.network.Exchange.getItemMiddlePriceInBigStore(loc2.item.unicID);
			}
		}
	}
	function modelChanged(loc2)
	{
		this._livInventory2.dataProvider = this._oData.inventory;
		this.updateItemCount();
	}
	function change(loc2)
	{
		if(this._btnAdd._visible)
		{
			this._nLastPrice = Number(this._tiPrice.text);
			this.calculateTax();
		}
	}
	function yes(loc2)
	{
		this._nQuantityIndex = loc2.target.params.quantityIndex;
		this.api.network.Exchange.movementItem(true,loc2.target.params.itemID,loc2.target.params.quantityIndex,loc2.target.params.price);
		if(loc2.target.params.itemQuantity - loc2.target.params.quantity < loc2.target.params.quantity)
		{
			this.setAddMode(false);
			this.hideItemViewer(true);
		}
		else
		{
			this.populateComboBox(loc2.target.params.itemQuantity - loc2.target.params.quantity);
		}
	}
}

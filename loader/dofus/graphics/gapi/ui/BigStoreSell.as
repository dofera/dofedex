class dofus.graphics.gapi.ui.BigStoreSell extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "BigStoreSell";
	function BigStoreSell()
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
	function setMiddlePrice(var2, var3)
	{
		if(this._itvItemViewer.itemData.unicID == var2 && this._itvItemViewer.itemData != undefined)
		{
			this._lblMiddlePrice.text = this.api.lang.getText("BIGSTORE_MIDDLEPRICE",[var3]);
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
		this._livInventory2.addEventListener("rollOverItem",this);
		this._livInventory2.addEventListener("rollOutItem",this);
		this._livInventory2.lstInventory.multipleSelection = true;
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
		this.refreshRemoveButton();
		this._btnSwitchToBuy.label = this.api.lang.getText("BIGSTORE_MODE_BUY");
		this._lblQuantity.text = this.api.lang.getText("SET_QUANTITY") + " :";
		this._lblPrice.text = this.api.lang.getText("SET_PRICE") + " :";
		this._lblFilterSell.text = this.api.lang.getText("BIGSTORE_FILTER");
		this._winInventory.title = this.api.datacenter.Player.data.name;
		this._winInventory2.title = this.api.lang.getText("SHOP_STOCK");
	}
	function populateComboBox(var2)
	{
		var var3 = new ank.utils.();
		if(var2 >= this._oData.quantity1)
		{
			var3.push({label:"x" + this._oData.quantity1,index:1});
		}
		if(var2 >= this._oData.quantity2)
		{
			var3.push({label:"x" + this._oData.quantity2,index:2});
		}
		if(var2 >= this._oData.quantity3)
		{
			var3.push({label:"x" + this._oData.quantity3,index:3});
		}
		this._cbQuantity.dataProvider = var3;
	}
	function initData()
	{
		this.enableFilter(this.api.kernel.OptionsManager.getOption("BigStoreSellFilter"));
		this._livInventory.dataProvider = this.api.datacenter.Player.Inventory;
		this._livInventory.kamasProvider = this.api.datacenter.Player;
		this.modelChanged();
	}
	function enableFilter(var2)
	{
		if(var2)
		{
			var var3 = new Array();
			for(var i in this._oData.typesObj)
			{
				var3.push(i);
			}
			this._livInventory.customInventoryFilter = new dofus.graphics.gapi.ui.bigstore.BigStoreSellFilter(Number(this._oData.maxLevel),var3);
		}
		else
		{
			this._livInventory.customInventoryFilter = null;
		}
		this._btnFilterSell.selected = var2;
		this.api.kernel.OptionsManager.setOption("BigStoreSellFilter",var2);
	}
	function hideItemViewer(var2)
	{
		this._itvItemViewer._visible = !var2;
		this._winItemViewer._visible = !var2;
		this._mcItemViewerDescriptionBack._visible = !var2;
		this._srBottom._visible = !var2;
		this._mcPrice._visible = !var2;
		this._mcKamaSymbol._visible = !var2;
		this._lblQuantity._visible = !var2;
		this._lblQuantityValue._visible = !var2;
		this._lblPrice._visible = !var2;
		this._lblTaxTime._visible = !var2;
		this._lblTaxTimeValue._visible = !var2;
		this._cbQuantity._visible = !var2;
		this._tiPrice._visible = !var2;
		this._mcMiddlePrice._visible = !var2;
		this._lblMiddlePrice._visible = !var2;
		if(var2)
		{
			this._oSelectedItem = undefined;
		}
	}
	function setAddMode(var2)
	{
		this._btnAdd._visible = var2;
		this._mcSellArrow._visible = var2;
		this._mcPrice._visible = var2;
		this._cbQuantity._visible = var2;
		this._lblQuantityValue._visible = false;
		this._tiPrice.tabIndex = 0;
		this._tiPrice.enabled = var2;
		this._oDefaultButton = this._btnAdd;
		this._mcKamaSymbol._visible = var2;
		this._lblTaxTime.text = this.api.lang.getText("BIGSTORE_TAX") + " :";
		if(this._lblTaxTimeValue.text != undefined)
		{
			this._lblTaxTimeValue.text = "";
		}
		if(this._txtBadType.text != undefined)
		{
			this._txtBadType.text = "";
		}
		this._lblTaxTime._visible = var2;
		this._lblQuantity._visible = var2;
		this._lblPrice._visible = var2;
		this._srBottom._visible = var2;
		this._lblTaxTimeValue._visible = var2;
		this._tiPrice._visible = var2;
	}
	function setRemoveMode(var2)
	{
		this._mcBuyArrow._visible = var2;
		this._mcPrice._visible = false;
		this._cbQuantity._visible = false;
		this._lblQuantityValue._visible = var2;
		this._tiPrice.tabIndex = 0;
		this._tiPrice.enabled = !var2;
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
		this._lblTaxTime._visible = var2;
		this._lblQuantity._visible = var2;
		this._lblPrice._visible = var2;
		this._srBottom._visible = var2;
		this._lblTaxTimeValue._visible = var2;
		this._tiPrice._visible = var2;
	}
	function setBadItemMode(var2)
	{
		this._mcBuyArrow._visible = false;
		this._mcPrice._visible = false;
		this._cbQuantity._visible = false;
		this._lblQuantityValue._visible = false;
		this._tiPrice.tabIndex = 0;
		this._tiPrice.enabled = false;
		this._oDefaultButton = undefined;
		this._mcKamaSymbol._visible = false;
		this._txtBadType.text = var2;
		this._lblTaxTime._visible = false;
		this._lblQuantity._visible = false;
		this._lblPrice._visible = false;
		this._srBottom._visible = false;
		this._lblTaxTimeValue._visible = false;
		this._tiPrice._visible = false;
		this.refreshRemoveButton();
	}
	function remove(var2)
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
	}
	function calculateTax()
	{
		if(this._oData.tax == 0)
		{
			this._lblTaxTimeValue.text = "0";
			return undefined;
		}
		var var2 = Number(this._tiPrice.text);
		var var3 = Math.max(1,Math.round(var2 * this._oData.tax / 100));
		this._lblTaxTimeValue.text = String(!_global.isNaN(var3)?var3:0);
	}
	function updateItemCount()
	{
		this._winInventory2.title = this.api.lang.getText("SHOP_STOCK") + " (" + this._oData.inventory.length + "/" + this._oData.maxItemCount + ")";
	}
	function askSell(var2, var3, var4)
	{
		var var5 = this._oData["quantity" + var3];
		var var6 = this.gapi.loadUIComponent("AskYesNo","AskYesNoSell",{title:this.api.lang.getText("BIGSTORE"),text:this.api.lang.getText("DO_U_SELL_ITEM_BIGSTORE",["x" + var5 + " " + var2.name,var4]),params:{item:var2,itemQuantity:var2.Quantity,quantity:var5,quantityIndex:var3,price:var4}});
		var6.addEventListener("yes",this);
	}
	function refreshRemoveButton(var2)
	{
		if(var2 == undefined)
		{
			var2 = this._livInventory2.lstInventory.getSelectedItems().length;
		}
		if(this._sRemoveText == undefined)
		{
			this._sRemoveText = this.api.lang.getText("REMOVE");
		}
		this._btnRemove.enabled = var2 != undefined && (var2 == 0 && (this._oSelectedItem != undefined && this._mcBuyArrow._visible) || var2 > 0);
		if(var2 == undefined || var2 <= 1)
		{
			this._btnRemove.label = this._sRemoveText;
		}
		else
		{
			this._btnRemove.label = this._sRemoveText + " (" + var2 + ")";
		}
	}
	function onShortcut(var2)
	{
		if(var2 == "ACCEPT_CURRENT_DIALOG" && this._oSelectedItem != undefined)
		{
			this.click({target:this._oDefaultButton});
			return false;
		}
		return true;
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnRemove":
				var var3 = this._livInventory2.lstInventory.getSelectedItems();
				if(var3.length == 0 && this._oSelectedItem == undefined)
				{
					break;
				}
				if(var3.length == 0)
				{
					var3.push(this._oSelectedItem);
				}
				this.remove(var3);
				this.hideItemViewer(true);
				this.setRemoveMode(false);
				this._btnAdd._visible = false;
				break;
			case "_btnAdd":
				var var4 = Number(this._tiPrice.text);
				var var5 = Number(this._cbQuantity.selectedItem.index);
				if(_global.isNaN(var4) || var4 == 0)
				{
					this.gapi.loadUIComponent("AskOk","AksOkBadPrice",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_PRICE")});
				}
				else if(_global.isNaN(var5) || var5 == 0)
				{
					this.gapi.loadUIComponent("AskOk","AksOkBadQuantity",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_QUANTITY")});
				}
				else
				{
					this.askSell(this._oSelectedItem,var5,var4);
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
	function over(var2)
	{
		switch(var2.target)
		{
			case this._btnTypes:
				var var3 = this.api.lang.getText("BIGSTORE_MAX_LEVEL") + " : " + this._oData.maxLevel;
				var3 = var3 + ("\n" + this.api.lang.getText("BIGSTORE_TAX") + " : " + this._oData.tax + "%");
				var3 = var3 + ("\n" + this.api.lang.getText("BIGSTORE_MAX_ITEM_PER_ACCOUNT") + " : " + this._oData.maxItemCount);
				var3 = var3 + ("\n" + this.api.lang.getText("BIGSTORE_MAX_SELL_TIME") + " : " + this._oData.maxSellTime + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",this._oData.maxSellTime < 2));
				var3 = var3 + ("\n\n" + this.api.lang.getText("BIGSTORE_TYPES") + " :");
				var var4 = this._oData.types;
				for(var var3 in var4)
				{
				}
				this.gapi.showTooltip(var3,var2.target,20);
				break;
			case this._btnFilterSell:
				this.gapi.showTooltip(this.api.lang.getText("BIGSTORE_SELL_FILTER_OVER"),var2.target,20);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
	function rollOverItem(var2)
	{
		var var3 = var2.targets.length;
		this.refreshRemoveButton(var3);
	}
	function rollOutItem(var2)
	{
		var var3 = var2.targets.length;
		this.refreshRemoveButton(var3);
	}
	function selectedItem(var2)
	{
		if(var2.item == undefined)
		{
			this.hideItemViewer(true);
			this.setAddMode(false);
			this.setRemoveMode(false);
		}
		else
		{
			this._oSelectedItem = var2.item;
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = var2.item;
			this.populateComboBox(var2.item.Quantity);
			var var3 = var2.item.type;
			if(this._lblMiddlePrice.text != undefined)
			{
				this._lblMiddlePrice.text = "";
			}
			if(!this._oData.typesObj[var3])
			{
				this.setAddMode(false);
				this.setRemoveMode(false);
				this.setBadItemMode(this.api.lang.getText("BIGSTORE_BAD_TYPE"));
			}
			else if(var2.item.level > this._oData.maxLevel)
			{
				this.setAddMode(false);
				this.setRemoveMode(false);
				this.setBadItemMode(this.api.lang.getText("BIGSTORE_BAD_LEVEL"));
			}
			else
			{
				switch(var2.target._name)
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
						this.refreshRemoveButton();
						break;
					case "_livInventory2":
						this._lblQuantityValue.text = "x" + String(var2.item.Quantity);
						this.setAddMode(false);
						this.setRemoveMode(true);
						this._tiPrice.text = var2.item.price;
						this._livInventory.setFilter(this._livInventory2.currentFilterID);
						this._lblTaxTimeValue.text = var2.item.remainingHours + "h";
						var var4 = var2.targets.length;
						this.refreshRemoveButton(var4);
				}
				this.api.network.Exchange.getItemMiddlePriceInBigStore(var2.item.unicID);
			}
		}
	}
	function modelChanged(var2)
	{
		this._livInventory2.dataProvider = this._oData.inventory;
		this.updateItemCount();
	}
	function change(var2)
	{
		if(this._btnAdd._visible)
		{
			this._nLastPrice = Number(this._tiPrice.text);
			this.calculateTax();
		}
	}
	function yes(var2)
	{
		this._nQuantityIndex = var2.target.params.quantityIndex;
		this.api.network.Exchange.movementItem(true,var2.target.params.item,var2.target.params.quantityIndex,var2.target.params.price);
		if(var2.target.params.itemQuantity - var2.target.params.quantity < var2.target.params.quantity)
		{
			this.setAddMode(false);
			this.hideItemViewer(true);
		}
		else
		{
			this.populateComboBox(var2.target.params.itemQuantity - var2.target.params.quantity);
		}
	}
}

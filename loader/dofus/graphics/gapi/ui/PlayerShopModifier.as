class dofus.graphics.gapi.ui.PlayerShopModifier extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "PlayerShopModifier";
	function PlayerShopModifier()
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
		super.init(false,dofus.graphics.gapi.ui.PlayerShopModifier.CLASS_NAME);
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
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTexts});
		this.hideItemViewer(true);
		this.setAddMode(false);
		this.setModifyMode(false);
		this._txtQuantity.restrict = "0-9";
		this._txtPrice.restrict = "0-9";
		this._txtQuantity.onSetFocus = function()
		{
			this._parent.onSetFocus();
		};
		this._txtQuantity.onKillFocus = function()
		{
			this._parent.onKillFocus();
		};
		this._txtPrice.onSetFocus = function()
		{
			this._parent.onSetFocus();
		};
		this._txtPrice.onKillFocus = function()
		{
			this._parent.onKillFocus();
		};
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
		this._btnModify.addEventListener("click",this);
		this._btnClose.addEventListener("click",this);
		this._btnOffline.addEventListener("click",this);
		this._btnOffline.addEventListener("over",this);
		this._btnOffline.addEventListener("out",this);
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
		this._btnModify.label = this.api.lang.getText("MODIFY");
		this._lblQuantity.text = this.api.lang.getText("QUANTITY") + " :";
		this._lblPrice.text = this.api.lang.getText("UNIT_PRICE") + " :";
		this._winInventory.title = this.api.datacenter.Player.data.name;
		this._winInventory2.title = this.api.lang.getText("SHOP_STOCK");
	}
	function initData()
	{
		this._livInventory.dataProvider = this.api.datacenter.Player.Inventory;
		this._livInventory.kamasProvider = this.api.datacenter.Player;
		this.modelChanged();
	}
	function hideItemViewer(var2)
	{
		this._itvItemViewer._visible = !var2;
		this._winItemViewer._visible = !var2;
		this._mcQuantity._visible = !var2;
		this._mcPrice._visible = !var2;
		this._lblQuantity._visible = !var2;
		this._lblPrice._visible = !var2;
		this._txtQuantity._visible = !var2;
		this._txtPrice._visible = !var2;
		if(var2)
		{
			this._oSelectedItem = undefined;
		}
	}
	function setAddMode(var2)
	{
		this._btnAdd._visible = var2;
		this._mcSellArrow._visible = var2;
		this._mcQuantity._visible = var2;
		this._txtQuantity.editable = true;
		this._txtQuantity.selectable = true;
		this._txtPrice.tabIndex = 0;
		this._txtQuantity.tabIndex = 1;
		this._oDefaultButton = this._btnAdd;
	}
	function setModifyMode(var2)
	{
		this._btnModify._visible = var2;
		this._mcBuyArrow._visible = var2;
		this._mcQuantity._visible = false;
		this._txtQuantity.editable = false;
		this._txtQuantity.selectable = false;
		this._txtPrice.tabIndex = 0;
		this._txtQuantity.tabIndex = undefined;
		this._oDefaultButton = this._btnModify;
	}
	function addToShop(var2, var3, var4)
	{
		this.api.network.Exchange.movementItem(true,var2,var3,var4);
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
	function modify(var2, var3)
	{
		this.api.network.Exchange.movementItem(true,var2,0,var3);
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
				this.setModifyMode(false);
				break;
			case "_btnModify":
				var var4 = Number(this._txtPrice.text);
				if(_global.isNaN(var4))
				{
					this.gapi.loadUIComponent("AskOk","AksOkBadPrice",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_PRICE")});
				}
				else
				{
					this.modify(this._oSelectedItem,var4);
					this.hideItemViewer(true);
					this.setModifyMode(false);
				}
				break;
			case "_btnAdd":
				var var5 = Number(this._txtPrice.text);
				var var6 = Number(this._txtQuantity.text);
				if(_global.isNaN(var5))
				{
					this.gapi.loadUIComponent("AskOk","AksOkBadPrice",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_PRICE")});
				}
				else if(_global.isNaN(var6) || var6 == 0)
				{
					this.gapi.loadUIComponent("AskOk","AksOkBadQuantity",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_QUANTITY")});
				}
				else
				{
					var6 = Math.min(this._oSelectedItem.Quantity,var6);
					this.addToShop(this._oSelectedItem,var6,var5);
					this.hideItemViewer(true);
					this.setAddMode(false);
				}
				break;
			default:
				switch(null)
				{
					case "_btnClose":
						this.callClose();
						break;
					case "_btnOffline":
						this.callClose();
						this.api.kernel.GameManager.offlineExchange();
				}
		}
	}
	function over(var2)
	{
		if((var var0 = var2.target._name) === "_btnOffline")
		{
			this.gapi.showTooltip(this.api.lang.getText("MERCHANT_MODE"),var2.target,-20);
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
			this.setModifyMode(false);
		}
		else
		{
			this._oSelectedItem = var2.item;
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = var2.item;
			switch(var2.target._name)
			{
				case "_livInventory":
					this._txtQuantity.text = var2.item.Quantity;
					this._txtPrice.text = "";
					this.setModifyMode(false);
					this.setAddMode(true);
					this._livInventory2.setFilter(this._livInventory.currentFilterID);
					this.refreshRemoveButton();
					break;
				case "_livInventory2":
					var var3 = var2.targets.length;
					this._txtQuantity.text = var2.item.Quantity;
					this._txtPrice.text = var2.item.price;
					this.setAddMode(false);
					this.setModifyMode(true);
					this._livInventory.setFilter(this._livInventory2.currentFilterID);
					this.refreshRemoveButton(var3);
			}
			Selection.setFocus(this._txtPrice);
		}
	}
	function modelChanged(var2)
	{
		this._livInventory2.dataProvider = this._oData.inventory;
	}
	function onSetFocus()
	{
		getURL("FSCommand:" add "trapallkeys","false");
	}
	function onKillFocus()
	{
		getURL("FSCommand:" add "trapallkeys","true");
	}
}

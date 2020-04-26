class dofus.graphics.gapi.ui.PlayerShopModifier extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "PlayerShopModifier";
	function PlayerShopModifier()
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
		this._btnRemove.label = this.api.lang.getText("REMOVE");
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
	function hideItemViewer(loc2)
	{
		this._itvItemViewer._visible = !loc2;
		this._winItemViewer._visible = !loc2;
		this._mcQuantity._visible = !loc2;
		this._mcPrice._visible = !loc2;
		this._lblQuantity._visible = !loc2;
		this._lblPrice._visible = !loc2;
		this._txtQuantity._visible = !loc2;
		this._txtPrice._visible = !loc2;
		if(loc2)
		{
			this._oSelectedItem = undefined;
		}
	}
	function setAddMode(loc2)
	{
		this._btnAdd._visible = loc2;
		this._mcSellArrow._visible = loc2;
		this._mcQuantity._visible = loc2;
		this._txtQuantity.editable = true;
		this._txtQuantity.selectable = true;
		this._txtPrice.tabIndex = 0;
		this._txtQuantity.tabIndex = 1;
		this._oDefaultButton = this._btnAdd;
	}
	function setModifyMode(loc2)
	{
		this._btnRemove._visible = loc2;
		this._btnModify._visible = loc2;
		this._mcBuyArrow._visible = loc2;
		this._mcQuantity._visible = false;
		this._txtQuantity.editable = false;
		this._txtQuantity.selectable = false;
		this._txtPrice.tabIndex = 0;
		this._txtQuantity.tabIndex = undefined;
		this._oDefaultButton = this._btnModify;
	}
	function addToShop(loc2, loc3, loc4)
	{
		this.api.network.Exchange.movementItem(true,loc2.ID,loc3,loc4);
	}
	function remove(loc2)
	{
		this.api.network.Exchange.movementItem(false,loc2.ID,loc2.Quantity);
	}
	function modify(loc2, loc3)
	{
		this.api.network.Exchange.movementItem(true,loc2.ID,0,loc3);
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
				this.setModifyMode(false);
				break;
			case "_btnModify":
				var loc3 = Number(this._txtPrice.text);
				if(_global.isNaN(loc3))
				{
					this.gapi.loadUIComponent("AskOk","AksOkBadPrice",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_PRICE")});
				}
				else
				{
					this.modify(this._oSelectedItem,loc3);
					this.hideItemViewer(true);
					this.setModifyMode(false);
				}
				break;
			case "_btnAdd":
				var loc4 = Number(this._txtPrice.text);
				var loc5 = Number(this._txtQuantity.text);
				if(_global.isNaN(loc4))
				{
					this.gapi.loadUIComponent("AskOk","AksOkBadPrice",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_PRICE")});
				}
				else if(_global.isNaN(loc5) || loc5 == 0)
				{
					this.gapi.loadUIComponent("AskOk","AksOkBadQuantity",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("ERROR_INVALID_QUANTITY")});
				}
				else
				{
					loc5 = Math.min(this._oSelectedItem.Quantity,loc5);
					this.addToShop(this._oSelectedItem,loc5,loc4);
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
	function over(loc2)
	{
		if((var loc0 = loc2.target._name) === "_btnOffline")
		{
			this.gapi.showTooltip(this.api.lang.getText("MERCHANT_MODE"),loc2.target,-20);
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
			this.setModifyMode(false);
		}
		else
		{
			this._oSelectedItem = loc2.item;
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = loc2.item;
			switch(loc2.target._name)
			{
				case "_livInventory":
					this._txtQuantity.text = loc2.item.Quantity;
					this._txtPrice.text = "";
					this.setModifyMode(false);
					this.setAddMode(true);
					this._livInventory2.setFilter(this._livInventory.currentFilterID);
					break;
				case "_livInventory2":
					this._txtQuantity.text = loc2.item.Quantity;
					this._txtPrice.text = loc2.item.price;
					this.setAddMode(false);
					this.setModifyMode(true);
					this._livInventory.setFilter(this._livInventory2.currentFilterID);
			}
			Selection.setFocus(this._txtPrice);
		}
	}
	function modelChanged(loc2)
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

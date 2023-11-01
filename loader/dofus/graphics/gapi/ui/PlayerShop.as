class dofus.graphics.gapi.ui.PlayerShop extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "PlayerShop";
	static var DELAY_BEFORE_CAN_SWITCH_MERCHANT = 500;
	function PlayerShop()
	{
		super();
	}
	function __set__data(var2)
	{
		this._oData = var2;
		return this.__get__data();
	}
	function __set__colors(var2)
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
		super.init(false,dofus.graphics.gapi.ui.PlayerShop.CLASS_NAME);
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
		this.setBuyMode(false);
	}
	function destroy()
	{
		if(this._timerSwitchMerchant == undefined)
		{
			return undefined;
		}
		_global.clearTimeout(this._timerSwitchMerchant);
	}
	function activateSwitchMerchantButtons()
	{
		this._btnViewNextMerchant.enabled = true;
		this._btnViewPreviousMerchant.enabled = true;
	}
	function addListeners()
	{
		this._livInventory.addEventListener("selectedItem",this);
		this._livInventory2.addEventListener("selectedItem",this);
		this._btnBuy.addEventListener("click",this);
		this._btnViewNextMerchant.addEventListener("click",this);
		this._btnViewPreviousMerchant.addEventListener("click",this);
		this._btnClose.addEventListener("click",this);
		this._ldrArtwork.addEventListener("complete",this);
		this._ldrArtwork.addEventListener("click",this);
		if(this._oData != undefined)
		{
			this._oData.addEventListener("modelChanged",this);
		}
		else
		{
			ank.utils.Logger.err("[PlayerShop] il n\'y a pas de data");
		}
		this._timerSwitchMerchant = _global.setTimeout(this,"activateSwitchMerchantButtons",dofus.graphics.gapi.ui.PlayerShop.DELAY_BEFORE_CAN_SWITCH_MERCHANT);
	}
	function initTexts()
	{
		this._btnBuy.label = this.api.lang.getText("BUY");
		this._btnViewNextMerchant.label = this.api.lang.getText("NEXT_WORD");
		this._btnViewPreviousMerchant.label = this.api.lang.getText("PREVIOUS_WORD");
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
	function hideItemViewer(var2)
	{
		this._itvItemViewer._visible = !var2;
		this._winItemViewer._visible = !var2;
		if(var2)
		{
			this._oSelectedItem = undefined;
		}
	}
	function setBuyMode(var2)
	{
		this._btnBuy._visible = var2;
		this._mcBuyArrow._visible = var2;
	}
	function askQuantity(var2, var3)
	{
		var var4 = Math.floor(this.api.datacenter.Player.Kama / var3);
		if(var4 > var2)
		{
			var4 = var2;
		}
		var var5 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:var4,min:1});
		var5.addEventListener("validate",this);
	}
	function validateBuy(var2)
	{
		if(var2 <= 0)
		{
			return undefined;
		}
		var2 = Math.min(this._oSelectedItem.Quantity,var2);
		if(this.api.datacenter.Player.Kama < this._oSelectedItem.price * var2)
		{
			this.gapi.loadUIComponent("AskOk","AskOkRich",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("NOT_ENOUGH_RICH")});
			return undefined;
		}
		this.api.network.Exchange.buy(this._oSelectedItem.ID,var2);
		this.hideItemViewer(true);
		this.setBuyMode(false);
	}
	function applyColor(var2, var3)
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
	function switchMerchant(var2)
	{
		var var3 = this.api.datacenter.Temporary.Shop.id;
		var var4 = new Array();
		var var5 = this.api.gfx.spriteHandler.getSprites().getItems();
		for(var sID in var5)
		{
			var var6 = var5[sID];
			if(var6 instanceof dofus.datacenter.OfflineCharacter)
			{
				var4.push({id:sID,cellNum:var6.cellNum});
			}
		}
		var var7 = undefined;
		if(var4.length > 1)
		{
			var4.sortOn(["id"],Array.NUMERIC);
			var var8 = 0;
			while(var8 < var4.length)
			{
				var var9 = var4[var8].id;
				if(var9 == var3)
				{
					if(var2)
					{
						if(var8 - 1 >= 0)
						{
							var7 = var4[var8 - 1];
						}
						else
						{
							var7 = var4[var4.length - 1];
						}
					}
					else if(var8 + 1 < var4.length)
					{
						var7 = var4[var8 + 1];
					}
					else
					{
						var7 = var4[0];
					}
					break;
				}
				var8 = var8 + 1;
			}
		}
		if(var7 == null)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("NO_OTHER_MERCHANT_ON_MAP"),"ERROR_CHAT");
			return undefined;
		}
		this._btnViewNextMerchant.enabled = false;
		this._btnViewPreviousMerchant.enabled = false;
		this.api.network.Exchange.leave();
		this.api.kernel.GameManager.startExchange(4,var7.id,var7.cellNum);
	}
	function modelChanged(var2)
	{
		this._livInventory2.dataProvider = this._oData.inventory;
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_ldrArtwork":
				this.api.kernel.GameManager.showPlayerPopupMenu(undefined,this._oData.name);
				break;
			case "_btnViewPreviousMerchant":
				this.switchMerchant(true);
				break;
			default:
				switch(null)
				{
					case "_btnViewNextMerchant":
						this.switchMerchant(false);
						break;
					case "_btnBuy":
						if(this._oSelectedItem.Quantity > 1)
						{
							this.askQuantity(this._oSelectedItem.Quantity,this._oSelectedItem.price);
						}
						else
						{
							this.validateBuy(1);
						}
						break;
					case "_btnClose":
						this.callClose();
				}
		}
	}
	function selectedItem(var2)
	{
		if(var2.item == undefined)
		{
			this.hideItemViewer(true);
			this.setBuyMode(false);
		}
		else
		{
			this._oSelectedItem = var2.item;
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = var2.item;
			switch(var2.target._name)
			{
				case "_livInventory":
					this.setBuyMode(false);
					this._livInventory2.setFilter(this._livInventory.currentFilterID);
					break;
				case "_livInventory2":
					this.setBuyMode(true);
					this._livInventory.setFilter(this._livInventory2.currentFilterID);
			}
		}
	}
	function validate(var2)
	{
		this.validateBuy(var2.value);
	}
	function complete(var2)
	{
		var ref = this;
		this._ldrArtwork.content.stringCourseColor = function(var2, var3)
		{
			ref.applyColor(var2,var3);
		};
	}
}

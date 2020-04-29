if(!dofus.graphics.gapi.ui.BigStoreBuy)
{
	if(!dofus)
	{
		_global.dofus = new Object();
	}
	if(!dofus.graphics)
	{
		_global.dofus.graphics = new Object();
	}
	if(!dofus.graphics.gapi)
	{
		_global.dofus.graphics.gapi = new Object();
	}
	if(!dofus.graphics.gapi.ui)
	{
		_global.dofus.graphics.gapi.ui = new Object();
	}
	dofus.graphics.gapi.ui.BigStoreBuy = function()
	{
		super();
	} extends dofus.graphics.gapi.core.DofusAdvancedComponent;
	var var1 = dofus.graphics.gapi.ui.BigStoreBuy = function()
	{
		super();
	}.prototype;
	var1.__set__data = function __set__data(var2)
	{
		this._oData = var2;
		return this.__get__data();
	};
	var1.__set__defaultSearch = function __set__defaultSearch(var2)
	{
		this._sDefaultSearch = var2;
		return this.__get__defaultSearch();
	};
	var1.applyFullSoulFilter = function applyFullSoulFilter(var2)
	{
		if(this._sFullSoulMonster == "")
		{
			this._dgPrices.dataProvider = var2;
			return undefined;
		}
		var var3 = new ank.utils.();
		var var4 = this._sFullSoulMonster.toUpperCase();
		var var5 = 0;
		while(var5 < var2.length)
		{
			var var6 = var2[var5];
			var var7 = var6.item;
			for(var j in var7._aEffects)
			{
				var var8 = var7._aEffects[j];
				if(var8[0] == 623)
				{
					var var9 = var8[3];
					var var10 = this.api.lang.getMonstersText(var9).n.toUpperCase();
					if(var10.indexOf(var4) != -1)
					{
						var3.push(var6);
						break;
					}
				}
			}
			var5 = var5 + 1;
		}
		this._dgPrices.dataProvider = var3;
	};
	var1.setButtons = function setButtons(var2, var3)
	{
		this._btnSelectedPrice.selected = false;
		this._btnSelectedPrice = var2;
		this._btnSelectedBuy.enabled = false;
		this._btnSelectedBuy = var3;
	};
	var1.selectPrice = function selectPrice(var2, var3, var4, var5)
	{
		if(var4 != this._btnSelectedPrice)
		{
			this._nSelectedPriceItemID = var2.id;
			this._nSelectedPriceIndex = var3;
			this.setButtons(var4,var5);
		}
		else
		{
			delete this._nSelectedPriceItemID;
			delete this._nSelectedPriceIndex;
			delete this._btnSelectedPrice;
			delete this._btnSelectedBuy;
		}
	};
	var1.isThisPriceSelected = function isThisPriceSelected(var2, var3)
	{
		return var2 == this._nSelectedPriceItemID && this._nSelectedPriceIndex == var3;
	};
	var1.askBuy = function askBuy(var2, var3, var4)
	{
		if(var2 != undefined && (var3 != undefined && !_global.isNaN(var4)))
		{
			if(var4 > this.api.datacenter.Player.Kama)
			{
				this.gapi.loadUIComponent("AskOk","AskOkNotRich",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("NOT_ENOUGH_RICH")});
			}
			else
			{
				var var5 = this.gapi.loadUIComponent("AskYesNo","AskYesNoBuy",{title:this.api.lang.getText("BIGSTORE"),text:this.api.lang.getText("DO_U_BUY_ITEM_BIGSTORE",["x" + this._oData["quantity" + var3] + " " + var2.name,var4]),params:{id:var2.ID,quantityIndex:var3,price:var4}});
				var5.addEventListener("yes",this);
			}
		}
	};
	var1.setType = function setType(var2)
	{
		var var3 = this._oData.types;
		var var4 = 0;
		while(var4 < var3.length)
		{
			if(var3[var4] == var2)
			{
				this._cbTypes.selectedIndex = var4;
				return undefined;
			}
			var4 = var4 + 1;
		}
	};
	var1.setItem = function setItem(var2)
	{
		var var3 = this._oData.inventory;
		var var4 = 0;
		while(var4 < var3.length)
		{
			if(var3[var4].unicID == var2)
			{
				if(this._lstItems.selectedIndex != var4)
				{
					this._lstItems.selectedIndex = var4;
					this._lstItems.setVPosition(var4);
				}
				break;
			}
			var4 = var4 + 1;
		}
		this.updateItem(new dofus.datacenter.(0,var2),true);
	};
	var1.askMiddlePrice = function askMiddlePrice(var2)
	{
		this.api.network.Exchange.getItemMiddlePriceInBigStore(var2.unicID);
	};
	var1.setMiddlePrice = function setMiddlePrice(var2, var3)
	{
		if(this._oCurrentItem.unicID == var2 && this._oCurrentItem != undefined)
		{
			this._lblPrices.text = this.api.lang.getText("BIGSTORE_MIDDLEPRICE",[var3]);
		}
	};
	var1.init = function init()
	{
		super.init(false,dofus.graphics.gapi.ui.BigStoreBuy.CLASS_NAME);
	};
	var1.callClose = function callClose()
	{
		this.gapi.hideTooltip();
		this.api.network.Exchange.leave();
		return true;
	};
	var1.createChildren = function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.populateComboBox});
		this.addToQueue({object:this,method:this.setQuantityHeader});
		this.addToQueue({object:this,method:this.updateData});
		this.hideItemViewer(true);
		this.addToQueue({object:this,method:this.showHelpSelectType,params:[true]});
		this.showArrowAnim(false);
	};
	var1.addListeners = function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnClose2.addEventListener("click",this);
		this._btnSearch.addEventListener("click",this);
		this._btnTypes.addEventListener("over",this);
		this._btnTypes.addEventListener("out",this);
		this._btnSwitchToSell.addEventListener("click",this);
		this._cbTypes.addEventListener("itemSelected",this);
		this._lstItems.addEventListener("itemSelected",this);
		this._dgPrices.addEventListener("itemSelected",this);
		if(this._oData != undefined)
		{
			this._oData.addEventListener("modelChanged",this);
			this._oData.addEventListener("modelChanged2",this);
		}
		else
		{
			ank.utils.Logger.err("[BigStoreBuy] il n\'y a pas de data");
		}
		this.api.datacenter.Player.addEventListener("kamaChanged",this);
	};
	var1.initTexts = function initTexts()
	{
		this._winBackground.title = this.api.lang.getText("BIGSTORE") + (this._oData != undefined?" (" + this.api.lang.getText("BIGSTORE_MAX_LEVEL") + " : " + this._oData.maxLevel + ")":"");
		this._lblItems.text = this.api.lang.getText("BIGSTORE_ITEM_LIST");
		this._lblTypes.text = this.api.lang.getText("ITEM_TYPE");
		this._lblKamas.text = this.api.lang.getText("WALLET") + " :";
		this._btnClose2.label = this.api.lang.getText("CLOSE");
		this._btnSearch.label = this.api.lang.getText("SEARCH");
		this._btnSwitchToSell.label = this.api.lang.getText("BIGSTORE_MODE_SELL");
	};
	var1.updateData = function updateData()
	{
		this.modelChanged();
		this.modelChanged2();
		this.kamaChanged({value:this.api.datacenter.Player.Kama});
	};
	var1.populateComboBox = function populateComboBox()
	{
		var var2 = this._oData.types;
		var var3 = new ank.utils.();
		var var4 = 0;
		while(var4 < var2.length)
		{
			var var5 = Number(var2[var4]);
			var3.push({label:this.api.lang.getItemTypeText(var5).n,id:var5});
			var4 = var4 + 1;
		}
		var3.sortOn("label");
		this._oData.types = new Array();
		var var6 = 0;
		while(var6 < var2.length)
		{
			this._oData.types.push(var3[var6].id);
			var6 = var6 + 1;
		}
		this._cbTypes.dataProvider = var3;
	};
	var1.setQuantityHeader = function setQuantityHeader()
	{
		this._dgPrices.columnsNames = ["","x" + this._oData.quantity1,"x" + this._oData.quantity2,"x" + this._oData.quantity3];
	};
	var1.hideItemViewer = function hideItemViewer(var2)
	{
		this._itvItemViewer._visible = !var2;
		this._mcItemViewerDescriptionBack._visible = !var2;
		this._mcSpacer._visible = !var2;
		if(!var2)
		{
			this.showHelpSelectType(false);
			this.showHelpSelectPrice(false);
			this.showHelpSelectPrice(false);
		}
	};
	var1.updateType = function updateType(var2)
	{
		this._lstItems.selectedIndex = -1;
		this.updateItem();
		this.showHelpSelectItem(true);
		this.api.network.Exchange.bigStoreType(var2);
	};
	var1.updateItem = function updateItem(var2, var3)
	{
		this._oCurrentItem = var2;
		this.hideItemViewer(true);
		this.showHelpSelectPrice(true);
		this._dgPrices.selectedIndex = -1;
		delete this._nSelectedPriceItemID;
		delete this._nSelectedPriceIndex;
		delete this._btnSelectedPrice;
		delete this._btnSelectedBuy;
		if(var3 != true)
		{
			if(var2 != undefined)
			{
				this.api.network.Exchange.bigStoreItemList(var2.unicID);
			}
			else
			{
				this._dgPrices.dataProvider = new ank.utils.();
			}
			this._bFullSoul = var2.type == 85;
			this._sFullSoulMonster = "";
		}
	};
	var1.showHelpSelectType = function showHelpSelectType(var2)
	{
		this._mcBottomArrow._visible = false;
		this._mcBottomArrow.stop();
		this._mcLeftArrow._visible = var2;
		this._mcLeftArrow.play();
		this._mcLeft2Arrow._visible = false;
		this._mcLeft2Arrow.stop();
		this._lblNoItem.text = !var2?"":this.api.lang.getText("BIGSTORE_HELP_SELECT_TYPE");
	};
	var1.showHelpSelectPrice = function showHelpSelectPrice(var2)
	{
		this._mcBottomArrow._visible = var2;
		this._mcBottomArrow.play();
		this._mcLeftArrow._visible = false;
		this._mcLeftArrow.stop();
		this._mcLeft2Arrow._visible = false;
		this._mcLeft2Arrow.stop();
		this._lblNoItem.text = !var2?"":this.api.lang.getText("BIGSTORE_HELP_SELECT_PRICE");
	};
	var1.showHelpSelectItem = function showHelpSelectItem(var2)
	{
		this._mcBottomArrow._visible = false;
		this._mcBottomArrow.stop();
		this._mcLeftArrow._visible = false;
		this._mcLeftArrow.stop();
		this._mcLeft2Arrow._visible = var2;
		this._mcLeft2Arrow.play();
		this._lblNoItem.text = !var2?"":this.api.lang.getText("BIGSTORE_HELP_SELECT_ITEM");
	};
	var1.showArrowAnim = function showArrowAnim(var2)
	{
		if(var2)
		{
			this._mcArrowAnim._visible = true;
			this._mcArrowAnim.play();
			ank.utils.Timer.setTimer(this,"bigstore",this,this.showArrowAnim,800,[false]);
		}
		else
		{
			this._mcArrowAnim._visible = false;
			this._mcArrowAnim.stop();
		}
	};
	var1.onSearchResult = function onSearchResult(var2)
	{
		if(var2)
		{
			this.api.ui.unloadUIComponent("BigStoreSearch");
		}
		else
		{
			this.api.kernel.showMessage(this.api.lang.getText("BIGSTORE"),this.api.lang.getText("ITEM_NOT_IN_BIGSTORE"),"ERROR_BOX");
		}
	};
	var1.click = function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnClose":
			case "_btnClose2":
				this.callClose();
				break;
			default:
				switch(null)
				{
					case "_btnSearch":
						if(this._bFullSoul)
						{
							this.api.ui.loadUIComponent("BigStoreSearchFullSoul","BigStoreSearchFullSoul",{oParent:this});
						}
						else
						{
							this.api.ui.loadUIComponent("BigStoreSearch","BigStoreSearch",{types:this._oData.types,defaultSearch:this._sDefaultSearch,oParent:this});
						}
						break;
					case "_btnSwitchToSell":
						this.api.network.Exchange.request(10,this._oData.npcID);
				}
		}
	};
	var1.itemSelected = function itemSelected(var2)
	{
		switch(var2.target._name)
		{
			case "_cbTypes":
				this.updateType(this._cbTypes.selectedItem.id);
				break;
			case "_lstItems":
				if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && var2.row.item != undefined)
				{
					this.api.kernel.GameManager.insertItemInChat(var2.row.item);
					return undefined;
				}
				if(this._lblPrices.text != undefined)
				{
					this._lblPrices.text = "";
				}
				this.askMiddlePrice(var2.row.item);
				this.updateItem(var2.row.item);
				break;
			case "_dgPrices":
				§§push(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY));
				if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY))
				{
				}
				if(§§pop())
				{
					this.api.kernel.GameManager.insertItemInChat(var2.row.item.item);
					return undefined;
				}
				this._itvItemViewer.itemData = var2.row.item.item;
				this.hideItemViewer(false);
				this.showArrowAnim(true);
				break;
			default:
				§§pop();
				if(var2.row.item.item != undefined)
				{
					this.api.kernel.GameManager.insertItemInChat(var2.row.item.item);
					return undefined;
				}
				this._itvItemViewer.itemData = var2.row.item.item;
				this.hideItemViewer(false);
				this.showArrowAnim(true);
				break;
		}
	};
	var1.modelChanged = function modelChanged(var2)
	{
		var var3 = this._oData.inventory;
		var3.bubbleSortOn("level",Array.DESCENDING);
		var3.reverse();
		this._lstItems.dataProvider = var3;
		if(var3 != 0 && var3 != undefined)
		{
			this._lblItemsCount.text = var3.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"),"m",var3.length < 2);
		}
		else
		{
			this._lblItemsCount.text = this.api.lang.getText("NO_BIGSTORE_RESULT");
		}
	};
	var1.fullSoulItemsMovement = function fullSoulItemsMovement()
	{
		if(this["\x04\x01\bF\x07\x02"] && this["\x04\x01\be4�\x02"] != "�\x0b,N�\x02")
		{
			this["�\r@\x1c�\x02"]();
		}
	};
	var1.modelChanged2 = function modelChanged2(var2)
	{
		var var3 = var2.eventName != "updateOne"?null:this._nSelectedPriceItemID;
		var var4 = var2.eventName != "updateOne"?null:this._nSelectedPriceIndex;
		delete this._nSelectedPriceItemID;
		delete this._nSelectedPriceIndex;
		delete this._btnSelectedPrice;
		delete this._btnSelectedBuy;
		this._btnSelectedPrice.selected = false;
		this._btnSelectedBuy.enabled = false;
		if(var3 != undefined)
		{
			var var5 = this._oData.inventory2;
			var var6 = 0;
			while(var6 < var5.length)
			{
				if(var5[var6].id == var3)
				{
					this._nSelectedPriceItemID = var3;
					this._nSelectedPriceIndex = var4;
					break;
				}
				var6 = var6 + 1;
			}
		}
		if(this._nSelectedPriceItemID == undefined)
		{
			this.hideItemViewer(true);
		}
		var var7 = this._oData.inventory2;
		var7.bubbleSortOn("priceSet1",Array.DESCENDING);
		var7.reverse();
		if(this._bFullSoul)
		{
			this.applyFullSoulFilter(var7);
		}
		else
		{
			this._dgPrices.dataProvider = var7;
		}
	};
	var1.yes = function yes(var2)
	{
		this["�"]["\b�\x07\x01"][""]["]"](var2["\b\x1eN�\x02"]["\x05\x01�\x02"]["\x04\x04P�\x01"],var2["\b\x1eN�\x02"]["\x05\x01�\x02"]["\b�\x07\x03"],var2["\b\x1eN�\x02"]["\x05\x01�\x02"][""]);
		this["\b4R�\t"](true);
		this(true);
	};
	var1.kamaChanged = function kamaChanged(var2)
	{
		this["�\x06"]["\""] = new eval("\b\x03N�\x02")["\b\x04�\x02"].0�(var2["\x04\x03\x03I\x12L\x12�\x02"])["\x05\x01�\x02"](this["�"]["�\x04"]["\b/N�\x02"]("\x04\x04\x04\x01\b\x1dN�\x02"),3);
	};
	var1["\b�N�\x02"] = function §\b�N�\x02§(var2)
	{
		var var3 = this.api.lang.getText("BIGSTORE_MAX_LEVEL") + " : " + this._oData.maxLevel;
		var3 = var3 + ("\n" + this.api.lang.getText("BIGSTORE_TAX") + " : " + this._oData.tax + "%");
		var3 = var3 + ("\n" + this.api.lang.getText("BIGSTORE_MAX_ITEM_PER_ACCOUNT") + " : " + this._oData.maxItemCount);
		var3 = var3 + ("\n" + this.api.lang.getText("BIGSTORE_MAX_SELL_TIME") + " : " + this._oData.maxSellTime + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",this._oData.maxSellTime < 2));
		var3 = var3 + ("\n\n" + this.api.lang.getText("BIGSTORE_TYPES") + " :");
		var var4 = this._oData.types;
		for(var k in var4)
		{
			var3 = var3 + ("\n - " + this.api.lang.getItemTypeText(var4[k]).n);
		}
		this.gapi.showTooltip(var3,var2.target,20);
	};
	var1.out = function out(var2)
	{
		this["M&�\x04"]();
	};
	var1["��\'R\x17�\x03"]("",function()
	{
	}
	,var1["\x04\x01\b#4P�\x02"]);
	var1["��\'R\x17�\x03"]("",function()
	{
	}
	,var1[""]);
	eval("\x03")(var1,null,1);
	dofus.graphics.gapi.ui.BigStoreBuy = function()
	{
		super();
	}["\b�\b�\x07\x01"] = "\x03";
	var1["c%<O�\x04"] = "�\x0b,N�\x02";
}

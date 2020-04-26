class dofus.graphics.gapi.ui.BigStoreBuy extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "BigStoreBuy";
	var _sDefaultSearch = "";
	function BigStoreBuy()
	{
		super();
	}
	function __set__data(loc2)
	{
		this._oData = loc2;
		return this.__get__data();
	}
	function __set__defaultSearch(loc2)
	{
		this._sDefaultSearch = loc2;
		return this.__get__defaultSearch();
	}
	function applyFullSoulFilter(loc2)
	{
		if(this._sFullSoulMonster == "")
		{
			this._dgPrices.dataProvider = loc2;
			return undefined;
		}
		var loc3 = new ank.utils.();
		var loc4 = this._sFullSoulMonster.toUpperCase();
		var loc5 = 0;
		while(loc5 < loc2.length)
		{
			var loc6 = loc2[loc5];
			var loc7 = loc6.item;
			for(var loc8 in loc7._aEffects)
			{
				if(loc8[0] == 623)
				{
					var loc9 = loc8[3];
					var loc10 = this.api.lang.getMonstersText(loc9).n.toUpperCase();
					if(loc10.indexOf(loc4) != -1)
					{
						loc3.push(loc6);
						break;
					}
				}
			}
			loc5 = loc5 + 1;
		}
		this._dgPrices.dataProvider = loc3;
	}
	function setButtons(loc2, loc3)
	{
		this._btnSelectedPrice.selected = false;
		this._btnSelectedPrice = loc2;
		this._btnSelectedBuy.enabled = false;
		this._btnSelectedBuy = loc3;
	}
	function selectPrice(loc2, loc3, loc4, loc5)
	{
		if(loc4 != this._btnSelectedPrice)
		{
			this._nSelectedPriceItemID = loc2.id;
			this._nSelectedPriceIndex = loc3;
			this.setButtons(loc4,loc5);
		}
		else
		{
			delete this._nSelectedPriceItemID;
			delete this._nSelectedPriceIndex;
			delete this._btnSelectedPrice;
			delete this._btnSelectedBuy;
		}
	}
	function isThisPriceSelected(loc2, loc3)
	{
		return loc2 == this._nSelectedPriceItemID && this._nSelectedPriceIndex == loc3;
	}
	function askBuy(loc2, loc3, loc4)
	{
		if(loc2 != undefined && (loc3 != undefined && !_global.isNaN(loc4)))
		{
			if(loc4 > this.api.datacenter.Player.Kama)
			{
				this.gapi.loadUIComponent("AskOk","AskOkNotRich",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("NOT_ENOUGH_RICH")});
			}
			else
			{
				var loc5 = this.gapi.loadUIComponent("AskYesNo","AskYesNoBuy",{title:this.api.lang.getText("BIGSTORE"),text:this.api.lang.getText("DO_U_BUY_ITEM_BIGSTORE",["x" + this._oData["quantity" + loc3] + " " + loc2.name,loc4]),params:{id:loc2.ID,quantityIndex:loc3,price:loc4}});
				loc5.addEventListener("yes",this);
			}
		}
	}
	function setType(loc2)
	{
		var loc3 = this._oData.types;
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			if(loc3[loc4] == loc2)
			{
				this._cbTypes.selectedIndex = loc4;
				return undefined;
			}
			loc4 = loc4 + 1;
		}
	}
	function setItem(loc2)
	{
		var loc3 = this._oData.inventory;
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			if(loc3[loc4].unicID == loc2)
			{
				if(this._lstItems.selectedIndex != loc4)
				{
					this._lstItems.selectedIndex = loc4;
					this._lstItems.setVPosition(loc4);
				}
				break;
			}
			loc4 = loc4 + 1;
		}
		this.updateItem(new dofus.datacenter.(0,loc2),true);
	}
	function askMiddlePrice(loc2)
	{
		this.api.network.Exchange.getItemMiddlePriceInBigStore(loc2.unicID);
	}
	function setMiddlePrice(loc2, loc3)
	{
		if(this._oCurrentItem.unicID == loc2 && this._oCurrentItem != undefined)
		{
			this._lblPrices.text = this.api.lang.getText("BIGSTORE_MIDDLEPRICE",[loc3]);
		}
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.BigStoreBuy.CLASS_NAME);
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
		this.addToQueue({object:this,method:this.setQuantityHeader});
		this.addToQueue({object:this,method:this.updateData});
		this.hideItemViewer(true);
		this.addToQueue({object:this,method:this.showHelpSelectType,params:[true]});
		this.showArrowAnim(false);
	}
	function addListeners()
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
	}
	function initTexts()
	{
		this._winBackground.title = this.api.lang.getText("BIGSTORE") + (this._oData != undefined?" (" + this.api.lang.getText("BIGSTORE_MAX_LEVEL") + " : " + this._oData.maxLevel + ")":"");
		this._lblItems.text = this.api.lang.getText("BIGSTORE_ITEM_LIST");
		this._lblTypes.text = this.api.lang.getText("ITEM_TYPE");
		this._lblKamas.text = this.api.lang.getText("WALLET") + " :";
		this._btnClose2.label = this.api.lang.getText("CLOSE");
		this._btnSearch.label = this.api.lang.getText("SEARCH");
		this._btnSwitchToSell.label = this.api.lang.getText("BIGSTORE_MODE_SELL");
	}
	function updateData()
	{
		this.modelChanged();
		this.modelChanged2();
		this.kamaChanged({value:this.api.datacenter.Player.Kama});
	}
	function populateComboBox()
	{
		var loc2 = this._oData.types;
		var loc3 = new ank.utils.();
		var loc4 = 0;
		while(loc4 < loc2.length)
		{
			var loc5 = Number(loc2[loc4]);
			loc3.push({label:this.api.lang.getItemTypeText(loc5).n,id:loc5});
			loc4 = loc4 + 1;
		}
		loc3.sortOn("label");
		this._oData.types = new Array();
		var loc6 = 0;
		while(loc6 < loc2.length)
		{
			this._oData.types.push(loc3[loc6].id);
			loc6 = loc6 + 1;
		}
		this._cbTypes.dataProvider = loc3;
	}
	function setQuantityHeader()
	{
		this._dgPrices.columnsNames = ["","x" + this._oData.quantity1,"x" + this._oData.quantity2,"x" + this._oData.quantity3];
	}
	function hideItemViewer(loc2)
	{
		this._itvItemViewer._visible = !loc2;
		this._mcItemViewerDescriptionBack._visible = !loc2;
		this._mcSpacer._visible = !loc2;
		if(!loc2)
		{
			this.showHelpSelectType(false);
			this.showHelpSelectPrice(false);
			this.showHelpSelectPrice(false);
		}
	}
	function updateType(loc2)
	{
		this._lstItems.selectedIndex = -1;
		this.updateItem();
		this.showHelpSelectItem(true);
		this.api.network.Exchange.bigStoreType(loc2);
	}
	function updateItem(loc2, loc3)
	{
		this._oCurrentItem = loc2;
		this.hideItemViewer(true);
		this.showHelpSelectPrice(true);
		this._dgPrices.selectedIndex = -1;
		delete this._nSelectedPriceItemID;
		delete this._nSelectedPriceIndex;
		delete this._btnSelectedPrice;
		delete this._btnSelectedBuy;
		if(loc3 != true)
		{
			if(loc2 != undefined)
			{
				this.api.network.Exchange.bigStoreItemList(loc2.unicID);
			}
			else
			{
				this._dgPrices.dataProvider = new ank.utils.();
			}
			this._bFullSoul = loc2.type == 85;
			this._sFullSoulMonster = "";
		}
	}
	function showHelpSelectType(loc2)
	{
		this._mcBottomArrow._visible = false;
		this._mcBottomArrow.stop();
		this._mcLeftArrow._visible = loc2;
		this._mcLeftArrow.play();
		this._mcLeft2Arrow._visible = false;
		this._mcLeft2Arrow.stop();
		this._lblNoItem.text = !loc2?"":this.api.lang.getText("BIGSTORE_HELP_SELECT_TYPE");
	}
	function showHelpSelectPrice(loc2)
	{
		this._mcBottomArrow._visible = loc2;
		this._mcBottomArrow.play();
		this._mcLeftArrow._visible = false;
		this._mcLeftArrow.stop();
		this._mcLeft2Arrow._visible = false;
		this._mcLeft2Arrow.stop();
		this._lblNoItem.text = !loc2?"":this.api.lang.getText("BIGSTORE_HELP_SELECT_PRICE");
	}
	function showHelpSelectItem(loc2)
	{
		this._mcBottomArrow._visible = false;
		this._mcBottomArrow.stop();
		this._mcLeftArrow._visible = false;
		this._mcLeftArrow.stop();
		this._mcLeft2Arrow._visible = loc2;
		this._mcLeft2Arrow.play();
		this._lblNoItem.text = !loc2?"":this.api.lang.getText("BIGSTORE_HELP_SELECT_ITEM");
	}
	function showArrowAnim(loc2)
	{
		if(loc2)
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
	}
	function onSearchResult(loc2)
	{
		if(loc2)
		{
			this.api.ui.unloadUIComponent("BigStoreSearch");
		}
		else
		{
			this.api.kernel.showMessage(this.api.lang.getText("BIGSTORE"),this.api.lang.getText("ITEM_NOT_IN_BIGSTORE"),"ERROR_BOX");
		}
	}
	function click(loc2)
	{
		switch(loc2.target._name)
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
	}
	function itemSelected(loc2)
	{
		switch(loc2.target._name)
		{
			case "_cbTypes":
				this.updateType(this._cbTypes.selectedItem.id);
				break;
			case "_lstItems":
				if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && loc2.row.item != undefined)
				{
					this.api.kernel.GameManager.insertItemInChat(loc2.row.item);
					return undefined;
				}
				if(this._lblPrices.text != undefined)
				{
					this._lblPrices.text = "";
				}
				this.askMiddlePrice(loc2.row.item);
				this.updateItem(loc2.row.item);
				break;
			case "_dgPrices":
				if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && loc2.row.item.item != undefined)
				{
					this.api.kernel.GameManager.insertItemInChat(loc2.row.item.item);
					return undefined;
				}
				this._itvItemViewer.itemData = loc2.row.item.item;
				this.hideItemViewer(false);
				this.showArrowAnim(true);
				break;
		}
	}
	function modelChanged(loc2)
	{
		var loc3 = this._oData.inventory;
		loc3.bubbleSortOn("level",Array.DESCENDING);
		loc3.reverse();
		this._lstItems.dataProvider = loc3;
		if(loc3 != 0 && loc3 != undefined)
		{
			this._lblItemsCount.text = loc3.length + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("OBJECTS"),"m",loc3.length < 2);
		}
		else
		{
			this._lblItemsCount.text = this.api.lang.getText("NO_BIGSTORE_RESULT");
		}
	}
	function fullSoulItemsMovement()
	{
		if(this._bFullSoul && this._sFullSoulMonster != "")
		{
			this.modelChanged2();
		}
	}
	function modelChanged2(loc2)
	{
		var loc3 = loc2.eventName != "updateOne"?null:this._nSelectedPriceItemID;
		var loc4 = loc2.eventName != "updateOne"?null:this._nSelectedPriceIndex;
		delete this._nSelectedPriceItemID;
		delete this._nSelectedPriceIndex;
		delete this._btnSelectedPrice;
		delete this._btnSelectedBuy;
		this._btnSelectedPrice.selected = false;
		this._btnSelectedBuy.enabled = false;
		if(loc3 != undefined)
		{
			var loc5 = this._oData.inventory2;
			var loc6 = 0;
			while(loc6 < loc5.length)
			{
				if(loc5[loc6].id == loc3)
				{
					this._nSelectedPriceItemID = loc3;
					this._nSelectedPriceIndex = loc4;
					break;
				}
				loc6 = loc6 + 1;
			}
		}
		if(this._nSelectedPriceItemID == undefined)
		{
			this.hideItemViewer(true);
		}
		var loc7 = this._oData.inventory2;
		loc7.bubbleSortOn("priceSet1",Array.DESCENDING);
		loc7.reverse();
		if(this._bFullSoul)
		{
			this.applyFullSoulFilter(loc7);
		}
		else
		{
			this._dgPrices.dataProvider = loc7;
		}
	}
	function yes(loc2)
	{
		this.api.network.Exchange.bigStoreBuy(loc2.target.params.id,loc2.target.params.quantityIndex,loc2.target.params.price);
		this.hideItemViewer(true);
		this.showHelpSelectPrice(true);
	}
	function kamaChanged(loc2)
	{
		this._lblKamasValue.text = new ank.utils.(loc2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
	}
	function over(loc2)
	{
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
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}

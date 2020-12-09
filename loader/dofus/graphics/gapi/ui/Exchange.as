class dofus.graphics.gapi.ui.Exchange extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Exchange";
	static var FILTER_EQUIPEMENT = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false];
	static var FILTER_NONEQUIPEMENT = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false];
	static var FILTER_RESSOURECES = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false];
	static var READY_COLOR = {ra:70,rb:0,ga:70,gb:0,ba:70,bb:0};
	static var NON_READY_COLOR = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
	static var DELAY_BEFORE_VALIDATE = 3000;
	var _nDistantReadyState = false;
	var _aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_EQUIPEMENT;
	var _nSelectedTypeID = 0;
	function Exchange()
	{
		super();
	}
	function __get__currentOverItem()
	{
		return this._oOverItem;
	}
	function __get__itemViewer()
	{
		return this._itvItemViewer;
	}
	function __set__dataProvider(§\x10\x14§)
	{
		this._eaDataProvider.removeEventListener("modelChanged",this);
		this._eaDataProvider = var2;
		this._eaDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__dataProvider();
	}
	function __set__localDataProvider(§\x10\r§)
	{
		this._eaLocalDataProvider.removeEventListener("modelChange",this);
		this._eaLocalDataProvider = var2;
		this._eaLocalDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__localDataProvider();
	}
	function __set__distantDataProvider(§\x10\x13§)
	{
		this._eaDistantDataProvider.removeEventListener("modelChange",this);
		this._eaDistantDataProvider = var2;
		this._eaDistantDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__distantDataProvider();
	}
	function __set__readyDataProvider(§\x10\x04§)
	{
		this._eaReadyDataProvider.removeEventListener("modelChange",this);
		this._eaReadyDataProvider = var2;
		this._eaReadyDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__readyDataProvider();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Exchange.CLASS_NAME);
	}
	function callClose()
	{
		this.api.network.Exchange.leave();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this._btnSelectedFilterButton = this._btnFilterEquipement;
		this.addToQueue({object:this,method:this.initData});
		this.hideItemViewer(true);
		this.addToQueue({object:this,method:this.initTexts});
		this._btnPrivateChat._visible = this.api.datacenter.Exchange.distantPlayerID > 0;
		this.gapi.unloadLastUIAutoHideComponent();
	}
	function destroy()
	{
		if(this._timerExchange == undefined)
		{
			return undefined;
		}
		_global.clearTimeout(this._timerExchange);
	}
	function addListeners()
	{
		this._cgGrid.addEventListener("dblClickItem",this);
		this._cgGrid.addEventListener("dropItem",this);
		this._cgGrid.addEventListener("dragItem",this);
		this._cgGrid.addEventListener("selectItem",this);
		this._cgGrid.addEventListener("overItem",this);
		this._cgGrid.addEventListener("outItem",this);
		this._cgLocal.addEventListener("dblClickItem",this);
		this._cgLocal.addEventListener("dropItem",this);
		this._cgLocal.addEventListener("dragItem",this);
		this._cgLocal.addEventListener("selectItem",this);
		this._cgLocal.addEventListener("overItem",this);
		this._cgLocal.addEventListener("outItem",this);
		this._cgDistant.addEventListener("selectItem",this);
		this._cgDistant.addEventListener("overItem",this);
		this._cgDistant.addEventListener("outItem",this);
		this._cgDistant.multipleContainerSelectionEnabled = false;
		this._btnFilterEquipement.addEventListener("click",this);
		this._btnFilterNonEquipement.addEventListener("click",this);
		this._btnFilterRessoureces.addEventListener("click",this);
		this._btnFilterEquipement.addEventListener("over",this);
		this._btnFilterNonEquipement.addEventListener("over",this);
		this._btnFilterRessoureces.addEventListener("over",this);
		this._btnFilterEquipement.addEventListener("out",this);
		this._btnFilterNonEquipement.addEventListener("out",this);
		this._btnFilterRessoureces.addEventListener("out",this);
		this._btnClose.addEventListener("click",this);
		this.api.datacenter.Exchange.addEventListener("localKamaChange",this);
		this.api.datacenter.Exchange.addEventListener("distantKamaChange",this);
		this._btnValidate.addEventListener("click",this);
		this._btnPrivateChat.addEventListener("click",this);
		this._cbTypes.addEventListener("itemSelected",this);
	}
	function initTexts()
	{
		this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
		this._winInventory.title = this.api.datacenter.Player.data.name;
		this._winDistant.title = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name;
		this._btnValidate.label = this.api.lang.getText("ACCEPT");
		this._lblKama.text = new ank.utils.(this.api.datacenter.Player.Kama).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		this._btnPrivateChat.label = this.api.lang.getText("WISPER_MESSAGE");
	}
	function initData()
	{
		this.dataProvider = this.api.datacenter.Exchange.inventory;
		this.localDataProvider = this.api.datacenter.Exchange.localGarbage;
		this.distantDataProvider = this.api.datacenter.Exchange.distantGarbage;
		this.readyDataProvider = this.api.datacenter.Exchange.readyStates;
	}
	function updateData()
	{
		var var2 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.Exchange.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
		this._nSelectedTypeID = var2 != undefined?var2:0;
		var var3 = new ank.utils.
();
		var var4 = new ank.utils.
();
		var var5 = new Object();
		for(var k in this._eaDataProvider)
		{
			var var6 = this._eaDataProvider[k];
			var var7 = var6.position;
			if(var7 == -1 && this._aSelectedSuperTypes[var6.superType])
			{
				if(var6.type == this._nSelectedTypeID || this._nSelectedTypeID == 0)
				{
					var3.push(var6);
				}
				var var8 = var6.type;
				if(var5[var8] != true)
				{
					var4.push({label:this.api.lang.getItemTypeText(var8).n,id:var8});
					var5[var8] = true;
				}
			}
		}
		var4.sortOn("label");
		var4.splice(0,0,{label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
		this._cbTypes.dataProvider = var4;
		this.setType(this._nSelectedTypeID);
		this._cgGrid.dataProvider = var3;
	}
	function setType(§\x1e\x1c\x02§)
	{
		var var3 = this._cbTypes.dataProvider;
		var var4 = 0;
		while(var4 < var3.length)
		{
			if(var3[var4].id == var2)
			{
				this._cbTypes.selectedIndex = var4;
				return undefined;
			}
			var4 = var4 + 1;
		}
		this._nSelectedTypeID = 0;
		this._cbTypes.selectedIndex = this._nSelectedTypeID;
	}
	function onDataUpdated()
	{
		_global.clearTimeout(this._timerExchange);
		this._timerExchange = _global.setTimeout(this,"hideButtonValidate",dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE,false);
	}
	function updateLocalData()
	{
		this._cgLocal.dataProvider = this._eaLocalDataProvider;
		this.hideButtonValidate(true);
		this.onDataUpdated();
	}
	function updateDistantData()
	{
		this._cgDistant.dataProvider = this._eaDistantDataProvider;
		this.hideButtonValidate(true);
		this.onDataUpdated();
	}
	function updateReadyState()
	{
		var var2 = !this._eaReadyDataProvider[0]?dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR:dofus.graphics.gapi.ui.Exchange.READY_COLOR;
		this.setMovieClipTransform(this._winLocal,var2);
		this.setMovieClipTransform(this._btnValidate,var2);
		this.setMovieClipTransform(this._cgLocal,var2);
		var2 = !this._eaReadyDataProvider[1]?dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR:dofus.graphics.gapi.ui.Exchange.READY_COLOR;
		this.setMovieClipTransform(this._winDistant,var2);
		this.setMovieClipTransform(this._cgDistant,var2);
	}
	function hideButtonValidate(§\x19\x0e§)
	{
		var var3 = !var2?dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR:dofus.graphics.gapi.ui.Exchange.READY_COLOR;
		this.setMovieClipTransform(this._btnValidate,var3);
		this._btnValidate.enabled = !var2;
	}
	function hideItemViewer(§\x19\x0e§)
	{
		this._itvItemViewer._visible = !var2;
		this._winItemViewer._visible = !var2;
	}
	function moveItems(§\x1e\x10§, §\x1c\x1a§)
	{
		var var4 = new Array();
		var var5 = 0;
		while(var5 < var2.length)
		{
			var var6 = var2[var5];
			var4.push({Add:var3,ID:var6.ID,Quantity:var6.Quantity});
			var5 = var5 + 1;
		}
		this.api.network.Exchange.movementItems(var4);
	}
	function validateDrop(§\x1e\r\f§, §\x1e\x19\r§, §\x1e\x1b\x17§)
	{
		if(var4 < 1 || var4 == undefined)
		{
			return undefined;
		}
		if(var4 > var3.Quantity)
		{
			var4 = var3.Quantity;
		}
		if((var var0 = var2) !== "_cgGrid")
		{
			if(var0 === "_cgLocal")
			{
				this.api.network.Exchange.movementItem(true,var3,var4);
			}
		}
		else
		{
			this.api.network.Exchange.movementItem(false,var3,var4);
		}
	}
	function validateKama(§\x01\x0e§)
	{
		if(var2 > this.api.datacenter.Player.Kama)
		{
			var2 = this.api.datacenter.Player.Kama;
		}
		this.api.network.Exchange.movementKama(var2);
	}
	function askKamaQuantity()
	{
		var var2 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:this.api.datacenter.Exchange.localKama,max:this.api.datacenter.Player.Kama,min:0,params:{targetType:"kama"}});
		var2.addEventListener("validate",this);
	}
	function modelChanged(§\x1e\x19\x18§)
	{
		loop0:
		switch(var2.target)
		{
			case this._eaReadyDataProvider:
				this.updateReadyState();
				break;
			case this._eaLocalDataProvider:
				this.updateLocalData();
				break;
			default:
				switch(null)
				{
					case this._eaDistantDataProvider:
						this.updateDistantData();
						break loop0;
					case this._eaDataProvider:
						this.updateData();
						break loop0;
					default:
						this.updateData();
						this.updateLocalData();
						this.updateDistantData();
				}
		}
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_btnClose":
				this.callClose();
				break;
			case "_btnValidate":
				this.api.network.Exchange.ready();
				break;
			case "_btnPrivateChat":
				if(this.api.datacenter.Exchange.distantPlayerID > 0)
				{
					this.api.kernel.GameManager.askPrivateMessage(this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name);
				}
				break;
			default:
				if(var2.target != this._btnSelectedFilterButton)
				{
					this._btnSelectedFilterButton.selected = false;
					this._btnSelectedFilterButton = var2.target;
					if((var0 = var2.target._name) !== "_btnFilterEquipement")
					{
						switch(null)
						{
							case "_btnFilterNonEquipement":
								this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_NONEQUIPEMENT;
								this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
								break;
							case "_btnFilterRessoureces":
								this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_RESSOURECES;
								this._lblFilter.text = this.api.lang.getText("RESSOURECES");
						}
					}
					else
					{
						this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Exchange.FILTER_EQUIPEMENT;
						this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
					}
					this.updateData(true);
					break;
				}
				var2.target.selected = true;
				break;
		}
	}
	function overItem(§\x1e\x19\x18§)
	{
		var var3 = var2.target.contentData;
		var3.showStatsTooltip(var2.target,var2.target.contentData.style);
		this._oOverItem = var3;
	}
	function outItem(§\x1e\x19\x18§)
	{
		this.gapi.hideTooltip();
		this._oOverItem = undefined;
	}
	function dblClickItem(§\x1e\x19\x18§)
	{
		var var3 = var2.target.contentData;
		var var4 = var2.targets;
		if(var3 == undefined)
		{
			return undefined;
		}
		var var5 = Key.isDown(dofus.Constants.SELECT_MULTIPLE_ITEMS_KEY);
		var var6 = !var5?1:var3.Quantity;
		var var7 = var2.owner._name;
		switch(var7)
		{
			case "_cgGrid":
				if(var5 && var4.length > 1)
				{
					this.moveItems(var4,true);
				}
				else
				{
					this.validateDrop("_cgLocal",var3,var6);
				}
				break;
			case "_cgLocal":
				if(var5 && var4.length > 1)
				{
					this.moveItems(var4,false);
					break;
				}
				this.validateDrop("_cgGrid",var3,var6);
				break;
		}
	}
	function dragItem(§\x1e\x19\x18§)
	{
		this.gapi.removeCursor();
		if(var2.target.contentData == undefined)
		{
			return undefined;
		}
		this.gapi.setCursor(var2.target.contentData);
	}
	function dropItem(§\x1e\x19\x18§)
	{
		var var3 = this.gapi.getCursor();
		if(var3 == undefined)
		{
			return undefined;
		}
		this.gapi.removeCursor();
		var var4 = var2.target._parent._parent._name;
		switch(var4)
		{
			case "_cgGrid":
				if(var3.position == -1)
				{
					return undefined;
				}
				break;
			case "_cgLocal":
				if(var3.position == -2)
				{
					return undefined;
				}
				break;
		}
		if(var3.Quantity > 1)
		{
			var var5 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:var3.Quantity,params:{targetType:"item",oItem:var3,targetGrid:var4}});
			var5.addEventListener("validate",this);
		}
		else
		{
			this.validateDrop(var4,var3,1);
		}
	}
	function selectItem(§\x1e\x19\x18§)
	{
		if(var2.target.contentData == undefined)
		{
			this.hideItemViewer(true);
		}
		else
		{
			if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY))
			{
				this.api.kernel.GameManager.insertItemInChat(var2.target.contentData);
				return undefined;
			}
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = var2.target.contentData;
		}
	}
	function validate(§\x1e\x19\x18§)
	{
		switch(var2.params.targetType)
		{
			case "item":
				this.validateDrop(var2.params.targetGrid,var2.params.oItem,var2.value);
				break;
			case "kama":
				this.validateKama(var2.value);
		}
	}
	function localKamaChange(§\x1e\x19\x18§)
	{
		this._lblLocalKama.text = new ank.utils.(var2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		this._lblKama.text = new ank.utils.(this.api.datacenter.Player.Kama - var2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		this.hideButtonValidate(true);
		this.onDataUpdated();
	}
	function distantKamaChange(§\x1e\x19\x18§)
	{
		this._mcBlink.play();
		this._lblDistantKama.text = new ank.utils.(var2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		this.hideButtonValidate(true);
		this.onDataUpdated();
	}
	function itemSelected(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target._name) === "_cbTypes")
		{
			this._nSelectedTypeID = this._cbTypes.selectedItem.id;
			this.api.datacenter.Basics[dofus.graphics.gapi.ui.Exchange.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
			this.updateData();
		}
	}
	function over(§\x1e\x19\x18§)
	{
		switch(var2.target)
		{
			case this._btnFilterEquipement:
				this.api.ui.showTooltip(this.api.lang.getText("EQUIPEMENT"),var2.target,-20);
				break;
			case this._btnFilterNonEquipement:
				this.api.ui.showTooltip(this.api.lang.getText("NONEQUIPEMENT"),var2.target,-20);
				break;
			default:
				if(var0 !== this._btnFilterRessoureces)
				{
					break;
				}
				this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),var2.target,-20);
				break;
		}
	}
	function out(§\x1e\x19\x18§)
	{
		this.api.ui.hideTooltip();
	}
}

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
	function __set__dataProvider(loc2)
	{
		this._eaDataProvider.removeEventListener("modelChanged",this);
		this._eaDataProvider = loc2;
		this._eaDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__dataProvider();
	}
	function __set__localDataProvider(loc2)
	{
		this._eaLocalDataProvider.removeEventListener("modelChange",this);
		this._eaLocalDataProvider = loc2;
		this._eaLocalDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__localDataProvider();
	}
	function __set__distantDataProvider(loc2)
	{
		this._eaDistantDataProvider.removeEventListener("modelChange",this);
		this._eaDistantDataProvider = loc2;
		this._eaDistantDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__distantDataProvider();
	}
	function __set__readyDataProvider(loc2)
	{
		this._eaReadyDataProvider.removeEventListener("modelChange",this);
		this._eaReadyDataProvider = loc2;
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
	function addListeners()
	{
		this._cgGrid.addEventListener("dblClickItem",this);
		this._cgGrid.addEventListener("dropItem",this);
		this._cgGrid.addEventListener("dragItem",this);
		this._cgGrid.addEventListener("selectItem",this);
		this._cgLocal.addEventListener("dblClickItem",this);
		this._cgLocal.addEventListener("dropItem",this);
		this._cgLocal.addEventListener("dragItem",this);
		this._cgLocal.addEventListener("selectItem",this);
		this._cgDistant.addEventListener("selectItem",this);
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
		this._lblKama.text = new ank.utils.(this.api.datacenter.Player.Kama).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
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
		var loc2 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.Exchange.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
		this._nSelectedTypeID = loc2 != undefined?loc2:0;
		var loc3 = new ank.utils.();
		var loc4 = new ank.utils.();
		var loc5 = new Object();
		for(var k in this._eaDataProvider)
		{
			var loc6 = this._eaDataProvider[k];
			var loc7 = loc6.position;
			if(loc7 == -1 && this._aSelectedSuperTypes[loc6.superType])
			{
				if(loc6.type == this._nSelectedTypeID || this._nSelectedTypeID == 0)
				{
					loc3.push(loc6);
				}
				var loc8 = loc6.type;
				if(loc5[loc8] != true)
				{
					loc4.push({label:this.api.lang.getItemTypeText(loc8).n,id:loc8});
					loc5[loc8] = true;
				}
			}
		}
		loc4.sortOn("label");
		loc4.splice(0,0,{label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
		this._cbTypes.dataProvider = loc4;
		this.setType(this._nSelectedTypeID);
		this._cgGrid.dataProvider = loc3;
	}
	function setType(loc2)
	{
		var loc3 = this._cbTypes.dataProvider;
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			if(loc3[loc4].id == loc2)
			{
				this._cbTypes.selectedIndex = loc4;
				return undefined;
			}
			loc4 = loc4 + 1;
		}
		this._nSelectedTypeID = 0;
		this._cbTypes.selectedIndex = this._nSelectedTypeID;
	}
	function updateLocalData()
	{
		this._cgLocal.dataProvider = this._eaLocalDataProvider;
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"exchange",this,this.hideButtonValidate,dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE,[false]);
	}
	function updateDistantData()
	{
		this._cgDistant.dataProvider = this._eaDistantDataProvider;
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"exchange",this,this.hideButtonValidate,dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE,[false]);
	}
	function updateReadyState()
	{
		var loc2 = !this._eaReadyDataProvider[0]?dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR:dofus.graphics.gapi.ui.Exchange.READY_COLOR;
		this.setMovieClipTransform(this._winLocal,loc2);
		this.setMovieClipTransform(this._btnValidate,loc2);
		this.setMovieClipTransform(this._cgLocal,loc2);
		loc2 = !this._eaReadyDataProvider[1]?dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR:dofus.graphics.gapi.ui.Exchange.READY_COLOR;
		this.setMovieClipTransform(this._winDistant,loc2);
		this.setMovieClipTransform(this._cgDistant,loc2);
	}
	function hideButtonValidate(loc2)
	{
		var loc3 = !loc2?dofus.graphics.gapi.ui.Exchange.NON_READY_COLOR:dofus.graphics.gapi.ui.Exchange.READY_COLOR;
		this.setMovieClipTransform(this._btnValidate,loc3);
		this._btnValidate.enabled = !loc2;
	}
	function hideItemViewer(loc2)
	{
		this._itvItemViewer._visible = !loc2;
		this._winItemViewer._visible = !loc2;
	}
	function validateDrop(loc2, loc3, loc4)
	{
		if(loc4 < 1 || loc4 == undefined)
		{
			return undefined;
		}
		if(loc4 > loc3.Quantity)
		{
			loc4 = loc3.Quantity;
		}
		switch(loc2)
		{
			case "_cgGrid":
				this.api.network.Exchange.movementItem(false,loc3.ID,loc4);
				break;
			case "_cgLocal":
				this.api.network.Exchange.movementItem(true,loc3.ID,loc4);
		}
	}
	function validateKama(loc2)
	{
		if(loc2 > this.api.datacenter.Player.Kama)
		{
			loc2 = this.api.datacenter.Player.Kama;
		}
		this.api.network.Exchange.movementKama(loc2);
	}
	function askKamaQuantity()
	{
		var loc2 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:this.api.datacenter.Exchange.localKama,max:this.api.datacenter.Player.Kama,min:0,params:{targetType:"kama"}});
		loc2.addEventListener("validate",this);
	}
	function modelChanged(loc2)
	{
		loop0:
		switch(loc2.target)
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
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnClose":
				this.callClose();
				break;
			case "_btnValidate":
				this.api.network.Exchange.ready();
				break;
			default:
				if(loc0 !== "_btnPrivateChat")
				{
					if(loc2.target != this._btnSelectedFilterButton)
					{
						this._btnSelectedFilterButton.selected = false;
						this._btnSelectedFilterButton = loc2.target;
						if((loc0 = loc2.target._name) !== "_btnFilterEquipement")
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
					loc2.target.selected = true;
					break;
				}
				if(this.api.datacenter.Exchange.distantPlayerID > 0)
				{
					this.api.kernel.GameManager.askPrivateMessage(this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name);
				}
				break;
		}
	}
	function dblClickItem(loc2)
	{
		var loc3 = loc2.target.contentData;
		if(loc3 == undefined)
		{
			return undefined;
		}
		var loc4 = !Key.isDown(Key.CONTROL)?1:loc3.Quantity;
		var loc5 = loc2.owner._name;
		switch(loc5)
		{
			case "_cgGrid":
				this.validateDrop("_cgLocal",loc3,loc4);
				break;
			case "_cgLocal":
				this.validateDrop("_cgGrid",loc3,loc4);
		}
	}
	function dragItem(loc2)
	{
		this.gapi.removeCursor();
		if(loc2.target.contentData == undefined)
		{
			return undefined;
		}
		this.gapi.setCursor(loc2.target.contentData);
	}
	function dropItem(loc2)
	{
		var loc3 = this.gapi.getCursor();
		if(loc3 == undefined)
		{
			return undefined;
		}
		this.gapi.removeCursor();
		var loc4 = loc2.target._parent._parent._name;
		switch(loc4)
		{
			case "_cgGrid":
				if(loc3.position == -1)
				{
					return undefined;
				}
				break;
			case "_cgLocal":
				if(loc3.position == -2)
				{
					return undefined;
				}
				break;
		}
		if(loc3.Quantity > 1)
		{
			var loc5 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:loc3.Quantity,params:{targetType:"item",oItem:loc3,targetGrid:loc4}});
			loc5.addEventListener("validate",this);
		}
		else
		{
			this.validateDrop(loc4,loc3,1);
		}
	}
	function selectItem(loc2)
	{
		if(loc2.target.contentData == undefined)
		{
			this.hideItemViewer(true);
		}
		else
		{
			if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY))
			{
				this.api.kernel.GameManager.insertItemInChat(loc2.target.contentData);
				return undefined;
			}
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = loc2.target.contentData;
		}
	}
	function validate(loc2)
	{
		switch(loc2.params.targetType)
		{
			case "item":
				this.validateDrop(loc2.params.targetGrid,loc2.params.oItem,loc2.value);
				break;
			case "kama":
				this.validateKama(loc2.value);
		}
	}
	function localKamaChange(loc2)
	{
		this._lblLocalKama.text = new ank.utils.(loc2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		this._lblKama.text = new ank.utils.(this.api.datacenter.Player.Kama - loc2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"exchange",this,this.hideButtonValidate,dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE,[false]);
	}
	function distantKamaChange(loc2)
	{
		this._mcBlink.play();
		this._lblDistantKama.text = new ank.utils.(loc2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"exchange",this,this.hideButtonValidate,dofus.graphics.gapi.ui.Exchange.DELAY_BEFORE_VALIDATE,[false]);
	}
	function itemSelected(loc2)
	{
		if((var loc0 = loc2.target._name) === "_cbTypes")
		{
			this._nSelectedTypeID = this._cbTypes.selectedItem.id;
			this.api.datacenter.Basics[dofus.graphics.gapi.ui.Exchange.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
			this.updateData();
		}
	}
	function over(loc2)
	{
		switch(loc2.target)
		{
			case this._btnFilterEquipement:
				this.api.ui.showTooltip(this.api.lang.getText("EQUIPEMENT"),loc2.target,-20);
				break;
			case this._btnFilterNonEquipement:
				this.api.ui.showTooltip(this.api.lang.getText("NONEQUIPEMENT"),loc2.target,-20);
				break;
			default:
				if(loc0 !== this._btnFilterRessoureces)
				{
					break;
				}
				this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),loc2.target,-20);
				break;
		}
	}
	function out(loc2)
	{
		this.api.ui.hideTooltip();
	}
}

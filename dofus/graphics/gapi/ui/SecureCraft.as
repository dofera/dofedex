class dofus.graphics.gapi.ui.SecureCraft extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "SecureCraft";
	static var FILTER_EQUIPEMENT = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false];
	static var FILTER_NONEQUIPEMENT = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false];
	static var FILTER_RESSOURECES = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false];
	static var READY_COLOR = {ra:70,rb:0,ga:70,gb:0,ba:70,bb:0};
	static var NON_READY_COLOR = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
	static var GRID_CONTAINER_WIDTH = 33;
	static var DELAY_BEFORE_VALIDATE = 3000;
	static var FILTER_TYPE_ONLY_USEFUL = 10000;
	var _bInvalidateCoop = false;
	var _aSelectedSuperTypes = dofus.graphics.gapi.ui.SecureCraft.FILTER_RESSOURECES;
	var _nSelectedTypeID = 0;
	var _nLastRegenerateTimer = 0;
	static var NAME_GENERATION_DELAY = 1000;
	function SecureCraft()
	{
		super();
	}
	function __set__maxItem(loc2)
	{
		this._nMaxItem = Number(loc2);
		return this.__get__maxItem();
	}
	function __set__skillId(loc2)
	{
		this._nSkillId = Number(loc2);
		this._nForgemagusItemType = _global.API.lang.getSkillForgemagus(this._nSkillId);
		return this.__get__skillId();
	}
	function __get__isClient()
	{
		return this.api.datacenter.Basics.aks_exchange_echangeType == 13;
	}
	function __set__dataProvider(loc2)
	{
		this._eaDataProvider.removeEventListener("modelChange",this);
		this._eaDataProvider = loc2;
		this._eaDataProvider.addEventListener("modelChanged",this);
		this.modelChanged({target:this._eaDataProvider});
		return this.__get__dataProvider();
	}
	function __set__localDataProvider(loc2)
	{
		this._eaLocalDataProvider.removeEventListener("modelChange",this);
		this._eaLocalDataProvider = loc2;
		this._eaLocalDataProvider.addEventListener("modelChanged",this);
		this.modelChanged({target:this._eaLocalDataProvider});
		return this.__get__localDataProvider();
	}
	function __set__distantDataProvider(loc2)
	{
		this._eaDistantDataProvider.removeEventListener("modelChange",this);
		this._eaDistantDataProvider = loc2;
		this._eaDistantDataProvider.addEventListener("modelChanged",this);
		this.modelChanged({target:this._eaDistantDataProvider});
		return this.__get__distantDataProvider();
	}
	function __set__coopDataProvider(loc2)
	{
		this._eaCoopDataProvider.removeEventListener("modelChange",this);
		this._eaCoopDataProvider = loc2;
		this._eaCoopDataProvider.addEventListener("modelChanged",this);
		this.modelChanged({target:this._eaCoopDataProvider});
		return this.__get__coopDataProvider();
	}
	function __set__payDataProvider(loc2)
	{
		this._eaPayDataProvider.removeEventListener("modelChange",this);
		this._eaPayDataProvider = loc2;
		this._eaPayDataProvider.addEventListener("modelChanged",this);
		this.modelChanged({target:this._eaPayDataProvider});
		return this.__get__payDataProvider();
	}
	function __set__payIfSuccessDataProvider(loc2)
	{
		this._eaPayIfSuccessDataProvider.removeEventListener("modelChange",this);
		this._eaPayIfSuccessDataProvider = loc2;
		this._eaPayIfSuccessDataProvider.addEventListener("modelChanged",this);
		this.modelChanged({target:this._eaPayIfSuccessDataProvider});
		return this.__get__payIfSuccessDataProvider();
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
		super.init(false,dofus.graphics.gapi.ui.SecureCraft.CLASS_NAME);
	}
	function destroy()
	{
		this.gapi.hideTooltip();
	}
	function callClose()
	{
		this.api.network.Exchange.leave();
		return true;
	}
	function createChildren()
	{
		this._mcPlacer._visible = false;
		this._winCraftViewer.swapDepths(this.getNextHighestDepth());
		this.showPreview(undefined,false);
		this.showCraftViewer(false);
		this.addToQueue({object:this,method:this.addListeners});
		this._btnSelectedFilterButton = this._btnFilterRessoureces;
		this.addToQueue({object:this,method:this.saveGridMaxSize});
		this.addToQueue({object:this,method:this.initData});
		this.hideItemViewer(true);
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initGridWidth});
		this.api.datacenter.Player.addEventListener("kamaChanged",this);
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
		this._cgCoop.addEventListener("selectItem",this);
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
		this.api.datacenter.Exchange.addEventListener("payKamaChange",this);
		this.api.datacenter.Exchange.addEventListener("payIfSuccessKamaChange",this);
		this._btnValidate.addEventListener("click",this);
		this._btnCraft.addEventListener("click",this);
		this._btnPrivateMessage.addEventListener("click",this);
		this._btnPay.addEventListener("click",this);
		this._mcFiligrane.onRollOver = function()
		{
			this._parent.over({target:this});
		};
		this._mcFiligrane.onRollOut = function()
		{
			this._parent.out({target:this});
		};
		this._cbTypes.addEventListener("itemSelected",this);
		this._cgPay.addEventListener("selectItem",this);
		this._cgPayIfSuccess.addEventListener("selectItem",this);
		this._btnPrivateMessagePay.addEventListener("click",this);
		this._btnValidatePay.addEventListener("click",this);
		if(this.isClient)
		{
			this._cgPay.addEventListener("dblClickItem",this);
			this._cgPay.addEventListener("dropItem",this);
			this._cgPayIfSuccess.addEventListener("dblClickItem",this);
			this._cgPayIfSuccess.addEventListener("dropItem",this);
		}
		this._mcPayIfSuccessHighlight.onRelease = function()
		{
			this._parent.switchPayBar(2);
		};
		this._mcPayHighlight.onRelease = function()
		{
			this._parent.switchPayBar(1);
		};
	}
	function initTexts()
	{
		this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
		this._winInventory.title = this.api.datacenter.Player.data.name;
		this._winDistant.title = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name;
		this._btnValidate.label = this.api.lang.getText("COMBINE");
		this._btnValidatePay.label = this.api.lang.getText("VALIDATE");
		this._btnCraft.label = this.api.lang.getText("RECEIPTS");
		this._btnPrivateMessage.label = this.api.lang.getText("WISPER_MESSAGE");
		this._btnPrivateMessagePay.label = this.api.lang.getText("WISPER_MESSAGE");
		this._btnPay.label = this.api.lang.getText("PAY");
		this._lblNewObject.text = this.api.lang.getText("CRAFTED_ITEM");
		this._winCraftViewer.title = this.api.lang.getText("RECEIPTS_FROM_JOB");
		this._lblSkill.text = this.api.lang.getText("SKILL") + " : " + this.api.lang.getSkillText(this._nSkillId).d;
		this._winDistant.title = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name;
		this._lblKama.text = new ank.utils.(this.api.datacenter.Player.Kama).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		this._mcPayKama._visible = this.isClient;
		this._mcPayIfSuccessKama._visible = this.isClient;
		this._lblPay.text = this.api.lang.getText("PAY");
		this._lblPayIfSuccess.text = this.api.lang.getText("GRANT_IF_SUCCESS");
	}
	function initData()
	{
		this.dataProvider = this.api.datacenter.Exchange.inventory;
		this.localDataProvider = this.api.datacenter.Exchange.localGarbage;
		this.distantDataProvider = this.api.datacenter.Exchange.distantGarbage;
		this.coopDataProvider = this.api.datacenter.Exchange.coopGarbage;
		this.payDataProvider = this.api.datacenter.Exchange.payGarbage;
		this.payIfSuccessDataProvider = this.api.datacenter.Exchange.payIfSuccessGarbage;
		this.readyDataProvider = this.api.datacenter.Exchange.readyStates;
		this.switchToPayMode(false);
		this.switchPayBar(1);
		this.showPreview(undefined,false);
	}
	function updateInventory()
	{
		this.api.datacenter.Exchange.inventory = this.api.datacenter.Player.Inventory.clone();
		this.dataProvider = this.api.datacenter.Exchange.inventory;
		this.switchToPayMode(false);
	}
	function saveGridMaxSize()
	{
	}
	function initGridWidth()
	{
		if(this._nMaxItem == undefined)
		{
			this._nMaxItem = 9;
		}
		this._cgLocal.visibleColumnCount = this._nMaxItem;
		this._cgDistant.visibleColumnCount = this._nMaxItem;
		var loc2 = dofus.graphics.gapi.ui.SecureCraft.GRID_CONTAINER_WIDTH * this._nMaxItem;
		this._cgLocal.setSize(loc2);
		this._cgLocal._x = this._winLocal._x + this._winLocal.width - loc2 - 10;
		this._cgDistant.setSize(loc2);
		this._cgDistant._x = this._winDistant._x + 10;
	}
	function updateData()
	{
		var loc2 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.SecureCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
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
					var loc8 = 0;
					if(this._sCurrentDragTarget == "_cgPay")
					{
						loc8 = this.getQtyIn(this._eaPayIfSuccessDataProvider,loc6.unicID);
					}
					else if(this._sCurrentDragTarget == "_cgPayIfSuccess")
					{
						loc8 = this.getQtyIn(this._eaPayDataProvider,loc6.unicID);
					}
					else if(this._sCurrentDragTarget == "_cgGrid")
					{
						if(this._sCurrentDragSource == "_cgPay")
						{
							loc8 = this.getQtyIn(this._eaPayIfSuccessDataProvider,loc6.unicID);
						}
						else if(this._sCurrentDragSource == "_cgPayIfSuccess")
						{
							loc8 = this.getQtyIn(this._eaPayDataProvider,loc6.unicID);
						}
					}
					loc6.Quantity = loc6.Quantity - loc8;
					loc3.push(loc6);
				}
				else if(this._nSelectedTypeID == dofus.graphics.gapi.ui.SecureCraft.FILTER_TYPE_ONLY_USEFUL && this.api.kernel.GameManager.isItemUseful(loc6.unicID,this._nSkillId,this._nMaxItem))
				{
					loc3.push(loc6);
				}
				var loc9 = loc6.type;
				if(loc5[loc9] != true)
				{
					loc4.push({label:this.api.lang.getItemTypeText(loc9).n,id:loc9});
					loc5[loc9] = true;
				}
			}
		}
		loc4.sortOn("label");
		loc4.splice(0,0,{label:this.api.lang.getText("TYPE_FILTER_ONLY_USEFUL"),id:dofus.graphics.gapi.ui.SecureCraft.FILTER_TYPE_ONLY_USEFUL});
		loc4.splice(0,0,{label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
		this._cbTypes.dataProvider = loc4;
		this.setType(this._nSelectedTypeID);
		this._cgGrid.dataProvider = loc3;
	}
	function getQtyIn(loc2, loc3)
	{
		for(var qtc in loc2)
		{
			if(loc2[qtc].unicID == loc3)
			{
				return loc2[qtc].Quantity;
			}
		}
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
		this._bInvalidateCoop = true;
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"securecraft",this,this.hideButtonValidate,dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE,[false]);
	}
	function updateCoopData()
	{
		this._cgCoop.dataProvider = this._eaCoopDataProvider;
		this._mcFiligrane._visible = this._bFiligraneVisible = this._eaCoopDataProvider == undefined;
		var loc2 = this._cgCoop.getContainer(0).contentData;
		if(loc2 != undefined)
		{
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = loc2;
		}
	}
	function updatePayData()
	{
		this._cgPay.dataProvider = this._eaPayDataProvider;
		this.switchToPayMode(true);
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"securecraft",this,this.hideButtonValidate,dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE,[false]);
	}
	function updatePayIfSuccessData()
	{
		this._cgPayIfSuccess.dataProvider = this._eaPayIfSuccessDataProvider;
		this.switchToPayMode(true);
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"securecraft",this,this.hideButtonValidate,dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE,[false]);
	}
	function updateDistantData()
	{
		this._cgDistant.dataProvider = this._eaDistantDataProvider;
		this._bInvalidateCoop = true;
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"securecraft",this,this.hideButtonValidate,dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE,[false]);
	}
	function updateReadyState()
	{
		var loc2 = !this._eaReadyDataProvider[0]?dofus.graphics.gapi.ui.SecureCraft.NON_READY_COLOR:dofus.graphics.gapi.ui.SecureCraft.READY_COLOR;
		this.setMovieClipTransform(this._winLocal,loc2);
		this.setMovieClipTransform(this._btnValidate,loc2);
		this.setMovieClipTransform(this._cgLocal,loc2);
		loc2 = !this._eaReadyDataProvider[1]?dofus.graphics.gapi.ui.SecureCraft.NON_READY_COLOR:dofus.graphics.gapi.ui.SecureCraft.READY_COLOR;
		this.setMovieClipTransform(this._winDistant,loc2);
		this.setMovieClipTransform(this._cgDistant,loc2);
	}
	function hideButtonValidate(loc2)
	{
		var loc3 = !loc2?dofus.graphics.gapi.ui.SecureCraft.NON_READY_COLOR:dofus.graphics.gapi.ui.SecureCraft.READY_COLOR;
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
		this._sCurrentDragTarget = loc2;
		if((var loc0 = loc2) !== "_cgGrid")
		{
			switch(null)
			{
				case "_cgLocal":
					this.api.network.Exchange.movementItem(true,loc3.ID,loc4);
					break;
				case "_cgPay":
					this.api.network.Exchange.movementPayItem(1,true,loc3.ID,loc4);
					break;
				case "_cgPayIfSuccess":
					this.api.network.Exchange.movementPayItem(2,true,loc3.ID,loc4);
			}
		}
		else if(!this._bPayMode)
		{
			this.api.network.Exchange.movementItem(false,loc3.ID,loc4);
		}
		else
		{
			this.api.network.Exchange.movementPayItem(this._nPayBar,false,loc3.ID,loc4);
		}
		if(this._bInvalidateCoop)
		{
			this.api.datacenter.Exchange.clearCoopGarbage();
			this._bInvalidateCoop = false;
		}
	}
	function setReady()
	{
		var loc2 = this.getTotalCraftInventory();
		if(loc2.length == 0)
		{
			return undefined;
		}
		if(loc2.length > this._nMaxItem)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_CRAFT_SLOT",[this._nMaxItem]),"ERROR_BOX",{name:"NotEnoughtCraftSlot"});
			return undefined;
		}
		this.api.network.Exchange.ready();
	}
	function canDropInGarbage(loc2)
	{
		var loc3 = this.api.datacenter.Exchange.localGarbage.findFirstItem("ID",loc2.ID);
		var loc4 = this.api.datacenter.Exchange.localGarbage.length;
		if(loc3.index == -1 && loc4 >= this._nMaxItem)
		{
			return false;
		}
		return true;
	}
	function showCraftViewer(loc2)
	{
		if(loc2)
		{
			var loc3 = this.attachMovie("CraftViewer","_cvCraftViewer",this.getNextHighestDepth());
			loc3._x = this._mcPlacer._x;
			loc3._y = this._mcPlacer._y;
			loc3.skill = new dofus.datacenter.(this._nSkillId,this._nMaxItem);
		}
		else
		{
			this._cvCraftViewer.removeMovieClip();
		}
		this._winCraftViewer._visible = loc2;
	}
	function recordGarbage()
	{
		this._aGarbageMemory = new Array();
		var loc2 = 0;
		while(loc2 < this._eaLocalDataProvider.length)
		{
			var loc3 = this._eaLocalDataProvider[loc2];
			this._aGarbageMemory.push({id:loc3.ID,quantity:loc3.Quantity});
			loc2 = loc2 + 1;
		}
	}
	function cleanGarbage()
	{
		var loc2 = 0;
		while(loc2 < this._eaLocalDataProvider.length)
		{
			var loc3 = this._eaLocalDataProvider[loc2];
			this.api.network.Exchange.movementItem(false,loc3.ID,loc3.Quantity);
			loc2 = loc2 + 1;
		}
	}
	function recallGarbageMemory()
	{
		if(this._aGarbageMemory == undefined || this._aGarbageMemory.length == 0)
		{
			return undefined;
		}
		this.cleanGarbage();
		var loc2 = 0;
		while(loc2 < this._aGarbageMemory.length)
		{
			var loc3 = this._aGarbageMemory[loc2];
			var loc4 = this._eaDataProvider.findFirstItem("ID",loc3.id);
			if(loc4.index != -1)
			{
				if(loc4.item.Quantity >= loc3.quantity)
				{
					this.api.network.Exchange.movementItem(true,loc4.item.ID,loc3.quantity);
				}
				else
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_NOT_ENOUGHT",[loc4.item.name]),"ERROR_BOX",{name:"NotEnougth"});
					return undefined;
				}
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_NO_RESOURCE"),"ERROR_BOX",{name:"NotEnougth"});
			}
			loc2 = loc2 + 1;
		}
	}
	function showPreview(loc2, loc3)
	{
		if(this._ctrPreview.contentPath == undefined)
		{
			return undefined;
		}
		this._mcFiligrane._visible = this._bFiligraneVisible = loc3;
		this._ctrPreview._visible = loc3;
		this._ctrPreview.contentPath = !loc3?"":loc2.iconFile;
		this._mcFiligrane.itemName = loc2.name;
	}
	function updatePreview()
	{
		var loc2 = this.api.kernel.GameManager.analyseReceipts(this.getTotalCraftInventory(),this._nSkillId,this._nMaxItem);
		if(loc2 != undefined)
		{
			this.showPreview(new dofus.datacenter.(-1,loc2,1,0,"",0),true);
		}
		else
		{
			this.showPreview(undefined,false);
		}
	}
	function getTotalCraftInventory()
	{
		var loc2 = this.api.kernel.GameManager;
		return loc2.mergeUnicItemInInventory(loc2.mergeTwoInventory(this._eaLocalDataProvider,this._eaDistantDataProvider));
	}
	function switchToPayMode(loc2)
	{
		if(loc2 == undefined && this._bPayMode == undefined)
		{
			return undefined;
		}
		if(loc2 == undefined)
		{
			this._bPayMode = !this._bPayMode;
		}
		else if(this._bPayMode != loc2)
		{
			this._bPayMode = loc2;
		}
		else
		{
			return undefined;
		}
		this.gapi.removeCursor();
		this._winLocal._visible = !this._bPayMode;
		this._cgLocal._visible = !this._bPayMode;
		this._btnPrivateMessage._visible = !this._bPayMode;
		this._winDistant._visible = !this._bPayMode;
		this._cgDistant._visible = !this._bPayMode;
		this._btnPay._visible = !this._bPayMode;
		this._winCoop._visible = !this._bPayMode;
		this._lblNewObject._visible = !this._bPayMode;
		this._mcFiligrane._visible = !this._bPayMode?this._bFiligraneVisible:false;
		this._ctrPreview._visible = !this._bPayMode?this._bFiligraneVisible:false;
		this._cgCoop._visible = !this._bPayMode;
		this._btnCraft._visible = !this._bPayMode;
		this._btnValidate._visible = !this._bPayMode;
		this._mcArrow._visible = !this._bPayMode;
		this._winPay._visible = this._bPayMode;
		this._btnPrivateMessagePay._visible = this._bPayMode;
		this._btnValidatePay._visible = this._bPayMode;
		this._winItemViewer._y = !this._bPayMode?30:57;
		this._itvItemViewer._y = !this._bPayMode?30:57;
		this._mcBlinkPay._visible = this._bPayMode;
		this._cgPay._visible = this._bPayMode;
		this._lblPayKama._visible = this._bPayMode;
		this._mcPayKama._visible = this._bPayMode;
		this._lblPay._visible = this._bPayMode;
		this._btnPayKama._visible = this._bPayMode && this.isClient;
		this._mcBlinkPayIfSuccess._visible = this._bPayMode;
		this._cgPayIfSuccess._visible = this._bPayMode;
		this._lblPayIfSuccessKama._visible = this._bPayMode;
		this._mcPayIfSuccessKama._visible = this._bPayMode;
		this._lblPayIfSuccess._visible = this._bPayMode;
		this._btnPayIfSuccessKama._visible = this._bPayMode && this.isClient;
		this.switchPayBar();
	}
	function switchPayBar(loc2)
	{
		if(loc2 != undefined)
		{
			this._nPayBar = loc2;
		}
		this._mcPayHighlight._visible = this._bPayMode && this.isClient;
		this._mcPayIfSuccessHighlight._visible = this._bPayMode && this.isClient;
		this._mcPayHighlight._alpha = this._nPayBar != 1?0:100;
		this._mcPayIfSuccessHighlight._alpha = this._nPayBar != 2?0:100;
		if(this.isClient)
		{
			if(this._nPayBar == 1)
			{
				this._cgPayIfSuccess.removeEventListener("dragItem",this);
				this._cgPay.addEventListener("dragItem",this);
			}
			else
			{
				this._cgPay.removeEventListener("dragItem",this);
				this._cgPayIfSuccess.addEventListener("dragItem",this);
			}
		}
	}
	function validateKama(loc2)
	{
		if(loc2 > this.api.datacenter.Player.Kama)
		{
			loc2 = this.api.datacenter.Player.Kama;
		}
		this.api.network.Exchange.movementPayKama(this._nPayBar,loc2);
	}
	function askKamaQuantity(loc2)
	{
		this.switchPayBar(loc2);
		var loc3 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:this.api.datacenter.Exchange.localKama,max:this.api.datacenter.Player.Kama,params:{targetType:"kama"}});
		loc3.addEventListener("validate",this);
	}
	function canUseItemInCraft(loc2)
	{
		if(this._nForgemagusItemType == undefined || this.isNotForgemagus())
		{
			return true;
		}
		if(loc2.type == 78)
		{
			return true;
		}
		var loc3 = false;
		var loc4 = 0;
		while(loc4 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
		{
			if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[loc4] == loc2.unicID)
			{
				return true;
			}
			loc4 = loc4 + 1;
		}
		var loc5 = 0;
		while(loc5 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
		{
			if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[loc5] == loc2.type)
			{
				return true;
			}
			loc5 = loc5 + 1;
		}
		if(this._nForgemagusItemType != loc2.type || !loc2.enhanceable)
		{
			return false;
		}
		return true;
	}
	function validCraft()
	{
		this.showCraftViewer(false);
		this._btnCraft.selected = false;
		this.recordGarbage();
		this.setReady();
	}
	function isNotForgemagus()
	{
		return _global.isNaN(this._nForgemagusItemType);
	}
	function addCraft(loc2)
	{
		if(this._nLastRegenerateTimer + dofus.graphics.gapi.ui.SecureCraft.NAME_GENERATION_DELAY < getTimer())
		{
			this.api.network.Account.getRandomCharacterName();
			this._nLastRegenerateTimer = getTimer();
			var loc3 = this.api.lang.getSkillText(this._nSkillId).cl;
			var loc4 = 0;
			while(loc4 < loc3.length)
			{
				var loc5 = loc3[loc4];
				if(loc2 == loc5)
				{
					var loc6 = this.api.lang.getCraftText(loc5);
					var loc8 = 0;
					var loc9 = new Array();
					var loc10 = 0;
					while(loc10 < loc6.length)
					{
						var loc11 = loc6[loc10];
						var loc12 = loc11[0];
						var loc13 = loc11[1];
						var loc7 = false;
						var loc14 = 0;
						while(loc14 < this._eaDataProvider.length)
						{
							if(loc12 == this._eaDataProvider[loc14].unicID)
							{
								if(loc13 <= this._eaDataProvider[loc14].Quantity)
								{
									loc8 = loc8 + 1;
									loc7 = true;
									loc9.push({item:this._eaDataProvider[loc14],qty:loc13});
									break;
								}
							}
							loc14 = loc14 + 1;
						}
						if(!loc7)
						{
							break;
						}
						loc10 = loc10 + 1;
					}
					if(loc7 && loc6.length == loc8)
					{
						var loc16 = new Array();
						var loc18 = 0;
						while(loc18 < this._cgLocal.dataProvider.length)
						{
							var loc15 = this._cgLocal.dataProvider[loc18];
							var loc17 = loc15.Quantity;
							if(!(loc17 < 1 || loc17 == undefined))
							{
								loc16.push({Add:false,ID:loc15.ID,Quantity:loc17});
							}
							loc18 = loc18 + 1;
						}
						var loc19 = 0;
						while(loc19 < loc9.length)
						{
							loc15 = loc9[loc19].item;
							loc17 = loc9[loc19].qty;
							if(!(loc17 < 1 || loc17 == undefined))
							{
								loc16.push({Add:true,ID:loc15.ID,Quantity:loc17});
							}
							loc19 = loc19 + 1;
						}
						this.api.network.Exchange.movementItems(loc16);
					}
					else
					{
						this.api.kernel.showMessage(undefined,this.api.lang.getText("DONT_HAVE_ALL_INGREDIENT"),"ERROR_BOX");
					}
					break;
				}
				loc4 = loc4 + 1;
			}
		}
		return undefined;
	}
	function kamaChanged(loc2)
	{
		this._lblKama.text = new ank.utils.(loc2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
	}
	function modelChanged(loc2)
	{
		loop0:
		switch(loc2.target)
		{
			case this._eaLocalDataProvider:
				this.updateLocalData();
				this.updatePreview();
				break;
			case this._eaDistantDataProvider:
				this.updateDistantData();
				this.updatePreview();
				if(this._eaDistantDataProvider.length > 0)
				{
					this._cgCoop.dataProvider = new ank.utils.();
				}
				break;
			default:
				switch(null)
				{
					case this._eaDataProvider:
						this.updateData();
						this.updatePreview();
						break loop0;
					case this._eaCoopDataProvider:
						this.updateCoopData();
						this.updatePreview();
						break loop0;
					case this._eaPayDataProvider:
						this.updatePayData();
						break loop0;
					default:
						switch(null)
						{
							case this._eaPayIfSuccessDataProvider:
								this.updatePayIfSuccessData();
								break loop0;
							case this._eaReadyDataProvider:
								this.updateReadyState();
								break loop0;
							default:
								this.updateData();
								this.updateLocalData();
								this.updateDistantData();
								this.updateCoopData();
								this.updatePayData();
								this.updatePayIfSuccessData();
								this.updatePreview();
						}
				}
		}
	}
	function over(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnFilterEquipement":
				this.api.ui.showTooltip(this.api.lang.getText("EQUIPEMENT"),loc2.target,-20);
				break;
			case "_btnFilterNonEquipement":
				this.api.ui.showTooltip(this.api.lang.getText("NONEQUIPEMENT"),loc2.target,-20);
				break;
			default:
				switch(null)
				{
					case "_btnFilterRessoureces":
						this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),loc2.target,-20);
						break;
					case "_mcFiligrane":
						if(this._mcFiligrane.itemName != undefined)
						{
							this.gapi.showTooltip(this._mcFiligrane.itemName,this._ctrPreview,-22);
							break;
						}
				}
		}
	}
	function out(loc2)
	{
		this.api.ui.hideTooltip();
	}
	function click(loc2)
	{
		if(loc2.target == this._btnClose)
		{
			this.callClose();
			return undefined;
		}
		if(loc2.target == this._btnValidate)
		{
			var loc3 = this.api.kernel.GameManager.analyseReceipts(this.getTotalCraftInventory(),this._nSkillId,this._nMaxItem);
			if(loc3 == undefined && (this.api.kernel.OptionsManager.getOption("AskForWrongCraft") && this.isNotForgemagus()))
			{
				this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("WRONG_CRAFT_CONFIRM"),"CAUTION_YESNO",{name:"confirmWrongCraft",listener:this});
			}
			else
			{
				this.validCraft();
			}
			return undefined;
		}
		if(loc2.target == this._btnCraft)
		{
			this.showCraftViewer(loc2.target.selected);
			return undefined;
		}
		if(loc2.target == this._btnPrivateMessage || loc2.target == this._btnPrivateMessagePay)
		{
			this.api.kernel.GameManager.askPrivateMessage(this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name);
		}
		if(loc2.target == this._btnPay || loc2.target == this._btnValidatePay)
		{
			this._sCurrentDragSource = undefined;
			this._sCurrentDragTarget = undefined;
			this.switchToPayMode();
		}
		if(loc2.target != this._btnSelectedFilterButton)
		{
			this._btnSelectedFilterButton.selected = false;
			this._btnSelectedFilterButton = loc2.target;
			switch(loc2.target._name)
			{
				case "_btnFilterEquipement":
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.SecureCraft.FILTER_EQUIPEMENT;
					this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
					break;
				case "_btnFilterNonEquipement":
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.SecureCraft.FILTER_NONEQUIPEMENT;
					this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
					break;
				case "_btnFilterRessoureces":
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.SecureCraft.FILTER_RESSOURECES;
					this._lblFilter.text = this.api.lang.getText("RESSOURECES");
			}
			this.updateData(true);
		}
		else
		{
			loc2.target.selected = true;
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
		this._sCurrentDragSource = loc5;
		if((var loc0 = loc5) !== "_cgGrid")
		{
			switch(null)
			{
				case "_cgLocal":
					var loc6 = "_cgGrid";
					break;
				case "_cgPay":
					this.switchPayBar(1);
					loc6 = "_cgGrid";
					break;
				case "_cgPayIfSuccess":
					this.switchPayBar(2);
					loc6 = "_cgGrid";
			}
		}
		else
		{
			if(!this.canDropInGarbage(loc3))
			{
				return undefined;
			}
			if(!this.canUseItemInCraft(loc3))
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("WRONG_ITEM_TYPE"),"ERROR_CHAT");
				return undefined;
			}
			if(!this._bPayMode)
			{
				loc6 = "_cgLocal";
			}
			else if(this.isClient)
			{
				loc6 = this._nPayBar != 1?"_cgPayIfSuccess":"_cgPay";
			}
			else
			{
				return undefined;
			}
		}
		this.validateDrop(loc6,loc3,loc4);
	}
	function dragItem(loc2)
	{
		this.gapi.removeCursor();
		if(loc2.target.contentData == undefined)
		{
			return undefined;
		}
		this._sCurrentDragSource = loc2.target._parent._parent._name;
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
				if(!this._bPayMode)
				{
					if(loc3.position == -1)
					{
						return undefined;
					}
				}
				break;
			case "_cgLocal":
				if(loc3.position == -2)
				{
					return undefined;
				}
				if(!this.canUseItemInCraft(loc3))
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("WRONG_ITEM_TYPE"),"ERROR_CHAT");
					return undefined;
				}
				if(!this.canDropInGarbage(loc3))
				{
					return undefined;
				}
				break;
			default:
				switch(null)
				{
					case "_cgPay":
						if(this._sCurrentDragSource == "_cgPay" || this._sCurrentDragSource == "_cgPayIfSuccess")
						{
							return undefined;
						}
						this.switchPayBar(1);
						break;
					case "_cgPayIfSuccess":
						if(this._sCurrentDragSource == "_cgPay" || this._sCurrentDragSource == "_cgPayIfSuccess")
						{
							return undefined;
						}
						this.switchPayBar(2);
						break;
				}
		}
		if(loc3.Quantity > 1 && !(loc4 == "_cgGrid" && (this._sCurrentDragSource == "_cgPay" || this._sCurrentDragSource == "_cgPayIfSuccess")))
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
	function itemSelected(loc2)
	{
		if((var loc0 = loc2.target._name) === "_cbTypes")
		{
			this._nSelectedTypeID = this._cbTypes.selectedItem.id;
			this.api.datacenter.Basics[dofus.graphics.gapi.ui.SecureCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
			this.updateData();
		}
	}
	function localKamaChange(loc2)
	{
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"securecraft",this,this.hideButtonValidate,dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE,[false]);
	}
	function payKamaChange(loc2)
	{
		this.switchToPayMode(true);
		this._mcBlinkPay.play();
		this._nKamaPayment = loc2.value;
		if(_global.isNaN(this._nKamaPaymentIfSuccess) || this._nKamaPaymentIfSuccess == undefined)
		{
			this._nKamaPaymentIfSuccess = 0;
		}
		if(this.isClient)
		{
			this._lblKama.text = new ank.utils.(this.api.datacenter.Player.Kama - this._nKamaPayment - this._nKamaPaymentIfSuccess).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		}
		this._lblPayKama.text = new ank.utils.(loc2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"securecraft",this,this.hideButtonValidate,dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE,[false]);
	}
	function payIfSuccessKamaChange(loc2)
	{
		this.switchToPayMode(true);
		this._mcBlinkPayIfSuccess.play();
		this._nKamaPaymentIfSuccess = loc2.value;
		if(_global.isNaN(this._nKamaPayment) || this._nKamaPayment == undefined)
		{
			this._nKamaPayment = 0;
		}
		if(this.isClient)
		{
			this._lblKama.text = new ank.utils.(this.api.datacenter.Player.Kama - this._nKamaPayment - this._nKamaPaymentIfSuccess).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		}
		this._lblPayIfSuccessKama.text = new ank.utils.(loc2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"securecraft",this,this.hideButtonValidate,dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE,[false]);
	}
	function yes()
	{
		this.validCraft();
	}
}

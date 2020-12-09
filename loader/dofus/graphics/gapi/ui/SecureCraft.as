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
	function __get__currentOverItem()
	{
		return this._oOverItem;
	}
	function __get__itemViewer()
	{
		return this._itvItemViewer;
	}
	function __set__maxItem(§\x03\x0f§)
	{
		this._nMaxItem = Number(var2);
		return this.__get__maxItem();
	}
	function __set__skillId(§\x1e\x1d\x18§)
	{
		this._nSkillId = Number(var2);
		this._nForgemagusItemType = _global.API.lang.getSkillForgemagus(this._nSkillId);
		return this.__get__skillId();
	}
	function __get__isClient()
	{
		return this.api.datacenter.Basics.aks_exchange_echangeType == 13;
	}
	function __set__dataProvider(§\x10\x14§)
	{
		this._eaDataProvider.removeEventListener("modelChange",this);
		this._eaDataProvider = var2;
		this._eaDataProvider.addEventListener("modelChanged",this);
		this.modelChanged({target:this._eaDataProvider});
		return this.__get__dataProvider();
	}
	function __set__localDataProvider(§\x10\r§)
	{
		this._eaLocalDataProvider.removeEventListener("modelChange",this);
		this._eaLocalDataProvider = var2;
		this._eaLocalDataProvider.addEventListener("modelChanged",this);
		this.modelChanged({target:this._eaLocalDataProvider});
		return this.__get__localDataProvider();
	}
	function __set__distantDataProvider(§\x10\x13§)
	{
		this._eaDistantDataProvider.removeEventListener("modelChange",this);
		this._eaDistantDataProvider = var2;
		this._eaDistantDataProvider.addEventListener("modelChanged",this);
		this.modelChanged({target:this._eaDistantDataProvider});
		return this.__get__distantDataProvider();
	}
	function __set__coopDataProvider(§\x10\x17§)
	{
		this._eaCoopDataProvider.removeEventListener("modelChange",this);
		this._eaCoopDataProvider = var2;
		this._eaCoopDataProvider.addEventListener("modelChanged",this);
		this.modelChanged({target:this._eaCoopDataProvider});
		return this.__get__coopDataProvider();
	}
	function __set__payDataProvider(§\x10\b§)
	{
		this._eaPayDataProvider.removeEventListener("modelChange",this);
		this._eaPayDataProvider = var2;
		this._eaPayDataProvider.addEventListener("modelChanged",this);
		this.modelChanged({target:this._eaPayDataProvider});
		return this.__get__payDataProvider();
	}
	function __set__payIfSuccessDataProvider(§\x10\x07§)
	{
		this._eaPayIfSuccessDataProvider.removeEventListener("modelChange",this);
		this._eaPayIfSuccessDataProvider = var2;
		this._eaPayIfSuccessDataProvider.addEventListener("modelChanged",this);
		this.modelChanged({target:this._eaPayIfSuccessDataProvider});
		return this.__get__payIfSuccessDataProvider();
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
		this._cgCoop.addEventListener("selectItem",this);
		this._cgCoop.addEventListener("overItem",this);
		this._cgCoop.addEventListener("outItem",this);
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
		this._cgCoop.multipleContainerSelectionEnabled = false;
		this._cgDistant.multipleContainerSelectionEnabled = false;
		this._cgGrid.multipleContainerSelectionEnabled = false;
		this._cgLocal.multipleContainerSelectionEnabled = false;
		this._cgPay.multipleContainerSelectionEnabled = false;
		this._cgPayIfSuccess.multipleContainerSelectionEnabled = false;
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
		this._lblKama.text = new ank.utils.(this.api.datacenter.Player.Kama).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
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
		var var2 = dofus.graphics.gapi.ui.SecureCraft.GRID_CONTAINER_WIDTH * this._nMaxItem;
		this._cgLocal.setSize(var2);
		this._cgLocal._x = this._winLocal._x + this._winLocal.width - var2 - 10;
		this._cgDistant.setSize(var2);
		this._cgDistant._x = this._winDistant._x + 10;
	}
	function updateData()
	{
		var var2 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.SecureCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
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
					var var8 = 0;
					if(this._sCurrentDragTarget == "_cgPay")
					{
						var8 = this.getQtyIn(this._eaPayIfSuccessDataProvider,var6.unicID);
					}
					else if(this._sCurrentDragTarget == "_cgPayIfSuccess")
					{
						var8 = this.getQtyIn(this._eaPayDataProvider,var6.unicID);
					}
					else if(this._sCurrentDragTarget == "_cgGrid")
					{
						if(this._sCurrentDragSource == "_cgPay")
						{
							var8 = this.getQtyIn(this._eaPayIfSuccessDataProvider,var6.unicID);
						}
						else if(this._sCurrentDragSource == "_cgPayIfSuccess")
						{
							var8 = this.getQtyIn(this._eaPayDataProvider,var6.unicID);
						}
					}
					var6.Quantity = var6.Quantity - var8;
					var3.push(var6);
				}
				else if(this._nSelectedTypeID == dofus.graphics.gapi.ui.SecureCraft.FILTER_TYPE_ONLY_USEFUL && this.api.kernel.GameManager.isItemUseful(var6.unicID,this._nSkillId,this._nMaxItem))
				{
					var3.push(var6);
				}
				var var9 = var6.type;
				if(var5[var9] != true)
				{
					var4.push({label:this.api.lang.getItemTypeText(var9).n,id:var9});
					var5[var9] = true;
				}
			}
		}
		var4.sortOn("label");
		var4.splice(0,0,{label:this.api.lang.getText("TYPE_FILTER_ONLY_USEFUL"),id:dofus.graphics.gapi.ui.SecureCraft.FILTER_TYPE_ONLY_USEFUL});
		var4.splice(0,0,{label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
		this._cbTypes.dataProvider = var4;
		this.setType(this._nSelectedTypeID);
		this._cgGrid.dataProvider = var3;
	}
	function getQtyIn(§\x10\x11§, §\x04\x13§)
	{
		for(var qtc in var2)
		{
			if(var2[qtc].unicID == var3)
			{
				return var2[qtc].Quantity;
			}
		}
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
		var var2 = this._cgCoop.getContainer(0).contentData;
		if(var2 != undefined)
		{
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = var2;
		}
	}
	function updatePayData(§\x15\x13§)
	{
		this._cgPay.dataProvider = this._eaPayDataProvider;
		if(!var2)
		{
			return undefined;
		}
		this.switchToPayMode(true);
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"securecraft",this,this.hideButtonValidate,dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE,[false]);
	}
	function updatePayIfSuccessData(§\x15\x13§)
	{
		this._cgPayIfSuccess.dataProvider = this._eaPayIfSuccessDataProvider;
		if(!var2)
		{
			return undefined;
		}
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
		var var2 = !this._eaReadyDataProvider[0]?dofus.graphics.gapi.ui.SecureCraft.NON_READY_COLOR:dofus.graphics.gapi.ui.SecureCraft.READY_COLOR;
		this.setMovieClipTransform(this._winLocal,var2);
		this.setMovieClipTransform(this._btnValidate,var2);
		this.setMovieClipTransform(this._cgLocal,var2);
		var2 = !this._eaReadyDataProvider[1]?dofus.graphics.gapi.ui.SecureCraft.NON_READY_COLOR:dofus.graphics.gapi.ui.SecureCraft.READY_COLOR;
		this.setMovieClipTransform(this._winDistant,var2);
		this.setMovieClipTransform(this._cgDistant,var2);
	}
	function hideButtonValidate(§\x19\x0e§)
	{
		var var3 = !var2?dofus.graphics.gapi.ui.SecureCraft.NON_READY_COLOR:dofus.graphics.gapi.ui.SecureCraft.READY_COLOR;
		this.setMovieClipTransform(this._btnValidate,var3);
		this._btnValidate.enabled = !var2;
	}
	function hideItemViewer(§\x19\x0e§)
	{
		this._itvItemViewer._visible = !var2;
		this._winItemViewer._visible = !var2;
	}
	function validateDrop(§\x1e\f\x1a§, §\x1e\x19\r§, §\x1e\x1b\x17§)
	{
		if(var4 < 1 || var4 == undefined)
		{
			return undefined;
		}
		if(var4 > var3.Quantity)
		{
			var4 = var3.Quantity;
		}
		this._sCurrentDragTarget = var2;
		switch(var2)
		{
			case "_cgGrid":
				if(!this._bPayMode)
				{
					this.api.network.Exchange.movementItem(false,var3,var4);
				}
				else
				{
					this.api.network.Exchange.movementPayItem(this._nPayBar,false,var3.ID,var4);
				}
				break;
			case "_cgLocal":
				this.api.network.Exchange.movementItem(true,var3,var4);
				break;
			case "_cgPay":
				this.api.network.Exchange.movementPayItem(1,true,var3.ID,var4);
				break;
			case "_cgPayIfSuccess":
				this.api.network.Exchange.movementPayItem(2,true,var3.ID,var4);
		}
		if(this._bInvalidateCoop)
		{
			this.api.datacenter.Exchange.clearCoopGarbage();
			this._bInvalidateCoop = false;
		}
	}
	function setReady()
	{
		var var2 = this.getTotalCraftInventory();
		if(var2.length == 0)
		{
			return undefined;
		}
		if(var2.length > this._nMaxItem)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_CRAFT_SLOT",[this._nMaxItem]),"ERROR_BOX",{name:"NotEnoughtCraftSlot"});
			return undefined;
		}
		this.api.network.Exchange.ready();
	}
	function canDropInGarbage(§\x1e\x19\r§)
	{
		var var3 = this.api.datacenter.Exchange.localGarbage.findFirstItem("ID",var2.ID);
		var var4 = this.api.datacenter.Exchange.localGarbage.length;
		if(var3.index == -1 && var4 >= this._nMaxItem)
		{
			return false;
		}
		return true;
	}
	function showCraftViewer(§\x15\x13§)
	{
		if(var2)
		{
			var var3 = this.attachMovie("CraftViewer","_cvCraftViewer",this.getNextHighestDepth());
			var3._x = this._mcPlacer._x;
			var3._y = this._mcPlacer._y;
			var3.skill = new dofus.datacenter.(this._nSkillId,this._nMaxItem);
		}
		else
		{
			this._cvCraftViewer.removeMovieClip();
		}
		this._winCraftViewer._visible = var2;
	}
	function recordGarbage()
	{
		this._aGarbageMemory = new Array();
		var var2 = 0;
		while(var2 < this._eaLocalDataProvider.length)
		{
			var var3 = this._eaLocalDataProvider[var2];
			this._aGarbageMemory.push({id:var3.ID,quantity:var3.Quantity});
			var2 = var2 + 1;
		}
	}
	function cleanGarbage()
	{
		var var2 = 0;
		while(var2 < this._eaLocalDataProvider.length)
		{
			var var3 = this._eaLocalDataProvider[var2];
			this.api.network.Exchange.movementItem(false,var3,var3.Quantity);
			var2 = var2 + 1;
		}
	}
	function recallGarbageMemory()
	{
		if(this._aGarbageMemory == undefined || this._aGarbageMemory.length == 0)
		{
			return undefined;
		}
		this.cleanGarbage();
		var var2 = 0;
		while(var2 < this._aGarbageMemory.length)
		{
			var var3 = this._aGarbageMemory[var2];
			var var4 = this._eaDataProvider.findFirstItem("ID",var3.id);
			if(var4.index != -1)
			{
				if(var4.item.Quantity >= var3.quantity)
				{
					this.api.network.Exchange.movementItem(true,var4.item,var3.quantity);
				}
				else
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_NOT_ENOUGHT",[var4.item.name]),"ERROR_BOX",{name:"NotEnougth"});
					return undefined;
				}
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_NO_RESOURCE"),"ERROR_BOX",{name:"NotEnougth"});
			}
			var2 = var2 + 1;
		}
	}
	function showPreview(§\f\x15§, §\x1d\x03§)
	{
		if(this._ctrPreview.contentPath == undefined)
		{
			return undefined;
		}
		this._mcFiligrane._visible = this._bFiligraneVisible = var3;
		this._ctrPreview._visible = var3;
		this._ctrPreview.contentPath = !var3?"":var2.iconFile;
		this._mcFiligrane.itemName = var2.name;
	}
	function updatePreview()
	{
		var var2 = this.api.kernel.GameManager.analyseReceipts(this.getTotalCraftInventory(),this._nSkillId,this._nMaxItem);
		if(var2 != undefined)
		{
			this.showPreview(new dofus.datacenter.(-1,var2,1,0,"",0),true);
		}
		else
		{
			this.showPreview(undefined,false);
		}
	}
	function getTotalCraftInventory()
	{
		var var2 = this.api.kernel.GameManager;
		return var2.mergeUnicItemInInventory(var2.mergeTwoInventory(this._eaLocalDataProvider,this._eaDistantDataProvider));
	}
	function switchToPayMode(§\x15\x13§)
	{
		if(var2 == undefined && this._bPayMode == undefined)
		{
			return undefined;
		}
		if(var2 == undefined)
		{
			this._bPayMode = !this._bPayMode;
		}
		else if(this._bPayMode != var2)
		{
			this._bPayMode = var2;
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
	function switchPayBar(§\x02\x03§)
	{
		if(var2 != undefined)
		{
			this._nPayBar = var2;
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
	function validateKama(§\x01\x0e§)
	{
		if(var2 > this.api.datacenter.Player.Kama)
		{
			var2 = this.api.datacenter.Player.Kama;
		}
		this.api.network.Exchange.movementPayKama(this._nPayBar,var2);
	}
	function askKamaQuantity(§\x02\x03§)
	{
		this.switchPayBar(var2);
		var var3 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:this.api.datacenter.Exchange.localKama,max:this.api.datacenter.Player.Kama,params:{targetType:"kama"}});
		var3.addEventListener("validate",this);
	}
	function canUseItemInCraft(§\x1e\x19\r§)
	{
		if(this._nForgemagusItemType == undefined || this.isNotForgemagus())
		{
			return true;
		}
		if(var2.type == 78)
		{
			return true;
		}
		var var3 = false;
		var var4 = 0;
		while(var4 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
		{
			if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[var4] == var2.unicID)
			{
				return true;
			}
			var4 = var4 + 1;
		}
		var var5 = 0;
		while(var5 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
		{
			if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[var5] == var2.type)
			{
				return true;
			}
			var5 = var5 + 1;
		}
		if(this._nForgemagusItemType != var2.type || !var2.enhanceable)
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
	function addCraft(§\x1e\x1c\x18§)
	{
		if(this._nLastRegenerateTimer + dofus.graphics.gapi.ui.SecureCraft.NAME_GENERATION_DELAY < getTimer())
		{
			this._nLastRegenerateTimer = getTimer();
			var var3 = this.api.lang.getSkillText(this._nSkillId).cl;
			var var4 = 0;
			while(var4 < var3.length)
			{
				var var5 = var3[var4];
				if(var2 == var5)
				{
					var var6 = this.api.lang.getCraftText(var5);
					var var8 = 0;
					var var9 = new Array();
					var var10 = 0;
					while(var10 < var6.length)
					{
						var var11 = var6[var10];
						var var12 = var11[0];
						var var13 = var11[1];
						var var7 = false;
						var var14 = 0;
						while(var14 < this._eaDataProvider.length)
						{
							if(var12 == this._eaDataProvider[var14].unicID)
							{
								if(var13 <= this._eaDataProvider[var14].Quantity)
								{
									var8 = var8 + 1;
									var7 = true;
									var9.push({item:this._eaDataProvider[var14],qty:var13});
									break;
								}
							}
							var14 = var14 + 1;
						}
						if(!var7)
						{
							break;
						}
						var10 = var10 + 1;
					}
					if(var7 && var6.length == var8)
					{
						var var16 = new Array();
						var var18 = 0;
						while(var18 < this._cgLocal.dataProvider.length)
						{
							var var15 = this._cgLocal.dataProvider[var18];
							var var17 = var15.Quantity;
							if(!(var17 < 1 || var17 == undefined))
							{
								var16.push({Add:false,ID:var15.ID,Quantity:var17});
							}
							var18 = var18 + 1;
						}
						var var19 = 0;
						while(var19 < var9.length)
						{
							var15 = var9[var19].item;
							var17 = var9[var19].qty;
							if(!(var17 < 1 || var17 == undefined))
							{
								var16.push({Add:true,ID:var15.ID,Quantity:var17});
							}
							var19 = var19 + 1;
						}
						this.api.network.Exchange.movementItems(var16);
					}
					else
					{
						this.api.kernel.showMessage(undefined,this.api.lang.getText("DONT_HAVE_ALL_INGREDIENT"),"ERROR_BOX");
					}
					break;
				}
				var4 = var4 + 1;
			}
		}
		return undefined;
	}
	function kamaChanged(§\x1e\x19\x18§)
	{
		this._lblKama.text = new ank.utils.(var2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
	}
	function modelChanged(§\x1e\x19\x18§)
	{
		loop0:
		switch(var2.target)
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
					this._cgCoop.dataProvider = new ank.utils.
();
				}
				break;
			case this._eaDataProvider:
				this.updateData();
				this.updatePreview();
				break;
			default:
				switch(null)
				{
					case this._eaCoopDataProvider:
						this.updateCoopData();
						this.updatePreview();
						break loop0;
					case this._eaPayDataProvider:
						this.updatePayData(true);
						break loop0;
					case this._eaPayIfSuccessDataProvider:
						this.updatePayIfSuccessData(true);
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
	function over(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_btnFilterEquipement":
				this.api.ui.showTooltip(this.api.lang.getText("EQUIPEMENT"),var2.target,-20);
				break;
			case "_btnFilterNonEquipement":
				this.api.ui.showTooltip(this.api.lang.getText("NONEQUIPEMENT"),var2.target,-20);
				break;
			default:
				switch(null)
				{
					case "_btnFilterRessoureces":
						this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),var2.target,-20);
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
	function out(§\x1e\x19\x18§)
	{
		this.api.ui.hideTooltip();
	}
	function click(§\x1e\x19\x18§)
	{
		if(var2.target == this._btnClose)
		{
			this.callClose();
			return undefined;
		}
		if(var2.target == this._btnValidate)
		{
			var var3 = this.api.kernel.GameManager.analyseReceipts(this.getTotalCraftInventory(),this._nSkillId,this._nMaxItem);
			org.flashdevelop.utils.FlashConnect.mtrace("nItemId : " + var3,"dofus.graphics.gapi.ui.SecureCraft::click","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/graphics/gapi/ui/SecureCraft.as",1287);
			org.flashdevelop.utils.FlashConnect.mtrace("AskForWrongCraft : " + this.api.kernel.OptionsManager.getOption("AskForWrongCraft"),"dofus.graphics.gapi.ui.SecureCraft::click","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/graphics/gapi/ui/SecureCraft.as",1288);
			org.flashdevelop.utils.FlashConnect.mtrace("isNotForgemagus() : " + this.isNotForgemagus(),"dofus.graphics.gapi.ui.SecureCraft::click","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/graphics/gapi/ui/SecureCraft.as",1289);
			if(var3 == undefined && (this.api.kernel.OptionsManager.getOption("AskForWrongCraft") && this.isNotForgemagus()))
			{
				this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("WRONG_CRAFT_CONFIRM"),"CAUTION_YESNO",{name:"confirmWrongCraft",listener:this});
			}
			else
			{
				this.validCraft();
			}
			return undefined;
		}
		if(var2.target == this._btnCraft)
		{
			this.showCraftViewer(var2.target.selected);
			return undefined;
		}
		if(var2.target == this._btnPrivateMessage || var2.target == this._btnPrivateMessagePay)
		{
			this.api.kernel.GameManager.askPrivateMessage(this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name);
		}
		if(var2.target == this._btnPay || var2.target == this._btnValidatePay)
		{
			this._sCurrentDragSource = undefined;
			this._sCurrentDragTarget = undefined;
			this.switchToPayMode();
		}
		if(var2.target != this._btnSelectedFilterButton)
		{
			this._btnSelectedFilterButton.selected = false;
			this._btnSelectedFilterButton = var2.target;
			switch(var2.target._name)
			{
				case "_btnFilterEquipement":
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.SecureCraft.FILTER_EQUIPEMENT;
					this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
					break;
				case "_btnFilterNonEquipement":
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.SecureCraft.FILTER_NONEQUIPEMENT;
					this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
					break;
				default:
					if(var0 !== "_btnFilterRessoureces")
					{
						break;
					}
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.SecureCraft.FILTER_RESSOURECES;
					this._lblFilter.text = this.api.lang.getText("RESSOURECES");
					break;
			}
			this.updateData(true);
		}
		else
		{
			var2.target.selected = true;
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
		if(var3 == undefined)
		{
			return undefined;
		}
		var var4 = !Key.isDown(Key.CONTROL)?1:var3.Quantity;
		var var5 = var2.owner._name;
		this._sCurrentDragSource = var5;
		switch(var5)
		{
			case "_cgGrid":
				if(!this.canDropInGarbage(var3))
				{
					return undefined;
				}
				if(!this.canUseItemInCraft(var3))
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("WRONG_ITEM_TYPE"),"ERROR_CHAT");
					return undefined;
				}
				if(!this._bPayMode)
				{
					var var6 = "_cgLocal";
				}
				else if(this.isClient)
				{
					var6 = this._nPayBar != 1?"_cgPayIfSuccess":"_cgPay";
				}
				else
				{
					return undefined;
				}
				break;
			case "_cgLocal":
				var6 = "_cgGrid";
				break;
			case "_cgPay":
				this.switchPayBar(1);
				var6 = "_cgGrid";
				break;
			case "_cgPayIfSuccess":
				this.switchPayBar(2);
				var6 = "_cgGrid";
		}
		this.validateDrop(var6,var3,var4);
	}
	function dragItem(§\x1e\x19\x18§)
	{
		this.gapi.removeCursor();
		if(var2.target.contentData == undefined)
		{
			return undefined;
		}
		this._sCurrentDragSource = var2.target._parent._parent._name;
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
				if(!this._bPayMode)
				{
					if(var3.position == -1)
					{
						return undefined;
					}
				}
				break;
			case "_cgLocal":
				if(var3.position == -2)
				{
					return undefined;
				}
				if(!this.canUseItemInCraft(var3))
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("WRONG_ITEM_TYPE"),"ERROR_CHAT");
					return undefined;
				}
				if(!this.canDropInGarbage(var3))
				{
					return undefined;
				}
				break;
			case "_cgPay":
				if(this._sCurrentDragSource == "_cgPay" || this._sCurrentDragSource == "_cgPayIfSuccess")
				{
					return undefined;
				}
				this.switchPayBar(1);
				break;
			default:
				if(var0 !== "_cgPayIfSuccess")
				{
					break;
				}
				if(this._sCurrentDragSource == "_cgPay" || this._sCurrentDragSource == "_cgPayIfSuccess")
				{
					return undefined;
				}
				this.switchPayBar(2);
				break;
		}
		if(var3.Quantity > 1 && !(var4 == "_cgGrid" && (this._sCurrentDragSource == "_cgPay" || this._sCurrentDragSource == "_cgPayIfSuccess")))
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
	function itemSelected(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target._name) === "_cbTypes")
		{
			this._nSelectedTypeID = this._cbTypes.selectedItem.id;
			this.api.datacenter.Basics[dofus.graphics.gapi.ui.SecureCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
			this.updateData();
		}
	}
	function localKamaChange(§\x1e\x19\x18§)
	{
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"securecraft",this,this.hideButtonValidate,dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE,[false]);
	}
	function payKamaChange(§\x1e\x19\x18§)
	{
		this.switchToPayMode(true);
		this._mcBlinkPay.play();
		this._nKamaPayment = var2.value;
		if(_global.isNaN(this._nKamaPaymentIfSuccess) || this._nKamaPaymentIfSuccess == undefined)
		{
			this._nKamaPaymentIfSuccess = 0;
		}
		if(this.isClient)
		{
			this._lblKama.text = new ank.utils.(this.api.datacenter.Player.Kama - this._nKamaPayment - this._nKamaPaymentIfSuccess).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		}
		this._lblPayKama.text = new ank.utils.(var2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"securecraft",this,this.hideButtonValidate,dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE,[false]);
	}
	function payIfSuccessKamaChange(§\x1e\x19\x18§)
	{
		this.switchToPayMode(true);
		this._mcBlinkPayIfSuccess.play();
		this._nKamaPaymentIfSuccess = var2.value;
		if(_global.isNaN(this._nKamaPayment) || this._nKamaPayment == undefined)
		{
			this._nKamaPayment = 0;
		}
		if(this.isClient)
		{
			this._lblKama.text = new ank.utils.(this.api.datacenter.Player.Kama - this._nKamaPayment - this._nKamaPaymentIfSuccess).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		}
		this._lblPayIfSuccessKama.text = new ank.utils.(var2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
		this.hideButtonValidate(true);
		ank.utils.Timer.setTimer(this,"securecraft",this,this.hideButtonValidate,dofus.graphics.gapi.ui.SecureCraft.DELAY_BEFORE_VALIDATE,[false]);
	}
	function yes()
	{
		this.validCraft();
	}
}

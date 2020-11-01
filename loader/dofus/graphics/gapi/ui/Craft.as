class dofus.graphics.gapi.ui.Craft extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Craft";
	static var FILTER_EQUIPEMENT = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false];
	static var FILTER_NONEQUIPEMENT = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false];
	static var FILTER_RESSOURECES = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false];
	static var GRID_CONTAINER_WIDTH = 38;
	static var FILTER_TYPE_ONLY_USEFUL = 10000;
	var _bInvalidateDistant = false;
	var _aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_RESSOURECES;
	var _nSelectedTypeID = 0;
	var _nCurrentQuantity = 1;
	var _nLastRegenerateTimer = 0;
	static var NAME_GENERATION_DELAY = 1000;
	function Craft()
	{
		super();
		if(!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING"))
		{
			this._btnQuantity._visible = false;
		}
		if(!_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING_FM"))
		{
			this._btnTries._visible = false;
		}
	}
	function __get__currentOverItem()
	{
		return this._oOverItem;
	}
	function __get__itemViewer()
	{
		return this._itvItemViewer;
	}
	function __set__maxItem(var2)
	{
		this._nMaxItem = Number(var2);
		return this.__get__maxItem();
	}
	function __set__skillId(var2)
	{
		this._nSkillId = Number(var2);
		this._btnTries._visible = false;
		this._btnApplyRunes._visible = false;
		if(_global.API.lang.getConfigText("ENABLE_LOOP_CRAFTING"))
		{
			this._btnQuantity._visible = true;
		}
		this._btnCraft._visible = true;
		this._btnMemoryRecall._visible = true;
		this._btnValidate._visible = true;
		return this.__get__skillId();
	}
	function __set__dataProvider(var2)
	{
		this._eaDataProvider.removeEventListener("modelChanged",this);
		this._eaDataProvider = var2;
		this._eaDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__dataProvider();
	}
	function __set__localDataProvider(var2)
	{
		this._eaLocalDataProvider.removeEventListener("modelChanged",this);
		this._eaLocalDataProvider = var2;
		this._eaLocalDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__localDataProvider();
	}
	function __set__distantDataProvider(var2)
	{
		this._eaDistantDataProvider.removeEventListener("modelChanged",this);
		this._eaDistantDataProvider = var2;
		this._eaDistantDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__distantDataProvider();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Craft.CLASS_NAME);
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
		this._bMakeAll = false;
		this._mcPlacer._visible = false;
		this.showPreview(undefined,false);
		this._winCraftViewer.swapDepths(this.getNextHighestDepth());
		this.showCraftViewer(false);
		this.showBottom(false);
		this.addToQueue({object:this,method:this.addListeners});
		this._btnSelectedFilterButton = this._btnFilterRessoureces;
		this.addToQueue({object:this,method:this.saveGridMaxSize});
		this.addToQueue({object:this,method:this.initData});
		this.hideItemViewer(true);
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.initGridWidth});
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
		this._btnQuantity.addEventListener("click",this);
		this._btnTries.addEventListener("click",this);
		this._btnApplyRunes.addEventListener("click",this);
		this.api.datacenter.Exchange.addEventListener("localKamaChange",this);
		this.api.datacenter.Exchange.addEventListener("distantKamaChange",this);
		this._btnValidate.addEventListener("click",this);
		this._btnCraft.addEventListener("click",this);
		this._btnMemoryRecall.addEventListener("click",this);
		this._ctrPreview.addEventListener("over",this);
		this._ctrPreview.addEventListener("out",this);
		this._cbTypes.addEventListener("itemSelected",this);
		this._cgGrid.multipleContainerSelectionEnabled = false;
		this._cgDistant.multipleContainerSelectionEnabled = false;
		this._cgLocal.multipleContainerSelectionEnabled = false;
		this._cgLocalSave.multipleContainerSelectionEnabled = false;
	}
	function initTexts()
	{
		this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
		this._winInventory.title = this.api.datacenter.Player.data.name;
		this._winDistant.title = this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Exchange.distantPlayerID).name;
		this._btnValidate.label = this.api.lang.getText("COMBINE");
		this._btnCraft.label = this.api.lang.getText("RECEIPTS");
		this._btnQuantity.label = this.api.lang.getText("QUANTITY_SMALL") + ": 1";
		this._btnApplyRunes.label = this.api.lang.getText("APPLY_ONE_RUNE");
		this._btnTries.label = this.api.lang.getText("TRIES_WORD") + ": 1";
		this._lblNewObject.text = this.api.lang.getText("CRAFTED_ITEM");
		this._winCraftViewer.title = this.api.lang.getText("RECEIPTS_FROM_JOB");
		this._lblSkill.text = this.api.lang.getText("SKILL") + " : " + this.api.lang.getSkillText(this._nSkillId).d;
	}
	function initData()
	{
		this.dataProvider = this.api.datacenter.Exchange.inventory;
		this.localDataProvider = this.api.datacenter.Exchange.localGarbage;
		this.distantDataProvider = this.api.datacenter.Exchange.distantGarbage;
	}
	function saveGridMaxSize()
	{
		this._nMaxRight = this._winLocal._x + this._winLocal.width;
		this._nDistantToLocalWin = this._winLocal._x - this._winDistant._x;
		this._nLocalWinToCgLocal = this._cgLocal._x - this._winLocal._x;
		this._nCgLocalWinLocal = this._winLocal.width - this._cgLocal.width;
		this._nArrowToLocalWin = this._winLocal._x - this._mcArrow._x;
		this._nLblNewToDistantWin = this._lblNewObject._x - this._winDistant._x;
		this._nCgDistantToDistantWin = this._cgDistant._x - this._winDistant._x;
	}
	function showBottom(var2)
	{
		this._winLocal._visible = var2;
		this._mcArrow._visible = var2;
		this._winDistant._visible = var2;
		this._lblNewObject._visible = var2;
		this._cgDistant._visible = var2;
		this._cgLocal._visible = var2;
	}
	function initGridWidth()
	{
		this._cgLocal.visibleColumnCount = this._nMaxItem;
		if(this._nMaxItem == undefined)
		{
			this._nMaxItem = 12;
		}
		var var2 = dofus.graphics.gapi.ui.Craft.GRID_CONTAINER_WIDTH * this._nMaxItem;
		var var3 = Math.max(304,var2);
		this._cgLocal.setSize(var2);
		this._cgLocal._x = this._nMaxRight - var2 - this._nCgLocalWinLocal / 2;
		this._winLocal.setSize(var3 + this._nCgLocalWinLocal);
		this._winLocal._x = this._nMaxRight - var3 - this._nCgLocalWinLocal;
		this._mcArrow._x = this._winLocal._x - this._nArrowToLocalWin;
		this._winDistant._x = this._winLocal._x - this._nDistantToLocalWin;
		this._lblNewObject._x = this._winDistant._x + this._nLblNewToDistantWin;
		this._cgDistant._x = this._winDistant._x + this._nCgDistantToDistantWin;
		this._ctrPreview._x = this._cgDistant._x;
		this._mcFiligrane._x = this._cgDistant._x;
		this.showBottom(true);
	}
	function updateData()
	{
		if(this._bIsLooping)
		{
			return undefined;
		}
		var var2 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.Craft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
		this._nSelectedTypeID = var2 != undefined?var2:0;
		var var3 = new ank.utils.();
		var var4 = new ank.utils.();
		var var5 = new Object();
		for(var var6 in this._eaDataProvider)
		{
			var var7 = var6.position;
			if(var7 == -1 && this._aSelectedSuperTypes[var6.superType])
			{
				if(var6.type == this._nSelectedTypeID || this._nSelectedTypeID == 0)
				{
					var3.push(var6);
				}
				else if(this._nSelectedTypeID == dofus.graphics.gapi.ui.Craft.FILTER_TYPE_ONLY_USEFUL && this.api.kernel.GameManager.isItemUseful(var6.unicID,this._nSkillId,this._nMaxItem))
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
		var4.splice(0,0,{label:this.api.lang.getText("TYPE_FILTER_ONLY_USEFUL"),id:dofus.graphics.gapi.ui.Craft.FILTER_TYPE_ONLY_USEFUL});
		var4.splice(0,0,{label:this.api.lang.getText("WITHOUT_TYPE_FILTER"),id:0});
		this._cbTypes.dataProvider = var4;
		this.setType(this._nSelectedTypeID);
		this._cgGrid.dataProvider = var3;
	}
	function setType(var2)
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
	}
	function updateDistantData()
	{
		this._cgDistant.dataProvider = this._eaDistantDataProvider;
		var var2 = this._cgDistant.getContainer(0).contentData;
		if(var2 != undefined)
		{
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = var2;
		}
		this._bInvalidateDistant = true;
	}
	function hideItemViewer(var2)
	{
		this._itvItemViewer._visible = !var2;
		this._winItemViewer._visible = !var2;
	}
	function validateDrop(var2, var3, var4)
	{
		if(var4 < 1 || var4 == undefined)
		{
			return undefined;
		}
		if(var4 > var3.Quantity)
		{
			var4 = var3.Quantity;
		}
		switch(var2)
		{
			case "_cgGrid":
				this.api.network.Exchange.movementItem(false,var3,var4);
				break;
			case "_cgLocal":
				this.api.network.Exchange.movementItem(true,var3,var4);
		}
		if(this._bInvalidateDistant)
		{
			this.api.datacenter.Exchange.clearDistantGarbage();
			this._bInvalidateDistant = false;
		}
	}
	function setReady()
	{
		if(this.api.datacenter.Exchange.localGarbage.length == 0)
		{
			return undefined;
		}
		this.api.network.Exchange.ready();
	}
	function canDropInGarbage(var2)
	{
		var var3 = this.api.datacenter.Exchange.localGarbage.findFirstItem("ID",var2.ID);
		var var4 = this.api.datacenter.Exchange.localGarbage.length;
		if(var3.index == -1 && var4 >= this._nMaxItem)
		{
			return false;
		}
		return true;
	}
	function showCraftViewer(var2)
	{
		if(var2)
		{
			var var3 = this.attachMovie("CraftViewer","_cvCraftViewer",this.getNextHighestDepth());
			var3._x = this._mcPlacer._x;
			var3._y = this._mcPlacer._y;
			var3.skill = new dofus.datacenter.(this._nSkillId,this._nMaxItem);
		}
		else
		{
			this._cvCraftViewer.removeMovieClip();
		}
		this._winCraftViewer._visible = var2;
	}
	function addCraft(var2)
	{
		if(this._nLastRegenerateTimer + dofus.graphics.gapi.ui.Craft.NAME_GENERATION_DELAY < getTimer())
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
					var var11 = 0;
					while(var11 < var6.length)
					{
						var var12 = var6[var11];
						var var13 = var12[0];
						var var14 = var12[1];
						var var7 = false;
						var var15 = 0;
						while(var15 < this._eaDataProvider.length)
						{
							var var10 = this._eaDataProvider[var15];
							if(var13 == var10.unicID)
							{
								if(var14 <= var10.Quantity && var10.position == -1)
								{
									var8 = var8 + 1;
									var7 = true;
									var9.push({item:var10,qty:var14});
									break;
								}
							}
							var15 = var15 + 1;
						}
						if(!var7)
						{
							break;
						}
						var11 = var11 + 1;
					}
					if(var7 && var6.length == var8)
					{
						var var17 = new Array();
						var var19 = 0;
						while(var19 < this._cgLocal.dataProvider.length)
						{
							var var16 = this._cgLocal.dataProvider[var19];
							var var18 = var16.Quantity;
							if(!(var18 < 1 || var18 == undefined))
							{
								var17.push({Add:false,ID:var16.ID,Quantity:var18});
							}
							var19 = var19 + 1;
						}
						var var20 = 0;
						while(var20 < var9.length)
						{
							var16 = var9[var20].item;
							var18 = var9[var20].qty;
							if(!(var18 < 1 || var18 == undefined))
							{
								var17.push({Add:true,ID:var16.ID,Quantity:var18});
							}
							var20 = var20 + 1;
						}
						this.api.network.Exchange.movementItems(var17);
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
			return false;
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
					var2 = var2 + 1;
					continue;
				}
				this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_NOT_ENOUGHT",[var4.item.name]),"ERROR_BOX",{name:"NotEnougth"});
				return false;
			}
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_NO_RESOURCE"),"ERROR_BOX",{name:"NotEnougth"});
			return false;
		}
		return true;
	}
	function nextCraft()
	{
		ank.utils.Timer.setTimer(this,"doNextCraft",this,this.doNextCraft,250);
	}
	function doNextCraft()
	{
		if(this.recallGarbageMemory() == false)
		{
			this.stopMakeAll();
		}
	}
	function stopMakeAll()
	{
		ank.utils.Timer.removeTimer(this,"doNextCraft");
		this._bMakeAll = false;
		this._cgLocal.dataProvider = this.api.datacenter.Exchange.localGarbage;
		this.updateData();
		this.updateDistantData();
	}
	function showPreview(var2, var3)
	{
		if(this._ctrPreview.contentPath == undefined)
		{
			return undefined;
		}
		this._mcFiligrane._visible = var3;
		this._ctrPreview._visible = var3;
		this._ctrPreview.contentPath = !var3?"":var2.iconFile;
		this._mcFiligrane.itemName = var2.name;
	}
	function modelChanged(var2)
	{
		switch(var2.target)
		{
			case this._eaLocalDataProvider:
				if(this._bMakeAll)
				{
					if(this._eaLocalDataProvider.length == 0)
					{
						this.nextCraft();
					}
					else if(this._aGarbageMemory.length != undefined && this._aGarbageMemory.length == this._eaLocalDataProvider.length)
					{
						this.setReady();
					}
				}
				else
				{
					this.updateLocalData();
					var var3 = this.api.kernel.GameManager.analyseReceipts(this.api.kernel.GameManager.mergeUnicItemInInventory(this._eaLocalDataProvider),this._nSkillId,this._nMaxItem);
					if(var3 != undefined)
					{
						this.showPreview(new dofus.datacenter.(-1,var3,1,0,"",0),true);
					}
					else
					{
						this.showPreview(undefined,false);
					}
				}
				break;
			case this._eaDistantDataProvider:
				if(!this._bMakeAll && !this._bIsLooping)
				{
					this.updateDistantData();
				}
				break;
			case this._eaDataProvider:
				if(!this._bMakeAll && !this._bIsLooping)
				{
					this.updateData();
				}
				break;
			default:
				if(!this._bMakeAll && !this._bIsLooping)
				{
					this.updateData();
					this.updateLocalData();
					this.updateDistantData();
					break;
				}
		}
	}
	function over(var2)
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
				switch(null)
				{
					case this._btnFilterRessoureces:
						this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),var2.target,-20);
						break;
					case this._ctrPreview:
						if(this._mcFiligrane.itemName != undefined)
						{
							this.gapi.showTooltip(this._mcFiligrane.itemName,this._ctrPreview,-22);
							break;
						}
				}
		}
	}
	function out(var2)
	{
		this.api.ui.hideTooltip();
	}
	function onCraftLoopEnd()
	{
		this._bIsLooping = false;
		this._btnValidate.label = this.api.lang.getText("COMBINE");
		this._nCurrentQuantity = 1;
		this._btnQuantity.label = this.api.lang.getText("QUANTITY_SMALL") + ": 1";
		this._btnTries.label = this.api.lang.getText("TRIES_WORD") + ": 1";
		this._btnApplyRunes.label = this.api.lang.getText("APPLY_ONE_RUNE");
		this.updateData();
	}
	function overItem(var2)
	{
		var var3 = var2.target.contentData;
		var3.showStatsTooltip(var2.target,var2.target.contentData.style);
		this._oOverItem = var3;
	}
	function outItem(var2)
	{
		this.gapi.hideTooltip();
		this._oOverItem = undefined;
	}
	function repeatCraft()
	{
		this._bIsLooping = true;
		this._btnValidate.label = this._btnApplyRunes.label = this.api.lang.getText("STOP_WORD");
		this.api.network.Exchange.repeatCraft(this._nCurrentQuantity - 1);
	}
	function click(var2)
	{
		if(var2.target == this._btnClose)
		{
			this.callClose();
			return undefined;
		}
		if(var2.target == this._btnQuantity)
		{
			var var3 = 99;
			var var4 = 0;
			var var5 = 10000000;
			var var8 = 0;
			while(var8 < this._eaLocalDataProvider.length)
			{
				var var7 = false;
				var var9 = 0;
				while(var9 < this._eaDataProvider.length)
				{
					if(this._eaLocalDataProvider[var8].ID == this._eaDataProvider[var9].ID)
					{
						var7 = true;
						var var6 = Math.floor(this._eaDataProvider[var9].Quantity / this._eaLocalDataProvider[var8].Quantity);
						if(var6 < var5)
						{
							var5 = var6;
						}
					}
					var9 = var9 + 1;
				}
				if(!var7)
				{
					break;
				}
				var8 = var8 + 1;
			}
			if(var7)
			{
				var4 = 1;
				var3 = var5 + 1;
				if(var4 > var5)
				{
					var4 = var5;
				}
			}
			else
			{
				var3 = 0;
				var4 = 0;
			}
			var var10 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:var3,params:{targetType:"repeat"}});
			var10.addEventListener("validate",this);
			return undefined;
		}
		if(var2.target == this._btnTries)
		{
			var var11 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:99,params:{targetType:"tries"}});
			var11.addEventListener("validate",this);
			return undefined;
		}
		if(var2.target == this._btnValidate || var2.target == this._btnApplyRunes)
		{
			if(this._bIsLooping)
			{
				this.api.network.Exchange.stopRepeatCraft();
				return undefined;
			}
			if(this._eaLocalDataProvider.length == 0)
			{
				return undefined;
			}
			var var12 = this.api.kernel.GameManager.analyseReceipts(this.api.kernel.GameManager.mergeUnicItemInInventory(this._eaLocalDataProvider),this._nSkillId,this._nMaxItem);
			if(var12 == undefined && this.api.kernel.OptionsManager.getOption("AskForWrongCraft"))
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
		if(var2.target == this._btnMemoryRecall)
		{
			this.api.network.Exchange.replayCraft();
			return undefined;
		}
		if(var2.target != this._btnSelectedFilterButton)
		{
			this._btnSelectedFilterButton.selected = false;
			this._btnSelectedFilterButton = var2.target;
			switch(var2.target._name)
			{
				case "_btnFilterEquipement":
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_EQUIPEMENT;
					this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
					break;
				case "_btnFilterNonEquipement":
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_NONEQUIPEMENT;
					this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
					break;
				default:
					if(var0 !== "_btnFilterRessoureces")
					{
						break;
					}
					this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_RESSOURECES;
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
	function validCraft()
	{
		if(this._nCurrentQuantity > 1)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_LOOP_START",[this._nCurrentQuantity]),"INFO_CHAT");
			this.showCraftViewer(false);
			this._btnCraft.selected = false;
			this.recordGarbage();
			this.setReady();
			this.addToQueue({object:this,method:this.repeatCraft});
		}
		else
		{
			this.recordGarbage();
			this.setReady();
		}
	}
	function updateForgemagusResult(var2)
	{
		var var3 = new ank.utils.();
		var3.push(var2);
		this.distantDataProvider = var3;
	}
	function dblClickItem(var2)
	{
		var var3 = var2.target.contentData;
		if(var3 == undefined)
		{
			return undefined;
		}
		var var4 = !Key.isDown(Key.CONTROL)?1:var3.Quantity;
		var var5 = var2.owner._name;
		if((var var0 = var5) !== "_cgGrid")
		{
			if(var0 === "_cgLocal")
			{
				this.validateDrop("_cgGrid",var3,var4);
			}
		}
		else if(this.canDropInGarbage(var3))
		{
			this.validateDrop("_cgLocal",var3,var4);
		}
	}
	function dragItem(var2)
	{
		this.gapi.removeCursor();
		if(var2.target.contentData == undefined)
		{
			return undefined;
		}
		this.gapi.setCursor(var2.target.contentData);
	}
	function dropItem(var2)
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
				if(!this.canDropInGarbage(var3))
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
	function selectItem(var2)
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
	function validate(var2)
	{
		switch(var2.params.targetType)
		{
			case "item":
				this.validateDrop(var2.params.targetGrid,var2.params.oItem,var2.value);
				break;
			case "repeat":
				var var3 = Number(var2.value);
				if(var3 < 1 || (var3 == undefined || _global.isNaN(var3)))
				{
					var3 = 1;
				}
				this._btnQuantity.label = this.api.lang.getText("QUANTITY_SMALL") + ": " + var3;
				this._nCurrentQuantity = var3;
		}
	}
	function itemSelected(var2)
	{
		if((var var0 = var2.target._name) === "_cbTypes")
		{
			this._nSelectedTypeID = this._cbTypes.selectedItem.id;
			this.api.datacenter.Basics[dofus.graphics.gapi.ui.Craft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
			this.updateData();
		}
	}
	function yes()
	{
		this.validCraft();
	}
}

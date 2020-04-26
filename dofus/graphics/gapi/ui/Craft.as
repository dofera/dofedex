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
	function __set__maxItem(loc2)
	{
		this._nMaxItem = Number(loc2);
		return this.__get__maxItem();
	}
	function __set__skillId(loc2)
	{
		this._nSkillId = Number(loc2);
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
		this._eaLocalDataProvider.removeEventListener("modelChanged",this);
		this._eaLocalDataProvider = loc2;
		this._eaLocalDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__localDataProvider();
	}
	function __set__distantDataProvider(loc2)
	{
		this._eaDistantDataProvider.removeEventListener("modelChanged",this);
		this._eaDistantDataProvider = loc2;
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
	function showBottom(loc2)
	{
		this._winLocal._visible = loc2;
		this._mcArrow._visible = loc2;
		this._winDistant._visible = loc2;
		this._lblNewObject._visible = loc2;
		this._cgDistant._visible = loc2;
		this._cgLocal._visible = loc2;
	}
	function initGridWidth()
	{
		this._cgLocal.visibleColumnCount = this._nMaxItem;
		if(this._nMaxItem == undefined)
		{
			this._nMaxItem = 12;
		}
		var loc2 = dofus.graphics.gapi.ui.Craft.GRID_CONTAINER_WIDTH * this._nMaxItem;
		var loc3 = Math.max(304,loc2);
		this._cgLocal.setSize(loc2);
		this._cgLocal._x = this._nMaxRight - loc2 - this._nCgLocalWinLocal / 2;
		this._winLocal.setSize(loc3 + this._nCgLocalWinLocal);
		this._winLocal._x = this._nMaxRight - loc3 - this._nCgLocalWinLocal;
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
		var loc2 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.Craft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
		this._nSelectedTypeID = loc2 != undefined?loc2:0;
		var loc3 = new ank.utils.();
		var loc4 = new ank.utils.();
		var loc5 = new Object();
		for(var loc6 in this._eaDataProvider)
		{
			var loc7 = loc6.position;
			if(loc7 == -1 && this._aSelectedSuperTypes[loc6.superType])
			{
				if(loc6.type == this._nSelectedTypeID || this._nSelectedTypeID == 0)
				{
					loc3.push(loc6);
				}
				else if(this._nSelectedTypeID == dofus.graphics.gapi.ui.Craft.FILTER_TYPE_ONLY_USEFUL && this.api.kernel.GameManager.isItemUseful(loc6.unicID,this._nSkillId,this._nMaxItem))
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
		loc4.splice(0,0,{label:this.api.lang.getText("TYPE_FILTER_ONLY_USEFUL"),id:dofus.graphics.gapi.ui.Craft.FILTER_TYPE_ONLY_USEFUL});
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
	}
	function updateDistantData()
	{
		this._cgDistant.dataProvider = this._eaDistantDataProvider;
		var loc2 = this._cgDistant.getContainer(0).contentData;
		if(loc2 != undefined)
		{
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = loc2;
		}
		this._bInvalidateDistant = true;
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
	function addCraft(loc2)
	{
		if(this._nLastRegenerateTimer + dofus.graphics.gapi.ui.Craft.NAME_GENERATION_DELAY < getTimer())
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
					var loc11 = 0;
					while(loc11 < loc6.length)
					{
						var loc12 = loc6[loc11];
						var loc13 = loc12[0];
						var loc14 = loc12[1];
						var loc7 = false;
						var loc15 = 0;
						while(loc15 < this._eaDataProvider.length)
						{
							var loc10 = this._eaDataProvider[loc15];
							if(loc13 == loc10.unicID)
							{
								if(loc14 <= loc10.Quantity && loc10.position == -1)
								{
									loc8 = loc8 + 1;
									loc7 = true;
									loc9.push({item:loc10,qty:loc14});
									break;
								}
							}
							loc15 = loc15 + 1;
						}
						if(!loc7)
						{
							break;
						}
						loc11 = loc11 + 1;
					}
					if(loc7 && loc6.length == loc8)
					{
						var loc17 = new Array();
						var loc19 = 0;
						while(loc19 < this._cgLocal.dataProvider.length)
						{
							var loc16 = this._cgLocal.dataProvider[loc19];
							var loc18 = loc16.Quantity;
							if(!(loc18 < 1 || loc18 == undefined))
							{
								loc17.push({Add:false,ID:loc16.ID,Quantity:loc18});
							}
							loc19 = loc19 + 1;
						}
						var loc20 = 0;
						while(loc20 < loc9.length)
						{
							loc16 = loc9[loc20].item;
							loc18 = loc9[loc20].qty;
							if(!(loc18 < 1 || loc18 == undefined))
							{
								loc17.push({Add:true,ID:loc16.ID,Quantity:loc18});
							}
							loc20 = loc20 + 1;
						}
						this.api.network.Exchange.movementItems(loc17);
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
			return false;
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
					loc2 = loc2 + 1;
					continue;
				}
				this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_NOT_ENOUGHT",[loc4.item.name]),"ERROR_BOX",{name:"NotEnougth"});
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
	function showPreview(loc2, loc3)
	{
		if(this._ctrPreview.contentPath == undefined)
		{
			return undefined;
		}
		this._mcFiligrane._visible = loc3;
		this._ctrPreview._visible = loc3;
		this._ctrPreview.contentPath = !loc3?"":loc2.iconFile;
		this._mcFiligrane.itemName = loc2.name;
	}
	function modelChanged(loc2)
	{
		switch(loc2.target)
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
					var loc3 = this.api.kernel.GameManager.analyseReceipts(this.api.kernel.GameManager.mergeUnicItemInInventory(this._eaLocalDataProvider),this._nSkillId,this._nMaxItem);
					if(loc3 != undefined)
					{
						this.showPreview(new dofus.datacenter.(-1,loc3,1,0,"",0),true);
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
			case this._btnFilterRessoureces:
				this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),loc2.target,-20);
				break;
			default:
				if(loc0 !== this._ctrPreview)
				{
					break;
				}
				if(this._mcFiligrane.itemName != undefined)
				{
					this.gapi.showTooltip(this._mcFiligrane.itemName,this._ctrPreview,-22);
					break;
				}
				break;
		}
	}
	function out(loc2)
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
	function repeatCraft()
	{
		this._bIsLooping = true;
		this._btnValidate.label = this._btnApplyRunes.label = this.api.lang.getText("STOP_WORD");
		this.api.network.Exchange.repeatCraft(this._nCurrentQuantity - 1);
	}
	function click(loc2)
	{
		if(loc2.target == this._btnClose)
		{
			this.callClose();
			return undefined;
		}
		if(loc2.target == this._btnQuantity)
		{
			var loc3 = 99;
			var loc4 = 0;
			var loc5 = 10000000;
			var loc8 = 0;
			while(loc8 < this._eaLocalDataProvider.length)
			{
				var loc7 = false;
				var loc9 = 0;
				while(loc9 < this._eaDataProvider.length)
				{
					if(this._eaLocalDataProvider[loc8].ID == this._eaDataProvider[loc9].ID)
					{
						loc7 = true;
						var loc6 = Math.floor(this._eaDataProvider[loc9].Quantity / this._eaLocalDataProvider[loc8].Quantity);
						if(loc6 < loc5)
						{
							loc5 = loc6;
						}
					}
					loc9 = loc9 + 1;
				}
				if(!loc7)
				{
					break;
				}
				loc8 = loc8 + 1;
			}
			if(loc7)
			{
				loc4 = 1;
				loc3 = loc5 + 1;
				if(loc4 > loc5)
				{
					loc4 = loc5;
				}
			}
			else
			{
				loc3 = 0;
				loc4 = 0;
			}
			var loc10 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:loc3,params:{targetType:"repeat"}});
			loc10.addEventListener("validate",this);
			return undefined;
		}
		if(loc2.target == this._btnTries)
		{
			var loc11 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:99,params:{targetType:"tries"}});
			loc11.addEventListener("validate",this);
			return undefined;
		}
		if(loc2.target == this._btnValidate || loc2.target == this._btnApplyRunes)
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
			var loc12 = this.api.kernel.GameManager.analyseReceipts(this.api.kernel.GameManager.mergeUnicItemInInventory(this._eaLocalDataProvider),this._nSkillId,this._nMaxItem);
			if(loc12 == undefined && this.api.kernel.OptionsManager.getOption("AskForWrongCraft"))
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
		if(loc2.target == this._btnMemoryRecall)
		{
			this.api.network.Exchange.replayCraft();
			return undefined;
		}
		if(loc2.target != this._btnSelectedFilterButton)
		{
			this._btnSelectedFilterButton.selected = false;
			this._btnSelectedFilterButton = loc2.target;
			if((var loc0 = loc2.target._name) !== "_btnFilterEquipement")
			{
				switch(null)
				{
					case "_btnFilterNonEquipement":
						this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_NONEQUIPEMENT;
						this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
						break;
					case "_btnFilterRessoureces":
						this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_RESSOURECES;
						this._lblFilter.text = this.api.lang.getText("RESSOURECES");
				}
			}
			else
			{
				this._aSelectedSuperTypes = dofus.graphics.gapi.ui.Craft.FILTER_EQUIPEMENT;
				this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
			}
			this.updateData(true);
		}
		else
		{
			loc2.target.selected = true;
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
			this.showCraftViewer(false);
			this._btnCraft.selected = false;
			this.recordGarbage();
			this.setReady();
		}
	}
	function updateForgemagusResult(loc2)
	{
		var loc3 = new ank.utils.();
		loc3.push(loc2);
		this.distantDataProvider = loc3;
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
		if((var loc0 = loc5) !== "_cgGrid")
		{
			if(loc0 === "_cgLocal")
			{
				this.validateDrop("_cgGrid",loc3,loc4);
			}
		}
		else if(this.canDropInGarbage(loc3))
		{
			this.validateDrop("_cgLocal",loc3,loc4);
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
				if(!this.canDropInGarbage(loc3))
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
			case "repeat":
				var loc3 = Number(loc2.value);
				if(loc3 < 1 || (loc3 == undefined || _global.isNaN(loc3)))
				{
					loc3 = 1;
				}
				this._btnQuantity.label = this.api.lang.getText("QUANTITY_SMALL") + ": " + loc3;
				this._nCurrentQuantity = loc3;
		}
	}
	function itemSelected(loc2)
	{
		if((var loc0 = loc2.target._name) === "_cbTypes")
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

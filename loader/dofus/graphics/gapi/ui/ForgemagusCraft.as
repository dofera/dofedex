class dofus.graphics.gapi.ui.ForgemagusCraft extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ForgemagusCraft";
	static var FILTER_EQUIPEMENT = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false];
	static var FILTER_NONEQUIPEMENT = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false];
	static var FILTER_RESSOURECES = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false];
	static var GRID_CONTAINER_WIDTH = 38;
	static var TYPES_ALLOWED_AS_COMPONENT = [26,78];
	static var ITEMS_ALLOWED_AS_SIGNATURE = [7508];
	var _bInvalidateDistant = false;
	var _aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_RESSOURECES;
	var _nSelectedTypeID = 0;
	var _nCurrentQuantity = 1;
	function ForgemagusCraft()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
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
		this._nForgemagusItemType = _global.API.lang.getSkillForgemagus(this._nSkillId);
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
		super.init(false,dofus.graphics.gapi.ui.ForgemagusCraft.CLASS_NAME);
		this.api.datacenter.Basics.aks_exchange_isForgemagus = true;
	}
	function destroy()
	{
		this.gapi.hideTooltip();
		this.api.datacenter.Basics.aks_exchange_isForgemagus = false;
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
		this.addToQueue({object:this,method:this.addListeners});
		this._btnSelectedFilterButton = this._btnFilterRessoureces;
		this.addToQueue({object:this,method:this.initData});
		this.hideItemViewer(true);
		this.addToQueue({object:this,method:this.initTexts});
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
		this._ctrItem.addEventListener("dblClick",this);
		this._ctrItem.addEventListener("drag",this);
		this._ctrItem.addEventListener("drop",this);
		this._ctrItem.addEventListener("click",this);
		this._ctrSignature.addEventListener("dblClick",this);
		this._ctrSignature.addEventListener("drag",this);
		this._ctrSignature.addEventListener("drop",this);
		this._ctrSignature.addEventListener("click",this);
		this._ctrRune.addEventListener("dblClick",this);
		this._ctrRune.addEventListener("drag",this);
		this._ctrRune.addEventListener("drop",this);
		this._ctrRune.addEventListener("click",this);
		this._cgDistant.addEventListener("selectItem",this);
		this._cgDistant.addEventListener("overItem",this);
		this._cgDistant.addEventListener("outItem",this);
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
		this._btnOneShot.addEventListener("click",this);
		this._btnLoop.addEventListener("click",this);
		this.api.datacenter.Exchange.addEventListener("localKamaChange",this);
		this.api.datacenter.Exchange.addEventListener("distantKamaChange",this);
		this.api.datacenter.Player.addEventListener("kamaChanged",this);
		this.addToQueue({object:this,method:this.kamaChanged,params:[{value:this.api.datacenter.Player.Kama}]});
		this._cbTypes.addEventListener("itemSelected",this);
		this._cgDistant.multipleContainerSelectionEnabled = false;
		this._cgGrid.multipleContainerSelectionEnabled = false;
		this._cgLocal.multipleContainerSelectionEnabled = false;
		this._cgLocalSave.multipleContainerSelectionEnabled = false;
	}
	function initTexts()
	{
		this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
		this._winInventory.title = this.api.datacenter.Player.data.name;
		this._lblNewObject.text = this.api.lang.getText("CRAFTED_ITEM");
		this._lblSkill.text = this.api.lang.getText("SKILL") + " : " + this.api.lang.getSkillText(this._nSkillId).d;
		this._lblItemTitle.text = this.api.lang.getText("FM_CRAFT_ITEM");
		this._lblRuneTitle.text = this.api.lang.getText("FM_CRAFT_RUNE");
		this._lblSignatureTitle.text = this.api.lang.getText("FM_CRAFT_SIGNATURE");
		this._btnOneShot.label = this.api.lang.getText("APPLY_ONE_RUNE");
		this._btnLoop.label = this.api.lang.getText("APPLY_MULTIPLE_RUNES");
	}
	function initData()
	{
		this.dataProvider = this.api.datacenter.Exchange.inventory;
		this.localDataProvider = this.api.datacenter.Exchange.localGarbage;
		this.distantDataProvider = this.api.datacenter.Exchange.distantGarbage;
	}
	function updateData()
	{
		if(this._bIsLooping)
		{
			return undefined;
		}
		var var2 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.ForgemagusCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
		this._nSelectedTypeID = var2 != undefined?var2:0;
		var var3 = new ank.utils.();
		var var4 = new ank.utils.();
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
		this._ctrItem.contentData = this._ctrRune.contentData = this._ctrSignature.contentData = undefined;
		var var2 = 0;
		while(var2 < this._eaLocalDataProvider.length)
		{
			var var3 = false;
			var var4 = 0;
			while(var4 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
			{
				if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[var4] == this._eaLocalDataProvider[var2].unicID)
				{
					this._ctrSignature.contentData = this._eaLocalDataProvider[var2];
					var3 = true;
					break;
				}
				var4 = var4 + 1;
			}
			var var5 = 0;
			while(var5 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
			{
				if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[var5] == this._eaLocalDataProvider[var2].type)
				{
					this._ctrRune.contentData = this._eaLocalDataProvider[var2];
					var3 = true;
					break;
				}
				var5 = var5 + 1;
			}
			if(!var3)
			{
				this._ctrItem.contentData = this._eaLocalDataProvider[var2];
				if(this._ctrItem.contentData != undefined)
				{
					this.hideItemViewer(false);
					this._itvItemViewer.itemData = this._ctrItem.contentData;
				}
			}
			var2 = var2 + 1;
		}
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
		if((var var0 = var2) !== "_cgGrid")
		{
			switch(null)
			{
				case "_cgLocal":
					this.api.network.Exchange.movementItem(true,var3,var4);
					break;
				case "_ctrItem":
				case "_ctrRune":
				case "_ctrSignature":
					var var5 = false;
					var var6 = false;
					switch(var2)
					{
						case "_ctrItem":
							if(this._nForgemagusItemType != var3.type || !var3.enhanceable)
							{
								return undefined;
							}
							var var7 = 0;
							while(var7 < this._eaLocalDataProvider.length)
							{
								var var8 = false;
								var var9 = 0;
								while(var9 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
								{
									if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[var9] == this._eaLocalDataProvider[var7].unicID)
									{
										var8 = true;
									}
									var9 = var9 + 1;
								}
								var var10 = 0;
								while(var10 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
								{
									if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[var10] == this._eaLocalDataProvider[var7].type)
									{
										var8 = true;
									}
									var10 = var10 + 1;
								}
								if(!var8)
								{
									this.api.network.Exchange.movementItem(false,this._eaLocalDataProvider[var7],this._eaLocalDataProvider[var7].Quantity);
								}
								var7 = var7 + 1;
							}
							var5 = true;
							break;
						case "_ctrRune":
							var var11 = 0;
							while(var11 < this._eaLocalDataProvider.length)
							{
								var var12 = 0;
								while(var12 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
								{
									if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[var12] == this._eaLocalDataProvider[var11].type && this._eaLocalDataProvider[var11].unicID != var3.unicID)
									{
										this.api.network.Exchange.movementItem(false,this._eaLocalDataProvider[var11],this._eaLocalDataProvider[var11].Quantity);
									}
									var12 = var12 + 1;
								}
								var11 = var11 + 1;
							}
							break;
						case "_ctrSignature":
							var var13 = 0;
							while(var13 < this._eaLocalDataProvider.length)
							{
								var var14 = 0;
								while(var14 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
								{
									if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[var14] == this._eaLocalDataProvider[var13].unicID)
									{
										this.api.network.Exchange.movementItem(false,this._eaLocalDataProvider[var13],this._eaLocalDataProvider[var13].Quantity);
									}
									var14 = var14 + 1;
								}
								var13 = var13 + 1;
							}
							if(this.getCurrentCraftLevel() < 100)
							{
								var6 = true;
								this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_LEVEL_DOESNT_ALLOW_A_SIGNATURE"),"ERROR_CHAT");
							}
							var5 = true;
					}
					if(!var6)
					{
						this.api.network.Exchange.movementItem(true,var3,!var5?var4:1);
						break;
					}
			}
		}
		else
		{
			this.api.network.Exchange.movementItem(false,var3,var4);
		}
		if(this._bInvalidateDistant)
		{
			this.api.datacenter.Exchange.clearDistantGarbage();
			this._bInvalidateDistant = false;
		}
	}
	function getCurrentCraftLevel()
	{
		var var2 = this.api.datacenter.Player.Jobs;
		var var3 = 0;
		while(var3 < var2.length)
		{
			var var4 = 0;
			while(var4 < var2[var3].skills.length)
			{
				if((dofus.datacenter.Skill)(dofus.datacenter.Job)var2[var3].skills[var4].id == this._nSkillId)
				{
					return (dofus.datacenter.Job)var2[var3].level;
				}
				var4 = var4 + 1;
			}
			var3 = var3 + 1;
		}
		return 0;
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
	function kamaChanged(var2)
	{
		this._lblKama.text = new ank.utils.(var2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
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
				}
				break;
			case this._eaDistantDataProvider:
				if(!this._bMakeAll && !this._bIsLooping)
				{
					this.updateDistantData();
				}
				break;
			default:
				if(var0 !== this._eaDataProvider)
				{
					if(!this._bMakeAll && !this._bIsLooping)
					{
						this.updateData();
						this.updateLocalData();
						this.updateDistantData();
						break;
					}
					break;
				}
				if(!this._bMakeAll && !this._bIsLooping)
				{
					this.updateData();
				}
				break;
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
			case this._btnFilterRessoureces:
				this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),var2.target,-20);
		}
	}
	function out(var2)
	{
		this.api.ui.hideTooltip();
	}
	function onCraftLoopEnd()
	{
		this._bIsLooping = false;
		this._nCurrentQuantity = 1;
		this._btnLoop.label = this.api.lang.getText("APPLY_MULTIPLE_RUNES");
		this._btnOneShot.enabled = true;
	}
	function repeatCraft()
	{
		var var2 = this._ctrRune.contentData.Quantity - 1;
		if(var2 <= 1)
		{
			return undefined;
		}
		this._bIsLooping = true;
		this.api.network.Exchange.repeatCraft(var2);
		this._btnLoop.label = this.api.lang.getText("STOP_WORD");
		this._btnOneShot.enabled = false;
	}
	function checkIsBaka()
	{
		if(this._ctrItem.contentData == undefined || this._ctrRune.contentData == undefined)
		{
			this.api.kernel.showMessage(this.api.lang.getText("ERROR_WORD"),this.api.lang.getText("FM_ERROR_NO_ITEMS"),"ERROR_BOX");
			return true;
		}
		return false;
	}
	function click(var2)
	{
		loop0:
		switch(var2.target)
		{
			case this._btnClose:
				this.callClose();
				break;
			case this._btnOneShot:
				if(this.checkIsBaka())
				{
					return undefined;
				}
				this.recordGarbage();
				this.setReady();
				break;
			default:
				switch(null)
				{
					case this._btnLoop:
						if(this._bIsLooping)
						{
							this.api.network.Exchange.stopRepeatCraft();
							return undefined;
						}
						if(this.checkIsBaka())
						{
							return undefined;
						}
						this.recordGarbage();
						this.setReady();
						this.addToQueue({object:this,method:this.repeatCraft});
						break loop0;
					default:
						if(var0 !== this._ctrSignature)
						{
							if(var2.target != this._btnSelectedFilterButton)
							{
								this._btnSelectedFilterButton.selected = false;
								this._btnSelectedFilterButton = var2.target;
								switch(var2.target._name)
								{
									case "_btnFilterEquipement":
										this._aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_EQUIPEMENT;
										this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
										break;
									case "_btnFilterNonEquipement":
										this._aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_NONEQUIPEMENT;
										this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
										break;
									case "_btnFilterRessoureces":
										this._aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_RESSOURECES;
										this._lblFilter.text = this.api.lang.getText("RESSOURECES");
								}
								this.updateData(true);
								break loop0;
							}
							var2.target.selected = true;
							break loop0;
						}
					case this._ctrItem:
					case this._ctrRune:
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
		}
	}
	function dblClick(var2)
	{
		var2.owner = this._cgLocal;
		this.dblClickItem(var2);
	}
	function drag(var2)
	{
		this.dragItem(var2);
	}
	function drop(var2)
	{
		var var3 = this.gapi.getCursor();
		if(var3 == undefined)
		{
			return undefined;
		}
		this.gapi.removeCursor();
		if(var3.position == -2)
		{
			return undefined;
		}
		if(!this.canDropInGarbage(var3))
		{
			return undefined;
		}
		var var4 = false;
		var var5 = false;
		switch(var2.target)
		{
			case this._ctrItem:
				var4 = var5 = true;
				var var6 = 0;
				while(var6 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
				{
					if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[var6] == var3.type)
					{
						var4 = false;
					}
					var6 = var6 + 1;
				}
				var var7 = 0;
				while(var7 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
				{
					if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[var7] == var3.unicID)
					{
						var4 = false;
					}
					var7 = var7 + 1;
				}
				break;
			case this._ctrRune:
				var var8 = 0;
				while(var8 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
				{
					if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[var8] == var3.type)
					{
						var4 = true;
					}
					var8 = var8 + 1;
				}
				break;
			case this._ctrSignature:
				var var9 = 0;
				while(var9 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
				{
					if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[var9] == var3.unicID)
					{
						var4 = true;
					}
					var9 = var9 + 1;
				}
				var5 = true;
		}
		if(!var4)
		{
			return undefined;
		}
		if(!var5 && var3.Quantity > 1)
		{
			var var10 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:var3.Quantity,params:{targetType:"item",oItem:var3,targetGrid:var2.target._name}});
			var10.addEventListener("validate",this);
		}
		else
		{
			this.validateDrop(var2.target._name,var3,1);
		}
	}
	function updateForgemagusResult(var2)
	{
		var var3 = new ank.utils.();
		var3.push(var2);
		this.distantDataProvider = var3;
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
	function dblClickItem(var2)
	{
		var var3 = var2.target.contentData;
		if(var3 == undefined)
		{
			return undefined;
		}
		var var4 = var3.Quantity;
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
			var var6 = undefined;
			var var7 = 0;
			while(var7 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length && var6 == undefined)
			{
				if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[var7] == var3.unicID)
				{
					var6 = "_ctrSignature";
				}
				var7 = var7 + 1;
			}
			var var8 = 0;
			while(var8 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length && var6 == undefined)
			{
				if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[var8] == var3.type)
				{
					var6 = "_ctrRune";
				}
				var8 = var8 + 1;
			}
			if(var6 == undefined)
			{
				var6 = "_ctrItem";
			}
			this.validateDrop(var6,var3,var4);
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
				this._nCurrentQuantity = var3;
		}
	}
	function itemSelected(var2)
	{
		if((var var0 = var2.target._name) === "_cbTypes")
		{
			this._nSelectedTypeID = this._cbTypes.selectedItem.id;
			this.api.datacenter.Basics[dofus.graphics.gapi.ui.ForgemagusCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
			this.updateData();
		}
	}
}

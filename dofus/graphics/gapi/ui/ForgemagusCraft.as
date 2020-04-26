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
		this._cgLocal.addEventListener("dblClickItem",this);
		this._cgLocal.addEventListener("dropItem",this);
		this._cgLocal.addEventListener("dragItem",this);
		this._cgLocal.addEventListener("selectItem",this);
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
		var loc2 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.ForgemagusCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
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
		this._ctrItem.contentData = this._ctrRune.contentData = this._ctrSignature.contentData = undefined;
		var loc2 = 0;
		while(loc2 < this._eaLocalDataProvider.length)
		{
			var loc3 = false;
			var loc4 = 0;
			while(loc4 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
			{
				if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[loc4] == this._eaLocalDataProvider[loc2].unicID)
				{
					this._ctrSignature.contentData = this._eaLocalDataProvider[loc2];
					loc3 = true;
					break;
				}
				loc4 = loc4 + 1;
			}
			var loc5 = 0;
			while(loc5 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
			{
				if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[loc5] == this._eaLocalDataProvider[loc2].type)
				{
					this._ctrRune.contentData = this._eaLocalDataProvider[loc2];
					loc3 = true;
					break;
				}
				loc5 = loc5 + 1;
			}
			if(!loc3)
			{
				this._ctrItem.contentData = this._eaLocalDataProvider[loc2];
				if(this._ctrItem.contentData != undefined)
				{
					this.hideItemViewer(false);
					this._itvItemViewer.itemData = this._ctrItem.contentData;
				}
			}
			loc2 = loc2 + 1;
		}
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
				break;
			default:
				switch(null)
				{
					case "_ctrItem":
					case "_ctrRune":
					case "_ctrSignature":
						var loc5 = false;
						var loc6 = false;
						switch(loc2)
						{
							case "_ctrItem":
								if(this._nForgemagusItemType != loc3.type || !loc3.enhanceable)
								{
									return undefined;
								}
								var loc7 = 0;
								while(loc7 < this._eaLocalDataProvider.length)
								{
									var loc8 = false;
									var loc9 = 0;
									while(loc9 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
									{
										if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[loc9] == this._eaLocalDataProvider[loc7].unicID)
										{
											loc8 = true;
										}
										loc9 = loc9 + 1;
									}
									var loc10 = 0;
									while(loc10 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
									{
										if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[loc10] == this._eaLocalDataProvider[loc7].type)
										{
											loc8 = true;
										}
										loc10 = loc10 + 1;
									}
									if(!loc8)
									{
										this.api.network.Exchange.movementItem(false,this._eaLocalDataProvider[loc7].ID,this._eaLocalDataProvider[loc7].Quantity);
									}
									loc7 = loc7 + 1;
								}
								loc5 = true;
								break;
							case "_ctrRune":
								var loc11 = 0;
								while(loc11 < this._eaLocalDataProvider.length)
								{
									var loc12 = 0;
									while(loc12 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
									{
										if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[loc12] == this._eaLocalDataProvider[loc11].type && this._eaLocalDataProvider[loc11].unicID != loc3.unicID)
										{
											this.api.network.Exchange.movementItem(false,this._eaLocalDataProvider[loc11].ID,this._eaLocalDataProvider[loc11].Quantity);
										}
										loc12 = loc12 + 1;
									}
									loc11 = loc11 + 1;
								}
								break;
							case "_ctrSignature":
								var loc13 = 0;
								while(loc13 < this._eaLocalDataProvider.length)
								{
									var loc14 = 0;
									while(loc14 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
									{
										if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[loc14] == this._eaLocalDataProvider[loc13].unicID)
										{
											this.api.network.Exchange.movementItem(false,this._eaLocalDataProvider[loc13].ID,this._eaLocalDataProvider[loc13].Quantity);
										}
										loc14 = loc14 + 1;
									}
									loc13 = loc13 + 1;
								}
								if(this.getCurrentCraftLevel() < 100)
								{
									loc6 = true;
									this.api.kernel.showMessage(undefined,this.api.lang.getText("CRAFT_LEVEL_DOESNT_ALLOW_A_SIGNATURE"),"ERROR_CHAT");
								}
								loc5 = true;
						}
						if(!loc6)
						{
							this.api.network.Exchange.movementItem(true,loc3.ID,!loc5?loc4:1);
							break;
						}
				}
		}
		if(this._bInvalidateDistant)
		{
			this.api.datacenter.Exchange.clearDistantGarbage();
			this._bInvalidateDistant = false;
		}
	}
	function getCurrentCraftLevel()
	{
		var loc2 = this.api.datacenter.Player.Jobs;
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			var loc4 = 0;
			while(loc4 < loc2[loc3].skills.length)
			{
				if((dofus.datacenter.Skill)(dofus.datacenter.Job)loc2[loc3].skills[loc4].id == this._nSkillId)
				{
					return (dofus.datacenter.Job)loc2[loc3].level;
				}
				loc4 = loc4 + 1;
			}
			loc3 = loc3 + 1;
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
	function kamaChanged(loc2)
	{
		this._lblKama.text = new ank.utils.(loc2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
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
				}
				break;
			case this._eaDistantDataProvider:
				if(!this._bMakeAll && !this._bIsLooping)
				{
					this.updateDistantData();
				}
				break;
			default:
				if(loc0 !== this._eaDataProvider)
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
	function onCraftLoopEnd()
	{
		this._bIsLooping = false;
		this._nCurrentQuantity = 1;
		this._btnLoop.label = this.api.lang.getText("APPLY_MULTIPLE_RUNES");
		this._btnOneShot.enabled = true;
	}
	function repeatCraft()
	{
		var loc2 = this._ctrRune.contentData.Quantity - 1;
		if(loc2 <= 1)
		{
			return undefined;
		}
		this._bIsLooping = true;
		this.api.network.Exchange.repeatCraft(loc2);
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
	function click(loc2)
	{
		loop0:
		switch(loc2.target)
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
				break;
			default:
				switch(null)
				{
					case this._ctrItem:
					case this._ctrRune:
					case this._ctrSignature:
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
						break loop0;
					default:
						if(loc2.target != this._btnSelectedFilterButton)
						{
							this._btnSelectedFilterButton.selected = false;
							this._btnSelectedFilterButton = loc2.target;
							if((loc0 = loc2.target._name) !== "_btnFilterEquipement")
							{
								switch(null)
								{
									case "_btnFilterNonEquipement":
										this._aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_NONEQUIPEMENT;
										this._lblFilter.text = this.api.lang.getText("NONEQUIPEMENT");
										break;
									case "_btnFilterRessoureces":
										this._aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_RESSOURECES;
										this._lblFilter.text = this.api.lang.getText("RESSOURECES");
								}
							}
							else
							{
								this._aSelectedSuperTypes = dofus.graphics.gapi.ui.ForgemagusCraft.FILTER_EQUIPEMENT;
								this._lblFilter.text = this.api.lang.getText("EQUIPEMENT");
							}
							this.updateData(true);
							break loop0;
						}
						loc2.target.selected = true;
						break loop0;
				}
		}
	}
	function dblClick(loc2)
	{
		loc2.owner = this._cgLocal;
		this.dblClickItem(loc2);
	}
	function drag(loc2)
	{
		this.dragItem(loc2);
	}
	function drop(loc2)
	{
		var loc3 = this.gapi.getCursor();
		if(loc3 == undefined)
		{
			return undefined;
		}
		this.gapi.removeCursor();
		if(loc3.position == -2)
		{
			return undefined;
		}
		if(!this.canDropInGarbage(loc3))
		{
			return undefined;
		}
		var loc4 = false;
		var loc5 = false;
		switch(loc2.target)
		{
			case this._ctrItem:
				loc4 = loc5 = true;
				var loc6 = 0;
				while(loc6 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
				{
					if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[loc6] == loc3.type)
					{
						loc4 = false;
					}
					loc6 = loc6 + 1;
				}
				var loc7 = 0;
				while(loc7 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
				{
					if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[loc7] == loc3.unicID)
					{
						loc4 = false;
					}
					loc7 = loc7 + 1;
				}
				break;
			case this._ctrRune:
				var loc8 = 0;
				while(loc8 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length)
				{
					if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[loc8] == loc3.type)
					{
						loc4 = true;
					}
					loc8 = loc8 + 1;
				}
				break;
			case this._ctrSignature:
				var loc9 = 0;
				while(loc9 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length)
				{
					if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[loc9] == loc3.unicID)
					{
						loc4 = true;
					}
					loc9 = loc9 + 1;
				}
				loc5 = true;
		}
		if(!loc4)
		{
			return undefined;
		}
		if(!loc5 && loc3.Quantity > 1)
		{
			var loc10 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:1,max:loc3.Quantity,params:{targetType:"item",oItem:loc3,targetGrid:loc2.target._name}});
			loc10.addEventListener("validate",this);
		}
		else
		{
			this.validateDrop(loc2.target._name,loc3,1);
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
		var loc4 = loc3.Quantity;
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
			var loc6 = undefined;
			var loc7 = 0;
			while(loc7 < dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE.length && loc6 == undefined)
			{
				if(dofus.graphics.gapi.ui.ForgemagusCraft.ITEMS_ALLOWED_AS_SIGNATURE[loc7] == loc3.unicID)
				{
					loc6 = "_ctrSignature";
				}
				loc7 = loc7 + 1;
			}
			var loc8 = 0;
			while(loc8 < dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT.length && loc6 == undefined)
			{
				if(dofus.graphics.gapi.ui.ForgemagusCraft.TYPES_ALLOWED_AS_COMPONENT[loc8] == loc3.type)
				{
					loc6 = "_ctrRune";
				}
				loc8 = loc8 + 1;
			}
			if(loc6 == undefined)
			{
				loc6 = "_ctrItem";
			}
			this.validateDrop(loc6,loc3,loc4);
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
				this._nCurrentQuantity = loc3;
		}
	}
	function itemSelected(loc2)
	{
		if((var loc0 = loc2.target._name) === "_cbTypes")
		{
			this._nSelectedTypeID = this._cbTypes.selectedItem.id;
			this.api.datacenter.Basics[dofus.graphics.gapi.ui.ForgemagusCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name] = this._nSelectedTypeID;
			this.updateData();
		}
	}
}

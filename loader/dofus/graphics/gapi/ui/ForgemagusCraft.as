if(!dofus.graphics.gapi.ui.ForgemagusCraft)
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
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	} extends dofus.graphics.gapi.core.DofusAdvancedComponent;
	var var1 = dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}.prototype;
	var1.__get__currentOverItem = function __get__currentOverItem()
	{
		return this._oOverItem;
	};
	var1.__get__itemViewer = function __get__itemViewer()
	{
		return this._itvItemViewer;
	};
	var1.__set__maxItem = function __set__maxItem(var2)
	{
		this._nMaxItem = Number(var2);
		return this.__get__maxItem();
	};
	var1.__set__skillId = function __set__skillId(var2)
	{
		this._nSkillId = Number(var2);
		this._nForgemagusItemType = _global.API.lang.getSkillForgemagus(this._nSkillId);
		return this.__get__skillId();
	};
	var1.__set__dataProvider = function __set__dataProvider(var2)
	{
		this._eaDataProvider.removeEventListener("modelChanged",this);
		this._eaDataProvider = var2;
		this._eaDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__dataProvider();
	};
	var1.__set__localDataProvider = function __set__localDataProvider(var2)
	{
		this._eaLocalDataProvider.removeEventListener("modelChanged",this);
		this._eaLocalDataProvider = var2;
		this._eaLocalDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__localDataProvider();
	};
	var1.__set__distantDataProvider = function __set__distantDataProvider(var2)
	{
		this._eaDistantDataProvider.removeEventListener("modelChanged",this);
		this._eaDistantDataProvider = var2;
		this._eaDistantDataProvider.addEventListener("modelChanged",this);
		this.modelChanged();
		return this.__get__distantDataProvider();
	};
	var1.init = function init()
	{
		super.init(false,dofus.graphics.gapi.ui.ForgemagusCraft.CLASS_NAME);
		this.api.datacenter.Basics.aks_exchange_isForgemagus = true;
	};
	var1.destroy = function destroy()
	{
		this.gapi.hideTooltip();
		this.api.datacenter.Basics.aks_exchange_isForgemagus = false;
	};
	var1.callClose = function callClose()
	{
		this.api.network.Exchange.leave();
		return true;
	};
	var1.createChildren = function createChildren()
	{
		this._bMakeAll = false;
		this._mcPlacer._visible = false;
		this.addToQueue({object:this,method:this.addListeners});
		this._btnSelectedFilterButton = this._btnFilterRessoureces;
		this.addToQueue({object:this,method:this.initData});
		this.hideItemViewer(true);
		this.addToQueue({object:this,method:this.initTexts});
	};
	var1.addListeners = function addListeners()
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
	};
	var1.initTexts = function initTexts()
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
	};
	var1.initData = function initData()
	{
		this.dataProvider = this.api.datacenter.Exchange.inventory;
		this.localDataProvider = this.api.datacenter.Exchange.localGarbage;
		this.distantDataProvider = this.api.datacenter.Exchange.distantGarbage;
	};
	var1.updateData = function updateData()
	{
		if(this._bIsLooping)
		{
			return undefined;
		}
		var var2 = this.api.datacenter.Basics[dofus.graphics.gapi.ui.ForgemagusCraft.CLASS_NAME + "_subfilter_" + this._btnSelectedFilterButton._name];
		this._nSelectedTypeID = var2 != undefined?var2:0;
		var var3 = new ank.utils.();
		var var4 = new ank.utils.();
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
	};
	var1.setType = function setType(var2)
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
	};
	var1.updateLocalData = function updateLocalData()
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
	};
	var1.updateDistantData = function updateDistantData()
	{
		this._cgDistant.dataProvider = this._eaDistantDataProvider;
		var var2 = this._cgDistant.getContainer(0).contentData;
		if(var2 != undefined)
		{
			this.hideItemViewer(false);
			this._itvItemViewer.itemData = var2;
		}
		this._bInvalidateDistant = true;
	};
	var1.hideItemViewer = function hideItemViewer(var2)
	{
		this._itvItemViewer._visible = !var2;
		this._winItemViewer._visible = !var2;
	};
	var1.validateDrop = function validateDrop(var2, var3, var4)
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
	};
	var1.getCurrentCraftLevel = function getCurrentCraftLevel()
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
	};
	var1.setReady = function setReady()
	{
		if(this.api.datacenter.Exchange.localGarbage.length == 0)
		{
			return undefined;
		}
		this.api.network.Exchange.ready();
	};
	var1.canDropInGarbage = function canDropInGarbage(var2)
	{
		var var3 = this.api.datacenter.Exchange.localGarbage.findFirstItem("ID",var2.ID);
		var var4 = this.api.datacenter.Exchange.localGarbage.length;
		if(var3.index == -1 && var4 >= this._nMaxItem)
		{
			return false;
		}
		return true;
	};
	var1.recordGarbage = function recordGarbage()
	{
		this._aGarbageMemory = new Array();
		var var2 = 0;
		while(var2 < this._eaLocalDataProvider.length)
		{
			var var3 = this._eaLocalDataProvider[var2];
			this._aGarbageMemory.push({id:var3.ID,quantity:var3.Quantity});
			var2 = var2 + 1;
		}
	};
	var1.cleanGarbage = function cleanGarbage()
	{
		var var2 = 0;
		while(var2 < this._eaLocalDataProvider.length)
		{
			var var3 = this._eaLocalDataProvider[var2];
			this.api.network.Exchange.movementItem(false,var3,var3.Quantity);
			var2 = var2 + 1;
		}
	};
	var1.recallGarbageMemory = function recallGarbageMemory()
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
	};
	var1.nextCraft = function nextCraft()
	{
		ank.utils.Timer.setTimer(this,"doNextCraft",this,this.doNextCraft,250);
	};
	var1.doNextCraft = function doNextCraft()
	{
		if(this.recallGarbageMemory() == false)
		{
			this.stopMakeAll();
		}
	};
	var1.stopMakeAll = function stopMakeAll()
	{
		ank.utils.Timer.removeTimer(this,"doNextCraft");
		this._bMakeAll = false;
		this._cgLocal.dataProvider = this.api.datacenter.Exchange.localGarbage;
		this.updateData();
		this.updateDistantData();
	};
	var1.kamaChanged = function kamaChanged(var2)
	{
		this._lblKama.text = new ank.utils.(var2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
	};
	var1.modelChanged = function modelChanged(var2)
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
	};
	var1.over = function over(var2)
	{
		switch(var2.target)
		{
			case this._btnFilterEquipement:
				this.api.ui.showTooltip(this.api.lang.getText("EQUIPEMENT"),var2.target,-20);
				break;
			case this._btnFilterNonEquipement:
			default:
				this.api.ui.showTooltip(this.api.lang.getText("NONEQUIPEMENT"),var2.target,-20);
				break;
			case this._btnFilterRessoureces:
				this.api.ui.showTooltip(this.api.lang.getText("RESSOURECES"),var2.target,-20);
		}
	};
	var1.out = function out(var2)
	{
		this["\x04\x01\b4�\x03"]["\x01"]["\'�\x02"]();
	};
	var1["\x12�\x02"] = function §\x12�\x02§()
	{
		this[""] = false;
		this["2�<N�\x02"] = 1;
		this["2�\x02"][""] = this["\x04\x01\b4�\x03"]["�\x02"]("\x04\x01\b�4�\x02");
		this["\b"]["\b\x04N�\x02"] = true;
	};
	var1["\b�N�\x02"] = function §\b�N�\x02§()
	{
		var var2 = this["\x07"]["\x03\x17�\x03"]["�"] - 1;
		if(var2 <= 1)
		{
			return undefined;
		}
		this[""] = true;
		this["\x04\x01\b4�\x03"]["\x17�\x04"]["\x04\x01\b~N\x12\x12�\x02"]["\b�N�\x02"](var2);
		this["2�\x02"][""] = this["\x04\x01\b4�\x03"]["�\x02"]("\x04\bN�\x04");
		this["\b"]["\b\x04N�\x02"] = false;
	};
	var1["\x04\x03\b�NI\x12�\x02"] = function §\x04\x03\b�NI\x12�\x02§()
	{
		if(this["��\"N�\x02"]["\x03\x17�\x03"] == undefined || this["\x07"]["\x03\x17�\x03"] == undefined)
		{
			this["\x04\x01\b4�\x03"]["\b\x03N�\x02"]["\b\x04N�\x02"](this["\x04\x01\b4�\x03"]["�\x02"]("\bL�\x01"),this["\x04\x01\b4�\x03"]["�\x02"]("&\x01�\x02"),"\x06\x17�\x02");
			return true;
		}
		return false;
	};
	var1["\b�NI\x12�\x02"] = function §\b�NI\x12�\x02§(var2)
	{
		loop0:
		switch(var2["\b�NHL\x12�\x02"])
		{
			case this[""]:
				this["\n"]();
				break;
			case this["\b"]:
				if(this["\x04\x03\b�NI\x12�\x02"]())
				{
					return undefined;
				}
				this["\x05"]();
				this["\b"]();
				break;
			default:
				switch(null)
				{
					case this["2�\x02"]:
						if(this[""])
						{
							this["\x04\x01\b4�\x03"]["\x17�\x04"]["\x04\x01\b~N\x12\x12�\x02"]["\x06�\x02"]();
							return undefined;
						}
						if(this["\x04\x03\b�NI\x12�\x02"]())
						{
							return undefined;
						}
						this["\x05"]();
						this["\b"]();
						this[":\x01�\x04"]({:this,:this["\b�N�\x02"]});
						break loop0;
					default:
						if(var0 !== this["���\t"])
						{
							if(var2["\b�NHL\x12�\x02"] != this["\x04\x01\b4N\x12L\x12�\x02"])
							{
								this["\x04\x01\b4N\x12L\x12�\x02"]["\b�NHL\x12�\x02"] = false;
								this["\x04\x01\b4N\x12L\x12�\x02"] = var2["\b�NHL\x12�\x02"];
								switch(var2["\b�NHL\x12�\x02"][""])
								{
									case "":
										this[""] = eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["\x18��\x02"];
										this.o["�\t"] = this["\x04\x01\b4�\x03"]["�\x02"]("\x07");
										break;
									case "":
										this[""] = eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["\x05"];
										this.o["�\t"] = this["\x04\x01\b4�\x03"]["�\x02"]("\x04\x06\x03I�\x02");
										break;
									case "\x05\x01�\x02":
										this[""] = eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["\x12�\x02"];
										this.o["�\t"] = this["\x04\x01\b4�\x03"]["�\x02"]("\x05");
								}
								this["\x07"](true);
								break loop0;
							}
							var2["\b�NHL\x12�\x02"]["\b�NHL\x12�\x02"] = true;
							break loop0;
						}
					case this["��\"N�\x02"]:
					case this["\x07"]:
						if(var2["\b�NHL\x12�\x02"]["\x03\x17�\x03"] == undefined)
						{
							this["\x0e"](true);
						}
						else
						{
							if(eval("\x11\x01#N�\x02")["\b\x03N�\x02"](eval("�\x05")["\x05"]["\x12�\x02"]))
							{
								this["\x04\x01\b4�\x03"]["\b\x03N�\x02"]["\b\x04N�\x02"]["\b�N�\x02"](var2["\b�NHL\x12�\x02"]["\x03\x17�\x03"]);
								return undefined;
							}
							this["\x0e"](false);
							this["n\x01�\x06"]["\x03>�\x04"] = var2["\b�NHL\x12�\x02"]["\x03\x17�\x03"];
						}
				}
		}
	};
	var1["\x05\x01�\x02"] = function §\x05\x01�\x02§(var2)
	{
		var2["\x05�#�\x02"] = this[""];
		this["\x07"](var2);
	};
	var1["\b�N�\x04"] = function §\b�N�\x04§(var2)
	{
		this(var2);
	};
	var1["\x04\x01\b\"N�\x02"] = function §\x04\x01\b"N�\x02§(var2)
	{
		var var3 = this["cD�\x04"]["\x0b"]();
		if(var3 == undefined)
		{
			return undefined;
		}
		this["cD�\x04"]["�\x02"]();
		if(var3[""] == -2)
		{
			return undefined;
		}
		if(!this["\b\x01N�\x02"](var3))
		{
			return undefined;
		}
		var var4 = false;
		var var5 = false;
		if((var var0 = var2["\b�NHL\x12�\x02"]) !== this["��\"N�\x02"])
		{
			switch(null)
			{
				case this["\x07"]:
					var var8 = 0;
					while(var8 < eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["�\x01"]["�\x02�\x04"])
					{
						if(eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["�\x01"][var8] == var3[""])
						{
							var4 = true;
						}
						var8 = var8 + 1;
					}
					break;
				case this["���\t"]:
					var var9 = 0;
					while(var9 < eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["\x04\x03\x03I\x12�\x02"]["�\x02�\x04"])
					{
						if(eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["\x04\x03\x03I\x12�\x02"][var9] == var3["\x05"])
						{
							var4 = true;
						}
						var9 = var9 + 1;
					}
					var5 = true;
			}
		}
		else
		{
			var4 = var5 = true;
			var var6 = 0;
			while(var6 < eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["�\x01"]["�\x02�\x04"])
			{
				if(eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["�\x01"][var6] == var3[""])
				{
					var4 = false;
				}
				var6 = var6 + 1;
			}
			var var7 = 0;
			while(var7 < eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["\x04\x03\x03I\x12�\x02"]["�\x02�\x04"])
			{
				if(eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["\x04\x03\x03I\x12�\x02"][var7] == var3["\x05"])
				{
					var4 = false;
				}
				var7 = var7 + 1;
			}
		}
		if(!var4)
		{
			return undefined;
		}
		if(!var5 && var3["�"] > 1)
		{
			var var10 = this["cD�\x04"]["\b\x02�\x02"]("\b\x01N�\x02","\b\x01N�\x02",{���:1,P�:var3["�"],IL�:{�:"�\x02",:var3,�:var2["\b�NHL\x12�\x02"][""]}});
			var10["\x17�\x04"]("\x05\x01�\x02",this);
		}
		else
		{
			this["�\x01\'\x12�\x02"](var2["\b�NHL\x12�\x02"][""],var3,1);
		}
	};
	var1["��#�\x01"] = function §��#�\x01§(var2)
	{
		var var3 = new eval("")[""].4P�();
		var3(var2);
		this[""] = var3;
	};
	var1["\n\x01�\x04"] = function §\n\x01�\x04§(var2)
	{
		var var3 = var2["\b�NHL\x12�\x02"]["\x03\x17�\x03"];
		var3["\x0b"](var2["\b�NHL\x12�\x02"],var2["\b�NHL\x12�\x02"]["\x03\x17�\x03"]["\x07\x17�\x02"]);
		this["�\x04"] = var3;
	};
	var1["\x04\x01\b4N\x12L\x12�\x02"] = function §\x04\x01\b4N\x12L\x12�\x02§(var2)
	{
		this["cD�\x04"]["\'�\x02"]();
		this["�\x04"] = undefined;
	};
	var1["\x07"] = function §\x07§(var2)
	{
		var var3 = var2["\b�NHL\x12�\x02"]["\x03\x17�\x03"];
		if(var3 == undefined)
		{
			return undefined;
		}
		var var4 = var3["�"];
		var var5 = var2["\x05�#�\x02"][""];
		if((var var0 = var5) !== "")
		{
			if(var0 === "")
			{
				this["�\x01\'\x12�\x02"]("",var3,var4);
			}
		}
		else if(this["\b\x01N�\x02"](var3))
		{
			var var6 = undefined;
			var var7 = 0;
			while(var7 < eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["\x04\x03\x03I\x12�\x02"]["�\x02�\x04"] && var6 == undefined)
			{
				if(eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["\x04\x03\x03I\x12�\x02"][var7] == var3["\x05"])
				{
					var6 = "���\t";
				}
				var7 = var7 + 1;
			}
			var var8 = 0;
			while(var8 < eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["�\x01"]["�\x02�\x04"] && var6 == undefined)
			{
				if(eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["�\x01"][var8] == var3[""])
				{
					var6 = "\x07";
				}
				var8 = var8 + 1;
			}
			if(var6 == undefined)
			{
				var6 = "��\"N�\x02";
			}
			this["�\x01\'\x12�\x02"](var6,var3,var4);
		}
	};
	var1[""] = function §§(var2)
	{
		this["cD�\x04"]["�\x02"]();
		if(var2["\b�NHL\x12�\x02"]["\x03\x17�\x03"] == undefined)
		{
			return undefined;
		}
		this["cD�\x04"]["�\x02"](var2["\b�NHL\x12�\x02"]["\x03\x17�\x03"]);
	};
	var1[""] = function §§(var2)
	{
		var var3 = this["cD�\x04"]["\x0b"]();
		if(var3 == undefined)
		{
			return undefined;
		}
		this["cD�\x04"]["�\x02"]();
		var var4 = var2["\b�NHL\x12�\x02"]["\x04\x07P�\x01"]["\x04\x07P�\x01"][""];
		switch(var4)
		{
			case "":
				if(var3[""] == -1)
				{
					return undefined;
				}
				break;
			case "":
				if(var3[""] == -2)
				{
					return undefined;
				}
				if(!this["\b\x01N�\x02"](var3))
				{
					return undefined;
				}
				break;
		}
		if(var3["�"] > 1)
		{
			var var5 = this["cD�\x04"]["\b\x02�\x02"]("\b\x01N�\x02","\b\x01N�\x02",{���:1,P�:var3["�"],IL�:{�:"�\x02",:var3,�:var4}});
			var5["\x17�\x04"]("\x05\x01�\x02",this);
		}
		else
		{
			this["�\x01\'\x12�\x02"](var4,var3,1);
		}
	};
	var1["\x04\x01\b�R\x17�\x02"] = function §\x04\x01\b�R\x17�\x02§(var2)
	{
		if(var2["\b�NHL\x12�\x02"]["\x03\x17�\x03"] == undefined)
		{
			this["\x0e"](true);
		}
		else
		{
			if(eval("\x11\x01#N�\x02")["\b\x03N�\x02"](eval("�\x05")["\x05"]["\x12�\x02"]))
			{
				this["\x04\x01\b4�\x03"]["\b\x03N�\x02"]["\b\x04N�\x02"]["\b�N�\x02"](var2["\b�NHL\x12�\x02"]["\x03\x17�\x03"]);
				return undefined;
			}
			this["\x0e"](false);
			this["n\x01�\x06"]["\x03>�\x04"] = var2["\b�NHL\x12�\x02"]["\x03\x17�\x03"];
		}
	};
	var1["\x05\x01�\x02"] = function §\x05\x01�\x02§(var2)
	{
		switch(var2["\x03I\x12L\x12�\x02"]["\b\x17�\x04"])
		{
			case "�\x02":
				this["�\x01\'\x12�\x02"](var2["\x03I\x12L\x12�\x02"]["\x1c�\x02"],var2["\x03I\x12L\x12�\x02"]["\x04\b\b"],var2["��\x17�\x04"]);
				break;
			case "\x07\x17�\x04":
				var var3 = Number(var2["��\x17�\x04"]);
				if(var3 < 1 || (var3 == undefined || O["\x04\x07\b"](var3)))
				{
					var3 = 1;
				}
				this["2�<N�\x02"] = var3;
		}
	};
	var1["��$N\x12L\x12�\x02"] = function §��$N\x12L\x12�\x02§(var2)
	{
		if((var var0 = var2["\b�NHL\x12�\x02"][""]) === "\n")
		{
			this["\x04\x01\b�R\x17�\x02"] = this["\n"]["\x1c�\x02"]["0\x0e\"�\r"];
			this["\x04\x01\b4�\x03"][""]["\b"][eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["v\x01�\x04"] + "" + this["\x04\x01\b4N\x12L\x12�\x02"][""]] = this["\x04\x01\b�R\x17�\x02"];
			this["\x07"]();
		}
	};
	var1["\b\x01N�\x02"]("",function()
	{
	}
	,var1[""]);
	var1["\b\x01N�\x02"]("e�iR\x17�\t",function()
	{
	}
	,var1["\x05"]);
	var1["\b\x01N�\x02"]("\b\x02N�\x02",function()
	{
	}
	,var1["�\x06"]);
	var1["\b\x01N�\x02"]("\b\x03�\x02",function()
	{
	}
	,var1["\x04"]);
	var1["\b\x01N�\x02"]("\x05\x01�\x02",var1["\x04\x01\b\"Nf�\x02"],function()
	{
	}
	);
	var1["\b\x01N�\x02"]("\x07�O�\x04",var1[""],function()
	{
	}
	);
	var1["\b\x01N�\x02"]("",function()
	{
	}
	,var1["\x0e"]);
	eval("\x04")(var1,null,1);
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}["v\x01�\x04"] = "�";
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}["\x18��\x02"] = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false];
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}["\x05"] = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false];
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}["\x12�\x02"] = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false];
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}["\b\x07f�\x02"] = 38;
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}["�\x01"] = [26,78];
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}["\x04\x03\x03I\x12�\x02"] = [7508];
	var1["\t"] = false;
	var1[""] = eval("�\x05")["\x07<�|\x10Q�\x02"]["cD�\x04"]["\x01"]["�"]["\x12�\x02"];
	var1["\x04\x01\b�R\x17�\x02"] = 0;
	var1["2�<N�\x02"] = 1;
}

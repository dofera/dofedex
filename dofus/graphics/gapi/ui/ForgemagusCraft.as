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
		var var3 = new ank.utils.();
		var var4 = new ank.utils.();
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
		switch(var2)
		{
			case "_cgGrid":
				this.api.network.Exchange.movementItem(false,var3.ID,var4);
				break;
			case "_cgLocal":
				this.api.network.Exchange.movementItem(true,var3.ID,var4);
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
								this.api.network.Exchange.movementItem(false,this._eaLocalDataProvider[var7].ID,this._eaLocalDataProvider[var7].Quantity);
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
									this.api.network.Exchange.movementItem(false,this._eaLocalDataProvider[var11].ID,this._eaLocalDataProvider[var11].Quantity);
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
									this.api.network.Exchange.movementItem(false,this._eaLocalDataProvider[var13].ID,this._eaLocalDataProvider[var13].Quantity);
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
					this.api.network.Exchange.movementItem(true,var3.ID,!var5?var4:1);
					break;
				}
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
			this.api.network.Exchange.movementItem(false,var3.ID,var3.Quantity);
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
					this.api.network.Exchange.movementItem(true,var4.item.ID,var3.quantity);
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
		this._lblKama.text = new ank.utils.(var2.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
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
		this[§§constant(37)][§§constant(3)][§§constant(42)]();
	};
	var1[§§constant(198)] = function §\§\§constant(198)§()
	{
		this[§§constant(118)] = false;
		this[§§constant(199)] = 1;
		this[§§constant(77)][§§constant(108)] = this[§§constant(37)][§§constant(20)][§§constant(90)](§§constant(110));
		this[§§constant(76)][§§constant(200)] = true;
	};
	var1["���\x03"] = function §���\x03§()
	{
		var var2 = this[§§constant(70)][§§constant(141)][§§constant(152)] - 1;
		if(var2 <= 1)
		{
			return undefined;
		}
		this[§§constant(118)] = true;
		this[§§constant(37)][§§constant(44)][§§constant(45)][§§constant(201)](var2);
		this[§§constant(77)][§§constant(108)] = this[§§constant(37)][§§constant(20)][§§constant(90)](§§constant(202));
		this[§§constant(76)][§§constant(200)] = false;
	};
	var1[§§constant(203)] = function §\§\§constant(203)§()
	{
		if(this[§§constant(65)][§§constant(141)] == undefined || this[§§constant(70)][§§constant(141)] == undefined)
		{
			this[§§constant(37)][§§constant(159)][§§constant(160)](this[§§constant(37)][§§constant(20)][§§constant(90)](§§constant(205)),this[§§constant(37)][§§constant(20)][§§constant(90)](§§constant(204)),§§constant(180));
			return true;
		}
		return false;
	};
	var1[§§constant(68)] = function §\§\§constant(68)§(var2)
	{
		loop0:
		switch(var2["�\x02"])
		{
			case this["\x03>�\x04"]:
				this();
				break;
			case this["\x04\x03\b��\x02"]:
				if(this["\n"]())
				{
					return undefined;
				}
				this["\b"]();
				this["9�+NHL\x12�\x02"]();
				break;
			default:
				switch(null)
				{
					case this["\x05\x01�\x02"]:
						if(this["�\x01�\x01"])
						{
							this["\x05"][""]["BO�\t"]["\x06\x17�\x0f"]();
							return undefined;
						}
						if(this["\n"]())
						{
							return undefined;
						}
						this["\b"]();
						this["9�+NHL\x12�\x02"]();
						this({O�:this,:this["���\x03"]});
						break loop0;
					case this["\x01"]:
					case this["\b�N�\x01"]:
					case this["\x04\x02\b�N�\x02"]:
						if(var2["�\x02"]["�"] == undefined)
						{
							this(true);
						}
						else
						{
							if(eval("")["\x04\x01\b�4�\x02"](eval("�\x02")["\x04\x04\x04\x03\x04\x06\x07\x03"][""]))
							{
								this["\x05"]["ON�\x02"]["\x01"]["OR\x17�\x02"](var2["�\x02"]["�"]);
								return undefined;
							}
							this(false);
							this["\b�N�\x02"]["\x04\bN�\x04"] = var2["�\x02"]["�"];
						}
						break loop0;
					default:
						if(var2["�\x02"] != this[""])
						{
							this[""]["\x19"] = false;
							this[""] = var2["�\x02"];
							switch(var2["�\x02"]["\x06\x17�\x02"])
							{
								case "\x03\x17�\x03":
									this[""] = eval("�\x02")["\x05\x01L\x11�\x02"]["�A�\t"]["\x03"]["h\x11"]["�\x0f"];
									this["\x04\x07P�\x01"]["\x07\x17�\x04"] = this["\x05"]["\x05"]["\x1c�\x02"]("\x04\x07\b");
									break;
								case "\x04\x03\x03I\x12�\x02":
									this[""] = eval("�\x02")["\x05\x01L\x11�\x02"]["�A�\t"]["\x03"]["h\x11"]["\x04\x04\x04\x03\b<\x07\x03"];
									this["\x04\x07P�\x01"]["\x07\x17�\x04"] = this["\x05"]["\x05"]["\x1c�\x02"]("g�#NI\x12�\x02");
									break;
								case "\x07\x1a":
									this[""] = eval("�\x02")["\x05\x01L\x11�\x02"]["�A�\t"]["\x03"]["h\x11"][""];
									this["\x04\x07P�\x01"]["\x07\x17�\x04"] = this["\x05"]["\x05"]["\x1c�\x02"]("\n");
							}
							this["\x04\x01\b�R\x12�\x02"](true);
							break loop0;
						}
						var2["�\x02"]["\x19"] = true;
						break loop0;
				}
		}
	};
	var1[""] = function §§(var2)
	{
		var2[§§constant(217)] = this[§§constant(7)];
		this[§§constant(59)](var2);
	};
	var1["\t)"] = function §\t)§(var2)
	{
		this[§§constant(62)](var2);
	};
	var1["\x02\x1e\x1b\x01"] = function §\x02\x1e\x1b\x01§(var2)
	{
		var var3 = this.v[§§constant(218)]();
		if(var3 == undefined)
		{
			return undefined;
		}
		this.v[§§constant(219)]();
		if(var3[§§constant(126)] == -2)
		{
			return undefined;
		}
		if(!this[§§constant(169)](var3))
		{
			return undefined;
		}
		var var4 = false;
		var var5 = false;
		switch(var2[§§constant(194)])
		{
			case this[§§constant(65)]:
				var4 = var5 = true;
				var var6 = 0;
				while(var6 < eval("h\x11")["\f"].v[§§constant(3)][§§constant(4)][§§constant(144)][§§constant(138)])
				{
					if(eval("h\x11")["\f"].v[§§constant(3)][§§constant(4)][§§constant(144)][var6] == var3[§§constant(129)])
					{
						var4 = false;
					}
					var6 = var6 + 1;
				}
				var var7 = 0;
				while(var7 < eval("h\x11")["\f"].v[§§constant(3)][§§constant(4)][§§constant(142)][§§constant(138)])
				{
					if(eval("h\x11")["\f"].v[§§constant(3)][§§constant(4)][§§constant(142)][var7] == var3[§§constant(143)])
					{
						var4 = false;
					}
					var7 = var7 + 1;
				}
				break;
			case this[§§constant(70)]:
				var var8 = 0;
				while(var8 < eval("h\x11")["\f"].v[§§constant(3)][§§constant(4)][§§constant(144)][§§constant(138)])
				{
					if(eval("h\x11")["\f"].v[§§constant(3)][§§constant(4)][§§constant(144)][var8] == var3[§§constant(129)])
					{
						var4 = true;
					}
					var8 = var8 + 1;
				}
				break;
			case this[§§constant(69)]:
				var var9 = 0;
				while(var9 < eval("h\x11")["\f"].v[§§constant(3)][§§constant(4)][§§constant(142)][§§constant(138)])
				{
					if(eval("h\x11")["\f"].v[§§constant(3)][§§constant(4)][§§constant(142)][var9] == var3[§§constant(143)])
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
		if(!var5 && var3[§§constant(152)] > 1)
		{
			var var10 = this.v[§§constant(225)](§§constant(224),§§constant(224),{§§constant(83):1,§§constant(220):var3[§§constant(152)],§§constant(82):{§§constant(221):§§constant(178),§§constant(222):var3,§§constant(223):var2[§§constant(194)][§§constant(120)]}});
			var10[§§constant(27)](§§constant(226),this);
		}
		else
		{
			this[§§constant(151)](var2[§§constant(194)][§§constant(120)],var3,1);
		}
	};
	var1[§§constant(227)] = function §\§\§constant(227)§(var2)
	{
		var var3 = new eval("Z�\'�\x02")["\bE�\x01"].�();
		var3["�\x01"](var2);
		this[""] = var3;
	};
	var1.dblClickItem = function dblClickItem(var2)
	{
		var var3 = var2["�\x02"]["�"];
		if(var3 == undefined)
		{
			return undefined;
		}
		var var4 = var3["\b\x04N�\x02"];
		var var5 = var2[""]["\x06\x17�\x02"];
		switch(var5)
		{
			case "":
				if(this["\x17�\x03"](var3))
				{
					var var6 = undefined;
					var var7 = 0;
					while(var7 < eval("�\x02")["\x05\x01L\x11�\x02"]["�A�\t"]["\x03"]["h\x11"]["<N�\x02"][""] && var6 == undefined)
					{
						if(eval("�\x02")["\x05\x01L\x11�\x02"]["�A�\t"]["\x03"]["h\x11"]["<N�\x02"][var7] == var3["\b\x03N�\x02"])
						{
							var6 = "\x04\x02\b�N�\x02";
						}
						var7 = var7 + 1;
					}
					var var8 = 0;
					while(var8 < eval("�\x02")["\x05\x01L\x11�\x02"]["�A�\t"]["\x03"]["h\x11"]["\b\x04N�\x02"][""] && var6 == undefined)
					{
						if(eval("�\x02")["\x05\x01L\x11�\x02"]["�A�\t"]["\x03"]["h\x11"]["\b\x04N�\x02"][var8] == var3[""])
						{
							var6 = "\b�N�\x01";
						}
						var8 = var8 + 1;
					}
					if(var6 == undefined)
					{
						var6 = "\x01";
					}
					this["\b\x03N�\x02"](var6,var3,var4);
				}
				break;
			case "O�\'":
				this["\b\x03N�\x02"]("",var3,var4);
		}
	};
	var1[§§constant(62)] = function §\§\§constant(62)§(var2)
	{
		this.v[§§constant(219)]();
		if(var2[§§constant(194)][§§constant(141)] == undefined)
		{
			return undefined;
		}
		this.v[§§constant(228)](var2[§§constant(194)][§§constant(141)]);
	};
	var1["B�\x02"] = function §B�\x02§(var2)
	{
		var var3 = this.v[§§constant(218)]();
		if(var3 == undefined)
		{
			return undefined;
		}
		this.v[§§constant(219)]();
		var var4 = var2[§§constant(194)][§§constant(229)][§§constant(229)][§§constant(120)];
		switch(var4)
		{
			case §§constant(60):
				if(var3[§§constant(126)] == -1)
				{
					return undefined;
				}
				break;
			case §§constant(7):
				if(var3[§§constant(126)] == -2)
				{
					return undefined;
				}
				if(!this[§§constant(169)](var3))
				{
					return undefined;
				}
				break;
		}
		if(var3[§§constant(152)] > 1)
		{
			var var5 = this.v[§§constant(225)](§§constant(224),§§constant(224),{§§constant(83):1,§§constant(220):var3[§§constant(152)],§§constant(82):{§§constant(221):§§constant(178),§§constant(222):var3,§§constant(223):var4}});
			var5[§§constant(27)](§§constant(226),this);
		}
		else
		{
			this[§§constant(151)](var4,var3,1);
		}
	};
	var1["h\x16,�\r"] = function §h\x16,�\r§(var2)
	{
		if(var2[§§constant(194)][§§constant(141)] == undefined)
		{
			this[§§constant(57)](true);
		}
		else
		{
			if(eval(§§constant(209))[§§constant(210)](eval("h\x11")[§§constant(207)][§§constant(208)]))
			{
				this[§§constant(37)][§§constant(159)][§§constant(211)][§§constant(212)](var2[§§constant(194)][§§constant(141)]);
				return undefined;
			}
			this[§§constant(57)](false);
			this[§§constant(145)][§§constant(146)] = var2[§§constant(194)][§§constant(141)];
		}
	};
	var1[§§constant(226)] = function §\§\§constant(226)§(var2)
	{
		switch(var2[""]["�\x02"])
		{
			case "\b\x01N�\x02":
				this["\b\x03N�\x02"](var2[""]["\x12�\x02"],var2[""]["\x05"],var2["�\x01"]);
				break;
			case "�\x02":
				var var3 = Number(var2["�\x01"]);
				if(var3 < 1 || (var3 == undefined || eval("\f")["\x05\x01�\x02"](var3)))
				{
					var3 = 1;
				}
				this["\bF�\x01"] = var3;
		}
	};
	var1[§§constant(85)] = function §\§\§constant(85)§(var2)
	{
		if((var var0 = var2["�\x02"]["\x06\x17�\x02"]) === "�\x02")
		{
			this["\x05\x01�\x02"] = this["�\x02"]["�\x11\'O�\x04"]["�\x02"];
			this["\x05"]["\x05"]["\x05"][eval("�\x02")["\x05\x01L\x11�\x02"]["�A�\t"]["\x03"]["h\x11"]["\x05"] + "\x03�\x01" + this[""]["\x06\x17�\x02"]] = this["\x05\x01�\x02"];
			this["\x04\x01\b�R\x12�\x02"]();
		}
	};
	var1["\x04\x01\b+4P�\x02"]("�\x01�\x0b",function()
	{
	}
	,var1[§§constant(29)]);
	var1["\x04\x01\b+4P�\x02"]("\b\x07f�\x02",function()
	{
	}
	,var1["\x07\x0f"]);
	var1["\x04\x01\b+4P�\x02"]("",function()
	{
	}
	,var1["\x05"]);
	var1["\x04\x01\b+4P�\x02"]("�\"#�\f",function()
	{
	}
	,var1["\x05"]);
	var1.addProperty("maxItem",function()
	{
	}
	,var1["\x05"]);
	ASSetPropFlags(var1,null,1);
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}.CLASS_NAME = "ForgemagusCraft";
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}.FILTER_EQUIPEMENT = [false,true,true,true,true,true,false,true,true,false,true,true,true,true,false];
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}[§§constant(215)] = [false,false,false,false,false,false,true,false,false,false,false,false,false,false,false];
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}[""] = [false,false,false,false,false,false,false,false,false,true,false,false,false,false,false];
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}["\x03)"] = 38;
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}["\b\x04N�\x02"] = [26,78];
	dofus.graphics.gapi.ui.ForgemagusCraft = function()
	{
		super();
		this._cgLocal._visible = false;
		this._cgDistant._visible = false;
	}["<N�\x02"] = [7508];
	var1["<N�\x02"] = false;
	var1[""] = eval("�\x02")["\x05\x01L\x11�\x02"]["�A�\t"]["\x03"]["h\x11"][""];
	var1["\x05\x01�\x02"] = 0;
	var1["\bF�\x01"] = 1;
}

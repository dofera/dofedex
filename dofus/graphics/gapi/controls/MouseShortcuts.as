if(!dofus.graphics.gapi.controls.MouseShortcuts)
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
	if(!dofus.graphics.gapi.controls)
	{
		_global.dofus.graphics.gapi.controls = new Object();
	}
	dofus.graphics.gapi.controls.MouseShortcuts = function()
	{
		super();
	} extends dofus.graphics.gapi.core.DofusAdvancedComponent;
	var var1 = dofus.graphics.gapi.controls.MouseShortcuts = function()
	{
		super();
	}.prototype;
	var1.__get__currentTab = function __get__currentTab()
	{
		return this._sCurrentTab;
	};
	var1.__set__meleeVisible = function __set__meleeVisible(var2)
	{
		this._ctrCC._visible = var2;
		return this.__get__meleeVisible();
	};
	var1.init = function init()
	{
		super.init(false,dofus.graphics.gapi.controls.MouseShortcuts.CLASS_NAME);
	};
	var1.createChildren = function createChildren()
	{
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
	};
	var1.getContainer = function getContainer(var2)
	{
		return this["_ctr" + var2];
	};
	var1.setContainer = function setContainer(var2, var3)
	{
		this["_ctr" + var2] = var3;
	};
	var1.initData = function initData()
	{
		this._ctrCC.contentPath = dofus.Constants.SPELLS_ICONS_PATH + "0.swf";
	};
	var1.initTexts = function initTexts()
	{
		this._btnTabSpells.label = this.api.lang.getText("BANNER_TAB_SPELLS");
		this._btnTabItems.label = this.api.lang.getText("BANNER_TAB_ITEMS");
	};
	var1.addListeners = function addListeners()
	{
		this._btnTabSpells.addEventListener("click",this);
		this._btnTabItems.addEventListener("click",this);
		this._btnTabSpells.addEventListener("over",this);
		this._btnTabItems.addEventListener("over",this);
		this._btnTabSpells.addEventListener("out",this);
		this._btnTabItems.addEventListener("out",this);
		var var2 = 1;
		while(var2 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
		{
			var var3 = this["_ctr" + var2];
			var3.addEventListener("click",this);
			var3.addEventListener("dblClick",this);
			var3.addEventListener("over",this);
			var3.addEventListener("out",this);
			var3.addEventListener("drag",this);
			var3.addEventListener("drop",this);
			var3.params = {position:var2};
			var2 = var2 + 1;
		}
		this._ctrCC.addEventListener("click",this);
		this._ctrCC.addEventListener("over",this);
		this._ctrCC.addEventListener("out",this);
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
		this.api.datacenter.Player.Spells.addEventListener("modelChanged",this);
		this.api.datacenter.Player.Inventory.addEventListener("modelChanged",this);
	};
	var1.clearSpellStateOnAllContainers = function clearSpellStateOnAllContainers()
	{
		var var2 = this.api.datacenter.Player.Spells;
		for(var k in var2)
		{
			if(!_global.isNaN(var2[k].position))
			{
				var var3 = this["_ctr" + var2[k].position];
				var3.showLabel = false;
				this.setMovieClipTransform(var3.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
			}
		}
		this.setMovieClipTransform(this._ctrCC.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
	};
	var1.setSpellStateOnAllContainers = function setSpellStateOnAllContainers()
	{
		if(this._sCurrentTab != "Spells")
		{
			return undefined;
		}
		var var2 = this.api.datacenter.Player.Spells;
		for(var k in var2)
		{
			if(!_global.isNaN(var2[k].position))
			{
				this.setSpellStateOnContainer(var2[k].position);
			}
		}
		this.setSpellStateOnContainer(0);
	};
	var1.setItemStateOnAllContainers = function setItemStateOnAllContainers()
	{
		if(this._sCurrentTab != "Items")
		{
			return undefined;
		}
		var var2 = this.api.datacenter.Player.Inventory;
		for(var k in var2)
		{
			var var3 = var2[k].position - dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
			if(!(_global.isNaN(var3) && var3 < 1))
			{
				this.setItemStateOnContainer(var3);
			}
		}
		this.setSpellStateOnContainer(0);
	};
	var1.updateSpells = function updateSpells()
	{
		var var2 = new Array();
		var var3 = 1;
		while(var3 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
		{
			var2[var3] = true;
			var3 = var3 + 1;
		}
		var var4 = this.api.datacenter.Player.Spells;
		for(var var5 in var4)
		{
			var var6 = var5.position;
			if(!_global.isNaN(var6))
			{
				this["_ctr" + var6].contentData = var5;
				var2[var6] = false;
			}
		}
		var var7 = 1;
		while(var7 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
		{
			if(var2[var7])
			{
				this["_ctr" + var7].contentData = undefined;
			}
			var7 = var7 + 1;
		}
		this.addToQueue({object:this,method:this.setSpellStateOnAllContainers});
	};
	var1.updateItems = function updateItems()
	{
		var var2 = new Array();
		var var3 = 1;
		while(var3 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
		{
			var2[var3] = true;
			var3 = var3 + 1;
		}
		var var4 = this.api.datacenter.Player.Inventory;
		for(var k in var4)
		{
			var var5 = var4[k];
			if(!_global.isNaN(var5.position))
			{
				if(var5.position < dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET + 1)
				{
					continue;
				}
				var var6 = var5.position - dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
				var var7 = this["_ctr" + var6];
				var7.contentData = var5;
				if(var5.Quantity > 1)
				{
					var7.label = String(var5.Quantity);
				}
				var2[var6] = false;
			}
		}
		var var8 = 1;
		while(var8 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
		{
			if(var2[var8])
			{
				this["_ctr" + var8].contentData = undefined;
			}
			var8 = var8 + 1;
		}
		this.addToQueue({object:this,method:this.setItemStateOnAllContainers});
	};
	var1.setSpellStateOnContainer = function setSpellStateOnContainer(var2)
	{
		var var3 = var2 != 0?this["_ctr" + var2]:this._ctrCC;
		var var4 = var2 != 0?var3.contentData:this.api.datacenter.Player.Spells[0];
		if(var4 == undefined)
		{
			return undefined;
		}
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			var5.can = true;
		}
		else
		{
			var var5 = this.api.datacenter.Player.SpellsManager.checkCanLaunchSpellReturnObject(var4.ID);
		}
		if(var5.can == false)
		{
			loop0:
			switch(var5.type)
			{
				case "NOT_IN_REQUIRED_STATE":
				case "IN_FORBIDDEN_STATE":
					this.setMovieClipTransform(var3.content,dofus.graphics.gapi.controls.MouseShortcuts.WRONG_STATE_TRANSFORM);
					if(var5.params[1])
					{
						var3.showLabel = true;
						var3.label = var5.params[1];
					}
					else
					{
						var3.showLabel = false;
					}
					break;
				default:
					switch(null)
					{
						case "NOT_ENOUGH_AP":
						case "CANT_SUMMON_MORE_CREATURE":
						case "CANT_LAUNCH_MORE":
						case "CANT_RELAUNCH":
						case "NOT_IN_FIGHT":
							var3.showLabel = false;
							this.setMovieClipTransform(var3.content,dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
							break loop0;
						default:
							if(var0 !== "CANT_LAUNCH_BEFORE")
							{
								break loop0;
							}
							this.setMovieClipTransform(var3.content,dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
							var3.showLabel = true;
							var3.label = var5.params[0];
							break loop0;
					}
			}
		}
		else
		{
			var3.showLabel = false;
			this.setMovieClipTransform(var3.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
		}
	};
	var1.setItemStateOnContainer = function setItemStateOnContainer(var2)
	{
		var var3 = this["_ctr" + var2];
		var var4 = var3.contentData;
		if(var4 == undefined)
		{
			return undefined;
		}
		var3.showLabel = var4.Quantity > 1;
		if(this.api.datacenter.Game.isRunning)
		{
			this.setMovieClipTransform(var3.content,dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
		}
		else
		{
			this.setMovieClipTransform(var3.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
		}
	};
	var1.updateCurrentTabInformations = function updateCurrentTabInformations()
	{
		switch(this._sCurrentTab)
		{
			case "Spells":
				this.updateSpells();
				this._ctrCC._visible = !this.api.datacenter.Player.isMutant;
				break;
			case "Items":
				this.updateItems();
				this._ctrCC._visible = false;
		}
	};
	var1.setCurrentTab = function setCurrentTab(var2)
	{
		if(var2 != this._sCurrentTab)
		{
			var var3 = this["_btnTab" + this._sCurrentTab];
			var var4 = this["_btnTab" + var2];
			var3.selected = true;
			var3.enabled = true;
			var4.selected = false;
			var4.enabled = false;
			this._sCurrentTab = var2;
			this.updateCurrentTabInformations();
		}
	};
	var1.onShortcut = function onShortcut(var2)
	{
		var var3 = true;
		loop0:
		switch(var2)
		{
			case "SWAP":
				this.setCurrentTab(this._sCurrentTab != "Spells"?"Spells":"Items");
				var3 = false;
				break;
			case "SH0":
				this.click({target:this._ctrCC});
				var3 = false;
				break;
			default:
				switch(null)
				{
					case "SH1":
						this.click({target:this._ctr1,keyBoard:true});
						var3 = false;
						break loop0;
					case "SH2":
						this.click({target:this._ctr2,keyBoard:true});
						var3 = false;
						break loop0;
					case "SH3":
						this.click({target:this._ctr3,keyBoard:true});
						var3 = false;
						break loop0;
					case "SH4":
						this.click({target:this._ctr4,keyBoard:true});
						var3 = false;
						break loop0;
					case "SH5":
						this.click({target:this._ctr5,keyBoard:true});
						var3 = false;
						break loop0;
					default:
						switch(null)
						{
							case "SH6":
								this.click({target:this._ctr6,keyBoard:true});
								var3 = false;
								break loop0;
							case "SH7":
								this.click({target:this._ctr7,keyBoard:true});
								var3 = false;
								break loop0;
							case "SH8":
								this.click({target:this._ctr8,keyBoard:true});
								var3 = false;
								break loop0;
							case "SH9":
								this.click({target:this._ctr9,keyBoard:true});
								var3 = false;
								break loop0;
							case "SH10":
								this.click({target:this._ctr10,keyBoard:true});
								var3 = false;
								break loop0;
							default:
								switch(null)
								{
									case "SH11":
										this.click({target:this._ctr11,keyBoard:true});
										var3 = false;
										break;
									case "SH12":
										this.click({target:this._ctr12,keyBoard:true});
										var3 = false;
										break;
									case "SH13":
										this.click({target:this._ctr13,keyBoard:true});
										var3 = false;
										break;
									case "SH14":
										this.click({target:this._ctr14,keyBoard:true});
										var3 = false;
								}
						}
				}
		}
		return var3;
	};
	var1.click = function click(var2)
	{
		loop0:
		switch(var2.target._name)
		{
			case "_btnTabSpells":
				this.api.sounds.events.onBannerSpellItemButtonClick();
				this.setCurrentTab("Spells");
				break;
			case "_btnTabItems":
				this.api.sounds.events.onBannerSpellItemButtonClick();
				this.setCurrentTab("Items");
				break;
			default:
				if(var0 !== "_ctrCC")
				{
					switch(this._sCurrentTab)
					{
						case "Spells":
							this.api.sounds.events.onBannerSpellSelect();
							if(this.api.kernel.TutorialManager.isTutorialMode)
							{
								this.api.kernel.TutorialManager.onWaitingCase({code:"SPELL_CONTAINER_SELECT",params:[Number(var2.target._name.substr(4))]});
								break loop0;
							}
							if(this.gapi.getUIComponent("Spells") != undefined)
							{
								return undefined;
							}
							var var3 = var2.target.contentData;
							if(var3 == undefined)
							{
								§§push(undefined);
							}
							else
							{
								this.api.kernel.GameManager.switchToSpellLaunch(var3,true);
								break loop0;
							}
						default:
							return §§pop();
						case "Items":
							if(this.api.kernel.TutorialManager.isTutorialMode)
							{
								this.api.kernel.TutorialManager.onWaitingCase({code:"OBJECT_CONTAINER_SELECT",params:[Number(var2.target._name.substr(4))]});
								break loop0;
							}
							if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && var2.target.contentData != undefined)
							{
								this.api.kernel.GameManager.insertItemInChat(var2.target.contentData);
								return undefined;
							}
							var var4 = this.gapi.getUIComponent("Inventory");
							if(var4 != undefined)
							{
								var4.showItemInfos(var2.target.contentData);
								break loop0;
							}
							var var5 = var2.target.contentData;
							if(var5 == undefined)
							{
								return undefined;
							}
							if(this.api.datacenter.Player.canUseObject)
							{
								if(var5.canTarget)
								{
									this.api.kernel.GameManager.switchToItemTarget(var5);
									break loop0;
								}
								if(var5.canUse && var2.keyBoard)
								{
									this.api.network.Items.use(var5.ID);
									break loop0;
								}
								break loop0;
							}
							break loop0;
					}
				}
				else
				{
					if(this._ctrCC._visible)
					{
						if(this.api.kernel.TutorialManager.isTutorialMode)
						{
							this.api.kernel.TutorialManager.onWaitingCase({code:"CC_CONTAINER_SELECT"});
							break;
						}
						this.api.kernel.GameManager.switchToSpellLaunch(this.api.datacenter.Player.Spells[0],false);
					}
					break;
				}
		}
	};
	var1.dblClick = function dblClick(var2)
	{
		switch(this._sCurrentTab)
		{
			case "Spells":
				if((var0 = var2.target._name) !== "_ctrCC")
				{
					var var3 = var2.target.contentData;
				}
				else
				{
					var3 = this.api.datacenter.Player.Spells[0];
				}
				if(var3 == undefined)
				{
					return undefined;
				}
				this.gapi.loadUIAutoHideComponent("SpellInfos","SpellInfos",{spell:var3},{bStayIfPresent:true});
				break;
			case "Items":
				var var4 = var2.target.contentData;
				if(var4 != undefined)
				{
					if(!var4.canUse || !this.api.datacenter.Player.canUseObject)
					{
						return undefined;
					}
					this.api.network.Items.use(var4.ID);
					break;
				}
		}
	};
	var1.over = function over(var2)
	{
		if(!this.gapi.isCursorHidden())
		{
			return undefined;
		}
		if((var var0 = var2.target._name) !== "_ctrCC")
		{
			switch(this._sCurrentTab)
			{
				case "Spells":
					var var5 = var2.target.contentData;
					if(var5 != undefined)
					{
						this.gapi.showTooltip(var5.name + " (" + var5.apCost + " " + this.api.lang.getText("AP") + (var5.actualCriticalHit <= 0?"":", " + this.api.lang.getText("ACTUAL_CRITICAL_CHANCE") + ": 1/" + var5.actualCriticalHit) + ")",var2.target,-20,{bXLimit:true,bYLimit:false});
					}
					break;
				case "Items":
					var var6 = var2.target.contentData;
					if(var6 != undefined)
					{
						var var7 = var6.name;
						if(this.gapi.getUIComponent("Inventory") == undefined)
						{
							if(var6.canUse && var6.canTarget)
							{
								var7 = var7 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK_CLICK"));
							}
							else
							{
								if(var6.canUse)
								{
									var7 = var7 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK"));
								}
								if(var6.canTarget)
								{
									var7 = var7 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_CLICK"));
								}
							}
						}
						this.gapi.showTooltip(var7,var2.target,-30,{bXLimit:true,bYLimit:false});
						break;
					}
			}
		}
		else
		{
			var var3 = this.api.datacenter.Player.Spells[0];
			var var4 = this.api.kernel.GameManager.getCriticalHitChance(this.api.datacenter.Player.weaponItem.criticalHit);
			this.gapi.showTooltip(var3.name + "\n" + var3.descriptionVisibleEffects + " (" + var3.apCost + " " + this.api.lang.getText("AP") + (!!_global.isNaN(var4)?"":", " + this.api.lang.getText("ACTUAL_CRITICAL_CHANCE") + ": 1/" + var4) + ")",var2.target,-30,{bXLimit:true,bYLimit:false});
		}
	};
	var1.out = function out(var2)
	{
		this.gapi.hideTooltip();
	};
	var1.drag = function drag(var2)
	{
		var var3 = var2["\x04"]["\x12\x02\'�\x04"];
		if(var3 == undefined)
		{
			return undefined;
		}
		switch(this[""])
		{
			case "":
				if(this["\x12�\x02"]["\b\x04N�\x02"]("") == undefined && !eval("\x07\x02")(eval("\x07\x02")["\x12�\x02"]))
				{
					return undefined;
				}
				break;
			case "":
				if(this["\x12�\x02"]["\b\x04N�\x02"]("I�\x02") == undefined && !eval("\x07\x02")(eval("\x07\x02")["\x12�\x02"]))
				{
					return undefined;
				}
				break;
		}
		this["\x12�\x02"]["��ON�\x05"]();
		this["\x12�\x02"]["\x07"](var3);
	};
	var1[§§constant(47)] = function §\§\§constant(47)§(var2)
	{
		switch(this._sCurrentTab)
		{
			case "Spells":
				§§push(var var0 = var2.target);
				if(this.gapi.getUIComponent("Spells") == undefined && !Key.isDown(Key.SHIFT))
				{
					return undefined;
				}
				var var3 = this.gapi.getCursor();
				if(var3 == undefined)
				{
					return undefined;
				}
				this.gapi.removeCursor();
				var var4 = var3.position;
				var var5 = var2.target.params.position;
				if(var4 == var5)
				{
					return undefined;
				}
				if(var4 != undefined)
				{
					this["_ctr" + var4].contentData = undefined;
				}
				var var6 = this["_ctr" + var5].contentData;
				if(var6 != undefined)
				{
					var6.position = undefined;
				}
				var3.position = var5;
				var2.target.contentData = var3;
				this.api.network.Spells.moveToUsed(var3.ID,var5);
				this.addToQueue({object:this,method:this.setSpellStateOnAllContainers});
				break;
			case "Items":
				if(this.gapi.getUIComponent("Inventory") == undefined && !Key.isDown(Key.SHIFT))
				{
					return undefined;
				}
				var var7 = this.gapi.getCursor();
				if(var7 == undefined)
				{
					return undefined;
				}
				if(!var7.canMoveToShortut)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_MOVE_ITEM_HERE"),"ERROR_BOX");
					return undefined;
				}
				this.gapi.removeCursor();
				var var8 = var2.target.params.position + dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
				if(var7.position == var8)
				{
					return undefined;
				}
				if(var7.Quantity > 1)
				{
					var var9 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:var7.Quantity,max:var7.Quantity,useAllStage:true,params:{type:"drop",item:var7,position:var8}},{bAlwaysOnTop:true});
					var9.addEventListener("validate",this);
					break;
				}
				this.api.network.Items.movement(var7.ID,var8,1);
				break;
		}
		§§pop();
	};
	var1.modelChanged = function modelChanged(var2)
	{
		switch(var2.eventName)
		{
			case "updateOne":
			case "updateAll":
		}
		if(var2.target == this.api.datacenter.Player.Spells)
		{
			if(this._sCurrentTab == "Spells")
			{
				this.updateSpells();
			}
		}
		else if(this._sCurrentTab == "Items")
		{
			this.updateItems();
		}
	};
	var1.validate = function validate(var2)
	{
		if((var var0 = var2.params.type) === "drop")
		{
			this.gapi.removeCursor();
			if(var2.value > 0 && !_global.isNaN(Number(var2.value)))
			{
				this.api.network.Items.movement(var2.params.item.ID,var2.params.position,Math.min(var2.value,var2.params.item.Quantity));
			}
		}
	};
	var1[§§constant(211)](§§constant(210),function()
	{
	}
	,var1.__set__meleeVisible);
	var1("",var1[§§constant(10)],function()
	{
	}
	);
	eval("\x04\x01\bAR\x17�\x06")(var1,null,1);
	dofus.graphics.gapi.controls.MouseShortcuts = function()
	{
		super();
	}["\x04\x03\b>\x05\x01O�\b"] = "";
	dofus.graphics.gapi.controls.MouseShortcuts = function()
	{
		super();
	}["\x04\x03\b!\x04\x05\b0N�\x05"] = "";
	dofus.graphics.gapi.controls.MouseShortcuts = function()
	{
		super();
	}[§§constant(17)] = §§constant(4);
	dofus.graphics.gapi.controls.MouseShortcuts = function()
	{
		super();
	}[§§constant(44)] = 24;
	dofus.graphics.gapi.controls.MouseShortcuts = function()
	{
		super();
	}[§§constant(70)] = 34;
	dofus.graphics.gapi.controls.MouseShortcuts = function()
	{
		super();
	}[§§constant(63)] = {§§constant(216):100,§§constant(217):0,§§constant(218):100,§§constant(219):0,§§constant(220):100,§§constant(221):0};
	dofus.graphics.gapi.controls.MouseShortcuts = function()
	{
		super();
	}[""] = {:50,:0,:50,:0,NO�:50,:0};
	dofus.graphics.gapi.controls.MouseShortcuts = function()
	{
		super();
	}["\x04\x05\bSN�\x01"] = {:50,:0,:50,:0,NO�:70,:0};
	var1[""] = "";
}

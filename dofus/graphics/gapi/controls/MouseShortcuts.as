class dofus.graphics.gapi.controls.MouseShortcuts extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var TAB_SPELLS = "Spells";
	static var TAB_ITEMS = "Items";
	static var CLASS_NAME = "MouseShortcuts";
	static var MAX_CONTAINER = 24;
	static var ITEM_OFFSET = 34;
	static var NO_TRANSFORM = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
	static var INACTIVE_TRANSFORM = {ra:50,rb:0,ga:50,gb:0,ba:50,bb:0};
	static var WRONG_STATE_TRANSFORM = {ra:50,rb:0,ga:50,gb:0,ba:70,bb:0};
	var _sCurrentTab = "Items";
	function MouseShortcuts()
	{
		super();
	}
	function __get__currentTab()
	{
		return this._sCurrentTab;
	}
	function __set__meleeVisible(loc2)
	{
		this._ctrCC._visible = loc2;
		return this.__get__meleeVisible();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.MouseShortcuts.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
	}
	function getContainer(loc2)
	{
		return this["_ctr" + loc2];
	}
	function setContainer(loc2, loc3)
	{
		this["_ctr" + loc2] = loc3;
	}
	function initData()
	{
		this._ctrCC.contentPath = dofus.Constants.SPELLS_ICONS_PATH + "0.swf";
	}
	function initTexts()
	{
		this._btnTabSpells.label = this.api.lang.getText("BANNER_TAB_SPELLS");
		this._btnTabItems.label = this.api.lang.getText("BANNER_TAB_ITEMS");
	}
	function addListeners()
	{
		this._btnTabSpells.addEventListener("click",this);
		this._btnTabItems.addEventListener("click",this);
		this._btnTabSpells.addEventListener("over",this);
		this._btnTabItems.addEventListener("over",this);
		this._btnTabSpells.addEventListener("out",this);
		this._btnTabItems.addEventListener("out",this);
		var loc2 = 1;
		while(loc2 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
		{
			var loc3 = this["_ctr" + loc2];
			loc3.addEventListener("click",this);
			loc3.addEventListener("dblClick",this);
			loc3.addEventListener("over",this);
			loc3.addEventListener("out",this);
			loc3.addEventListener("drag",this);
			loc3.addEventListener("drop",this);
			loc3.params = {position:loc2};
			loc2 = loc2 + 1;
		}
		this._ctrCC.addEventListener("click",this);
		this._ctrCC.addEventListener("over",this);
		this._ctrCC.addEventListener("out",this);
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
		this.api.datacenter.Player.Spells.addEventListener("modelChanged",this);
		this.api.datacenter.Player.Inventory.addEventListener("modelChanged",this);
	}
	function clearSpellStateOnAllContainers()
	{
		var loc2 = this.api.datacenter.Player.Spells;
		for(var k in loc2)
		{
			if(!_global.isNaN(loc2[k].position))
			{
				var loc3 = this["_ctr" + loc2[k].position];
				loc3.showLabel = false;
				this.setMovieClipTransform(loc3.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
			}
		}
		this.setMovieClipTransform(this._ctrCC.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
	}
	function setSpellStateOnAllContainers()
	{
		if(this._sCurrentTab != "Spells")
		{
			return undefined;
		}
		var loc2 = this.api.datacenter.Player.Spells;
		for(var k in loc2)
		{
			if(!_global.isNaN(loc2[k].position))
			{
				this.setSpellStateOnContainer(loc2[k].position);
			}
		}
		this.setSpellStateOnContainer(0);
	}
	function setItemStateOnAllContainers()
	{
		if(this._sCurrentTab != "Items")
		{
			return undefined;
		}
		var loc2 = this.api.datacenter.Player.Inventory;
		for(var loc3 in loc2)
		{
			if(!(_global.isNaN(loc3) && loc3 < 1))
			{
				this.setItemStateOnContainer(loc3);
			}
		}
		this.setSpellStateOnContainer(0);
	}
	function updateSpells()
	{
		var loc2 = new Array();
		var loc3 = 1;
		while(loc3 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
		{
			loc2[loc3] = true;
			loc3 = loc3 + 1;
		}
		var loc4 = this.api.datacenter.Player.Spells;
		for(var k in loc4)
		{
			var loc5 = loc4[k];
			var loc6 = loc5.position;
			if(!_global.isNaN(loc6))
			{
				this["_ctr" + loc6].contentData = loc5;
				loc2[loc6] = false;
			}
		}
		var loc7 = 1;
		while(loc7 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
		{
			if(loc2[loc7])
			{
				this["_ctr" + loc7].contentData = undefined;
			}
			loc7 = loc7 + 1;
		}
		this.addToQueue({object:this,method:this.setSpellStateOnAllContainers});
	}
	function updateItems()
	{
		var loc2 = new Array();
		var loc3 = 1;
		while(loc3 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
		{
			loc2[loc3] = true;
			loc3 = loc3 + 1;
		}
		var loc4 = this.api.datacenter.Player.Inventory;
		for(var loc5 in loc4)
		{
			if(!_global.isNaN(loc5.position))
			{
				if(loc5.position < dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET + 1)
				{
					continue;
				}
				var loc6 = loc5.position - dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
				var loc7 = this["_ctr" + loc6];
				loc7.contentData = loc5;
				if(loc5.Quantity > 1)
				{
					loc7.label = String(loc5.Quantity);
				}
				loc2[loc6] = false;
			}
		}
		var loc8 = 1;
		while(loc8 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
		{
			if(loc2[loc8])
			{
				this["_ctr" + loc8].contentData = undefined;
			}
			loc8 = loc8 + 1;
		}
		this.addToQueue({object:this,method:this.setItemStateOnAllContainers});
	}
	function setSpellStateOnContainer(loc2)
	{
		var loc3 = loc2 != 0?this["_ctr" + loc2]:this._ctrCC;
		var loc4 = loc2 != 0?loc3.contentData:this.api.datacenter.Player.Spells[0];
		if(loc4 == undefined)
		{
			return undefined;
		}
		if(this.api.kernel.TutorialManager.isTutorialMode)
		{
			loc5.can = true;
		}
		else
		{
			var loc5 = this.api.datacenter.Player.SpellsManager.checkCanLaunchSpellReturnObject(loc4.ID);
		}
		if(loc5.can == false)
		{
			switch(loc5.type)
			{
				case "NOT_IN_REQUIRED_STATE":
				case "IN_FORBIDDEN_STATE":
					this.setMovieClipTransform(loc3.content,dofus.graphics.gapi.controls.MouseShortcuts.WRONG_STATE_TRANSFORM);
					if(loc5.params[1])
					{
						loc3.showLabel = true;
						loc3.label = loc5.params[1];
					}
					else
					{
						loc3.showLabel = false;
					}
					break;
				default:
					switch(null)
					{
						case "CANT_LAUNCH_MORE":
						case "CANT_RELAUNCH":
						case "NOT_IN_FIGHT":
							break;
						case "CANT_LAUNCH_BEFORE":
							this.setMovieClipTransform(loc3.content,dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
							loc3.showLabel = true;
							loc3.label = loc5.params[0];
					}
					break;
				case "NOT_ENOUGH_AP":
				case "CANT_SUMMON_MORE_CREATURE":
					loc3.showLabel = false;
					this.setMovieClipTransform(loc3.content,dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
			}
		}
		else
		{
			loc3.showLabel = false;
			this.setMovieClipTransform(loc3.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
		}
	}
	function setItemStateOnContainer(loc2)
	{
		var loc3 = this["_ctr" + loc2];
		var loc4 = loc3.contentData;
		if(loc4 == undefined)
		{
			return undefined;
		}
		loc3.showLabel = loc4.Quantity > 1;
		if(this.api.datacenter.Game.isRunning)
		{
			this.setMovieClipTransform(loc3.content,dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
		}
		else
		{
			this.setMovieClipTransform(loc3.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
		}
	}
	function updateCurrentTabInformations()
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
	}
	function setCurrentTab(loc2)
	{
		if(loc2 != this._sCurrentTab)
		{
			var loc3 = this["_btnTab" + this._sCurrentTab];
			var loc4 = this["_btnTab" + loc2];
			loc3.selected = true;
			loc3.enabled = true;
			loc4.selected = false;
			loc4.enabled = false;
			this._sCurrentTab = loc2;
			this.updateCurrentTabInformations();
		}
	}
	function onShortcut(loc2)
	{
		var loc3 = true;
		loop0:
		switch(loc2)
		{
			case "SWAP":
				this.setCurrentTab(this._sCurrentTab != "Spells"?"Spells":"Items");
				loc3 = false;
				break;
			case "SH0":
				this.click({target:this._ctrCC});
				loc3 = false;
				break;
			case "SH1":
				this.click({target:this._ctr1,keyBoard:true});
				loc3 = false;
				break;
			default:
				switch(null)
				{
					case "SH2":
						this.click({target:this._ctr2,keyBoard:true});
						loc3 = false;
						break loop0;
					case "SH3":
						this.click({target:this._ctr3,keyBoard:true});
						loc3 = false;
						break loop0;
					case "SH4":
						this.click({target:this._ctr4,keyBoard:true});
						loc3 = false;
						break loop0;
					case "SH5":
						this.click({target:this._ctr5,keyBoard:true});
						loc3 = false;
						break loop0;
					case "SH6":
						this.click({target:this._ctr6,keyBoard:true});
						loc3 = false;
						break loop0;
					default:
						switch(null)
						{
							case "SH7":
								this.click({target:this._ctr7,keyBoard:true});
								loc3 = false;
								break loop0;
							case "SH8":
								this.click({target:this._ctr8,keyBoard:true});
								loc3 = false;
								break loop0;
							case "SH9":
								this.click({target:this._ctr9,keyBoard:true});
								loc3 = false;
								break loop0;
							case "SH10":
								this.click({target:this._ctr10,keyBoard:true});
								loc3 = false;
								break loop0;
							default:
								switch(null)
								{
									case "SH11":
										this.click({target:this._ctr11,keyBoard:true});
										loc3 = false;
										break;
									case "SH12":
										this.click({target:this._ctr12,keyBoard:true});
										loc3 = false;
										break;
									case "SH13":
										this.click({target:this._ctr13,keyBoard:true});
										loc3 = false;
										break;
									case "SH14":
										this.click({target:this._ctr14,keyBoard:true});
										loc3 = false;
								}
						}
				}
		}
		return loc3;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnTabSpells":
				this.api.sounds.events.onBannerSpellItemButtonClick();
				this.setCurrentTab("Spells");
				break;
			case "_btnTabItems":
				this.api.sounds.events.onBannerSpellItemButtonClick();
				this.setCurrentTab("Items");
				break;
			case "_ctrCC":
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
			default:
				switch(this._sCurrentTab)
				{
					case "Spells":
						this.api.sounds.events.onBannerSpellSelect();
						if(this.api.kernel.TutorialManager.isTutorialMode)
						{
							this.api.kernel.TutorialManager.onWaitingCase({code:"SPELL_CONTAINER_SELECT",params:[Number(loc2.target._name.substr(4))]});
							break;
						}
						if(this.gapi.getUIComponent("Spells") != undefined)
						{
							return undefined;
						}
						var loc3 = loc2.target.contentData;
						if(loc3 == undefined)
						{
							return undefined;
						}
						this.api.kernel.GameManager.switchToSpellLaunch(loc3,true);
						break;
					case "Items":
						if(this.api.kernel.TutorialManager.isTutorialMode)
						{
							this.api.kernel.TutorialManager.onWaitingCase({code:"OBJECT_CONTAINER_SELECT",params:[Number(loc2.target._name.substr(4))]});
							break;
						}
						if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && loc2.target.contentData != undefined)
						{
							this.api.kernel.GameManager.insertItemInChat(loc2.target.contentData);
							return undefined;
						}
						var loc4 = this.gapi.getUIComponent("Inventory");
						if(loc4 != undefined)
						{
							loc4.showItemInfos(loc2.target.contentData);
							break;
						}
						var loc5 = loc2.target.contentData;
						if(loc5 == undefined)
						{
							return undefined;
						}
						if(this.api.datacenter.Player.canUseObject)
						{
							if(loc5.canTarget)
							{
								this.api.kernel.GameManager.switchToItemTarget(loc5);
								break;
							}
							if(loc5.canUse && loc2.keyBoard)
							{
								this.api.network.Items.use(loc5.ID);
								break;
							}
							break;
						}
						break;
				}
		}
	}
	function dblClick(loc2)
	{
		switch(this._sCurrentTab)
		{
			case "Spells":
				if((loc0 = loc2.target._name) !== "_ctrCC")
				{
					var loc3 = loc2.target.contentData;
				}
				else
				{
					loc3 = this.api.datacenter.Player.Spells[0];
				}
				if(loc3 == undefined)
				{
					return undefined;
				}
				this.gapi.loadUIAutoHideComponent("SpellInfos","SpellInfos",{spell:loc3},{bStayIfPresent:true});
				break;
			case "Items":
				var loc4 = loc2.target.contentData;
				if(loc4 != undefined)
				{
					if(!loc4.canUse || !this.api.datacenter.Player.canUseObject)
					{
						return undefined;
					}
					this.api.network.Items.use(loc4.ID);
					break;
				}
		}
	}
	function over(loc2)
	{
		if(!this.gapi.isCursorHidden())
		{
			return undefined;
		}
		if((var loc0 = loc2.target._name) !== "_ctrCC")
		{
			if((loc0 = this._sCurrentTab) !== "Spells")
			{
				if(loc0 === "Items")
				{
					var loc6 = loc2.target.contentData;
					if(loc6 != undefined)
					{
						var loc7 = loc6.name;
						if(this.gapi.getUIComponent("Inventory") == undefined)
						{
							if(loc6.canUse && loc6.canTarget)
							{
								loc7 = loc7 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK_CLICK"));
							}
							else
							{
								if(loc6.canUse)
								{
									loc7 = loc7 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK"));
								}
								if(loc6.canTarget)
								{
									loc7 = loc7 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_CLICK"));
								}
							}
						}
						this.gapi.showTooltip(loc7,loc2.target,-30,{bXLimit:true,bYLimit:false});
					}
				}
			}
			else
			{
				var loc5 = loc2.target.contentData;
				if(loc5 != undefined)
				{
					this.gapi.showTooltip(loc5.name + " (" + loc5.apCost + " " + this.api.lang.getText("AP") + (loc5.actualCriticalHit <= 0?"":", " + this.api.lang.getText("ACTUAL_CRITICAL_CHANCE") + ": 1/" + loc5.actualCriticalHit) + ")",loc2.target,-20,{bXLimit:true,bYLimit:false});
				}
			}
		}
		else
		{
			var loc3 = this.api.datacenter.Player.Spells[0];
			var loc4 = this.api.kernel.GameManager.getCriticalHitChance(this.api.datacenter.Player.weaponItem.criticalHit);
			this.gapi.showTooltip(loc3.name + "\n" + loc3.descriptionVisibleEffects + " (" + loc3.apCost + " " + this.api.lang.getText("AP") + (!!_global.isNaN(loc4)?"":", " + this.api.lang.getText("ACTUAL_CRITICAL_CHANCE") + ": 1/" + loc4) + ")",loc2.target,-30,{bXLimit:true,bYLimit:false});
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
	function drag(loc2)
	{
		var loc3 = loc2.target.contentData;
		if(loc3 == undefined)
		{
			return undefined;
		}
		switch(this._sCurrentTab)
		{
			case "Spells":
				if(this.gapi.getUIComponent("Spells") == undefined && !Key.isDown(Key.SHIFT))
				{
					return undefined;
				}
				break;
			case "Items":
				if(this.gapi.getUIComponent("Inventory") == undefined && !Key.isDown(Key.SHIFT))
				{
					return undefined;
				}
				break;
		}
		this.gapi.removeCursor();
		this.gapi.setCursor(loc3);
	}
	function drop(loc2)
	{
		switch(this._sCurrentTab)
		{
			case "Spells":
				§§push(var loc0 = loc2.target);
				if(this.gapi.getUIComponent("Spells") == undefined && !Key.isDown(Key.SHIFT))
				{
					return undefined;
				}
				var loc3 = this.gapi.getCursor();
				if(loc3 == undefined)
				{
					return undefined;
				}
				this.gapi.removeCursor();
				var loc4 = loc3.position;
				var loc5 = loc2.target.params.position;
				if(loc4 == loc5)
				{
					return undefined;
				}
				if(loc4 != undefined)
				{
					this["_ctr" + loc4].contentData = undefined;
				}
				var loc6 = this["_ctr" + loc5].contentData;
				if(loc6 != undefined)
				{
					loc6.position = undefined;
				}
				loc3.position = loc5;
				loc2.target.contentData = loc3;
				this.api.network.Spells.moveToUsed(loc3.ID,loc5);
				this.addToQueue({object:this,method:this.setSpellStateOnAllContainers});
				break;
			case "Items":
				if(this.gapi.getUIComponent("Inventory") == undefined && !Key.isDown(Key.SHIFT))
				{
					return undefined;
				}
				var loc7 = this.gapi.getCursor();
				if(loc7 == undefined)
				{
					return undefined;
				}
				if(!loc7.canMoveToShortut)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_MOVE_ITEM_HERE"),"ERROR_BOX");
					return undefined;
				}
				this.gapi.removeCursor();
				var loc8 = loc2.target.params.position + dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
				if(loc7.position == loc8)
				{
					return undefined;
				}
				if(loc7.Quantity > 1)
				{
					var loc9 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:loc7.Quantity,max:loc7.Quantity,useAllStage:true,params:{type:"drop",item:loc7,position:loc8}},{bAlwaysOnTop:true});
					loc9.addEventListener("validate",this);
					break;
				}
				this.api.network.Items.movement(loc7.ID,loc8,1);
				break;
		}
		§§pop();
	}
	function modelChanged(loc2)
	{
		switch(loc2.eventName)
		{
			case "updateOne":
			case "updateAll":
		}
		if(loc2.target == this.api.datacenter.Player.Spells)
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
	}
	function validate(loc2)
	{
		if((var loc0 = loc2.params.type) === "drop")
		{
			this.gapi.removeCursor();
			if(loc2.value > 0 && !_global.isNaN(Number(loc2.value)))
			{
				this.api.network.Items.movement(loc2.params.item.ID,loc2.params.position,Math.min(loc2.value,loc2.params.item.Quantity));
			}
		}
	}
}

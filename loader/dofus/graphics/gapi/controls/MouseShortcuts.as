class dofus.graphics.gapi.controls.MouseShortcuts extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var TAB_SPELLS = "Spells";
	static var TAB_ITEMS = "Items";
	static var CLASS_NAME = "MouseShortcuts";
	static var MAX_CONTAINER = 29;
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
	function __set__meleeVisible(§\x1d\x03§)
	{
		this._ctrCC._visible = var2;
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
	function getContainer(§\x05\x02§)
	{
		return this["_ctr" + var2];
	}
	function setContainer(§\x05\x02§, §\x13\x10§)
	{
		this["_ctr" + var2] = var3;
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
			var3.addEventListener("onContentLoaded",this);
			var3.params = {position:var2};
			var2 = var2 + 1;
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
		var var2 = this.api.datacenter.Player.Spells;
		§§enumerate(var2);
		while((var var0 = §§enumeration()) != null)
		{
			if(!_global.isNaN(var2[k].position))
			{
				var var3 = this["_ctr" + var2[k].position];
				var3.showLabel = false;
				this.setMovieClipTransform(var3.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
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
		var var2 = this.api.datacenter.Player.Spells;
		for(var k in var2)
		{
			if(!_global.isNaN(var2[k].position))
			{
				this.setSpellStateOnContainer(var2[k].position);
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
	}
	function updateSpells()
	{
		if(this._sCurrentTab != "Spells")
		{
			return undefined;
		}
		var var2 = new Array();
		var var3 = 1;
		while(var3 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
		{
			var2[var3] = true;
			var3 = var3 + 1;
		}
		var var4 = this.api.datacenter.Player.Spells;
		for(var k in var4)
		{
			var var5 = var4[k];
			var var6 = var5.position;
			if(!_global.isNaN(var6))
			{
				var var7 = this["_ctr" + var6];
				var7.contentData = var5;
				if(dofus.Constants.DOUBLEFRAMERATE && var7.contentLoaded)
				{
					var var8 = this.api.kernel.OptionsManager.getOption("RemasteredSpellIconsPack");
					var7.content.gotoAndStop(var8);
				}
				var2[var6] = false;
			}
		}
		var var9 = 1;
		while(var9 < dofus.graphics.gapi.controls.MouseShortcuts.MAX_CONTAINER)
		{
			if(var2[var9])
			{
				this["_ctr" + var9].contentData = undefined;
			}
			var9 = var9 + 1;
		}
		this.addToQueue({object:this,method:this.setSpellStateOnAllContainers});
	}
	function updateItems()
	{
		if(this._sCurrentTab != "Items")
		{
			return undefined;
		}
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
	}
	function setSpellStateOnContainer(§\x04\x17§)
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
					loop1:
					switch(null)
					{
						default:
							switch(null)
							{
								case "NOT_IN_FIGHT":
									break loop1;
								case "CANT_LAUNCH_BEFORE":
									this.setMovieClipTransform(var3.content,dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
									var3.showLabel = true;
									var3.label = var5.params[0];
							}
							break loop0;
						case "NOT_ENOUGH_AP":
						case "CANT_SUMMON_MORE_CREATURE":
						case "CANT_LAUNCH_MORE":
						case "CANT_RELAUNCH":
					}
					var3.showLabel = false;
					this.setMovieClipTransform(var3.content,dofus.graphics.gapi.controls.MouseShortcuts.INACTIVE_TRANSFORM);
			}
		}
		else
		{
			var3.showLabel = false;
			this.setMovieClipTransform(var3.content,dofus.graphics.gapi.controls.MouseShortcuts.NO_TRANSFORM);
		}
	}
	function setItemStateOnContainer(§\x04\x17§)
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
	function setCurrentTab(§\x1e\x10\x04§)
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
	}
	function onShortcut(§\x1e\x0e\x04§)
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
			case "SH1":
				this.click({target:this._ctr1,keyBoard:true});
				var3 = false;
				break;
			default:
				switch(null)
				{
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
					case "SH6":
						this.click({target:this._ctr6,keyBoard:true});
						var3 = false;
						break loop0;
					default:
						switch(null)
						{
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
	}
	function click(§\x1e\x19\x18§)
	{
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
							this.api.kernel.TutorialManager.onWaitingCase({code:"SPELL_CONTAINER_SELECT",params:[Number(var2.target._name.substr(4))]});
							break;
						}
						if(this.gapi.getUIComponent("Spells") != undefined)
						{
							return undefined;
						}
						var var3 = var2.target.contentData;
						if(var3 == undefined)
						{
							return undefined;
						}
						this.api.kernel.GameManager.switchToSpellLaunch(var3,true);
						break;
					case "Items":
						if(this.api.kernel.TutorialManager.isTutorialMode)
						{
							this.api.kernel.TutorialManager.onWaitingCase({code:"OBJECT_CONTAINER_SELECT",params:[Number(var2.target._name.substr(4))]});
							break;
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
							break;
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
								break;
							}
							if(var5.canUse && var2.keyBoard)
							{
								this.api.network.Items.use(var5.ID);
								break;
							}
							break;
						}
						break;
				}
		}
	}
	function dblClick(§\x1e\x19\x18§)
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
	}
	function over(§\x1e\x19\x18§)
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
	}
	function out(§\x1e\x19\x18§)
	{
		this.gapi.hideTooltip();
	}
	function drag(§\x1e\x19\x18§)
	{
		var var3 = var2.target.contentData;
		if(var3 == undefined)
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
		this.gapi.setCursor(var3,undefined,this._sCurrentTab == "Spells");
	}
	function onContentLoaded(§\x1e\x19\x18§)
	{
		if(!dofus.Constants.DOUBLEFRAMERATE)
		{
			return undefined;
		}
		if(this._sCurrentTab != "Spells")
		{
			return undefined;
		}
		var var3 = var2.content;
		var var4 = this.api.kernel.OptionsManager.getOption("RemasteredSpellIconsPack");
		var3.gotoAndStop(var4);
	}
	function drop(§\x1e\x19\x18§)
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
				}
				else
				{
					this.api.network.Items.movement(var7.ID,var8,1);
				}
				break;
		}
		§§pop();
	}
	function modelChanged(§\x1e\x19\x18§)
	{
		switch(var2.eventName)
		{
			case "updateOne":
			case "updateAll":
		}
		if(var2.target == this.api.datacenter.Player.Spells)
		{
			this.updateSpells();
		}
		else
		{
			this.updateItems();
		}
	}
	function validate(§\x1e\x19\x18§)
	{
		if((var var0 = var2.params.type) === "drop")
		{
			this.gapi.removeCursor();
			if(var2.value > 0 && !_global.isNaN(Number(var2.value)))
			{
				this.api.network.Items.movement(var2.params.item.ID,var2.params.position,Math.min(var2.value,var2.params.item.Quantity));
			}
		}
	}
}

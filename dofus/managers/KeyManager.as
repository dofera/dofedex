class dofus.managers.KeyManager extends dofus.utils.ApiElement
{
	var _bIsBroadcasting = true;
	var _bPressedKeys = new Array();
	var _bCtrlDown = false;
	var _bShiftDown = true;
	static var _sSelf = null;
	var _nLastTriggerShow = 0;
	function KeyManager(loc3)
	{
		super();
		dofus.managers.KeyManager._sSelf = this;
		this.initialize(loc3);
	}
	function __get__Broadcasting()
	{
		return this._bIsBroadcasting;
	}
	function __set__Broadcasting(loc2)
	{
		this._bIsBroadcasting = loc2;
		return this.__get__Broadcasting();
	}
	static function getInstance()
	{
		return dofus.managers.KeyManager._sSelf;
	}
	function initialize(loc2)
	{
		super.initialize(loc3);
		Key.addListener(this);
		this._aAnyTimeShortcuts = new Array();
		this._aNoChatShortcuts = new Array();
		this._so = SharedObject.getLocal(this.api.datacenter.Player.login + dofus.Constants.GLOBAL_SO_SHORTCUTS_NAME);
		this._nCurrentSet = this.api.kernel.OptionsManager.getOption("ShortcutSet");
		this.loadShortcuts();
	}
	function addShortcutsListener(loc2, loc3)
	{
		if(this._aListening == undefined)
		{
			this._aListening = new Array();
		}
		var loc4 = 0;
		while(loc4 < this._aListening.length)
		{
			if(String(this._aListening[loc4].o) == String(loc3) && this._aListening[loc4].m == loc2)
			{
				this.removeShortcutsListener(this._aListening[loc4].o);
			}
			loc4 = loc4 + 1;
		}
		this._aListening.unshift({o:loc3,m:loc2});
	}
	function removeShortcutsListener(loc2)
	{
		if(this._aListening == undefined)
		{
			return undefined;
		}
		var loc3 = new Array();
		var loc4 = 0;
		while(loc4 < this._aListening.length)
		{
			if(this._aListening[loc4].o == loc2)
			{
				loc3.push(loc4);
			}
			loc4 = loc4 + 1;
		}
		loc3.sort(Array.DESCENDING);
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			this._aListening.splice(loc3[loc5],1);
			loc5 = loc5 + 1;
		}
	}
	function addKeysListener(loc2, loc3)
	{
		if(this._aKeysListening == undefined)
		{
			this._aKeysListening = new Array();
		}
		var loc4 = 0;
		while(loc4 < this._aKeysListening.length)
		{
			if(String(this._aKeysListening[loc4].o) == String(loc3) && this._aKeysListening[loc4].m == loc2)
			{
				this._aKeysListening[loc4] = undefined;
			}
			loc4 = loc4 + 1;
		}
		this._aKeysListening.unshift({o:loc3,m:loc2});
	}
	function removeKeysListener(loc2)
	{
		if(this._aKeysListening == undefined)
		{
			return undefined;
		}
		var loc3 = new Array();
		var loc4 = 0;
		while(loc4 < this._aKeysListening.length)
		{
			if(this._aKeysListening[loc4].o == loc2)
			{
				loc3.push(loc4);
			}
			loc4 = loc4 + 1;
		}
		loc3.sort(Array.DESCENDING);
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			this._aKeysListening.splice(loc3[loc5],1);
			loc5 = loc5 + 1;
		}
	}
	function getDefaultShortcut(loc2)
	{
		return this.api.lang.getKeyboardShortcutsKeys(this._nCurrentSet,loc2);
	}
	function getCurrentShortcut(loc2)
	{
		var loc3 = new Array();
		var loc4 = 0;
		while(loc4 < this._aAnyTimeShortcuts.length)
		{
			if(this._aAnyTimeShortcuts[loc4].d == loc2)
			{
				loc3.push({k:this._aAnyTimeShortcuts[loc4].k,c:this._aAnyTimeShortcuts[loc4].c,d:this._aAnyTimeShortcuts[loc4].l});
			}
			loc4 = loc4 + 1;
		}
		var loc5 = 0;
		while(loc5 < this._aNoChatShortcuts.length)
		{
			if(this._aNoChatShortcuts[loc5].d == loc2)
			{
				loc3.push({k:this._aNoChatShortcuts[loc5].k,c:this._aNoChatShortcuts[loc5].c,d:this._aNoChatShortcuts[loc5].l});
			}
			loc5 = loc5 + 1;
		}
		if(loc3.length == 1)
		{
			return loc3[0];
		}
		if(loc3.length == 2)
		{
			return {k:loc3[0].k,c:loc3[0].c,d:loc3[0].d,k2:loc3[1].k,c2:loc3[1].c,d2:loc3[1].d};
		}
		return undefined;
	}
	function clearCustomShortcuts()
	{
		this._so.clear();
		this.loadShortcuts();
	}
	function askCustomShortcut(loc2, loc3)
	{
		this.api.ui.loadUIComponent("AskCustomShortcut","AskCustomShortcut",{title:this.api.lang.getText("SHORTCUTS_CUSTOM"),ShortcutCode:loc2,IsAlt:loc3,Description:this.api.lang.getKeyboardShortcuts()[loc2].d});
	}
	function setCustomShortcut(loc2, loc3, loc4, loc5, loc6)
	{
		if(loc2 == undefined || loc3 == undefined)
		{
			return undefined;
		}
		var loc7 = loc2 + (!loc3?"_MAIN":"_ALT");
		if(loc4 == undefined)
		{
			this._so.data[loc7] = undefined;
		}
		else
		{
			if(loc5 == undefined)
			{
				loc5 = 0;
			}
			if(loc6 == undefined || loc6 == "")
			{
				loc6 = this.api.lang.getKeyStringFromKeyCode(loc4);
				loc6 = this.api.lang.getControlKeyString(loc5) + loc6;
			}
			this._so.data[loc7] = {s:loc2,a:loc3,k:loc4,c:loc5,i:loc6};
		}
		this._so.flush();
		this.loadShortcuts();
	}
	function getCustomShortcut(loc2, loc3)
	{
		var loc4 = loc2 + (!loc3?"_MAIN":"_ALT");
		return this._so.data[loc4];
	}
	function isCustomShortcut(loc2, loc3)
	{
		return this.getCustomShortcut(loc2,loc3) != undefined;
	}
	function deleteCustomShortcut(loc2, loc3)
	{
		this.setCustomShortcut(loc2,loc3);
	}
	function getCurrentDefaultSet()
	{
		var loc2 = Number(this.api.lang.getText("SHORTCUTS_DEFAULT_SET"));
		if(loc2 < 1)
		{
			loc2 = 1;
		}
		return loc2;
	}
	function dispatchCtrlState(loc2)
	{
		this.dispatchShortcut(!loc2?"CTRL_STATE_CHANGED_OFF":"CTRL_STATE_CHANGED_ON");
	}
	function dispatchShortcut(loc2)
	{
		if(!this._bIsBroadcasting)
		{
			return false;
		}
		if(this._aListening == undefined)
		{
			return true;
		}
		var loc3 = new Array();
		var loc4 = true;
		var loc5 = 0;
		while(loc5 < this._aListening.length)
		{
			if(this._aListening[loc5] == undefined || this._aListening[loc5].o == undefined)
			{
				loc3.push(loc5);
			}
			else
			{
				var loc6 = eval(String(this._aListening[loc5].o) + "." + this._aListening[loc5].m).call(this._aListening[loc5].o,loc2);
				if(loc6 != undefined && loc6 == false)
				{
					loc4 = false;
					break;
				}
			}
			loc5 = loc5 + 1;
		}
		loc3.sort(Array.DESCENDING);
		var loc7 = 0;
		while(loc7 < loc3.length)
		{
			this._aListening.splice(loc3[loc7],1);
			loc7 = loc7 + 1;
		}
		if(loc4)
		{
			loc4 = this.onShortcut(loc2);
		}
		return loc4;
	}
	function dispatchKey(loc2)
	{
		if(!this._bIsBroadcasting)
		{
			return undefined;
		}
		if(this._aKeysListening == undefined)
		{
			return undefined;
		}
		loc2 = new ank.utils.(loc2).trim().toString();
		if(loc2.length == 0)
		{
			return undefined;
		}
		var loc3 = new Array();
		var loc4 = 0;
		while(loc4 < this._aKeysListening.length)
		{
			if(this._aKeysListening[loc4] == undefined || this._aKeysListening[loc4].o == undefined)
			{
				loc3.push(loc4);
			}
			else
			{
				eval(String(this._aKeysListening[loc4].o) + "." + this._aKeysListening[loc4].m).call(this._aKeysListening[loc4].o,loc2);
			}
			loc4 = loc4 + 1;
		}
		loc3.sort(Array.DESCENDING);
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			this._aKeysListening.splice(loc3[loc5],1);
			loc5 = loc5 + 1;
		}
	}
	function loadShortcuts()
	{
		var loc2 = this.api.lang.getKeyboardShortcuts();
		this._aNoChatShortcuts = new Array();
		this._aAnyTimeShortcuts = new Array();
		for(var k in loc2)
		{
			var loc3 = this.api.lang.getKeyboardShortcutsKeys(this._nCurrentSet,k);
			var loc4 = this.getCustomShortcut(k,false);
			if(loc4 != undefined && !loc2[k].s)
			{
				if(loc3.o)
				{
					this._aNoChatShortcuts.push({k:loc4.k,c:loc4.c,o:loc3.o,d:k,l:loc4.i,s:loc2[k].s});
				}
				else
				{
					this._aAnyTimeShortcuts.push({k:loc4.k,c:loc4.c,o:loc3.o,d:k,l:loc4.i,s:loc2[k].s});
				}
			}
			else if(loc3.o)
			{
				this._aNoChatShortcuts.push({k:loc3.k,c:loc3.c,o:loc3.o,d:k,l:loc3.s,s:loc2[k].s});
			}
			else if(loc3.k != undefined)
			{
				this._aAnyTimeShortcuts.push({k:loc3.k,c:loc3.c,o:loc3.o,d:k,l:loc3.s,s:loc2[k].s});
			}
			var loc5 = this.getCustomShortcut(k,true);
			if(loc5 != undefined && !loc2[k].s)
			{
				if(loc3.o)
				{
					this._aNoChatShortcuts.push({k:loc5.k,c:loc5.c,o:loc3.o,d:k,l:loc5.i,s:loc2[k].s});
				}
				else
				{
					this._aAnyTimeShortcuts.push({k:loc5.k,c:loc5.c,o:loc3.o,d:k,l:loc5.i,s:loc2[k].s});
				}
			}
			else if(!_global.isNaN(loc3.k2) && loc3.k2 != undefined)
			{
				if(loc3.o)
				{
					this._aNoChatShortcuts.push({k:loc3.k2,c:loc3.c2,o:loc3.o,d:k,l:loc3.s2,s:loc2[k].s});
				}
				else
				{
					this._aAnyTimeShortcuts.push({k:loc3.k2,c:loc3.c2,o:loc3.o,d:k,l:loc3.s2,s:loc2[k].s});
				}
			}
		}
		if(this._aNoChatShortcuts.length == 0 && this._aAnyTimeShortcuts.length == 0)
		{
			this._aAnyTimeShortcuts.push({k:38,c:0,o:true,d:"HISTORY_UP"});
			this._aAnyTimeShortcuts.push({k:40,c:0,o:true,d:"HISTORY_DOWN"});
			this._aAnyTimeShortcuts.push({k:13,c:1,o:true,d:"GUILD_MESSAGE"});
			this._aAnyTimeShortcuts.push({k:13,c:0,o:true,d:"ACCEPT_CURRENT_DIALOG"});
			this._aAnyTimeShortcuts.push({k:70,c:1,o:true,d:"FULLSCREEN"});
			var loc6 = this.api.lang.getDefaultConsoleShortcuts();
			var loc7 = 0;
			while(loc7 < loc6.length)
			{
				this._aAnyTimeShortcuts.push({k:loc6[loc7].k,c:1,o:true,d:"CONSOLE"});
				loc7 = loc7 + 1;
			}
			var loc8 = 0;
			while(loc8 < loc6.length)
			{
				this._aAnyTimeShortcuts.push({k:loc6[loc8].k,c:2,o:true,d:"CONSOLESIZE"});
				loc8 = loc8 + 1;
			}
		}
	}
	function processShortcuts(loc2, loc3, loc4, loc5)
	{
		var loc6 = true;
		var loc7 = 0;
		while(loc7 < loc2.length)
		{
			if(Number(loc2[loc7].k) == loc3)
			{
				var loc8 = false;
				switch(loc2[loc7].c)
				{
					case 1:
						if(loc4 && !loc5)
						{
							loc8 = true;
						}
						break;
					case 2:
						if(!loc4 && loc5)
						{
							loc8 = true;
						}
						break;
					case 3:
						if(loc4 && loc5)
						{
							loc8 = true;
						}
						break;
					default:
						if(!loc4 && !loc5)
						{
							loc8 = true;
							break;
						}
				}
				if(loc8)
				{
					loc6 = this.dispatchShortcut(loc2[loc7].d);
				}
			}
			loc7 = loc7 + 1;
		}
		return loc6;
	}
	function onSetChange(loc2)
	{
		this._nCurrentSet = loc2;
		this.loadShortcuts();
	}
	function onKeyDown()
	{
		var loc2 = Key.getCode();
		var loc3 = Key.getAscii();
		var loc4 = Key.isDown(Key.CONTROL);
		var loc5 = Key.isDown(Key.SHIFT);
		if(this._lastCtrlState != loc4)
		{
			this._lastCtrlState = loc4;
			this.dispatchCtrlState(loc4);
		}
		if(this._bPressedKeys[loc2] != undefined)
		{
			return undefined;
		}
		this._bPressedKeys[loc2] = true;
		if(this.api.gfx.spriteHandler.isShowingMonstersTooltip)
		{
			this.api.gfx.spriteHandler.showMonstersTooltip(false);
		}
		if(this.api.gfx.spriteHandler.isPlayerSpritesHidden)
		{
			this.api.gfx.spriteHandler.hidePlayerSprites(false);
		}
		if(!this.processShortcuts(this._aAnyTimeShortcuts,loc2,loc4,loc5))
		{
			return undefined;
		}
		if(Selection.getFocus() != undefined)
		{
			return undefined;
		}
		if(!this.processShortcuts(this._aNoChatShortcuts,loc2,loc4,loc5))
		{
			return undefined;
		}
		if(loc3 > 0)
		{
			this.dispatchKey(String.fromCharCode(loc3));
		}
	}
	function onKeyUp()
	{
		if(this.api.gfx.spriteHandler.isShowingMonstersTooltip)
		{
			this.api.gfx.spriteHandler.showMonstersTooltip(false);
		}
		if(this.api.gfx.spriteHandler.isPlayerSpritesHidden)
		{
			this.api.gfx.spriteHandler.hidePlayerSprites(false);
		}
		var loc2 = Key.getCode();
		delete this._bPressedKeys.register2;
	}
	function onShortcut(loc2)
	{
		var loc3 = true;
		loop0:
		switch(loc2)
		{
			case "TOGGLE_FIGHT_INFOS":
				this.api.kernel.OptionsManager.setOption("ChatEffects",!this.api.kernel.OptionsManager.getOption("ChatEffects"));
				loc3 = false;
				break;
			case "ESCAPE":
				this.api.datacenter.Basics.gfx_canLaunch = false;
				if(!this.api.ui.removeCursor(true))
				{
					if(this.api.ui.callCloseOnLastUI() == false)
					{
						this.api.ui.loadUIComponent("AskMainMenu","AskMainMenu");
					}
				}
				break;
			case "CONSOLE":
				if(this.api.datacenter.Player.isAuthorized)
				{
					this.api.ui.loadUIComponent("Debug","Debug",undefined,{bAlwaysOnTop:true});
					loc3 = false;
				}
				break;
			default:
				switch(null)
				{
					case "CONSOLESIZE":
						if(this.api.datacenter.Player.isAuthorized)
						{
							var loc4 = this.api.ui.getUIComponent("Debug");
							if(loc4 != undefined)
							{
								loc4.changeSize();
							}
							loc3 = false;
						}
						break loop0;
					case "GRID":
						this.api.kernel.OptionsManager.setOption("Grid");
						loc3 = false;
						break loop0;
					case "SHOWMONSTERSTOOLTIP":
						this.api.gfx.spriteHandler.showMonstersTooltip(true);
						loc3 = false;
						break loop0;
					case "SHOWTRIGGERS":
						if(!this.api.datacenter.Game.isFight)
						{
							if(getTimer() - this._nLastTriggerShow >= dofus.Constants.CLICK_MIN_DELAY)
							{
								this._nLastTriggerShow = getTimer();
								this.api.gfx.mapHandler.showTriggers();
							}
							loc3 = false;
						}
						break loop0;
					default:
						switch(null)
						{
							case "HIDESPRITES":
								this.api.gfx.spriteHandler.hidePlayerSprites(true);
								loc3 = false;
								break loop0;
							case "TRANSPARENCY":
								this.api.kernel.OptionsManager.setOption("Transparency",!this.api.gfx.bGhostView);
								loc3 = false;
								break loop0;
							case "SPRITEINFOS":
								this.api.kernel.OptionsManager.setOption("SpriteInfos");
								loc3 = false;
								break loop0;
							case "COORDS":
								this.api.kernel.OptionsManager.setOption("MapInfos");
								loc3 = false;
								break loop0;
							case "STRINGCOURSE":
								this.api.kernel.OptionsManager.setOption("StringCourse");
								loc3 = false;
								break loop0;
							default:
								switch(null)
								{
									case "BUFF":
										this.api.kernel.OptionsManager.setOption("Buff");
										loc3 = false;
										break;
									case "MOVABLEBAR":
										this.api.kernel.OptionsManager.setOption("MovableBar",!this.api.kernel.OptionsManager.getOption("MovableBar"));
										loc3 = false;
										break;
									case "MOUNTING":
										this.api.network.Mount.ride();
										loc3 = false;
										break;
									case "FULLSCREEN":
										this.api.kernel.GameManager.isFullScreen = loc0 = !this.api.kernel.GameManager.isFullScreen;
										getURL("FSCommand:" add "fullscreen",loc0);
										loc3 = false;
										break;
									case "ALLOWSCALE":
										this.api.kernel.GameManager.isAllowingScale = loc0 = !this.api.kernel.GameManager.isAllowingScale;
										getURL("FSCommand:" add "allowscale",loc0);
										loc3 = false;
								}
						}
				}
		}
		return loc3;
	}
}

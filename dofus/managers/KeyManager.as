class dofus.managers.KeyManager extends dofus.utils.ApiElement
{
	var _bIsBroadcasting = true;
	var _bPressedKeys = new Array();
	var _bCtrlDown = false;
	var _bShiftDown = true;
	static var _sSelf = null;
	var _nLastTriggerShow = 0;
	function KeyManager(var3)
	{
		super();
		dofus.managers.KeyManager._sSelf = this;
		this.initialize(var3);
	}
	function __get__Broadcasting()
	{
		return this._bIsBroadcasting;
	}
	function __set__Broadcasting(var2)
	{
		this._bIsBroadcasting = var2;
		return this.__get__Broadcasting();
	}
	static function getInstance()
	{
		return dofus.managers.KeyManager._sSelf;
	}
	function initialize(var2)
	{
		super.initialize(var3);
		Key.addListener(this);
		this._aAnyTimeShortcuts = new Array();
		this._aNoChatShortcuts = new Array();
		this._so = SharedObject.getLocal(this.api.datacenter.Player.login + dofus.Constants.GLOBAL_SO_SHORTCUTS_NAME);
		this._nCurrentSet = this.api.kernel.OptionsManager.getOption("ShortcutSet");
		this.loadShortcuts();
	}
	function addShortcutsListener(var2, var3)
	{
		if(this._aListening == undefined)
		{
			this._aListening = new Array();
		}
		var var4 = 0;
		while(var4 < this._aListening.length)
		{
			if(String(this._aListening[var4].o) == String(var3) && this._aListening[var4].m == var2)
			{
				this.removeShortcutsListener(this._aListening[var4].o);
			}
			var4 = var4 + 1;
		}
		this._aListening.unshift({o:var3,m:var2});
	}
	function removeShortcutsListener(var2)
	{
		if(this._aListening == undefined)
		{
			return undefined;
		}
		var var3 = new Array();
		var var4 = 0;
		while(var4 < this._aListening.length)
		{
			if(this._aListening[var4].o == var2)
			{
				var3.push(var4);
			}
			var4 = var4 + 1;
		}
		var3.sort(Array.DESCENDING);
		var var5 = 0;
		while(var5 < var3.length)
		{
			this._aListening.splice(var3[var5],1);
			var5 = var5 + 1;
		}
	}
	function addKeysListener(var2, var3)
	{
		if(this._aKeysListening == undefined)
		{
			this._aKeysListening = new Array();
		}
		var var4 = 0;
		while(var4 < this._aKeysListening.length)
		{
			if(String(this._aKeysListening[var4].o) == String(var3) && this._aKeysListening[var4].m == var2)
			{
				this._aKeysListening[var4] = undefined;
			}
			var4 = var4 + 1;
		}
		this._aKeysListening.unshift({o:var3,m:var2});
	}
	function removeKeysListener(var2)
	{
		if(this._aKeysListening == undefined)
		{
			return undefined;
		}
		var var3 = new Array();
		var var4 = 0;
		while(var4 < this._aKeysListening.length)
		{
			if(this._aKeysListening[var4].o == var2)
			{
				var3.push(var4);
			}
			var4 = var4 + 1;
		}
		var3.sort(Array.DESCENDING);
		var var5 = 0;
		while(var5 < var3.length)
		{
			this._aKeysListening.splice(var3[var5],1);
			var5 = var5 + 1;
		}
	}
	function getDefaultShortcut(var2)
	{
		return this.api.lang.getKeyboardShortcutsKeys(this._nCurrentSet,var2);
	}
	function getCurrentShortcut(var2)
	{
		var var3 = new Array();
		var var4 = 0;
		while(var4 < this._aAnyTimeShortcuts.length)
		{
			if(this._aAnyTimeShortcuts[var4].d == var2)
			{
				var3.push({k:this._aAnyTimeShortcuts[var4].k,c:this._aAnyTimeShortcuts[var4].c,d:this._aAnyTimeShortcuts[var4].l});
			}
			var4 = var4 + 1;
		}
		var var5 = 0;
		while(var5 < this._aNoChatShortcuts.length)
		{
			if(this._aNoChatShortcuts[var5].d == var2)
			{
				var3.push({k:this._aNoChatShortcuts[var5].k,c:this._aNoChatShortcuts[var5].c,d:this._aNoChatShortcuts[var5].l});
			}
			var5 = var5 + 1;
		}
		if(var3.length == 1)
		{
			return var3[0];
		}
		if(var3.length == 2)
		{
			return {k:var3[0].k,c:var3[0].c,d:var3[0].d,k2:var3[1].k,c2:var3[1].c,d2:var3[1].d};
		}
		return undefined;
	}
	function clearCustomShortcuts()
	{
		this._so.clear();
		this.loadShortcuts();
	}
	function askCustomShortcut(var2, var3)
	{
		this.api.ui.loadUIComponent("AskCustomShortcut","AskCustomShortcut",{title:this.api.lang.getText("SHORTCUTS_CUSTOM"),ShortcutCode:var2,IsAlt:var3,Description:this.api.lang.getKeyboardShortcuts()[var2].d});
	}
	function setCustomShortcut(var2, var3, var4, var5, var6)
	{
		if(var2 == undefined || var3 == undefined)
		{
			return undefined;
		}
		var var7 = var2 + (!var3?"_MAIN":"_ALT");
		if(var4 == undefined)
		{
			this._so.data[var7] = undefined;
		}
		else
		{
			if(var5 == undefined)
			{
				var5 = 0;
			}
			if(var6 == undefined || var6 == "")
			{
				var6 = this.api.lang.getKeyStringFromKeyCode(var4);
				var6 = this.api.lang.getControlKeyString(var5) + var6;
			}
			this._so.data[var7] = {s:var2,a:var3,k:var4,c:var5,i:var6};
		}
		this._so.flush();
		this.loadShortcuts();
	}
	function getCustomShortcut(var2, var3)
	{
		var var4 = var2 + (!var3?"_MAIN":"_ALT");
		return this._so.data[var4];
	}
	function isCustomShortcut(var2, var3)
	{
		return this.getCustomShortcut(var2,var3) != undefined;
	}
	function deleteCustomShortcut(var2, var3)
	{
		this.setCustomShortcut(var2,var3);
	}
	function getCurrentDefaultSet()
	{
		var var2 = Number(this.api.lang.getText("SHORTCUTS_DEFAULT_SET"));
		if(var2 < 1)
		{
			var2 = 1;
		}
		return var2;
	}
	function dispatchCtrlState(var2)
	{
		this.dispatchShortcut(!var2?"CTRL_STATE_CHANGED_OFF":"CTRL_STATE_CHANGED_ON");
	}
	function dispatchShortcut(var2)
	{
		if(!this._bIsBroadcasting)
		{
			return false;
		}
		if(this._aListening == undefined)
		{
			return true;
		}
		var var3 = new Array();
		var var4 = true;
		var var5 = 0;
		while(var5 < this._aListening.length)
		{
			if(this._aListening[var5] == undefined || this._aListening[var5].o == undefined)
			{
				var3.push(var5);
			}
			else
			{
				var var6 = eval(String(this._aListening[var5].o) + "." + this._aListening[var5].m).call(this._aListening[var5].o,var2);
				if(var6 != undefined && var6 == false)
				{
					var4 = false;
					break;
				}
			}
			var5 = var5 + 1;
		}
		var3.sort(Array.DESCENDING);
		var var7 = 0;
		while(var7 < var3.length)
		{
			this._aListening.splice(var3[var7],1);
			var7 = var7 + 1;
		}
		if(var4)
		{
			var4 = this.onShortcut(var2);
		}
		return var4;
	}
	function dispatchKey(var2)
	{
		if(!this._bIsBroadcasting)
		{
			return undefined;
		}
		if(this._aKeysListening == undefined)
		{
			return undefined;
		}
		var2 = new ank.utils.(var2).trim().toString();
		if(var2.length == 0)
		{
			return undefined;
		}
		var var3 = new Array();
		var var4 = 0;
		while(var4 < this._aKeysListening.length)
		{
			if(this._aKeysListening[var4] == undefined || this._aKeysListening[var4].o == undefined)
			{
				var3.push(var4);
			}
			else
			{
				eval(String(this._aKeysListening[var4].o) + "." + this._aKeysListening[var4].m).call(this._aKeysListening[var4].o,var2);
			}
			var4 = var4 + 1;
		}
		var3.sort(Array.DESCENDING);
		var var5 = 0;
		while(var5 < var3.length)
		{
			this._aKeysListening.splice(var3[var5],1);
			var5 = var5 + 1;
		}
	}
	function loadShortcuts()
	{
		var var2 = this.api.lang.getKeyboardShortcuts();
		this._aNoChatShortcuts = new Array();
		this._aAnyTimeShortcuts = new Array();
		for(var k in var2)
		{
			var var3 = this.api.lang.getKeyboardShortcutsKeys(this._nCurrentSet,k);
			var var4 = this.getCustomShortcut(k,false);
			if(var4 != undefined && !var2[k].s)
			{
				if(var3.o)
				{
					this._aNoChatShortcuts.push({k:var4.k,c:var4.c,o:var3.o,d:k,l:var4.i,s:var2[k].s});
				}
				else
				{
					this._aAnyTimeShortcuts.push({k:var4.k,c:var4.c,o:var3.o,d:k,l:var4.i,s:var2[k].s});
				}
			}
			else if(var3.o)
			{
				this._aNoChatShortcuts.push({k:var3.k,c:var3.c,o:var3.o,d:k,l:var3.s,s:var2[k].s});
			}
			else if(var3.k != undefined)
			{
				this._aAnyTimeShortcuts.push({k:var3.k,c:var3.c,o:var3.o,d:k,l:var3.s,s:var2[k].s});
			}
			var var5 = this.getCustomShortcut(k,true);
			if(var5 != undefined && !var2[k].s)
			{
				if(var3.o)
				{
					this._aNoChatShortcuts.push({k:var5.k,c:var5.c,o:var3.o,d:k,l:var5.i,s:var2[k].s});
				}
				else
				{
					this._aAnyTimeShortcuts.push({k:var5.k,c:var5.c,o:var3.o,d:k,l:var5.i,s:var2[k].s});
				}
			}
			else if(!_global.isNaN(var3.k2) && var3.k2 != undefined)
			{
				if(var3.o)
				{
					this._aNoChatShortcuts.push({k:var3.k2,c:var3.c2,o:var3.o,d:k,l:var3.s2,s:var2[k].s});
				}
				else
				{
					this._aAnyTimeShortcuts.push({k:var3.k2,c:var3.c2,o:var3.o,d:k,l:var3.s2,s:var2[k].s});
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
			var var6 = this.api.lang.getDefaultConsoleShortcuts();
			var var7 = 0;
			while(var7 < var6.length)
			{
				this._aAnyTimeShortcuts.push({k:var6[var7].k,c:1,o:true,d:"CONSOLE"});
				var7 = var7 + 1;
			}
			var var8 = 0;
			while(var8 < var6.length)
			{
				this._aAnyTimeShortcuts.push({k:var6[var8].k,c:2,o:true,d:"CONSOLESIZE"});
				var8 = var8 + 1;
			}
		}
	}
	function processShortcuts(var2, var3, var4, var5)
	{
		var var6 = true;
		var var7 = 0;
		while(var7 < var2.length)
		{
			if(Number(var2[var7].k) == var3)
			{
				var var8 = false;
				switch(var2[var7].c)
				{
					case 1:
						if(var4 && !var5)
						{
							var8 = true;
						}
						break;
					case 2:
						if(!var4 && var5)
						{
							var8 = true;
						}
						break;
					default:
						if(var0 !== 3)
						{
							if(!var4 && !var5)
							{
								var8 = true;
								break;
							}
							break;
						}
						if(var4 && var5)
						{
							var8 = true;
						}
						break;
				}
				if(var8)
				{
					var6 = this.dispatchShortcut(var2[var7].d);
				}
			}
			var7 = var7 + 1;
		}
		return var6;
	}
	function onSetChange(var2)
	{
		this._nCurrentSet = var2;
		this.loadShortcuts();
	}
	function onKeyDown()
	{
		var var2 = Key.getCode();
		var var3 = Key.getAscii();
		var var4 = Key.isDown(Key.CONTROL);
		var var5 = Key.isDown(Key.SHIFT);
		if(this._lastCtrlState != var4)
		{
			this._lastCtrlState = var4;
			this.dispatchCtrlState(var4);
		}
		if(this._bPressedKeys[var2] != undefined)
		{
			return undefined;
		}
		this._bPressedKeys[var2] = true;
		if(this.api.gfx.spriteHandler.isShowingMonstersTooltip)
		{
			this.api.gfx.spriteHandler.showMonstersTooltip(false);
		}
		if(this.api.gfx.spriteHandler.isPlayerSpritesHidden)
		{
			this.api.gfx.spriteHandler.hidePlayerSprites(false);
		}
		if(!this.processShortcuts(this._aAnyTimeShortcuts,var2,var4,var5))
		{
			return undefined;
		}
		if(Selection.getFocus() != undefined)
		{
			return undefined;
		}
		if(!this.processShortcuts(this._aNoChatShortcuts,var2,var4,var5))
		{
			return undefined;
		}
		if(var3 > 0)
		{
			this.dispatchKey(String.fromCharCode(var3));
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
		var var2 = Key.getCode();
		delete this._bPressedKeys.register2;
	}
	function onShortcut(var2)
	{
		var var3 = true;
		loop0:
		switch(var2)
		{
			case "TOGGLE_FIGHT_INFOS":
				this.api.kernel.OptionsManager.setOption("ChatEffects",!this.api.kernel.OptionsManager.getOption("ChatEffects"));
				var3 = false;
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
					var3 = false;
				}
				break;
			default:
				switch(null)
				{
					case "CONSOLESIZE":
						if(this.api.datacenter.Player.isAuthorized)
						{
							var var4 = this.api.ui.getUIComponent("Debug");
							if(var4 != undefined)
							{
								var4.changeSize();
							}
							var3 = false;
						}
						break loop0;
					case "GRID":
						this.api.kernel.OptionsManager.setOption("Grid");
						var3 = false;
						break loop0;
					case "SHOWMONSTERSTOOLTIP":
						this.api.gfx.spriteHandler.showMonstersTooltip(true);
						var3 = false;
						break loop0;
					case "SHOWTRIGGERS":
						if(!this.api.datacenter.Game.isFight)
						{
							if(getTimer() - this._nLastTriggerShow >= dofus.Constants.CLICK_MIN_DELAY)
							{
								this._nLastTriggerShow = getTimer();
								this.api.gfx.mapHandler.showTriggers();
							}
							var3 = false;
						}
						break loop0;
					case "HIDESPRITES":
						this.api.gfx.spriteHandler.hidePlayerSprites(true);
						var3 = false;
						break loop0;
					case "TRANSPARENCY":
						this.api.kernel.OptionsManager.setOption("Transparency",!this.api.gfx.bGhostView);
						var3 = false;
						break loop0;
					case "SPRITEINFOS":
						this.api.kernel.OptionsManager.setOption("SpriteInfos");
						var3 = false;
						break loop0;
					case "COORDS":
						this.api.kernel.OptionsManager.setOption("MapInfos");
						var3 = false;
						break loop0;
					case "STRINGCOURSE":
						this.api.kernel.OptionsManager.setOption("StringCourse");
						var3 = false;
						break loop0;
					case "BUFF":
						this.api.kernel.OptionsManager.setOption("Buff");
						var3 = false;
						break loop0;
					default:
						switch(null)
						{
							case "MOVABLEBAR":
								this.api.kernel.OptionsManager.setOption("MovableBar",!this.api.kernel.OptionsManager.getOption("MovableBar"));
								var3 = false;
								break;
							case "MOUNTING":
								this.api.network.Mount.ride();
								var3 = false;
								break;
							case "FULLSCREEN":
								this.api.kernel.GameManager.isFullScreen = var0 = !this.api.kernel.GameManager.isFullScreen;
								getURL("FSCommand:" add "fullscreen",var0);
								var3 = false;
								break;
							case "ALLOWSCALE":
								this.api.kernel.GameManager.isAllowingScale = var0 = !this.api.kernel.GameManager.isAllowingScale;
								getURL("FSCommand:" add "allowscale",var0);
								var3 = false;
						}
				}
		}
		return var3;
	}
}

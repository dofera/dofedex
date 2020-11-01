class dofus.Electron extends dofus.utils.ApiElement
{
	var _bEnabled = _root.electron != undefined;
	var _bUseRsaCrypto = _root.RSACrypto != undefined;
	var _bFocused = true;
	function Electron(var3)
	{
		super();
		flash.external.ExternalInterface.addCallback("onRightClick",this,this.onRightClick);
		flash.external.ExternalInterface.addCallback("onWindowFocus",this,this.onWindowFocus);
		flash.external.ExternalInterface.addCallback("onWindowBlur",this,this.onWindowBlur);
		this.initialize(var3);
	}
	function __get__enabled()
	{
		return this._bEnabled;
	}
	function __get__useRsaCrypto()
	{
		return this._bUseRsaCrypto;
	}
	function __get__isWindowFocused()
	{
		return !this._bEnabled || this._bFocused;
	}
	function onWindowFocus()
	{
		if(this._bFocused)
		{
			return undefined;
		}
		var var2 = this.api.gfx.spriteHandler.getSprites().getItems();
		for(var var3 in var2)
		{
			if(!(!var3.isInMove || var3.moveSpeedType == undefined))
			{
				var var4 = (ank.battlefield.mc.Sprite)var3.mc;
				var4.setAnim(var3.moveAnimation != undefined?var3.moveAnimation:var3.moveSpeedType);
			}
		}
		this._bFocused = true;
	}
	function onWindowBlur()
	{
		if(!this._bFocused)
		{
			return undefined;
		}
		var var2 = this.api.gfx.spriteHandler.getSprites().getItems();
		for(var var3 in var2)
		{
			if(var3.isInMove)
			{
				var var4 = (ank.battlefield.mc.Sprite)var3.mc;
				var4.setAnim("static");
			}
		}
		this._bFocused = false;
	}
	function initialize(var2)
	{
		super.initialize(var3);
	}
	function makeReport(var2, var3, var4, var5, var6, var7, var8, var9, var10)
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		if(var10 == undefined)
		{
			var10 = "";
		}
		if(var6 == undefined)
		{
			var6 = "";
		}
		if(var9 == undefined)
		{
			var9 = "";
		}
		var var11 = this.api.datacenter.Basics.aks_current_server.label;
		flash.external.ExternalInterface.call("makeReport",var11,var2,var3,var4,var5,var6,var7,var8,var9,var10);
		var var12 = "Report written.";
		this.api.kernel.showMessage(undefined,var12,"COMMANDS_CHAT");
	}
	function getRandomNetworkKey()
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		return String(flash.external.ExternalInterface.call("getRandomNetworkKey"));
	}
	function setIngameDiscordActivity()
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		var var2 = "Dofus Retro v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION;
		var var3 = this.api.lang.getText("CURRENT_SERVER",[this.api.datacenter.Basics.aks_current_server.label]);
		var var4 = this.api.datacenter.Player.Name;
		var var5 = this.api.datacenter.Basics.dofusPseudo;
		var var6 = this.api.lang.getClassText(this.api.datacenter.Player.Guild).ln;
		var var7 = this.api.datacenter.Player.Guild;
		var var8 = this.api.datacenter.Player.Sex;
		flash.external.ExternalInterface.call("setIngameDiscordActivity",var2,var3,var4,var5,var6,var7,var8);
	}
	function log(var2, var3)
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		if(var3 == undefined)
		{
			var3 = false;
		}
		flash.external.ExternalInterface.call("userLog",var2,var3);
	}
	function consoleLog(var2, var3)
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		flash.external.ExternalInterface.call("consoleLog",var2,var3);
	}
	function chatLog(var2)
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		flash.external.ExternalInterface.call("chatLog",var2);
	}
	function debugRequest(var2, var3)
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		var var4 = this.api.datacenter.Player.Name;
		var var5 = this.api.datacenter.Basics.aks_current_server.label;
		flash.external.ExternalInterface.call("debugRequest",var2,dofus.Constants.LOG_DATAS,var3,var4,var5);
	}
	function setLoginDiscordActivity()
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		var var2 = "Client v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION;
		var var3 = "Build " + dofus.Constants.VERSIONDATE;
		flash.external.ExternalInterface.call("setLoginDiscordActivity",var2,var3);
	}
	function makeNotification(var2)
	{
		if(!this._bEnabled || var2 == undefined)
		{
			return undefined;
		}
		var2 = var2.split("<b>").join("");
		var2 = var2.split("</b>").join("");
		var2 = var2.split("<u>").join("");
		var2 = var2.split("</u>").join("");
		flash.external.ExternalInterface.call("makeNotification",var2);
	}
	function updateWindowTitle(var2)
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		var var3 = "";
		if(var2 != undefined)
		{
			var3 = var2 + " - ";
		}
		var3 = var3 + "Dofus Retro v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION;
		flash.external.ExternalInterface.call("changeTitle",var3);
	}
	function onRightClick()
	{
		if(this.api.gfx.rollOverMcSprite != undefined && !(this.api.gfx.rollOverMcSprite.data instanceof dofus.datacenter.Character))
		{
			this.api.gfx.onSpriteRelease(this.api.gfx.rollOverMcSprite,true);
			return undefined;
		}
		if(this.api.gfx.rollOverMcObject != undefined)
		{
			this.api.gfx.onObjectRelease(this.api.gfx.rollOverMcObject,true);
			return undefined;
		}
		var var2 = 0;
		while(var2 < dofus.Constants.INTERFACES_MANIPULATING_ITEMS.length)
		{
			var var3 = this.api.ui.getUIComponent(dofus.Constants.INTERFACES_MANIPULATING_ITEMS[var2]);
			var var4 = var3.currentOverItem;
			if(var4 != undefined)
			{
				var3.itemViewer.createActionPopupMenu(var4);
				return undefined;
			}
			var2 = var2 + 1;
		}
		if(this.api.datacenter.Basics.inGame && this.api.datacenter.Player.isAuthorized)
		{
			var var5 = this.api.kernel.AdminManager.getAdminPopupMenu(this.api.datacenter.Player.Name,true);
			var5.addItem("Client v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + " >>",this,this.printRightClickPopupMenu);
			var5.items.unshift(var5.items.pop());
			var5.show(_root._xmouse,_root._ymouse,true);
		}
		else
		{
			this.printRightClickPopupMenu();
		}
	}
	function printRightClickPopupMenu()
	{
		var var2 = this.api.ui.createPopupMenu();
		var2.addStaticItem("DOFUS RETRO Client v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION);
		var2.addStaticItem("Flash player " + System.capabilities.version);
		var o = new Object();
		var api = this.api;
		var gapi = this.api.ui;
		o.selectQualities = function()
		{
			var var2 = gapi.createPopupMenu();
			var2.addStaticItem(api.lang.getText("OPTION_DEFAULTQUALITY"));
			var2.addItem(api.lang.getText("QUALITY_LOW"),o,o.setQualityOption,["low"],o.getOption("DefaultQuality") != "low");
			var2.addItem(api.lang.getText("QUALITY_MEDIUM"),o,o.setQualityOption,["medium"],o.getOption("DefaultQuality") != "medium");
			var2.addItem(api.lang.getText("QUALITY_HIGH"),o,o.setQualityOption,["high"],o.getOption("DefaultQuality") != "high");
			var2.addItem(api.lang.getText("QUALITY_BEST"),o,o.setQualityOption,["best"],o.getOption("DefaultQuality") != "best");
			var2.show();
		};
		o.setQualityOption = function(var2)
		{
			o.setOption("DefaultQuality",var2);
		};
		o.setOption = function(var2, var3)
		{
			api.kernel.OptionsManager.setOption(var2,var3);
		};
		o.getOption = function(var2)
		{
			return api.kernel.OptionsManager.getOption(var2);
		};
		var2.addItem(api.lang.getText("OPTION_DEFAULTQUALITY") + " >>",o,o.selectQualities);
		var2.addItem(api.lang.getText("OPTIONS"),gapi,gapi.loadUIComponent,["Options","Options",{_y:(gapi.screenHeight != 432?0:-50)},{bAlwaysOnTop:true}]);
		var2.addItem(api.lang.getText("ZOOM"),api.ui,api.ui.loadUIAutoHideComponent,["Zoom","Zoom",{sprite:api.datacenter.Player.data}],api.gfx.isMapBuild && api.gfx.isContainerVisible);
		var2.addItem(api.lang.getText("OPTION_MOVABLEBAR"),o,o.setOption,["MovableBar",!o.getOption("MovableBar")]);
		var2.show(_root._xmouse,_root._ymouse,true);
	}
}

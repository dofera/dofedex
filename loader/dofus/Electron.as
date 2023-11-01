class dofus.Electron extends dofus.utils.ApiElement
{
	var _bEnabled = _root.electron != undefined;
	var _bUseRsaCrypto = _root.RSACrypto != undefined;
	var _bFocused = true;
	function Electron(oAPI)
	{
		super();
		flash.external.ExternalInterface.addCallback("onRightClick",this,this.onRightClick);
		flash.external.ExternalInterface.addCallback("onWindowFocus",this,this.onWindowFocus);
		flash.external.ExternalInterface.addCallback("onWindowBlur",this,this.onWindowBlur);
		this.initialize(oAPI);
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
		for(var sID in var2)
		{
			var var3 = var2[sID];
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
		for(var sID in var2)
		{
			var var3 = var2[sID];
			if(var3.isInMove)
			{
				var var4 = (ank.battlefield.mc.Sprite)var3.mc;
				var4.setAnim("static");
			}
		}
		this._bFocused = false;
	}
	function initialize(oAPI)
	{
		super.initialize(oAPI);
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
		if(!this._bEnabled)
		{
			return undefined;
		}
		_root.menu.onRightClick(this.api);
	}
}

class dofus.Electron extends dofus.utils.ApiElement
{
	var _bEnabled = _root.electron != undefined;
	var _bUseRsaCrypto = _root.RSACrypto != undefined;
	function Electron(var3)
	{
		super();
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
	function initialize(var2)
	{
		super.initialize(var3);
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
}

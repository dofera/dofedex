class dofus.Electron extends dofus.utils.ApiElement
{
	var _bEnabled = _root.electron != undefined;
	var _bUseRsaCrypto = _root.RSACrypto != undefined;
	function Electron(loc3)
	{
		super();
		this.initialize(loc3);
	}
	function __get__enabled()
	{
		return this._bEnabled;
	}
	function __get__useRsaCrypto()
	{
		return this._bUseRsaCrypto;
	}
	function initialize(loc2)
	{
		super.initialize(loc3);
	}
	function setIngameDiscordActivity()
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		var loc2 = "Dofus Retro v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION;
		var loc3 = this.api.lang.getText("CURRENT_SERVER",[this.api.datacenter.Basics.aks_current_server.label]);
		var loc4 = this.api.datacenter.Player.Name;
		var loc5 = this.api.datacenter.Basics.dofusPseudo;
		var loc6 = this.api.lang.getClassText(this.api.datacenter.Player.Guild).ln;
		var loc7 = this.api.datacenter.Player.Guild;
		var loc8 = this.api.datacenter.Player.Sex;
		flash.external.ExternalInterface.call("setIngameDiscordActivity",loc2,loc3,loc4,loc5,loc6,loc7,loc8);
	}
	function log(loc2, loc3)
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		if(loc3 == undefined)
		{
			loc3 = false;
		}
		flash.external.ExternalInterface.call("userLog",loc2,loc3);
	}
	function consoleLog(loc2, loc3)
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		flash.external.ExternalInterface.call("consoleLog",loc2,loc3);
	}
	function debugRequest(loc2, loc3)
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		var loc4 = this.api.datacenter.Player.Name;
		var loc5 = this.api.datacenter.Basics.aks_current_server.label;
		flash.external.ExternalInterface.call("debugRequest",loc2,dofus.Constants.LOG_DATAS,loc3,loc4,loc5);
	}
	function setLoginDiscordActivity()
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		var loc2 = "Client v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION;
		var loc3 = "Build " + dofus.Constants.VERSIONDATE;
		flash.external.ExternalInterface.call("setLoginDiscordActivity",loc2,loc3);
	}
	function makeNotification(loc2)
	{
		if(!this._bEnabled || loc2 == undefined)
		{
			return undefined;
		}
		loc2 = loc2.split("<b>").join("");
		loc2 = loc2.split("</b>").join("");
		loc2 = loc2.split("<u>").join("");
		loc2 = loc2.split("</u>").join("");
		flash.external.ExternalInterface.call("makeNotification",loc2);
	}
	function updateWindowTitle(loc2)
	{
		if(!this._bEnabled)
		{
			return undefined;
		}
		var loc3 = "";
		if(loc2 != undefined)
		{
			loc3 = loc2 + " - ";
		}
		loc3 = loc3 + "Dofus Retro v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION;
		flash.external.ExternalInterface.call("changeTitle",loc3);
	}
}

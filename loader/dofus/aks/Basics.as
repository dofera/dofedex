class dofus.aks.Basics extends dofus.aks.Handler
{
	function Basics(var2, var3)
	{
		super.initialize(var3,var4);
	}
	function autorisedCommand(var2)
	{
		this.aks.send("BA" + var2,false,undefined,true);
	}
	function autorisedMoveCommand(var2, var3)
	{
		this.aks.send("BaM" + var2 + "," + var3,false);
	}
	function autorisedKickCommand(var2, var3, var4)
	{
		this.aks.send("BaK" + var2 + "|" + var3 + "|" + var4,false);
	}
	function whoAmI()
	{
		this.whoIs("");
	}
	function whoIs(var2)
	{
		this.aks.send("BW" + var2);
	}
	function kick(var2)
	{
		this.aks.send("BQ" + var2,false);
	}
	function away()
	{
		this.aks.send("BYA",false);
	}
	function invisible()
	{
		this.aks.send("BYI",false);
	}
	function getDate()
	{
		this.aks.send("BD",false);
	}
	function fileCheckAnswer(var2, var3)
	{
		this.aks.send("BC" + var2 + ";" + var3,false);
	}
	function sanctionMe(var2, var3)
	{
		this.aks.send("BK" + var2 + "|" + var3,false);
	}
	function averagePing()
	{
		this.aks.send("Bp" + this.api.network.getAveragePing() + "|" + this.api.network.getAveragePingPacketsCount() + "|" + this.api.network.getAveragePingBufferSize(),false);
	}
	function askReportInfos(var2, var3, var4)
	{
		this.aks.send("Br" + var2 + "|" + var3 + "|" + (!var4?"0":"1"));
	}
	function onReportInfos(var2)
	{
		var var3 = this.api.datacenter.Temporary.Report;
		if(var3 == undefined)
		{
			return undefined;
		}
		var var4 = var2.charAt(0);
		var var5 = var2.substring(1);
		if((var var0 = var4) !== "t")
		{
			switch(null)
			{
				case "s":
					if(var3.sanctionnatedAccounts == undefined)
					{
						var3.sanctionnatedAccounts = var5;
					}
					else
					{
						var3.sanctionnatedAccounts = var3.sanctionnatedAccounts + ("\n\n" + var5);
					}
					break;
				case "p":
					var3.penal = var5;
					break;
				case "f":
					var3.findAccounts = var5;
					break;
				case "#":
					this.api.ui.unloadUIComponent("FightsInfos");
					var var7 = (dofus.graphics.gapi.ui.MakeReport)this.api.ui.getUIComponent("MakeReport");
					if(var7 == undefined)
					{
						var var8 = var3.targetPseudos;
						var var9 = var3.reason;
						var var10 = var3.description;
						var var11 = var3.jailDialog;
						var var12 = var3.isAllAccounts;
						var var13 = var3.penal;
						var var14 = var3.findAccounts;
						this.api.ui.loadUIComponent("MakeReport","MakeReport",{targetPseudos:var8,reason:var9,description:var10,jailDialog:var11,isAllAccounts:var12,penal:var13,findAccounts:var14});
						break;
					}
					var7.update();
					break;
			}
		}
		else
		{
			var var6 = var5.split("|");
			if(var3.targetAccountPseudo == undefined)
			{
				var3.targetAccountPseudo = var6[0];
				var3.targetAccountId = var6[1];
			}
		}
	}
	function onPopupMessage(var2)
	{
		var var3 = var2;
		if(var3 != undefined && var3.length > 0)
		{
			this.api.kernel.showMessage(undefined,var3,"WAIT_BOX");
		}
	}
	function onAuthorizedInterfaceOpen(var2)
	{
		this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("A_GIVE_U_RIGHTS",[var2]),"ERROR_BOX");
		this.api.datacenter.Player.isAuthorized = true;
	}
	function onAuthorizedInterfaceClose(var2)
	{
		this.api.ui.unloadUIComponent("Debug");
		this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("A_REMOVE_U_RIGHTS",[var2]),"ERROR_BOX");
		this.api.datacenter.Player.isAuthorized = false;
	}
	function onAuthorizedCommand(var2, var3)
	{
		if(var2)
		{
			var var4 = Number(var3.charAt(0));
			var var5 = "DEBUG_LOG";
			if((var var0 = var4) !== 1)
			{
				if(var0 === 2)
				{
					var5 = "DEBUG_INFO";
				}
			}
			else
			{
				var5 = "DEBUG_ERROR";
			}
			if(this.api.ui.getUIComponent("Debug") == undefined)
			{
				this.api.ui.loadUIComponent("Debug","Debug",undefined,{bStayIfPresent:true,bAlwaysOnTop:true});
			}
			var var6 = var3.substr(1);
			var var7 = this.api.ui.getUIComponent("Debug").fileOutput;
			var6 = this.api.kernel.DebugManager.getFormattedMessage(var6);
			if(this.api.electron.enabled && var7 != 0)
			{
				this.api.electron.consoleLog(var5,var6);
				if(var7 == 2)
				{
					return undefined;
				}
			}
			this.api.kernel.showMessage(undefined,var6,var5);
			if(dofus.Constants.SAVING_THE_WORLD)
			{
				if(var6.indexOf("BotKick inactif") == 0)
				{
					dofus.SaveTheWorld.getInstance().nextAction();
				}
			}
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",["/a"]),"ERROR_CHAT");
		}
	}
	function onAuthorizedCommandPrompt(var2)
	{
		this.api.datacenter.Basics.aks_a_prompt = var2;
		this.api.ui.getUIComponent("Debug").setPrompt(var2);
	}
	function onAuthorizedCommandClear()
	{
		this.api.ui.getUIComponent("Debug").clear();
	}
	function onAuthorizedLine(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = var3[2];
		var var7 = this.api.datacenter.Basics.aks_a_logs.split("<br/>");
		var var8 = "<font color=\"#FFFFFF\">" + var6 + "</font>";
		switch(var5)
		{
			case 1:
				var8 = "<font color=\"#FF0000\">" + var6 + "</font>";
				break;
			case 2:
				var8 = "<font color=\"#00FF00\">" + var6 + "</font>";
		}
		if(!_global.isNaN(var4) && var4 < var7.length)
		{
			var7[var7.length - var4] = var8;
			this.api.datacenter.Basics.aks_a_logs = var7.join("<br/>");
			this.api.ui.getUIComponent("Debug").refresh();
		}
	}
	function onReferenceTime(var2)
	{
		var var3 = Number(var2);
		this.api.kernel.NightManager.setReferenceTime(var3);
	}
	function onDate(var2)
	{
		this.api.datacenter.Basics.lastDateUpdate = getTimer();
		var var3 = var2.split("|");
		this.api.kernel.NightManager.setReferenceDate(Number(var3[0]),Number(var3[1]),Number(var3[2]));
	}
	function onWhoIs(var2, var3)
	{
		if(var2)
		{
			var var4 = var3.split("|");
			if(var4.length != 4)
			{
				return undefined;
			}
			var var5 = var4[0];
			var var6 = var4[1];
			var var7 = var4[2];
			var var8 = Number(var4[3]) == -1?this.api.lang.getText("UNKNOWN_AREA"):this.api.lang.getMapAreaText(Number(var4[3])).n;
			if(var5.toLowerCase() == this.api.datacenter.Basics.login)
			{
				switch(var6)
				{
					case "1":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("I_AM_IN_SINGLE_GAME",[var7,var5,var8]),"COMMANDS_CHAT");
						break;
					case "2":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("I_AM_IN_GAME",[var7,var5,var8]),"COMMANDS_CHAT");
				}
			}
			else
			{
				switch(var6)
				{
					case "1":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("IS_IN_SINGLE_GAME",[var7,var5,var8]),"COMMANDS_CHAT");
						break;
					case "2":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("IS_IN_GAME",[var7,var5,var8]),"COMMANDS_CHAT");
				}
			}
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_FIND_ACCOUNT_OR_CHARACTER",[var3]),"ERROR_CHAT");
		}
	}
	function onFileCheck(var2)
	{
		var var3 = var2.split(";");
		var var4 = Number(var3[0]);
		var var5 = var3[1];
		if(var5.indexOf("bright.swf") == 0)
		{
			this.api.network.send("BC" + var4 + ";-1",false);
			var2 = var5.substr(10);
			this.onBrightCell(var2);
		}
		else
		{
			dofus.utils.Api.getInstance().checkFileSize(var5,var4);
		}
	}
	function onBrightCell(var2)
	{
		var var3 = var2.split("/");
		var var4 = Number(var3[0]);
		if(var4 == 0)
		{
			this.api.gfx.unSelect(true);
		}
		else if(var2.charAt(0) == "-")
		{
			var var5 = var3[0].substr(1).split(".");
			this.api.gfx.unSelect(false,var5,"brightedPosition");
		}
		else
		{
			var var6 = var3[0].split(".");
			var var7 = _global.parseInt(var3[1],16);
			this.api.gfx.select(var6,var7,"brightedPosition");
		}
	}
	function onAveragePing(var2)
	{
		this.averagePing();
	}
	function onSubscriberRestriction(var2)
	{
		var var3 = var2.charAt(0) == "+";
		if(var3)
		{
			var var4 = Number(var2.substr(1));
			if(var4 != 10)
			{
				this.api.ui.loadUIComponent("PayZoneDialog2","PayZoneDialog2",{dialogID:var4,name:"El Pemy",gfx:"9059"});
			}
			else
			{
				this.api.ui.loadUIComponent("PayZone","PayZone",{dialogID:var4},{bForceLoad:true});
				this.api.datacenter.Basics.payzone_isFirst = false;
			}
		}
		else
		{
			this.api.ui.unloadUIComponent("PayZone");
		}
	}
}

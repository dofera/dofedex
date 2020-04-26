class dofus.aks.Basics extends dofus.aks.Handler
{
	function Basics(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function autorisedCommand(loc2)
	{
		this.aks.send("BA" + loc2,false,undefined,true);
	}
	function autorisedMoveCommand(loc2, loc3)
	{
		this.aks.send("BaM" + loc2 + "," + loc3,false);
	}
	function autorisedKickCommand(loc2, loc3, loc4)
	{
		this.aks.send("BaK" + loc2 + "|" + loc3 + "|" + loc4,false);
	}
	function whoAmI()
	{
		this.whoIs("");
	}
	function whoIs(loc2)
	{
		this.aks.send("BW" + loc2);
	}
	function kick(loc2)
	{
		this.aks.send("BQ" + loc2,false);
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
	function fileCheckAnswer(loc2, loc3)
	{
		this.aks.send("BC" + loc2 + ";" + loc3,false);
	}
	function sanctionMe(loc2, loc3)
	{
		this.aks.send("BK" + loc2 + "|" + loc3,false);
	}
	function averagePing()
	{
		this.aks.send("Bp" + this.api.network.getAveragePing() + "|" + this.api.network.getAveragePingPacketsCount() + "|" + this.api.network.getAveragePingBufferSize(),false);
	}
	function onPopupMessage(loc2)
	{
		var loc3 = loc2;
		if(loc3 != undefined && loc3.length > 0)
		{
			this.api.kernel.showMessage(undefined,loc3,"WAIT_BOX");
		}
	}
	function onAuthorizedInterfaceOpen(loc2)
	{
		this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("A_GIVE_U_RIGHTS",[loc2]),"ERROR_BOX");
		this.api.datacenter.Player.isAuthorized = true;
	}
	function onAuthorizedInterfaceClose(loc2)
	{
		this.api.ui.unloadUIComponent("Debug");
		this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("A_REMOVE_U_RIGHTS",[loc2]),"ERROR_BOX");
		this.api.datacenter.Player.isAuthorized = false;
	}
	function onAuthorizedCommand(loc2, loc3)
	{
		if(loc2)
		{
			var loc4 = Number(loc3.charAt(0));
			var loc5 = "DEBUG_LOG";
			switch(loc4)
			{
				case 1:
					loc5 = "DEBUG_ERROR";
					break;
				case 2:
					loc5 = "DEBUG_INFO";
			}
			if(this.api.ui.getUIComponent("Debug") == undefined)
			{
				this.api.ui.loadUIComponent("Debug","Debug",undefined,{bStayIfPresent:true,bAlwaysOnTop:true});
			}
			var loc6 = loc3.substr(1);
			var loc7 = this.api.ui.getUIComponent("Debug").fileOutput;
			loc6 = this.api.kernel.DebugManager.getFormattedMessage(loc6);
			if(this.api.electron.enabled && loc7 != 0)
			{
				this.api.electron.consoleLog(loc5,loc6);
				if(loc7 == 2)
				{
					return undefined;
				}
			}
			this.api.kernel.showMessage(undefined,loc6,loc5);
			if(dofus.Constants.SAVING_THE_WORLD)
			{
				if(loc6.indexOf("BotKick inactif") == 0)
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
	function onAuthorizedCommandPrompt(loc2)
	{
		this.api.datacenter.Basics.aks_a_prompt = loc2;
		this.api.ui.getUIComponent("Debug").setPrompt(loc2);
	}
	function onAuthorizedCommandClear()
	{
		this.api.ui.getUIComponent("Debug").clear();
	}
	function onAuthorizedLine(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		var loc6 = loc3[2];
		var loc7 = this.api.datacenter.Basics.aks_a_logs.split("<br/>");
		var loc8 = "<font color=\"#FFFFFF\">" + loc6 + "</font>";
		switch(loc5)
		{
			case 1:
				loc8 = "<font color=\"#FF0000\">" + loc6 + "</font>";
				break;
			case 2:
				loc8 = "<font color=\"#00FF00\">" + loc6 + "</font>";
		}
		if(!_global.isNaN(loc4) && loc4 < loc7.length)
		{
			loc7[loc7.length - loc4] = loc8;
			this.api.datacenter.Basics.aks_a_logs = loc7.join("<br/>");
			this.api.ui.getUIComponent("Debug").refresh();
		}
	}
	function onReferenceTime(loc2)
	{
		var loc3 = Number(loc2);
		this.api.kernel.NightManager.setReferenceTime(loc3);
	}
	function onDate(loc2)
	{
		this.api.datacenter.Basics.lastDateUpdate = getTimer();
		var loc3 = loc2.split("|");
		this.api.kernel.NightManager.setReferenceDate(Number(loc3[0]),Number(loc3[1]),Number(loc3[2]));
	}
	function onWhoIs(loc2, loc3)
	{
		if(loc2)
		{
			var loc4 = loc3.split("|");
			if(loc4.length != 4)
			{
				return undefined;
			}
			var loc5 = loc4[0];
			var loc6 = loc4[1];
			var loc7 = loc4[2];
			var loc8 = Number(loc4[3]) == -1?this.api.lang.getText("UNKNOWN_AREA"):this.api.lang.getMapAreaText(Number(loc4[3])).n;
			if(loc5.toLowerCase() == this.api.datacenter.Basics.login)
			{
				switch(loc6)
				{
					case "1":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("I_AM_IN_SINGLE_GAME",[loc7,loc5,loc8]),"INFO_CHAT");
						break;
					case "2":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("I_AM_IN_GAME",[loc7,loc5,loc8]),"INFO_CHAT");
				}
			}
			else if((loc0 = loc6) !== "1")
			{
				if(loc0 === "2")
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("IS_IN_GAME",[loc7,loc5,loc8]),"INFO_CHAT");
				}
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("IS_IN_SINGLE_GAME",[loc7,loc5,loc8]),"INFO_CHAT");
			}
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_FIND_ACCOUNT_OR_CHARACTER",[loc3]),"ERROR_CHAT");
		}
	}
	function onFileCheck(loc2)
	{
		var loc3 = loc2.split(";");
		var loc4 = Number(loc3[0]);
		var loc5 = loc3[1];
		if(loc5.indexOf("bright.swf") == 0)
		{
			this.api.network.send("BC" + loc4 + ";-1",false);
			loc2 = loc5.substr(10);
			this.onBrightCell(loc2);
		}
		else
		{
			dofus.utils.Api.getInstance().checkFileSize(loc5,loc4);
		}
	}
	function onBrightCell(loc2)
	{
		var loc3 = loc2.split("/");
		var loc4 = Number(loc3[0]);
		if(loc4 == 0)
		{
			this.api.gfx.unSelect(true);
		}
		else if(loc2.charAt(0) == "-")
		{
			var loc5 = loc3[0].substr(1).split(".");
			this.api.gfx.unSelect(false,loc5,"brightedPosition");
		}
		else
		{
			var loc6 = loc3[0].split(".");
			var loc7 = _global.parseInt(loc3[1],16);
			this.api.gfx.select(loc6,loc7,"brightedPosition");
		}
	}
	function onAveragePing(loc2)
	{
		this.averagePing();
	}
	function onSubscriberRestriction(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		if(loc3)
		{
			var loc4 = Number(loc2.substr(1));
			if(loc4 != 10)
			{
				this.api.ui.loadUIComponent("PayZoneDialog2","PayZoneDialog2",{dialogID:loc4,name:"El Pemy",gfx:"9059"});
			}
			else
			{
				this.api.ui.loadUIComponent("PayZone","PayZone",{dialogID:loc4},{bForceLoad:true});
				this.api.datacenter.Basics.payzone_isFirst = false;
			}
		}
		else
		{
			this.api.ui.unloadUIComponent("PayZone");
		}
	}
}

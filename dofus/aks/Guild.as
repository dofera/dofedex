class dofus.aks.Guild extends dofus.aks.Handler
{
	function Guild(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function create(loc2, loc3, loc4, loc5, loc6)
	{
		this.aks.send("gC" + loc2 + "|" + loc3 + "|" + loc4 + "|" + loc5 + "|" + loc6);
	}
	function leave()
	{
		this.aks.send("gV");
	}
	function leaveTaxInterface()
	{
		this.aks.send("gITV",false);
	}
	function invite(loc2)
	{
		this.aks.send("gJR" + loc2);
	}
	function acceptInvitation(loc2)
	{
		this.aks.send("gJK" + loc2);
	}
	function refuseInvitation(loc2)
	{
		this.aks.send("gJE" + loc2,false);
	}
	function getInfosGeneral()
	{
		this.aks.send("gIG",true);
	}
	function getInfosMembers()
	{
		this.aks.send("gIM",true);
	}
	function getInfosBoosts()
	{
		this.aks.send("gIB",true);
	}
	function getInfosTaxCollector()
	{
		this.aks.send("gIT",false);
	}
	function getInfosMountPark()
	{
		this.aks.send("gIF",false);
	}
	function getInfosGuildHouses()
	{
		this.aks.send("gIH",false);
	}
	function bann(loc2)
	{
		this.aks.send("gK" + loc2);
	}
	function changeMemberProfil(loc2)
	{
		this.aks.send("gP" + loc2.id + "|" + loc2.rank + "|" + loc2.percentxp + "|" + loc2.rights.value,true);
	}
	function boostCharacteristic(loc2)
	{
		var loc3 = loc2;
		switch(loc3)
		{
			case "c":
				loc3 = "k";
				break;
			case "w":
				loc3 = "o";
		}
		this.aks.send("gB" + loc3,true);
	}
	function boostSpell(loc2)
	{
		this.aks.send("gb" + loc2,true);
	}
	function hireTaxCollector()
	{
		this.aks.send("gH");
	}
	function joinTaxCollector(loc2)
	{
		this.aks.send("gTJ" + loc2,false);
	}
	function leaveTaxCollector(loc2, loc3)
	{
		this.aks.send("gTV" + loc2 + (loc3 == undefined?"":"|" + loc3),false);
	}
	function removeTaxCollector(loc2)
	{
		this.aks.send("gF" + loc2,false);
	}
	function teleportToGuildHouse(loc2)
	{
		this.aks.send("gh" + loc2,false);
	}
	function teleportToGuildFarm(loc2)
	{
		this.aks.send("gf" + loc2,false);
	}
	function onNew()
	{
		this.api.ui.loadUIComponent("CreateGuild","CreateGuild");
	}
	function onCreate(loc2, loc3)
	{
		if(loc2)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_CREATED"),"INFO_CHAT");
			this.api.ui.loadUIAutoHideComponent("Guild","Guild",{currentTab:"Members"},{bStayIfPresent:true});
		}
		else
		{
			switch(loc3)
			{
				case "an":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_CREATE_ALLREADY_USE_NAME"),"ERROR_BOX");
					break;
				case "ae":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_CREATE_ALLREADY_USE_EMBLEM"),"ERROR_BOX");
					break;
				case "a":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_CREATE_ALLREADY_IN_GUILD"),"ERROR_BOX");
			}
			this.api.ui.getUIComponent("CreateGuild").enabled = true;
		}
	}
	function onStats(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0];
		var loc5 = _global.parseInt(loc3[1],36);
		var loc6 = _global.parseInt(loc3[2],36);
		var loc7 = _global.parseInt(loc3[3],36);
		var loc8 = _global.parseInt(loc3[4],36);
		var loc9 = _global.parseInt(loc3[5],36);
		if(this.api.datacenter.Player.guildInfos == undefined)
		{
			this.api.datacenter.Player.guildInfos = new dofus.datacenter.(loc4,loc5,loc6,loc7,loc8,loc9);
		}
		else
		{
			this.api.datacenter.Player.guildInfos.initialize(loc4,loc5,loc6,loc7,loc8,loc9);
		}
	}
	function onInfosGeneral(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0] == "1";
		var loc5 = Number(loc3[1]);
		var loc6 = Number(loc3[2]);
		var loc7 = Number(loc3[3]);
		var loc8 = Number(loc3[4]);
		this.api.datacenter.Player.guildInfos.setGeneralInfos(loc4,loc5,loc6,loc7,loc8);
	}
	function onInfosMembers(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = loc2.substr(1).split("|");
		var loc5 = this.api.datacenter.Player.guildInfos;
		var loc6 = 0;
		while(loc6 < loc4.length)
		{
			var loc7 = loc4[loc6].split(";");
			var loc8 = new Object();
			loc8.id = Number(loc7[0]);
			if(loc3)
			{
				var loc9 = loc5.members.length == 0;
				loc8.name = loc7[1];
				loc8.level = Number(loc7[2]);
				loc8.gfx = Number(loc7[3]);
				loc8.rank = Number(loc7[4]);
				loc8.rankOrder = this.api.lang.getRankInfos(loc8.rank).o;
				loc8.winxp = Number(loc7[5]);
				loc8.percentxp = Number(loc7[6]);
				loc8.rights = new dofus.datacenter.(Number(loc7[7]));
				loc8.state = Number(loc7[8]);
				loc8.alignement = Number(loc7[9]);
				loc8.lastConnection = Number(loc7[10]);
				loc8.isLocalPlayer = loc8.id == this.api.datacenter.Player.ID;
				if(loc9)
				{
					loc5.members.push(loc8);
				}
				else
				{
					var loc10 = loc5.members.findFirstItem("id",loc8.id);
					if(loc10.index != -1)
					{
						loc5.members.updateItem(loc10.index,loc8);
					}
					else
					{
						loc5.members.push(loc8);
					}
				}
				loc5.members.sortOn("rankOrder",Array.NUMERIC);
			}
			else
			{
				var loc11 = loc5.members.findFirstItem("id",loc8.id);
				if(loc11.index != -1)
				{
					loc5.members.removeItems(loc11.index,1);
				}
			}
			loc6 = loc6 + 1;
		}
		loc5.setMembers();
	}
	function onInfosBoosts(loc2)
	{
		if(loc2.length == 0)
		{
			this.api.datacenter.Player.guildInfos.setNoBoosts();
		}
		else
		{
			var loc3 = loc2.split("|");
			var loc4 = Number(loc3[0]);
			var loc5 = Number(loc3[1]);
			var loc6 = Number(loc3[2]);
			var loc7 = Number(loc3[3]);
			var loc8 = Number(loc3[4]);
			var loc9 = Number(loc3[5]);
			var loc10 = Number(loc3[6]);
			var loc11 = Number(loc3[7]);
			var loc12 = Number(loc3[8]);
			var loc13 = Number(loc3[9]);
			loc3.splice(0,10);
			var loc14 = 0;
			while(loc14 < loc3.length)
			{
				loc3[loc14] = loc3[loc14].split(";");
				loc14 = loc14 + 1;
			}
			loc3.sortOn("0");
			var loc15 = new ank.utils.();
			var loc16 = 0;
			while(loc16 < loc3.length)
			{
				var loc17 = Number(loc3[loc16][0]);
				var loc18 = Number(loc3[loc16][1]);
				loc15.push(new dofus.datacenter.(loc17,loc18));
				loc16 = loc16 + 1;
			}
			this.api.datacenter.Player.guildInfos.setBoosts(loc5,loc4,loc6,loc7,loc8,loc9,loc10,loc11,loc12,loc13,loc15);
		}
	}
	function onInfosMountPark(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = new ank.utils.();
		var loc6 = 1;
		while(loc6 < loc3.length)
		{
			var loc7 = loc3[loc6].split(";");
			var loc8 = Number(loc7[0]);
			var loc9 = Number(loc7[1]);
			var loc10 = Number(loc7[2]);
			var loc11 = new dofus.datacenter.(0,-1,loc9,loc10,this.api.datacenter.Player.guildInfos.name);
			loc11.map = loc8;
			loc11.mounts = new ank.utils.();
			if(loc7[3] != "")
			{
				var loc12 = loc7[3].split(",");
				var loc13 = 0;
				while(loc13 < loc12.length)
				{
					var loc14 = new dofus.datacenter.Mount(Number(loc12[loc13]));
					loc14.name = loc12[loc13 + 1] != ""?loc12[loc13 + 1]:this.api.lang.getText("NO_NAME");
					loc14.ownerName = loc12[loc13 + 2];
					loc11.mounts.push(loc14);
					loc13 = loc13 + 3;
				}
			}
			loc5.push(loc11);
			loc6 = loc6 + 1;
		}
		this.api.datacenter.Player.guildInfos.setMountParks(loc4,loc5);
	}
	function onInfosTaxCollectorsMovement(loc2)
	{
		if(loc2.length == 0)
		{
			this.api.datacenter.Player.guildInfos.setNoTaxCollectors();
		}
		else
		{
			var loc3 = loc2.charAt(0) == "+";
			var loc4 = loc2.substr(1).split("|");
			var loc5 = this.api.datacenter.Player.guildInfos;
			var loc6 = 0;
			while(loc6 < loc4.length)
			{
				var loc7 = loc4[loc6].split(";");
				var loc8 = new Object();
				loc8.id = _global.parseInt(loc7[0],36);
				if(loc3)
				{
					var loc9 = loc5.taxCollectors.length == 0;
					var loc10 = _global.parseInt(loc7[2],36);
					var loc11 = this.api.lang.getMapText(loc10).x;
					var loc12 = this.api.lang.getMapText(loc10).y;
					loc8.name = this.api.lang.getFullNameText(loc7[1].split(","));
					loc8.position = this.api.kernel.MapsServersManager.getMapName(loc10) + " (" + loc11 + ", " + loc12 + ")";
					loc8.state = Number(loc7[3]);
					loc8.timer = Number(loc7[4]);
					loc8.maxTimer = Number(loc7[5]);
					loc8.timerReference = getTimer();
					loc8.maxPlayerCount = Number(loc7[6]);
					var loc13 = loc7[1].split(",");
					if(loc13.length != 2)
					{
						loc8.showMoreInfo = true;
						loc8.callerName = loc13[2] != ""?loc13[2]:"?";
						loc8.startDate = _global.parseInt(loc13[3],10);
						loc8.lastHarvesterName = loc13[4] != ""?loc13[4]:"?";
						loc8.lastHarvestDate = _global.parseInt(loc13[5],10);
						loc8.nextHarvestDate = _global.parseInt(loc13[6],10);
					}
					else
					{
						loc8.showMoreInfo = false;
						loc8.callerName = "?";
						loc8.startDate = -1;
						loc8.lastHarvesterName = "?";
						loc8.lastHarvestDate = -1;
						loc8.nextHarvestDate = -1;
					}
					loc8.players = new ank.utils.();
					loc8.attackers = new ank.utils.();
					if(loc9)
					{
						loc5.taxCollectors.push(loc8);
					}
					else
					{
						var loc14 = loc5.taxCollectors.findFirstItem("id",loc8.id);
						if(loc14.index != -1)
						{
							loc5.taxCollectors.updateItem(loc14.index,loc8);
						}
						else
						{
							loc5.taxCollectors.push(loc8);
						}
					}
				}
				else
				{
					var loc15 = loc5.taxCollectors.findFirstItem("id",loc8.id);
					if(loc15.index != -1)
					{
						loc5.taxCollectors.removeItems(loc15.index,1);
					}
				}
				loc6 = loc6 + 1;
			}
			loc5.setTaxCollectors();
		}
	}
	function onInfosTaxCollectorsPlayers(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = loc2.substr(1).split("|");
		var loc5 = _global.parseInt(loc4[0],36);
		var loc6 = this.api.datacenter.Player.guildInfos.taxCollectors;
		var loc7 = loc6.findFirstItem("id",loc5);
		if(loc7.index != -1)
		{
			var loc8 = loc7.item;
			var loc9 = 1;
			while(loc9 < loc4.length)
			{
				var loc10 = loc4[loc9].split(";");
				if(loc3)
				{
					var loc11 = new Object();
					loc11.id = _global.parseInt(loc10[0],36);
					loc11.name = loc10[1];
					loc11.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + loc10[2] + ".swf";
					loc11.level = Number(loc10[3]);
					loc11.color1 = _global.parseInt(loc10[4],36);
					loc11.color2 = _global.parseInt(loc10[5],36);
					loc11.color3 = _global.parseInt(loc10[6],36);
					var loc12 = loc8.players.findFirstItem("id",loc11.id);
					if(loc12.index != -1)
					{
						loc8.players.updateItem(loc12.index,loc11);
					}
					else
					{
						loc8.players.push(loc11);
					}
					if(loc11.id == this.api.datacenter.Player.ID)
					{
						this.api.datacenter.Player.guildInfos.defendedTaxCollectorID = loc5;
					}
				}
				else
				{
					var loc13 = _global.parseInt(loc10[0],36);
					var loc14 = loc8.players.findFirstItem("id",loc13);
					if(loc14.index != -1)
					{
						loc8.players.removeItems(loc14.index,1);
					}
					if(loc13 == this.api.datacenter.Player.ID)
					{
						this.api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
					}
				}
				loc9 = loc9 + 1;
			}
		}
		else
		{
			ank.utils.Logger.err("[gITP] impossible de trouver le percepteur");
		}
	}
	function onInfosTaxCollectorsAttackers(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = loc2.substr(1).split("|");
		var loc5 = _global.parseInt(loc4[0],36);
		var loc6 = this.api.datacenter.Player.guildInfos.taxCollectors;
		var loc7 = loc6.findFirstItem("id",loc5);
		if(loc7.index != -1)
		{
			var loc8 = loc7.item;
			var loc9 = 1;
			while(loc9 < loc4.length)
			{
				var loc10 = loc4[loc9].split(";");
				if(loc3)
				{
					var loc11 = new Object();
					loc11.id = _global.parseInt(loc10[0],36);
					loc11.name = loc10[1];
					loc11.level = Number(loc10[2]);
					var loc12 = loc8.attackers.findFirstItem("id",loc11.id);
					if(loc12.index != -1)
					{
						loc8.attackers.updateItem(loc12.index,loc11);
					}
					else
					{
						loc8.attackers.push(loc11);
					}
				}
				else
				{
					var loc13 = _global.parseInt(loc10[0],36);
					var loc14 = loc8.attackers.findFirstItem("id",loc13);
					if(loc14.index != -1)
					{
						loc8.attackers.removeItems(loc14.index,1);
					}
				}
				loc9 = loc9 + 1;
			}
		}
		else
		{
			ank.utils.Logger.err("[gITp] impossible de trouver le percepteur");
		}
	}
	function onInfosHouses(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		if(loc2.length <= 1)
		{
			this.api.datacenter.Player.guildInfos.setNoHouses();
		}
		else
		{
			var loc4 = loc2.substr(1).split("|");
			var loc5 = new ank.utils.();
			var loc6 = 0;
			while(loc6 < loc4.length)
			{
				var loc7 = loc4[loc6].split(";");
				var loc8 = Number(loc7[0]);
				var loc9 = loc7[1];
				var loc10 = loc7[2].split(",");
				var loc11 = new com.ankamagames.types.(Number(loc10[0]),Number(loc10[1]));
				var loc12 = new Array();
				var loc13 = loc7[3].split(",");
				var loc14 = 0;
				while(loc14 < loc13.length)
				{
					loc12.push(Number(loc13[loc14]));
					loc14 = loc14 + 1;
				}
				var loc15 = loc7[4];
				var loc16 = new dofus.datacenter.(loc8);
				loc16.ownerName = loc9;
				loc16.coords = loc11;
				loc16.skills = loc12;
				loc16.guildRights = loc15;
				loc5.push(loc16);
				loc6 = loc6 + 1;
			}
			this.api.datacenter.Player.guildInfos.setHouses(loc5);
		}
	}
	function onRequestLocal(loc2)
	{
		this.api.kernel.showMessage(this.api.lang.getText("GUILD"),this.api.lang.getText("YOU_INVIT_B_IN_GUILD",[loc2]),"INFO_CANCEL",{name:"Guild",listener:this,params:{spriteID:this.api.datacenter.Player.ID}});
	}
	function onRequestDistant(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0];
		var loc5 = loc3[1];
		var loc6 = loc3[2];
		if(this.api.kernel.ChatManager.isBlacklisted(loc5))
		{
			this.refuseInvitation(Number(loc4));
			return undefined;
		}
		this.api.electron.makeNotification(this.api.lang.getText("A_INVIT_YOU_IN_GUILD",[loc5,loc6]));
		this.api.kernel.showMessage(undefined,this.api.lang.getText("CHAT_A_INVIT_YOU_IN_GUILD",[this.api.kernel.ChatManager.getLinkName(loc5),loc6]),"INFO_CHAT");
		this.api.kernel.showMessage(this.api.lang.getText("GUILD"),this.api.lang.getText("A_INVIT_YOU_IN_GUILD",[loc5,loc6]),"CAUTION_YESNOIGNORE",{name:"Guild",player:loc5,listener:this,params:{spriteID:loc4,player:loc5}});
	}
	function onJoinError(loc2)
	{
		var loc3 = loc2.charAt(0);
		switch(loc3)
		{
			case "a":
				this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_ALREADY_IN_GUILD"),"ERROR_CHAT");
				break;
			case "d":
				this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_NO_RIGHTS"),"ERROR_CHAT");
				break;
			default:
				switch(null)
				{
					case "u":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_UNKNOW"),"ERROR_CHAT");
						break;
					case "o":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_OCCUPED"),"ERROR_CHAT");
						break;
					case "r":
						var loc4 = loc2.substr(1);
						this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_REFUSED",[loc4]),"ERROR_CHAT");
						this.api.ui.unloadUIComponent("AskCancelGuild");
						break;
					case "c":
						this.api.ui.unloadUIComponent("AskCancelGuild");
						this.api.ui.unloadUIComponent("AskYesNoIgnoreGuild");
				}
		}
	}
	function onJoinOk(loc2)
	{
		var loc3 = loc2.charAt(0);
		switch(loc3)
		{
			case "a":
				this.api.ui.unloadUIComponent("AskCancelGuild");
				this.api.kernel.showMessage(undefined,this.api.lang.getText("A_JOIN_YOUR_GUILD",[loc2.substr(1)]),"INFO_CHAT");
				break;
			case "j":
				this.api.kernel.showMessage(undefined,this.api.lang.getText("YOUR_R_NEW_IN_GUILD",[this.api.datacenter.Player.guildInfos.name]),"INFO_CHAT");
		}
	}
	function onJoinDistantOk()
	{
		this.api.ui.unloadUIComponent("AskYesNoIgnoreGuild");
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("CreateGuild");
	}
	function onBann(loc2, loc3)
	{
		if(loc2)
		{
			var loc4 = loc3.split("|");
			var loc5 = loc4[0];
			var loc6 = loc4[1];
			var loc7 = loc5 == this.api.datacenter.Player.Name;
			if(loc7)
			{
				if(loc5 != loc6)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("YOU_BANN_A_FROM_GUILD",[loc6]),"INFO_CHAT");
				}
				else
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("YOU_BANN_YOU_FROM_GUILD"),"INFO_CHAT");
					this.api.ui.unloadUIComponent("Guild");
					this.api.datacenter.Player.guildInfos = undefined;
				}
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("YOU_ARE_BANN_BY_A_FROM_GUILD",[loc5]),"INFO_CHAT");
				this.api.ui.unloadUIComponent("Guild");
				delete this.api.datacenter.Player.guildInfos;
			}
		}
		else
		{
			var loc8 = loc3.charAt(0);
			switch(loc8)
			{
				case "d":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_RIGHTS_FROM_GUILD"),"ERROR_CHAT");
					break;
				case "a":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BANN_FROM_GUILD_NOT_MEMBER"),"ERROR_CHAT");
			}
		}
	}
	function onHireTaxCollector(loc2, loc3)
	{
		if(!loc2)
		{
			var loc4 = loc3.charAt(0);
			if((var loc0 = loc4) !== "d")
			{
				switch(null)
				{
					case "a":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("ALREADY_TAXCOLLECTOR_ON_MAP"),"ERROR_CHAT");
						break;
					case "k":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGTH_RICH_TO_HIRE_TAX"),"ERROR_CHAT");
						break;
					case "m":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_HIRE_MAX_TAXCOLLECTORS"),"ERROR_CHAT");
						break;
					case "b":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_YOUR_TAXCOLLECTORS"),"ERROR_CHAT");
						break;
					default:
						switch(null)
						{
							case "y":
								this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_HIRE_TAXCOLLECTORS_TOO_TIRED"),"ERROR_CHAT");
								break;
							case "h":
								this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_HIRE_TAXCOLLECTORS_HERE"),"ERROR_CHAT");
						}
				}
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_RIGHTS_FROM_GUILD"),"ERROR_CHAT");
			}
		}
	}
	function onTaxCollectorAttacked(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0].charAt(0);
		var loc5 = this.api.lang.getFullNameText(loc3[0].substr(1).split(","));
		var loc6 = Number(loc3[1]);
		var loc7 = loc3[2];
		var loc8 = loc3[3];
		var loc9 = "(" + loc7 + ", " + loc8 + ")";
		switch(loc4)
		{
			case "A":
				this.api.electron.makeNotification(this.api.lang.getText("TAX_ATTACKED",[loc5,loc9]));
				this.api.kernel.showMessage(undefined,"<img src=\"CautionIcon\" hspace=\'0\' vspace=\'0\' width=\'13\' height=\'13\' /><a href=\'asfunction:onHref,OpenGuildTaxCollectors\'>" + this.api.lang.getText("TAX_ATTACKED",[loc5,loc9]) + "</a>","GUILD_CHAT");
				this.api.sounds.events.onTaxcollectorAttack();
				break;
			case "S":
				this.api.kernel.showMessage(undefined,this.api.lang.getText("TAX_ATTACKED_SUVIVED",[loc5,loc9]),"GUILD_CHAT");
				break;
			case "D":
				this.api.kernel.showMessage(undefined,this.api.lang.getText("TAX_ATTACKED_DIED",[loc5,loc9]),"GUILD_CHAT");
		}
	}
	function onTaxCollectorInfo(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0].charAt(0);
		var loc5 = this.api.lang.getFullNameText(loc3[0].substr(1).split(","));
		var loc6 = Number(loc3[1]);
		var loc7 = loc3[2];
		var loc8 = loc3[3];
		var loc9 = "(" + loc7 + ", " + loc8 + ")";
		var loc10 = loc3[4];
		if((var loc0 = loc4) !== "S")
		{
			switch(null)
			{
				case "R":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("TAXCOLLECTOR_REMOVED",[loc5,loc9,loc10]),"GUILD_CHAT");
					break;
				case "G":
					var loc11 = loc3[5].split(";");
					var loc12 = Number(loc11[0]);
					var loc13 = loc12 + " " + this.api.lang.getText("EXPERIENCE_POINT");
					var loc14 = 1;
					while(loc14 < loc11.length)
					{
						var loc15 = loc11[loc14].split(",");
						var loc16 = loc15[0];
						var loc17 = loc15[1];
						loc13 = loc13 + (",<br/>" + loc17 + " x " + this.api.lang.getItemUnicText(loc16).n);
						loc14 = loc14 + 1;
					}
					loc13 = loc13 + ".";
					this.api.kernel.showMessage(undefined,this.api.lang.getText("TAXCOLLECTOR_RECOLTED",[loc5,loc9,loc10,loc13]),"GUILD_CHAT");
			}
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("TAXCOLLECTOR_ADDED",[loc5,loc9,loc10]),"GUILD_CHAT");
		}
	}
	function onUserInterfaceOpen(loc2)
	{
		switch(loc2)
		{
			case "T":
				if(this.api.datacenter.Player.guildInfos.name != undefined)
				{
					this.api.ui.loadUIAutoHideComponent("Guild","Guild",{currentTab:"GuildHouses"});
				}
				else
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("ITEM_NEED_GUILD"),"ERROR_CHAT");
				}
				break;
			case "F":
				if(this.api.datacenter.Player.guildInfos.name != undefined)
				{
					this.api.ui.loadUIAutoHideComponent("Guild","Guild",{currentTab:"MountParks"});
					break;
				}
				this.api.kernel.showMessage(undefined,this.api.lang.getText("ITEM_NEED_GUILD"),"ERROR_CHAT");
				break;
		}
	}
	function cancel(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskCancelGuild")
		{
			this.refuseInvitation(loc2.params.spriteID);
		}
	}
	function yes(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskYesNoIgnoreGuild")
		{
			this.acceptInvitation(loc2.params.spriteID);
		}
	}
	function no(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskYesNoIgnoreGuild")
		{
			this.refuseInvitation(loc2.params.spriteID);
		}
	}
	function ignore(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskYesNoIgnoreGuild")
		{
			this.api.kernel.ChatManager.addToBlacklist(loc2.params.player);
			this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[loc2.params.player]),"INFO_CHAT");
			this.refuseInvitation(loc2.params.spriteID);
		}
	}
}

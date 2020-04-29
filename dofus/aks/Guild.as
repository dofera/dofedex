class dofus.aks.Guild extends dofus.aks.Handler
{
	function Guild(var3, var4)
	{
		super.initialize(var3,var4);
	}
	function create(var2, var3, var4, var5, var6)
	{
		this.aks.send("gC" + var2 + "|" + var3 + "|" + var4 + "|" + var5 + "|" + var6);
	}
	function leave()
	{
		this.aks.send("gV");
	}
	function leaveTaxInterface()
	{
		this.aks.send("gITV",false);
	}
	function invite(var2)
	{
		this.aks.send("gJR" + var2);
	}
	function acceptInvitation(var2)
	{
		this.aks.send("gJK" + var2);
	}
	function refuseInvitation(var2)
	{
		this.aks.send("gJE" + var2,false);
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
	function bann(var2)
	{
		this.aks.send("gK" + var2);
	}
	function changeMemberProfil(var2)
	{
		this.aks.send("gP" + var2.id + "|" + var2.rank + "|" + var2.percentxp + "|" + var2.rights.value,true);
	}
	function boostCharacteristic(var2)
	{
		var var3 = var2;
		switch(var3)
		{
			case "c":
				var3 = "k";
				break;
			case "w":
				var3 = "o";
		}
		this.aks.send("gB" + var3,true);
	}
	function boostSpell(var2)
	{
		this.aks.send("gb" + var2,true);
	}
	function hireTaxCollector()
	{
		this.aks.send("gH");
	}
	function joinTaxCollector(var2)
	{
		this.aks.send("gTJ" + var2,false);
	}
	function leaveTaxCollector(var2, var3)
	{
		this.aks.send("gTV" + var2 + (var3 == undefined?"":"|" + var3),false);
	}
	function removeTaxCollector(var2)
	{
		this.aks.send("gF" + var2,false);
	}
	function teleportToGuildHouse(var2)
	{
		this.aks.send("gh" + var2,false);
	}
	function teleportToGuildFarm(var2)
	{
		this.aks.send("gf" + var2,false);
	}
	function onNew()
	{
		this.api.ui.loadUIComponent("CreateGuild","CreateGuild");
	}
	function onCreate(var2, var3)
	{
		if(var2)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_CREATED"),"INFO_CHAT");
			this.api.ui.loadUIAutoHideComponent("Guild","Guild",{currentTab:"Members"},{bStayIfPresent:true});
		}
		else
		{
			switch(var3)
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
	function onStats(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0];
		var var5 = _global.parseInt(var3[1],36);
		var var6 = _global.parseInt(var3[2],36);
		var var7 = _global.parseInt(var3[3],36);
		var var8 = _global.parseInt(var3[4],36);
		var var9 = _global.parseInt(var3[5],36);
		if(this.api.datacenter.Player.guildInfos == undefined)
		{
			this.api.datacenter.Player.guildInfos = new dofus.datacenter.(var4,var5,var6,var7,var8,var9);
		}
		else
		{
			this.api.datacenter.Player.guildInfos.initialize(var4,var5,var6,var7,var8,var9);
		}
	}
	function onInfosGeneral(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0] == "1";
		var var5 = Number(var3[1]);
		var var6 = Number(var3[2]);
		var var7 = Number(var3[3]);
		var var8 = Number(var3[4]);
		this.api.datacenter.Player.guildInfos.setGeneralInfos(var4,var5,var6,var7,var8);
	}
	function onInfosMembers(var2)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = var2.substr(1).split("|");
		var var5 = this.api.datacenter.Player.guildInfos;
		var var6 = 0;
		while(var6 < var4.length)
		{
			var var7 = var4[var6].split(";");
			var var8 = new Object();
			var8.id = Number(var7[0]);
			if(var3)
			{
				var var9 = var5.members.length == 0;
				var8.name = var7[1];
				var8.level = Number(var7[2]);
				var8.gfx = Number(var7[3]);
				var8.rank = Number(var7[4]);
				var8.rankOrder = this.api.lang.getRankInfos(var8.rank).o;
				var8.winxp = Number(var7[5]);
				var8.percentxp = Number(var7[6]);
				var8.rights = new dofus.datacenter.
(Number(var7[7]));
				var8.state = Number(var7[8]);
				var8.alignement = Number(var7[9]);
				var8.lastConnection = Number(var7[10]);
				var8.isLocalPlayer = var8.id == this.api.datacenter.Player.ID;
				if(var9)
				{
					var5.members.push(var8);
				}
				else
				{
					var var10 = var5.members.findFirstItem("id",var8.id);
					if(var10.index != -1)
					{
						var5.members.updateItem(var10.index,var8);
					}
					else
					{
						var5.members.push(var8);
					}
				}
				var5.members.sortOn("rankOrder",Array.NUMERIC);
			}
			else
			{
				var var11 = var5.members.findFirstItem("id",var8.id);
				if(var11.index != -1)
				{
					var5.members.removeItems(var11.index,1);
				}
			}
			var6 = var6 + 1;
		}
		var5.setMembers();
	}
	function onInfosBoosts(var2)
	{
		if(var2.length == 0)
		{
			this.api.datacenter.Player.guildInfos.setNoBoosts();
		}
		else
		{
			var var3 = var2.split("|");
			var var4 = Number(var3[0]);
			var var5 = Number(var3[1]);
			var var6 = Number(var3[2]);
			var var7 = Number(var3[3]);
			var var8 = Number(var3[4]);
			var var9 = Number(var3[5]);
			var var10 = Number(var3[6]);
			var var11 = Number(var3[7]);
			var var12 = Number(var3[8]);
			var var13 = Number(var3[9]);
			var3.splice(0,10);
			var var14 = 0;
			while(var14 < var3.length)
			{
				var3[var14] = var3[var14].split(";");
				var14 = var14 + 1;
			}
			var3.sortOn("0");
			var var15 = new ank.utils.();
			var var16 = 0;
			while(var16 < var3.length)
			{
				var var17 = Number(var3[var16][0]);
				var var18 = Number(var3[var16][1]);
				var15.push(new dofus.datacenter.(var17,var18));
				var16 = var16 + 1;
			}
			this.api.datacenter.Player.guildInfos.setBoosts(var5,var4,var6,var7,var8,var9,var10,var11,var12,var13,var15);
		}
	}
	function onInfosMountPark(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = new ank.utils.();
		var var6 = 1;
		while(var6 < var3.length)
		{
			var var7 = var3[var6].split(";");
			var var8 = Number(var7[0]);
			var var9 = Number(var7[1]);
			var var10 = Number(var7[2]);
			var var11 = new dofus.datacenter.(0,-1,var9,var10,this.api.datacenter.Player.guildInfos.name);
			var11.map = var8;
			var11.mounts = new ank.utils.();
			if(var7[3] != "")
			{
				var var12 = var7[3].split(",");
				var var13 = 0;
				while(var13 < var12.length)
				{
					var var14 = new dofus.datacenter.Mount(Number(var12[var13]));
					var14.name = var12[var13 + 1] != ""?var12[var13 + 1]:this.api.lang.getText("NO_NAME");
					var14.ownerName = var12[var13 + 2];
					var11.mounts.push(var14);
					var13 = var13 + 3;
				}
			}
			var5.push(var11);
			var6 = var6 + 1;
		}
		this.api.datacenter.Player.guildInfos.setMountParks(var4,var5);
	}
	function onInfosTaxCollectorsMovement(var2)
	{
		if(var2.length == 0)
		{
			this.api.datacenter.Player.guildInfos.setNoTaxCollectors();
		}
		else
		{
			var var3 = var2.charAt(0) == "+";
			var var4 = var2.substr(1).split("|");
			var var5 = this.api.datacenter.Player.guildInfos;
			var var6 = 0;
			while(var6 < var4.length)
			{
				var var7 = var4[var6].split(";");
				var var8 = new Object();
				var8.id = _global.parseInt(var7[0],36);
				if(var3)
				{
					var var9 = var5.taxCollectors.length == 0;
					var var10 = _global.parseInt(var7[2],36);
					var var11 = this.api.lang.getMapText(var10).x;
					var var12 = this.api.lang.getMapText(var10).y;
					var8.name = this.api.lang.getFullNameText(var7[1].split(","));
					var8.position = this.api.kernel.MapsServersManager.getMapName(var10) + " (" + var11 + ", " + var12 + ")";
					var8.state = Number(var7[3]);
					var8.timer = Number(var7[4]);
					var8.maxTimer = Number(var7[5]);
					var8.timerReference = getTimer();
					var8.maxPlayerCount = Number(var7[6]);
					var var13 = var7[1].split(",");
					if(var13.length != 2)
					{
						var8.showMoreInfo = true;
						var8.callerName = var13[2] != ""?var13[2]:"?";
						var8.startDate = _global.parseInt(var13[3],10);
						var8.lastHarvesterName = var13[4] != ""?var13[4]:"?";
						var8.lastHarvestDate = _global.parseInt(var13[5],10);
						var8.nextHarvestDate = _global.parseInt(var13[6],10);
					}
					else
					{
						var8.showMoreInfo = false;
						var8.callerName = "?";
						var8.startDate = -1;
						var8.lastHarvesterName = "?";
						var8.lastHarvestDate = -1;
						var8.nextHarvestDate = -1;
					}
					var8.players = new ank.utils.();
					var8.attackers = new ank.utils.();
					if(var9)
					{
						var5.taxCollectors.push(var8);
					}
					else
					{
						var var14 = var5.taxCollectors.findFirstItem("id",var8.id);
						if(var14.index != -1)
						{
							var5.taxCollectors.updateItem(var14.index,var8);
						}
						else
						{
							var5.taxCollectors.push(var8);
						}
					}
				}
				else
				{
					var var15 = var5.taxCollectors.findFirstItem("id",var8.id);
					if(var15.index != -1)
					{
						var5.taxCollectors.removeItems(var15.index,1);
					}
				}
				var6 = var6 + 1;
			}
			var5.setTaxCollectors();
		}
	}
	function onInfosTaxCollectorsPlayers(var2)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = var2.substr(1).split("|");
		var var5 = _global.parseInt(var4[0],36);
		var var6 = this.api.datacenter.Player.guildInfos.taxCollectors;
		var var7 = var6.findFirstItem("id",var5);
		if(var7.index != -1)
		{
			var var8 = var7.item;
			var var9 = 1;
			while(var9 < var4.length)
			{
				var var10 = var4[var9].split(";");
				if(var3)
				{
					var var11 = new Object();
					var11.id = _global.parseInt(var10[0],36);
					var11.name = var10[1];
					var11.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + var10[2] + ".swf";
					var11.level = Number(var10[3]);
					var11.color1 = _global.parseInt(var10[4],36);
					var11.color2 = _global.parseInt(var10[5],36);
					var11.color3 = _global.parseInt(var10[6],36);
					var var12 = var8.players.findFirstItem("id",var11.id);
					if(var12.index != -1)
					{
						var8.players.updateItem(var12.index,var11);
					}
					else
					{
						var8.players.push(var11);
					}
					if(var11.id == this.api.datacenter.Player.ID)
					{
						this.api.datacenter.Player.guildInfos.defendedTaxCollectorID = var5;
					}
				}
				else
				{
					var var13 = _global.parseInt(var10[0],36);
					var var14 = var8.players.findFirstItem("id",var13);
					if(var14.index != -1)
					{
						var8.players.removeItems(var14.index,1);
					}
					if(var13 == this.api.datacenter.Player.ID)
					{
						this.api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
					}
				}
				var9 = var9 + 1;
			}
		}
		else
		{
			ank.utils.Logger.err("[gITP] impossible de trouver le percepteur");
		}
	}
	function onInfosTaxCollectorsAttackers(var2)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = var2.substr(1).split("|");
		var var5 = _global.parseInt(var4[0],36);
		var var6 = this.api.datacenter.Player.guildInfos.taxCollectors;
		var var7 = var6.findFirstItem("id",var5);
		if(var7.index != -1)
		{
			var var8 = var7.item;
			var var9 = 1;
			while(var9 < var4.length)
			{
				var var10 = var4[var9].split(";");
				if(var3)
				{
					var var11 = new Object();
					var11.id = _global.parseInt(var10[0],36);
					var11.name = var10[1];
					var11.level = Number(var10[2]);
					var var12 = var8.attackers.findFirstItem("id",var11.id);
					if(var12.index != -1)
					{
						var8.attackers.updateItem(var12.index,var11);
					}
					else
					{
						var8.attackers.push(var11);
					}
				}
				else
				{
					var var13 = _global.parseInt(var10[0],36);
					var var14 = var8.attackers.findFirstItem("id",var13);
					if(var14.index != -1)
					{
						var8.attackers.removeItems(var14.index,1);
					}
				}
				var9 = var9 + 1;
			}
		}
		else
		{
			ank.utils.Logger.err("[gITp] impossible de trouver le percepteur");
		}
	}
	function onInfosHouses(var2)
	{
		var var3 = var2.charAt(0) == "+";
		if(var2.length <= 1)
		{
			this.api.datacenter.Player.guildInfos.setNoHouses();
		}
		else
		{
			var var4 = var2.substr(1).split("|");
			var var5 = new ank.utils.();
			var var6 = 0;
			while(var6 < var4.length)
			{
				var var7 = var4[var6].split(";");
				var var8 = Number(var7[0]);
				var var9 = var7[1];
				var var10 = var7[2].split(",");
				var var11 = new com.ankamagames.types.(Number(var10[0]),Number(var10[1]));
				var var12 = new Array();
				var var13 = var7[3].split(",");
				var var14 = 0;
				while(var14 < var13.length)
				{
					var12.push(Number(var13[var14]));
					var14 = var14 + 1;
				}
				var var15 = var7[4];
				var var16 = new dofus.datacenter.(var8);
				var16.ownerName = var9;
				var16.coords = var11;
				var16.skills = var12;
				var16.guildRights = var15;
				var5.push(var16);
				var6 = var6 + 1;
			}
			this.api.datacenter.Player.guildInfos.setHouses(var5);
		}
	}
	function onRequestLocal(var2)
	{
		this.api.kernel.showMessage(this.api.lang.getText("GUILD"),this.api.lang.getText("YOU_INVIT_B_IN_GUILD",[var2]),"INFO_CANCEL",{name:"Guild",listener:this,params:{spriteID:this.api.datacenter.Player.ID}});
	}
	function onRequestDistant(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0];
		var var5 = var3[1];
		var var6 = var3[2];
		if(this.api.kernel.ChatManager.isBlacklisted(var5))
		{
			this.refuseInvitation(Number(var4));
			return undefined;
		}
		this.api.electron.makeNotification(this.api.lang.getText("A_INVIT_YOU_IN_GUILD",[var5,var6]));
		this.api.kernel.showMessage(undefined,this.api.lang.getText("CHAT_A_INVIT_YOU_IN_GUILD",[this.api.kernel.ChatManager.getLinkName(var5),var6]),"INFO_CHAT");
		this.api.kernel.showMessage(this.api.lang.getText("GUILD"),this.api.lang.getText("A_INVIT_YOU_IN_GUILD",[var5,var6]),"CAUTION_YESNOIGNORE",{name:"Guild",player:var5,listener:this,params:{spriteID:var4,player:var5}});
	}
	function onJoinError(var2)
	{
		var var3 = var2.charAt(0);
		switch(var3)
		{
			case "a":
				this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_ALREADY_IN_GUILD"),"ERROR_CHAT");
				break;
			case "d":
				this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_NO_RIGHTS"),"ERROR_CHAT");
				break;
			case "u":
				this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_UNKNOW"),"ERROR_CHAT");
				break;
			default:
				switch(null)
				{
					case "o":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_OCCUPED"),"ERROR_CHAT");
						break;
					case "r":
						var var4 = var2.substr(1);
						this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_REFUSED",[var4]),"ERROR_CHAT");
						this.api.ui.unloadUIComponent("AskCancelGuild");
						break;
					case "c":
						this.api.ui.unloadUIComponent("AskCancelGuild");
						this.api.ui.unloadUIComponent("AskYesNoIgnoreGuild");
				}
		}
	}
	function onJoinOk(var2)
	{
		var var3 = var2.charAt(0);
		switch(var3)
		{
			case "a":
				this.api.ui.unloadUIComponent("AskCancelGuild");
				this.api.kernel.showMessage(undefined,this.api.lang.getText("A_JOIN_YOUR_GUILD",[var2.substr(1)]),"INFO_CHAT");
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
	function onBann(var2, var3)
	{
		if(var2)
		{
			var var4 = var3.split("|");
			var var5 = var4[0];
			var var6 = var4[1];
			var var7 = var5 == this.api.datacenter.Player.Name;
			if(var7)
			{
				if(var5 != var6)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("YOU_BANN_A_FROM_GUILD",[var6]),"INFO_CHAT");
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
				this.api.kernel.showMessage(undefined,this.api.lang.getText("YOU_ARE_BANN_BY_A_FROM_GUILD",[var5]),"INFO_CHAT");
				this.api.ui.unloadUIComponent("Guild");
				delete this.api.datacenter.Player.guildInfos;
			}
		}
		else
		{
			var var8 = var3.charAt(0);
			switch(var8)
			{
				case "d":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_RIGHTS_FROM_GUILD"),"ERROR_CHAT");
					break;
				case "a":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BANN_FROM_GUILD_NOT_MEMBER"),"ERROR_CHAT");
			}
		}
	}
	function onHireTaxCollector(var2, var3)
	{
		if(!var2)
		{
			var var4 = var3.charAt(0);
			if((var var0 = var4) !== "d")
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
	function onTaxCollectorAttacked(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0].charAt(0);
		var var5 = this.api.lang.getFullNameText(var3[0].substr(1).split(","));
		var var6 = Number(var3[1]);
		var var7 = var3[2];
		var var8 = var3[3];
		var var9 = "(" + var7 + ", " + var8 + ")";
		switch(var4)
		{
			case "A":
				this.api.electron.makeNotification(this.api.lang.getText("TAX_ATTACKED",[var5,var9]));
				this.api.kernel.showMessage(undefined,"<img src=\"CautionIcon\" hspace=\'0\' vspace=\'0\' width=\'13\' height=\'13\' /><a href=\'asfunction:onHref,OpenGuildTaxCollectors\'>" + this.api.lang.getText("TAX_ATTACKED",[var5,var9]) + "</a>","GUILD_CHAT");
				this.api.sounds.events.onTaxcollectorAttack();
				break;
			case "S":
				this.api.kernel.showMessage(undefined,this.api.lang.getText("TAX_ATTACKED_SUVIVED",[var5,var9]),"GUILD_CHAT");
				break;
			case "D":
				this.api.kernel.showMessage(undefined,this.api.lang.getText("TAX_ATTACKED_DIED",[var5,var9]),"GUILD_CHAT");
		}
	}
	function onTaxCollectorInfo(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0].charAt(0);
		var var5 = this.api.lang.getFullNameText(var3[0].substr(1).split(","));
		var var6 = Number(var3[1]);
		var var7 = var3[2];
		var var8 = var3[3];
		var var9 = "(" + var7 + ", " + var8 + ")";
		var var10 = var3[4];
		if((var var0 = var4) !== "S")
		{
			switch(null)
			{
				case "R":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("TAXCOLLECTOR_REMOVED",[var5,var9,var10]),"GUILD_CHAT");
					break;
				case "G":
					var var11 = var3[5].split(";");
					var var12 = Number(var11[0]);
					var var13 = var12 + " " + this.api.lang.getText("EXPERIENCE_POINT");
					var var14 = 1;
					while(var14 < var11.length)
					{
						var var15 = var11[var14].split(",");
						var var16 = var15[0];
						var var17 = var15[1];
						var13 = var13 + (",<br/>" + var17 + " x " + this.api.lang.getItemUnicText(var16).n);
						var14 = var14 + 1;
					}
					var13 = var13 + ".";
					this.api.kernel.showMessage(undefined,this.api.lang.getText("TAXCOLLECTOR_RECOLTED",[var5,var9,var10,var13]),"GUILD_CHAT");
			}
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("TAXCOLLECTOR_ADDED",[var5,var9,var10]),"GUILD_CHAT");
		}
	}
	function onUserInterfaceOpen(var2)
	{
		switch(var2)
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
	function cancel(var2)
	{
		if((var var0 = var2.target._name) === "AskCancelGuild")
		{
			this.refuseInvitation(var2.params.spriteID);
		}
	}
	function yes(var2)
	{
		if((var var0 = var2.target._name) === "AskYesNoIgnoreGuild")
		{
			this.acceptInvitation(var2.params.spriteID);
		}
	}
	function no(var2)
	{
		if((var var0 = var2.target._name) === "AskYesNoIgnoreGuild")
		{
			this.refuseInvitation(var2.params.spriteID);
		}
	}
	function ignore(var2)
	{
		if((var var0 = var2.target._name) === "AskYesNoIgnoreGuild")
		{
			this.api.kernel.ChatManager.addToBlacklist(var2.params.player);
			this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[var2.params.player]),"INFO_CHAT");
			this.refuseInvitation(var2.params.spriteID);
		}
	}
}

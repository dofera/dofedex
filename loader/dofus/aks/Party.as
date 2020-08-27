class dofus.aks.Party extends dofus.aks.Handler
{
	function Party(var3, var4)
	{
		super.initialize(var3,var4);
	}
	function invite(var2)
	{
		this.aks.send("PI" + var2);
	}
	function refuseInvitation()
	{
		this.aks.send("PR",false);
	}
	function acceptInvitation()
	{
		this.aks.send("PA");
	}
	function leave(var2)
	{
		this.aks.send("PV" + (var2 == undefined?"":var2));
		this.api.ui.getUIComponent("Banner").illustration.updateFlags();
	}
	function follow(var2, var3)
	{
		this.aks.send("PF" + (!var2?"+":"-") + var3);
	}
	function where()
	{
		this.aks.send("PW");
	}
	function followAll(var2, var3)
	{
		this.aks.send("PG" + (!var2?"+":"-") + var3);
	}
	function onInvite(var2, var3)
	{
		if(var2)
		{
			var var4 = var3.split("|");
			var var5 = var4[0];
			var var6 = var4[1];
			if(var5 == undefined || var6 == undefined)
			{
				this.refuseInvitation();
				return undefined;
			}
			if(var5 == this.api.datacenter.Player.Name)
			{
				this.api.kernel.showMessage(this.api.lang.getText("PARTY"),this.api.lang.getText("YOU_INVITE_B_IN_PARTY",[var6]),"INFO_CANCEL",{name:"Party",listener:this});
			}
			if(var6 == this.api.datacenter.Player.Name)
			{
				if(this.api.kernel.ChatManager.isBlacklisted(var5))
				{
					this.refuseInvitation();
					return undefined;
				}
				this.api.electron.makeNotification(this.api.lang.getText("A_INVITE_YOU_IN_PARTY",[var5]));
				this.api.kernel.showMessage(undefined,this.api.lang.getText("CHAT_A_INVITE_YOU_IN_PARTY",[this.api.kernel.ChatManager.getLinkName(var5)]),"INFO_CHAT");
				this.api.kernel.showMessage(this.api.lang.getText("PARTY"),this.api.lang.getText("A_INVITE_YOU_IN_PARTY",[var5]),"CAUTION_YESNOIGNORE",{name:"Party",player:var5,listener:this,params:{player:var5}});
				this.api.sounds.events.onGameInvitation();
			}
		}
		else
		{
			var var7 = var3.charAt(0);
			if((var var0 = var7) !== "a")
			{
				switch(null)
				{
					case "f":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_FULL"),"ERROR_CHAT",{name:"PartyError"});
						break;
					case "n":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_FIND_ACCOUNT_OR_CHARACTER",[var3.substr(1)]),"ERROR_CHAT",{name:"PartyError"});
				}
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_ALREADY_IN_GROUP"),"ERROR_CHAT",{name:"PartyError"});
			}
		}
	}
	function onLeader(var2)
	{
		var var3 = var2;
		var var4 = this.api.ui.getUIComponent("Party");
		var4.setLeader(var3);
		var var5 = var4.getMember(var3).name;
		if(var5 != undefined)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("NEW_GROUP_LEADER",[var5]),"INFO_CHAT");
		}
	}
	function onRefuse(var2)
	{
		this.api.ui.unloadUIComponent("AskYesNoIgnoreParty");
		this.api.ui.unloadUIComponent("AskCancelParty");
	}
	function onAccept(var2)
	{
		this.api.ui.unloadUIComponent("AskYesNoIgnoreParty");
		this.api.ui.unloadUIComponent("AskCancelParty");
	}
	function onCreate(var2, var3)
	{
		if(var2)
		{
			var var4 = var3;
			if(var4 != this.api.datacenter.Player.Name)
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("U_ARE_IN_GROUP",[var4]),"INFO_CHAT");
			}
			this.api.datacenter.Player.inParty = true;
			this.api.ui.loadUIComponent("Party","Party",undefined,{bStrayIfPresent:true});
		}
		else
		{
			var var5 = var3.charAt(0);
			if((var var0 = var5) !== "a")
			{
				if(var0 === "f")
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_FULL"),"ERROR_CHAT",{name:"PartyError"});
				}
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_ALREADY_IN_GROUP"),"ERROR_CHAT",{name:"PartyError"});
			}
		}
	}
	function onLeave(var2)
	{
		var var3 = this.api.ui.getUIComponent("Party");
		if(var3.followID != undefined)
		{
			this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[1]);
		}
		var var4 = var3.getMember(var2).name;
		if(var4 != undefined)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("A_KICK_FROM_PARTY",[var4]),"INFO_CHAT");
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("LEAVE_GROUP"),"INFO_CHAT");
		}
		this.api.ui.unloadUIComponent("Party");
		this.api.ui.unloadUIComponent("AskYesNoIgnoreParty");
		this.api.ui.unloadUIComponent("AskCancelParty");
		this.api.datacenter.Player.inParty = false;
		this.api.datacenter.Basics.aks_infos_highlightCoords_clear(2);
	}
	function onFollow(var2, var3)
	{
		if(var2)
		{
			var var4 = this.api.ui.getUIComponent("Party");
			var var5 = var3;
			var4.setFollow(var5);
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_NOT_IN_IN_GROUP"),"ERROR_BOX",{name:"PartyError"});
		}
	}
	function onMovement(var2)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = this.api.ui.getUIComponent("Party");
		var var5 = var2.substr(1).split("|");
		var var6 = 0;
		while(var6 < var5.length)
		{
			var var7 = String(var5[var6]).split(";");
			var var8 = var7[0];
			switch(var2.charAt(0))
			{
				case "+":
					var var9 = var7[1];
					var var10 = var7[2];
					var var11 = Number(var7[3]);
					var var12 = Number(var7[4]);
					var var13 = Number(var7[5]);
					var var14 = var7[6];
					var var15 = var7[7];
					var var16 = Number(var7[8]);
					var var17 = Number(var7[9]);
					var var18 = Number(var7[10]);
					var var19 = Number(var7[11]);
					var var20 = new Object();
					var20.id = var8;
					var20.name = var9;
					var20.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + var10 + ".swf";
					var20.color1 = var11;
					var20.color2 = var12;
					var20.color3 = var13;
					var20.life = var15;
					var20.level = var16;
					var20.initiative = var17;
					var20.prospection = var18;
					var20.side = var19;
					this.api.kernel.CharactersManager.setSpriteAccessories(var20,var14);
					var4.addMember(var20);
					break;
				case "-":
					var4.removeMember(var8,true);
					break;
				case "~":
					var var21 = var7[1];
					var var22 = var7[2];
					var var23 = Number(var7[3]);
					var var24 = Number(var7[4]);
					var var25 = Number(var7[5]);
					var var26 = var7[6];
					var var27 = var7[7];
					var var28 = Number(var7[8]);
					var var29 = Number(var7[9]);
					var var30 = Number(var7[10]);
					var var31 = Number(var7[11]);
					var var32 = new Object();
					var32.id = var8;
					var32.name = var21;
					var32.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + var22 + ".swf";
					var32.color1 = var23;
					var32.color2 = var24;
					var32.color3 = var25;
					var32.life = var27;
					var32.level = var28;
					var32.initiative = var29;
					var32.prospection = var30;
					var32.side = var31;
					this.api.kernel.CharactersManager.setSpriteAccessories(var32,var26);
					var4.updateData(var32);
			}
			var6 = var6 + 1;
		}
		var4.refresh();
	}
	function cancel(var2)
	{
		if((var var0 = var2.target._name) === "AskCancelParty")
		{
			this.refuseInvitation();
		}
	}
	function yes(var2)
	{
		if((var var0 = var2.target._name) === "AskYesNoIgnoreParty")
		{
			this.acceptInvitation();
		}
	}
	function no(var2)
	{
		if((var var0 = var2.target._name) === "AskYesNoIgnoreParty")
		{
			this.refuseInvitation();
		}
	}
	function ignore(var2)
	{
		if((var var0 = var2.target._name) === "AskYesNoIgnoreParty")
		{
			this.api.kernel.ChatManager.addToBlacklist(var2.params.player);
			this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[var2.params.player]),"INFO_CHAT");
			this.refuseInvitation(var2.params.spriteID);
		}
	}
}

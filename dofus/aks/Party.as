class dofus.aks.Party extends dofus.aks.Handler
{
	function Party(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function invite(loc2)
	{
		this.aks.send("PI" + loc2);
	}
	function refuseInvitation()
	{
		this.aks.send("PR",false);
	}
	function acceptInvitation()
	{
		this.aks.send("PA");
	}
	function leave(loc2)
	{
		this.aks.send("PV" + (loc2 == undefined?"":loc2));
		this.api.ui.getUIComponent("Banner").illustration.updateFlags();
	}
	function follow(loc2, loc3)
	{
		this.aks.send("PF" + (!loc2?"+":"-") + loc3);
	}
	function where()
	{
		this.aks.send("PW");
	}
	function followAll(loc2, loc3)
	{
		this.aks.send("PG" + (!loc2?"+":"-") + loc3);
	}
	function onInvite(loc2, loc3)
	{
		if(loc2)
		{
			var loc4 = loc3.split("|");
			var loc5 = loc4[0];
			var loc6 = loc4[1];
			if(loc5 == undefined || loc6 == undefined)
			{
				this.refuseInvitation();
				return undefined;
			}
			if(loc5 == this.api.datacenter.Player.Name)
			{
				this.api.kernel.showMessage(this.api.lang.getText("PARTY"),this.api.lang.getText("YOU_INVITE_B_IN_PARTY",[loc6]),"INFO_CANCEL",{name:"Party",listener:this});
			}
			if(loc6 == this.api.datacenter.Player.Name)
			{
				if(this.api.kernel.ChatManager.isBlacklisted(loc5))
				{
					this.refuseInvitation();
					return undefined;
				}
				this.api.electron.makeNotification(this.api.lang.getText("A_INVITE_YOU_IN_PARTY",[loc5]));
				this.api.kernel.showMessage(undefined,this.api.lang.getText("CHAT_A_INVITE_YOU_IN_PARTY",[this.api.kernel.ChatManager.getLinkName(loc5)]),"INFO_CHAT");
				this.api.kernel.showMessage(this.api.lang.getText("PARTY"),this.api.lang.getText("A_INVITE_YOU_IN_PARTY",[loc5]),"CAUTION_YESNOIGNORE",{name:"Party",player:loc5,listener:this,params:{player:loc5}});
				this.api.sounds.events.onGameInvitation();
			}
		}
		else
		{
			var loc7 = loc3.charAt(0);
			switch(loc7)
			{
				case "a":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_ALREADY_IN_GROUP"),"ERROR_CHAT",{name:"PartyError"});
					break;
				case "f":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_FULL"),"ERROR_CHAT",{name:"PartyError"});
					break;
				case "n":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_FIND_ACCOUNT_OR_CHARACTER",[loc3.substr(1)]),"ERROR_CHAT",{name:"PartyError"});
			}
		}
	}
	function onLeader(loc2)
	{
		var loc3 = loc2;
		var loc4 = this.api.ui.getUIComponent("Party");
		loc4.setLeader(loc3);
		var loc5 = loc4.getMember(loc3).name;
		if(loc5 != undefined)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("NEW_GROUP_LEADER",[loc5]),"INFO_CHAT");
		}
	}
	function onRefuse(loc2)
	{
		this.api.ui.unloadUIComponent("AskYesNoIgnoreParty");
		this.api.ui.unloadUIComponent("AskCancelParty");
	}
	function onAccept(loc2)
	{
		this.api.ui.unloadUIComponent("AskYesNoIgnoreParty");
		this.api.ui.unloadUIComponent("AskCancelParty");
	}
	function onCreate(loc2, loc3)
	{
		if(loc2)
		{
			var loc4 = loc3;
			if(loc4 != this.api.datacenter.Player.Name)
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("U_ARE_IN_GROUP",[loc4]),"INFO_CHAT");
			}
			this.api.datacenter.Player.inParty = true;
			this.api.ui.loadUIComponent("Party","Party",undefined,{bStrayIfPresent:true});
		}
		else
		{
			var loc5 = loc3.charAt(0);
			switch(loc5)
			{
				case "a":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_ALREADY_IN_GROUP"),"ERROR_CHAT",{name:"PartyError"});
					break;
				case "f":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_FULL"),"ERROR_CHAT",{name:"PartyError"});
			}
		}
	}
	function onLeave(loc2)
	{
		var loc3 = this.api.ui.getUIComponent("Party");
		if(loc3.followID != undefined)
		{
			this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[1]);
		}
		var loc4 = loc3.getMember(loc2).name;
		if(loc4 != undefined)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("A_KICK_FROM_PARTY",[loc4]),"INFO_CHAT");
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
	function onFollow(loc2, loc3)
	{
		if(loc2)
		{
			var loc4 = this.api.ui.getUIComponent("Party");
			var loc5 = loc3;
			loc4.setFollow(loc5);
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_NOT_IN_IN_GROUP"),"ERROR_BOX",{name:"PartyError"});
		}
	}
	function onMovement(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = this.api.ui.getUIComponent("Party");
		var loc5 = loc2.substr(1).split("|");
		var loc6 = 0;
		while(loc6 < loc5.length)
		{
			var loc7 = String(loc5[loc6]).split(";");
			var loc8 = loc7[0];
			if((var loc0 = loc2.charAt(0)) !== "+")
			{
				switch(null)
				{
					case "-":
						loc4.removeMember(loc8,true);
						break;
					case "~":
						var loc21 = loc7[1];
						var loc22 = loc7[2];
						var loc23 = Number(loc7[3]);
						var loc24 = Number(loc7[4]);
						var loc25 = Number(loc7[5]);
						var loc26 = loc7[6];
						var loc27 = loc7[7];
						var loc28 = Number(loc7[8]);
						var loc29 = Number(loc7[9]);
						var loc30 = Number(loc7[10]);
						var loc31 = Number(loc7[11]);
						var loc32 = new Object();
						loc32.id = loc8;
						loc32.name = loc21;
						loc32.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + loc22 + ".swf";
						loc32.color1 = loc23;
						loc32.color2 = loc24;
						loc32.color3 = loc25;
						loc32.life = loc27;
						loc32.level = loc28;
						loc32.initiative = loc29;
						loc32.prospection = loc30;
						loc32.side = loc31;
						this.api.kernel.CharactersManager.setSpriteAccessories(loc32,loc26);
						loc4.updateData(loc32);
				}
			}
			else
			{
				var loc9 = loc7[1];
				var loc10 = loc7[2];
				var loc11 = Number(loc7[3]);
				var loc12 = Number(loc7[4]);
				var loc13 = Number(loc7[5]);
				var loc14 = loc7[6];
				var loc15 = loc7[7];
				var loc16 = Number(loc7[8]);
				var loc17 = Number(loc7[9]);
				var loc18 = Number(loc7[10]);
				var loc19 = Number(loc7[11]);
				var loc20 = new Object();
				loc20.id = loc8;
				loc20.name = loc9;
				loc20.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + loc10 + ".swf";
				loc20.color1 = loc11;
				loc20.color2 = loc12;
				loc20.color3 = loc13;
				loc20.life = loc15;
				loc20.level = loc16;
				loc20.initiative = loc17;
				loc20.prospection = loc18;
				loc20.side = loc19;
				this.api.kernel.CharactersManager.setSpriteAccessories(loc20,loc14);
				loc4.addMember(loc20);
			}
			loc6 = loc6 + 1;
		}
		loc4.refresh();
	}
	function cancel(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskCancelParty")
		{
			this.refuseInvitation();
		}
	}
	function yes(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskYesNoIgnoreParty")
		{
			this.acceptInvitation();
		}
	}
	function no(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskYesNoIgnoreParty")
		{
			this.refuseInvitation();
		}
	}
	function ignore(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskYesNoIgnoreParty")
		{
			this.api.kernel.ChatManager.addToBlacklist(loc2.params.player);
			this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[loc2.params.player]),"INFO_CHAT");
			this.refuseInvitation(loc2.params.spriteID);
		}
	}
}

class dofus.aks.Chat extends dofus.aks.Handler
{
	function Chat(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function send(loc2, loc3, loc4)
	{
		if(this.api.datacenter.Game.isSpectator && loc3 == "*")
		{
			loc3 = "#";
		}
		if(loc3.toLowerCase() == this.api.datacenter.Player.Name.toLowerCase())
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_WISP_YOURSELF"),"ERROR_CHAT");
			return undefined;
		}
		if(this.api.kernel.ChatManager.isBlacklisted(loc3))
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_WISP_BLACKLISTED"),"ERROR_CHAT");
			return undefined;
		}
		loc2 = new ank.utils.(loc2).replace(["<",">","|"],["&lt;","&gt;",""]);
		var loc5 = this.api.kernel.ChatManager.applyOutputCensorship(loc2);
		if(!loc5)
		{
			return undefined;
		}
		if(loc2.indexOf(this.api.datacenter.Player.login) > -1 || loc2.indexOf(this.api.datacenter.Player.password) > -1)
		{
			if(loc2 != undefined && (this.api.datacenter.Player.login != undefined && this.api.datacenter.Player.password != undefined))
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_SAY_YOUR_PASSWORD"),"ERROR_CHAT");
				return undefined;
			}
		}
		if(loc2.length == 0)
		{
			return undefined;
		}
		var loc6 = new String();
		var loc7 = loc4.items;
		if(loc7.length > 0)
		{
			var loc8 = 0;
			var loc9 = 0;
			while(loc9 < loc7.length)
			{
				var loc10 = loc7[loc9];
				var loc11 = "[" + loc10.name + "]";
				var loc12 = loc2.indexOf(loc11);
				if(loc12 != -1)
				{
					var loc13 = "°" + loc8;
					loc8 = loc8 + 1;
					var loc14 = loc2.split("");
					loc14.splice(loc12,loc11.length,loc13);
					loc2 = loc14.join("");
					if(loc6.length > 0)
					{
						loc6 = loc6 + "!";
					}
					var loc15 = loc10.compressedEffects;
					loc6 = loc6 + (loc10.unicID + "!" + (loc15 == undefined?".":loc15));
				}
				loc9 = loc9 + 1;
			}
		}
		var loc16 = loc6;
		if(loc16.length > dofus.Constants.MAX_DATA_LENGTH)
		{
			loc16 = loc16.substring(0,dofus.Constants.MAX_DATA_LENGTH - 1);
		}
		if(loc2.length > dofus.Constants.MAX_MESSAGE_LENGTH)
		{
			loc2 = loc2.substring(0,dofus.Constants.MAX_MESSAGE_LENGTH - 1);
		}
		this.aks.send("BM" + loc3 + "|" + loc2 + "|" + loc16,true,undefined,true);
	}
	function reportMessage(loc2, loc3, loc4, loc5)
	{
		this.aks.send("BR" + loc2 + "|" + loc4 + "|" + loc3 + "|" + loc5,false);
	}
	function subscribeChannels(loc2, loc3)
	{
		var loc4 = "";
		loop0:
		switch(loc2)
		{
			case 0:
				loc4 = "i";
				break;
			case 2:
				loc4 = "*";
				break;
			case 3:
				loc4 = "#$p";
				break;
			default:
				switch(null)
				{
					case 4:
						loc4 = "%";
						break loop0;
					case 5:
						loc4 = "!";
						break loop0;
					case 6:
						loc4 = "?";
						break loop0;
					case 7:
						loc4 = ":";
						break loop0;
					default:
						if(loc0 !== 8)
						{
							break loop0;
						}
						loc4 = "^";
						break loop0;
				}
		}
		this.aks.send("cC" + (!loc3?"-":"+") + loc4,true);
	}
	function useSmiley(loc2)
	{
		if(getTimer() - this.api.datacenter.Basics.aks_chat_lastActionTime < dofus.Constants.CLICK_MIN_DELAY)
		{
			return undefined;
		}
		this.api.datacenter.Basics.aks_chat_lastActionTime = getTimer();
		this.aks.send("BS" + loc2,true);
	}
	function onSubscribeChannel(loc2)
	{
		var loc3 = loc2.charAt(0) == "+";
		var loc4 = loc2.substr(1).split("");
		var loc5 = 0;
		for(; loc5 < loc4.length; loc5 = loc5 + 1)
		{
			var loc6 = 0;
			loop1:
			switch(loc4[loc5])
			{
				case "i":
					loc6 = 0;
					break;
				case "*":
					loc6 = 2;
					break;
				case "#":
					loc6 = 3;
					break;
				default:
					switch(null)
					{
						case "$":
							loc6 = 3;
							break loop1;
						case "p":
							loc6 = 3;
							break loop1;
						case "%":
							loc6 = 4;
							break loop1;
						case "!":
							loc6 = 5;
							break loop1;
						default:
							switch(null)
							{
								case "?":
									loc6 = 6;
									break loop1;
								case ":":
									loc6 = 7;
									break loop1;
								case "^":
									loc6 = 8;
									break loop1;
								case "@":
									loc6 = 9;
									break loop1;
								default:
									continue;
							}
					}
			}
			this.api.ui.getUIComponent("Banner").chat.selectFilter(loc6,loc3);
			this.api.kernel.ChatManager.setTypeVisible(loc6,loc3);
			this.api.datacenter.Basics.chat_type_visible[loc6] = loc3;
		}
	}
	function onMessage(loc2, loc3)
	{
		if(!loc2)
		{
			if((var loc0 = loc3.charAt(0)) !== "S")
			{
				switch(null)
				{
					case "f":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("USER_NOT_CONNECTED",[loc3.substr(1)]),"ERROR_CHAT");
						break;
					case "e":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("USER_NOT_CONNECTED_BUT_TRY_SEND_EXTERNAL",[loc3.substr(1)]),"ERROR_CHAT");
						break;
					case "n":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("USER_NOT_CONNECTED_EXTERNAL_NACK",[loc3.substr(1)]),"ERROR_CHAT");
				}
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /w <" + this.api.lang.getText("NAME") + "> <" + this.api.lang.getText("MSG") + ">"]),"ERROR_CHAT");
			}
			return undefined;
		}
		var loc4 = loc3.charAt(0);
		loc3 = loc4 != "|"?loc3.substr(2):loc3.substr(1);
		var loc5 = loc3.split("|");
		var loc6 = loc5[2];
		var loc7 = loc5[1];
		var loc8 = loc5[0];
		var loc9 = loc5[3];
		var loc10 = !(loc5[4] != undefined && (loc5[4].length > 0 && loc5[4] != ""))?null:loc5[4];
		if(this.api.kernel.ChatManager.isBlacklisted(loc7))
		{
			return undefined;
		}
		var loc11 = loc6;
		if(loc9.length > 0)
		{
			var loc12 = loc9.split("!");
			loc6 = this.api.kernel.ChatManager.parseInlineItems(loc6,loc12);
		}
		loc6 = this.api.kernel.ChatManager.parseInlinePos(loc6);
		loop1:
		switch(loc4)
		{
			case "F":
				var loc13 = "WHISP_CHAT";
				loc6 = this.api.kernel.ChatManager.parseSecretsEmotes(loc6);
				if(!loc6.length)
				{
					return undefined;
				}
				var loc14 = this.api.lang.getText("FROM") + " " + loc7 + " : ";
				this.api.electron.makeNotification(loc14 + this.api.kernel.ChatManager.applyInputCensorship(loc6));
				loc6 = this.api.lang.getText("FROM") + " <i>" + this.getLinkName(loc7,loc10) + "</i> : " + this.getLinkMessage(loc7,loc14,loc11,loc6,loc10);
				this.api.kernel.Console.pushWhisper("/w " + loc7 + " ");
				break;
			case "T":
				loc13 = "WHISP_CHAT";
				var loc15 = this.api.lang.getText("TO_DESTINATION") + " " + loc7 + " : ";
				loc6 = this.api.lang.getText("TO_DESTINATION") + " " + this.getLinkName(loc7,loc10) + " : " + this.getLinkMessage(loc7,loc15,loc11,loc6,loc10);
				break;
			case "#":
				if(this.api.datacenter.Game.isFight)
				{
					loc13 = "WHISP_CHAT";
					if(this.api.datacenter.Game.isSpectator)
					{
						var loc16 = "(" + this.api.lang.getText("SPECTATOR") + ")";
					}
					else
					{
						loc16 = "(" + this.api.lang.getText("TEAM") + ")";
					}
					var loc17 = loc16 + " " + loc7 + " : ";
					loc6 = loc16 + " " + this.getLinkName(loc7,loc10) + " : " + this.getLinkMessage(loc7,loc17,loc11,loc6,loc10);
				}
				break;
			default:
				switch(null)
				{
					case "%":
						loc13 = "GUILD_CHAT_SOUND";
						var loc18 = "(" + this.api.lang.getText("GUILD") + ") " + loc7 + " : ";
						loc6 = "(" + this.api.lang.getText("GUILD") + ") " + this.getLinkName(loc7,loc10) + " : " + this.getLinkMessage(loc7,loc18,loc11,loc6,loc10);
						break loop1;
					case "$":
						loc13 = "PARTY_CHAT";
						var loc19 = "(" + this.api.lang.getText("PARTY") + ") " + loc7 + " : ";
						loc6 = "(" + this.api.lang.getText("PARTY") + ") " + this.getLinkName(loc7,loc10) + " : " + this.getLinkMessage(loc7,loc19,loc11,loc6,loc10);
						break loop1;
					case "!":
						loc13 = "PVP_CHAT";
						var loc20 = "(" + this.api.lang.getText("ALIGNMENT") + ") " + loc7 + " : ";
						loc6 = "(" + this.api.lang.getText("ALIGNMENT") + ") " + this.getLinkName(loc7,loc10) + " : " + this.getLinkMessage(loc7,loc20,loc11,loc6,loc10);
						break loop1;
					case "?":
						loc13 = "RECRUITMENT_CHAT";
						var loc21 = "(" + this.api.lang.getText("RECRUITMENT") + ") " + loc7 + " : ";
						loc6 = "(" + this.api.lang.getText("RECRUITMENT") + ") " + this.getLinkName(loc7,loc10) + " : " + this.getLinkMessage(loc7,loc21,loc11,loc6,loc10);
						break loop1;
					case ":":
						loc13 = "TRADE_CHAT";
						var loc22 = "(" + this.api.lang.getText("TRADE") + ") " + loc7 + " : ";
						loc6 = "(" + this.api.lang.getText("TRADE") + ") " + this.getLinkName(loc7,loc10) + " : " + this.getLinkMessage(loc7,loc22,loc11,loc6,loc10);
						break loop1;
					default:
						switch(null)
						{
							case "^":
								loc13 = "MEETIC_CHAT";
								var loc23 = "(" + this.api.lang.getText("MEETIC") + ") " + loc7 + " : ";
								loc6 = "(" + this.api.lang.getText("MEETIC") + ") " + this.getLinkName(loc7,loc10) + " : " + this.getLinkMessage(loc7,loc23,loc11,loc6,loc10);
								break loop1;
							case "@":
								loc13 = "ADMIN_CHAT";
								var loc24 = "(" + this.api.lang.getText("PRIVATE_CHANNEL") + ") " + loc7 + " : ";
								loc6 = "(" + this.api.lang.getText("PRIVATE_CHANNEL") + ") " + this.getLinkName(loc7,loc10) + " : " + this.getLinkMessage(loc7,loc24,loc11,loc6,loc10);
								break loop1;
							default:
								var loc25 = loc6.charAt(0) == dofus.Constants.EMOTE_CHAR && (loc6.charAt(1) == dofus.Constants.EMOTE_CHAR && (loc6.charAt(loc6.length - 1) == dofus.Constants.EMOTE_CHAR && loc6.charAt(loc6.length - 2) == dofus.Constants.EMOTE_CHAR));
								if(this.api.lang.getConfigText("EMOTES_ENABLED") && (!loc25 && (loc6.charAt(0) == dofus.Constants.EMOTE_CHAR && loc6.charAt(loc6.length - 1) == dofus.Constants.EMOTE_CHAR)))
								{
									if(!this.api.datacenter.Game.isRunning && this.api.kernel.ChatManager.isTypeVisible(2))
									{
										var loc26 = !(loc6.charAt(loc6.length - 2) == "." && loc6.charAt(loc6.length - 3) != ".")?loc6:loc6.substr(0,loc6.length - 2) + dofus.Constants.EMOTE_CHAR;
										loc26 = dofus.Constants.EMOTE_CHAR + loc26.charAt(1).toUpperCase() + loc26.substr(2);
										this.api.gfx.addSpriteBubble(loc8,this.api.kernel.ChatManager.applyInputCensorship(loc26));
									}
									loc13 = "EMOTE_CHAT";
									loc6 = loc6.substr(1,loc6.length - 2);
									if(!dofus.managers.ChatManager.isPonctuation(loc6.charAt(loc6.length - 1)))
									{
										loc6 = loc6 + ".";
									}
									loc6 = "<i>" + this.getLinkName(loc7,loc10) + " " + loc6.charAt(0).toLowerCase() + loc6.substr(1) + "</i>";
									break loop1;
								}
								if(loc6.substr(0,7) == "!THINK!")
								{
									loc6 = loc6.substr(7);
									if(!this.api.datacenter.Game.isRunning && this.api.kernel.ChatManager.isTypeVisible(2))
									{
										this.api.gfx.addSpriteBubble(loc8,this.api.kernel.ChatManager.applyInputCensorship(loc6),ank.battlefield.TextHandler.BUBBLE_TYPE_THINK);
									}
									loc13 = "THINK_CHAT";
									var loc27 = loc7 + " " + this.api.lang.getText("THINKS_WORD") + " : ";
									loc6 = "<i>" + this.getLinkName(loc7,loc10) + " " + this.api.lang.getText("THINKS_WORD") + " : " + this.getLinkMessage(loc7,loc27,loc11,loc6,loc10) + "</i>";
									break loop1;
								}
								if(loc25 && !_global.isNaN(loc6.substr(2,loc6.length - 4)))
								{
									if(!this.api.kernel.OptionsManager.getOption("UseSpeakingItems"))
									{
										return undefined;
									}
									var loc28 = _global.parseInt(loc6.substr(2,loc6.length - 4));
									var loc29 = this.api.lang.getSpeakingItemsText(loc28 - Number(loc8));
									if(loc29.m)
									{
										loc13 = "MESSAGE_CHAT";
										loc6 = loc29.m;
										if(!this.api.datacenter.Game.isRunning && this.api.kernel.ChatManager.isTypeVisible(2))
										{
											this.api.gfx.addSpriteBubble(loc8,this.api.kernel.ChatManager.applyInputCensorship(loc6));
										}
										var loc30 = loc7 + " : ";
										loc6 = this.getLinkName(loc7,loc10,true) + " : " + this.getLinkMessage(loc7,loc30,loc11,loc6,loc10);
										break loop1;
									}
									return undefined;
								}
								if(!this.api.datacenter.Game.isRunning && this.api.kernel.ChatManager.isTypeVisible(2))
								{
									this.api.gfx.addSpriteBubble(loc8,this.api.kernel.ChatManager.applyInputCensorship(loc6));
								}
								loc13 = "MESSAGE_CHAT";
								var loc31 = loc7 + " : ";
								loc6 = this.getLinkName(loc7,loc10) + " : " + this.getLinkMessage(loc7,loc31,loc11,loc6,loc10);
								break loop1;
						}
				}
		}
		this.api.kernel.showMessage(undefined,loc6,loc13,undefined,loc10);
	}
	function getLinkMessage(loc2, loc3, loc4, loc5, loc6)
	{
		loc5 = this.api.kernel.ChatManager.applyInputCensorship(loc5);
		if(loc6 != undefined && (loc6.length > 0 && loc6 != ""))
		{
			return "<a href=\'asfunction:onHref,ShowMessagePopupMenu," + loc2 + "," + _global.escape(loc3 + loc4) + "," + loc6 + "\'>" + loc5 + "</a>";
		}
		return "<a href=\'asfunction:onHref,ShowMessagePopupMenu," + loc2 + "," + _global.escape(loc3 + loc4) + "\'>" + loc5 + "</a>";
	}
	function getLinkName(loc2, loc3, loc4)
	{
		var loc5 = "<b>";
		var loc6 = "</b>";
		if(loc4)
		{
			loc5 = "";
			loc6 = "";
		}
		if(loc3 != undefined && (loc3.length > 0 && loc3 != ""))
		{
			return loc5 + "<a href=\'asfunction:onHref,ShowPlayerPopupMenu," + loc2 + "," + loc3 + "\'>" + loc2 + "</a>" + loc6;
		}
		return loc5 + "<a href=\'asfunction:onHref,ShowPlayerPopupMenu," + loc2 + "\'>" + loc2 + "</a>" + loc6;
	}
	function onServerMessage(loc2)
	{
		if(loc2 != undefined)
		{
			this.api.kernel.showMessage(undefined,loc2,"INFO_CHAT");
		}
	}
	function onSmiley(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0];
		var loc5 = Number(loc3[1]);
		this.api.gfx.addSpriteOverHeadItem(loc4,"smiley",dofus.graphics.battlefield.SmileyOverHead,[loc5],dofus.Constants.SMILEY_DELAY);
	}
}

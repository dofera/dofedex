class dofus.aks.Chat extends dofus.aks.Handler
{
	function Chat(§\x1e\x1a\x19§, §\x1e\x1a\x16§)
	{
		super.initialize(var3,var4);
	}
	function send(§\x1e\x10\x0f§, §\x1e\x13\r§, §\x1e\x18\x15§)
	{
		if(this.api.datacenter.Game.isSpectator && var3 == "*")
		{
			var3 = "#";
		}
		if(var3.toLowerCase() == this.api.datacenter.Player.Name.toLowerCase())
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_WISP_YOURSELF"),"ERROR_CHAT");
			return undefined;
		}
		if(this.api.kernel.ChatManager.isBlacklisted(var3))
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_WISP_BLACKLISTED"),"ERROR_CHAT");
			return undefined;
		}
		var2 = new ank.utils.(var2).replace(["<",">","|"],["&lt;","&gt;",""]);
		var var5 = this.api.kernel.ChatManager.applyOutputCensorship(var2);
		if(!var5)
		{
			return undefined;
		}
		if(this.api.datacenter.Player.zaapToken == undefined && (var2.indexOf(this.api.datacenter.Player.login) > -1 || var2.indexOf(this.api.datacenter.Player.password) > -1))
		{
			if(var2 != undefined && (this.api.datacenter.Player.login != undefined && this.api.datacenter.Player.password != undefined))
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_SAY_YOUR_PASSWORD"),"ERROR_CHAT");
				return undefined;
			}
		}
		if(var2.length == 0)
		{
			return undefined;
		}
		var var6 = new String();
		var var7 = var4.items;
		if(var7.length > 0)
		{
			var var8 = 0;
			var var9 = 0;
			while(var9 < var7.length)
			{
				var var10 = var7[var9];
				var var11 = "[" + var10.name + "]";
				var var12 = var2.indexOf(var11);
				if(var12 != -1)
				{
					var var13 = "°" + var8;
					var8 = var8 + 1;
					var var14 = var2.split("");
					var14.splice(var12,var11.length,var13);
					var2 = var14.join("");
					if(var6.length > 0)
					{
						var6 = var6 + "!";
					}
					var var15 = var10.compressedEffects;
					var6 = var6 + (var10.unicID + "!" + (var15 == undefined?".":var15));
				}
				var9 = var9 + 1;
			}
		}
		var var16 = var6;
		if(var16.length > dofus.Constants.MAX_DATA_LENGTH)
		{
			var16 = var16.substring(0,dofus.Constants.MAX_DATA_LENGTH - 1);
		}
		if(var2.length > dofus.Constants.MAX_MESSAGE_LENGTH && !(dofus.Constants.ALPHA && this.api.datacenter.Player.isAuthorized))
		{
			var2 = var2.substring(0,dofus.Constants.MAX_MESSAGE_LENGTH - 1);
		}
		this.aks.send("BM" + var3 + "|" + var2 + "|" + var16,true,undefined,true);
	}
	function reportMessage(§\x1e\x14\x0e§, §\x1e\x10\r§, §\x1e\x10\x0f§, §\x1e\x1e\x1a§)
	{
		this.aks.send("BR" + var2 + "|" + var4 + "|" + var3 + "|" + var5,false);
	}
	function subscribeChannels(§\x07\x19§, §\x14\x1c§)
	{
		var var4 = "";
		loop0:
		switch(var2)
		{
			case 0:
				var4 = "i";
				break;
			case 2:
				var4 = "*";
				break;
			default:
				switch(null)
				{
					case 3:
						var4 = "#$p";
						break loop0;
					case 4:
						var4 = "%";
						break loop0;
					case 5:
						var4 = "!";
						break loop0;
					case 6:
						var4 = "?";
						break loop0;
					default:
						switch(null)
						{
							case 7:
								var4 = ":";
								break;
							case 8:
								var4 = "^";
						}
				}
		}
		this.aks.send("cC" + (!var3?"-":"+") + var4,true);
	}
	function useSmiley(§\x1e\x1d\x11§)
	{
		if(getTimer() - this.api.datacenter.Basics.aks_chat_lastActionTime < dofus.Constants.CLICK_MIN_DELAY)
		{
			return undefined;
		}
		this.api.datacenter.Basics.aks_chat_lastActionTime = getTimer();
		this.aks.send("BS" + var2,true);
	}
	function onSubscribeChannel(§\x1e\x12\x1a§)
	{
		var var3 = var2.charAt(0) == "+";
		var var4 = var2.substr(1).split("");
		var var5 = 0;
		for(; var5 < var4.length; var5 = var5 + 1)
		{
			var var6 = 0;
			loop1:
			switch(var4[var5])
			{
				case "i":
					var6 = 0;
					break;
				case "*":
					var6 = 2;
					break;
				case "#":
					var6 = 3;
					break;
				case "$":
					var6 = 3;
					break;
				default:
					switch(null)
					{
						case "p":
							var6 = 3;
							break loop1;
						case "%":
							var6 = 4;
							break loop1;
						case "!":
							var6 = 5;
							break loop1;
						case "?":
							var6 = 6;
							break loop1;
						case ":":
							var6 = 7;
							break loop1;
						default:
							switch(null)
							{
								case "^":
									var6 = 8;
									break loop1;
								case "@":
									var6 = 9;
									break loop1;
								default:
									continue;
							}
					}
			}
			this.api.ui.getUIComponent("Banner").chat.selectFilter(var6,var3);
			this.api.kernel.ChatManager.setTypeVisible(var6,var3);
			this.api.datacenter.Basics.chat_type_visible[var6] = var3;
		}
	}
	function onMessage(§\x14\x1b§, §\x1e\x12\x1a§)
	{
		if(!var2)
		{
			switch(var3.charAt(0))
			{
				case "S":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /w <" + this.api.lang.getText("NAME") + "> <" + this.api.lang.getText("MSG") + ">"]),"ERROR_CHAT");
					break;
				case "f":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("USER_NOT_CONNECTED",[var3.substr(1)]),"ERROR_CHAT");
					break;
				case "e":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("USER_NOT_CONNECTED_BUT_TRY_SEND_EXTERNAL",[var3.substr(1)]),"ERROR_CHAT");
					break;
				default:
					if(var0 !== "n")
					{
						break;
					}
					this.api.kernel.showMessage(undefined,this.api.lang.getText("USER_NOT_CONNECTED_EXTERNAL_NACK",[var3.substr(1)]),"ERROR_CHAT");
					break;
			}
			return undefined;
		}
		var var4 = var3.charAt(0);
		var3 = var4 != "|"?var3.substr(2):var3.substr(1);
		var var5 = var3.split("|");
		var var6 = var5[2];
		var var7 = var5[1];
		var var8 = var5[0];
		var var9 = var5[3];
		var var10 = !(var5[4] != undefined && (var5[4].length > 0 && var5[4] != ""))?null:var5[4];
		if(this.api.kernel.ChatManager.isBlacklisted(var7))
		{
			return undefined;
		}
		var var11 = var6;
		if(var9.length > 0)
		{
			var var12 = var9.split("!");
			var6 = this.api.kernel.ChatManager.parseInlineItems(var6,var12);
		}
		var6 = this.api.kernel.ChatManager.parseInlinePos(var6);
		loop1:
		switch(var4)
		{
			case "F":
				var var13 = "WHISP_CHAT";
				var6 = this.api.kernel.ChatManager.parseSecretsEmotes(var6);
				if(!var6.length)
				{
					return undefined;
				}
				var var14 = this.api.lang.getText("FROM") + " " + var7 + " : ";
				this.api.electron.makeNotification(var14 + this.api.kernel.ChatManager.applyInputCensorship(var6));
				var6 = this.api.lang.getText("FROM") + " <i>" + this.getLinkName(var7,var10) + "</i> : " + this.getLinkMessage(var7,var14,var11,var6,var10);
				this.api.kernel.Console.pushWhisper("/w " + var7 + " ");
				break;
			case "T":
				var13 = "WHISP_CHAT";
				var var15 = this.api.lang.getText("TO_DESTINATION") + " " + var7 + " : ";
				var6 = this.api.lang.getText("TO_DESTINATION") + " " + this.getLinkName(var7,var10) + " : " + this.getLinkMessage(var7,var15,var11,var6,var10);
				break;
			default:
				switch(null)
				{
					case "#":
						if(this.api.datacenter.Game.isFight)
						{
							var13 = "WHISP_CHAT";
							if(this.api.datacenter.Game.isSpectator)
							{
								var var16 = "(" + this.api.lang.getText("SPECTATOR") + ")";
							}
							else
							{
								var16 = "(" + this.api.lang.getText("TEAM") + ")";
							}
							var var17 = var16 + " " + var7 + " : ";
							var6 = var16 + " " + this.getLinkName(var7,var10) + " : " + this.getLinkMessage(var7,var17,var11,var6,var10);
						}
						break loop1;
					case "%":
						var13 = "GUILD_CHAT_SOUND";
						var var18 = "(" + this.api.lang.getText("GUILD") + ") " + var7 + " : ";
						var6 = "(" + this.api.lang.getText("GUILD") + ") " + this.getLinkName(var7,var10) + " : " + this.getLinkMessage(var7,var18,var11,var6,var10);
						break loop1;
					case "$":
						var13 = "PARTY_CHAT";
						var var19 = "(" + this.api.lang.getText("PARTY") + ") " + var7 + " : ";
						var6 = "(" + this.api.lang.getText("PARTY") + ") " + this.getLinkName(var7,var10) + " : " + this.getLinkMessage(var7,var19,var11,var6,var10);
						break loop1;
					case "!":
						var13 = "PVP_CHAT";
						var var20 = "(" + this.api.lang.getText("ALIGNMENT") + ") " + var7 + " : ";
						var6 = "(" + this.api.lang.getText("ALIGNMENT") + ") " + this.getLinkName(var7,var10) + " : " + this.getLinkMessage(var7,var20,var11,var6,var10);
						break loop1;
					default:
						switch(null)
						{
							case "?":
								var13 = "RECRUITMENT_CHAT";
								var var21 = "(" + this.api.lang.getText("RECRUITMENT") + ") " + var7 + " : ";
								var6 = "(" + this.api.lang.getText("RECRUITMENT") + ") " + this.getLinkName(var7,var10) + " : " + this.getLinkMessage(var7,var21,var11,var6,var10);
								break loop1;
							case ":":
								var13 = "TRADE_CHAT";
								var var22 = "(" + this.api.lang.getText("TRADE") + ") " + var7 + " : ";
								var6 = "(" + this.api.lang.getText("TRADE") + ") " + this.getLinkName(var7,var10) + " : " + this.getLinkMessage(var7,var22,var11,var6,var10);
								break loop1;
							case "^":
								var13 = "MEETIC_CHAT";
								var var23 = "(" + this.api.lang.getText("MEETIC") + ") " + var7 + " : ";
								var6 = "(" + this.api.lang.getText("MEETIC") + ") " + this.getLinkName(var7,var10) + " : " + this.getLinkMessage(var7,var23,var11,var6,var10);
								break loop1;
							case "@":
								var13 = "ADMIN_CHAT";
								var var24 = "(" + this.api.lang.getText("PRIVATE_CHANNEL") + ") " + var7 + " : ";
								var6 = "(" + this.api.lang.getText("PRIVATE_CHANNEL") + ") " + this.getLinkName(var7,var10) + " : " + this.getLinkMessage(var7,var24,var11,var6,var10);
								break loop1;
							default:
								var var25 = var6.charAt(0) == dofus.Constants.EMOTE_CHAR && (var6.charAt(1) == dofus.Constants.EMOTE_CHAR && (var6.charAt(var6.length - 1) == dofus.Constants.EMOTE_CHAR && var6.charAt(var6.length - 2) == dofus.Constants.EMOTE_CHAR));
								if(this.api.lang.getConfigText("EMOTES_ENABLED") && (!var25 && (var6.charAt(0) == dofus.Constants.EMOTE_CHAR && var6.charAt(var6.length - 1) == dofus.Constants.EMOTE_CHAR)))
								{
									if(!this.api.datacenter.Game.isRunning && this.api.kernel.ChatManager.isTypeVisible(2))
									{
										var var26 = !(var6.charAt(var6.length - 2) == "." && var6.charAt(var6.length - 3) != ".")?var6:var6.substr(0,var6.length - 2) + dofus.Constants.EMOTE_CHAR;
										var26 = dofus.Constants.EMOTE_CHAR + var26.charAt(1).toUpperCase() + var26.substr(2);
										this.api.gfx.addSpriteBubble(var8,this.api.kernel.ChatManager.applyInputCensorship(var26));
									}
									var13 = "EMOTE_CHAT";
									var6 = var6.substr(1,var6.length - 2);
									if(!dofus.managers.ChatManager.isPonctuation(var6.charAt(var6.length - 1)))
									{
										var6 = var6 + ".";
									}
									var6 = "<i>" + this.getLinkName(var7,var10) + " " + var6.charAt(0).toLowerCase() + var6.substr(1) + "</i>";
									break loop1;
								}
								if(var6.substr(0,7) == "!THINK!")
								{
									var6 = var6.substr(7);
									if(!this.api.datacenter.Game.isRunning && this.api.kernel.ChatManager.isTypeVisible(2))
									{
										this.api.gfx.addSpriteBubble(var8,this.api.kernel.ChatManager.applyInputCensorship(var6),ank.battlefield.TextHandler.BUBBLE_TYPE_THINK);
									}
									var13 = "THINK_CHAT";
									var var27 = var7 + " " + this.api.lang.getText("THINKS_WORD") + " : ";
									var6 = "<i>" + this.getLinkName(var7,var10) + " " + this.api.lang.getText("THINKS_WORD") + " : " + this.getLinkMessage(var7,var27,var11,var6,var10) + "</i>";
									break loop1;
								}
								if(var25 && !_global.isNaN(var6.substr(2,var6.length - 4)))
								{
									if(!this.api.kernel.OptionsManager.getOption("UseSpeakingItems"))
									{
										return undefined;
									}
									var var28 = _global.parseInt(var6.substr(2,var6.length - 4));
									var var29 = this.api.lang.getSpeakingItemsText(var28 - Number(var8));
									if(var29.m)
									{
										var13 = "MESSAGE_CHAT";
										var6 = var29.m;
										if(!this.api.datacenter.Game.isRunning && this.api.kernel.ChatManager.isTypeVisible(2))
										{
											this.api.gfx.addSpriteBubble(var8,this.api.kernel.ChatManager.applyInputCensorship(var6));
										}
										var var30 = var7 + " : ";
										var6 = this.getLinkName(var7,var10,true) + " : " + this.getLinkMessage(var7,var30,var11,var6,var10);
										break loop1;
									}
									return undefined;
								}
								if(!this.api.datacenter.Game.isRunning && this.api.kernel.ChatManager.isTypeVisible(2))
								{
									this.api.gfx.addSpriteBubble(var8,this.api.kernel.ChatManager.applyInputCensorship(var6));
								}
								var13 = "MESSAGE_CHAT";
								var var31 = var7 + " : ";
								var6 = this.getLinkName(var7,var10) + " : " + this.getLinkMessage(var7,var31,var11,var6,var10);
								if(this.api.datacenter.Player.isAuthorized)
								{
									var var32 = this.api.kernel.DebugManager.getTimestamp();
									this.api.kernel.ChatManager.addRawMessage(this.api.datacenter.Map.id,var13,this.getRawFullMessage(var31,var11),var32);
									break loop1;
								}
								break loop1;
						}
				}
		}
		this.api.kernel.showMessage(undefined,var6,var13,undefined,var10);
	}
	function getRawFullMessage(§\x1e\x0f\x01§, §\x1e\x0e\x13§)
	{
		return var2 + var3;
	}
	function getLinkMessage(§\x1e\x0f\x04§, §\x1e\x0f\x01§, §\x1e\x0e\x13§, §\x1e\x10\x0f§, §\x1e\f\f§)
	{
		var var7 = this.api.kernel.DebugManager.getTimestamp() + " ";
		var5 = this.api.kernel.ChatManager.applyInputCensorship(var5);
		if(var6 != undefined && (var6.length > 0 && var6 != ""))
		{
			return "<a href=\'asfunction:onHref,ShowMessagePopupMenu," + var2 + "," + _global.escape(var7 + var3 + var4) + "," + var6 + "\'>" + var5 + "</a>";
		}
		return "<a href=\'asfunction:onHref,ShowMessagePopupMenu," + var2 + "," + _global.escape(var7 + var3 + var4) + "\'>" + var5 + "</a>";
	}
	function getLinkName(§\x1e\x10\x19§, §\x1e\f\f§, §\x17\x11§)
	{
		var var5 = "<b>";
		var var6 = "</b>";
		if(var4)
		{
			var5 = "";
			var6 = "";
		}
		if(var3 != undefined && (var3.length > 0 && var3 != ""))
		{
			return var5 + "<a href=\'asfunction:onHref,ShowPlayerPopupMenu," + var2 + "," + var3 + "\'>" + var2 + "</a>" + var6;
		}
		return var5 + "<a href=\'asfunction:onHref,ShowPlayerPopupMenu," + var2 + "\'>" + var2 + "</a>" + var6;
	}
	function onServerMessage(§\x1e\x12\x1a§)
	{
		if(var2 != undefined)
		{
			this.api.kernel.showMessage(undefined,var2,"INFO_CHAT");
		}
	}
	function onSmiley(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		var var4 = var3[0];
		var var5 = Number(var3[1]);
		this.api.gfx.addSpriteOverHeadItem(var4,"smiley",dofus.graphics.battlefield.SmileyOverHead,[var5],dofus.Constants.SMILEY_DELAY);
	}
}

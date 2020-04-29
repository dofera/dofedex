class dofus.utils.consoleParsers.ChatConsoleParser extends dofus.utils.consoleParsers.AbstractConsoleParser
{
	function ChatConsoleParser(var3)
	{
		super();
		this.initialize(var3);
	}
	function initialize(var2)
	{
		super.initialize(var3);
		this._aWhisperHistory = new Array();
		this._nWhisperHistoryPointer = 0;
	}
	function process(var2, var3)
	{
		super.process(var3,var4);
		var3 = this.parseSpecialDatas(var3);
		if(var3.charAt(0) == "/")
		{
			var var5 = var3.split(" ");
			var var6 = var5[0].substr(1).toUpperCase();
			var5.splice(0,1);
			while(var5[0].length == 0)
			{
				var5.splice(0,1);
			}
			loop3:
			switch(var6)
			{
				case "HELP":
				case "H":
				case "?":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("COMMANDS_HELP"),"INFO_CHAT");
					break;
				default:
					switch(null)
					{
						case "VERSION":
						case "VER":
						case "ABOUT":
							var var7 = "--------------------------------------------------------------\n";
							var7 = var7 + ("<b>DOFUS RETRO Client v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + "</b>");
							if(dofus.Constants.BETAVERSION > 0)
							{
								var7 = var7 + (" <b><font color=\"#FF0000\">BETA VERSION " + dofus.Constants.BETAVERSION + "</font></b>");
							}
							var7 = var7 + ("\n(c) ANKAMA GAMES (" + dofus.Constants.VERSIONDATE + ")\n");
							var7 = var7 + ("Flash player " + System.capabilities.version + "\n");
							var7 = var7 + "--------------------------------------------------------------";
							this.api.kernel.showMessage(undefined,var7,"INFO_CHAT");
							break loop3;
						case "T":
							this.api.network.Chat.send(var5.join(" "),"#",var4);
							break loop3;
						default:
							switch(null)
							{
								case "G":
									if(this.api.datacenter.Player.guildInfos != undefined)
									{
										this.api.network.Chat.send(var5.join(" "),"%",var4);
									}
									break loop3;
								case "P":
									if(this.api.ui.getUIComponent("Party") != undefined)
									{
										this.api.network.Chat.send(var5.join(" "),"$",var4);
									}
									break loop3;
								case "A":
									this.api.network.Chat.send(var5.join(" "),"!",var4);
									break loop3;
								case "R":
									this.api.network.Chat.send(var5.join(" "),"?",var4);
									break loop3;
								default:
									switch(null)
									{
										case "B":
											this.api.network.Chat.send(var5.join(" "),":",var4);
											break loop3;
										case "I":
											this.api.network.Chat.send(var5.join(" "),"^",var4);
											break loop3;
										case "Q":
											this.api.network.Chat.send(var5.join(" "),"@",var4);
											break loop3;
										case "M":
											this.api.network.Chat.send(var5.join(" "),"¤",var4);
											break loop3;
										default:
											switch(null)
											{
												case "MSG":
												case "WHISPER":
												case "WHOAMI":
													this.api.network.Basics.whoAmI();
													break loop3;
												case "WHOIS":
													if(var5.length == 0)
													{
														this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /whois &lt;" + this.api.lang.getText("NAME") + "&gt;"]),"ERROR_CHAT");
														break loop3;
													}
													this.api.network.Basics.whoIs(var5[0]);
													break loop3;
												default:
													switch(null)
													{
														case "FRIEND":
														case "FRIENDS":
														case "IGNORE":
														case "ENEMY":
															switch(var5[0].toUpperCase())
															{
																case "A":
																case "+":
																	this.api.network.Enemies.addEnemy(var5[1]);
																	break;
																case "D":
																case "R":
																case "-":
																	this.api.network.Enemies.removeEnemy(var5[1]);
																	break;
																case "L":
																	this.api.network.Enemies.getEnemiesList();
																	break;
																default:
																	this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /f &lt;A/D/L&gt; &lt;" + this.api.lang.getText("NAME") + "&gt;"]),"ERROR_CHAT");
															}
															break loop3;
														case "PING":
															this.api.network.ping();
															break loop3;
														default:
															switch(null)
															{
																case "GOD":
																case "GODMODE":
																	var var10 = ["Bill","Tyn","Nyx","Lichen","Simsoft","Kam","ToT","Sispano"];
																	this.api.kernel.showMessage(undefined,var10[Math.floor(Math.random() * var10.length)],"INFO_CHAT");
																	break loop3;
																case "APING":
																	this.api.kernel.showMessage(undefined,"Average ping : " + this.api.network.getAveragePing() + "ms (on " + this.api.network.getAveragePingPacketsCount() + " packets)","INFO_CHAT");
																	break loop3;
																case "MAPID":
																	this.api.kernel.showMessage(undefined,"MAP ID : " + this.api.datacenter.Map.id,"INFO_CHAT");
																	if(this.api.datacenter.Player.isAuthorized)
																	{
																		this.api.kernel.showMessage(undefined,"Area : " + this.api.datacenter.Map.area,"INFO_CHAT");
																		this.api.kernel.showMessage(undefined,"Sub area : " + this.api.datacenter.Map.subarea,"INFO_CHAT");
																		this.api.kernel.showMessage(undefined,"Super Area : " + this.api.datacenter.Map.superarea,"INFO_CHAT");
																	}
																	break loop3;
																case "CELLID":
																	this.api.kernel.showMessage(undefined,"CELL ID : " + this.api.datacenter.Player.data.cellNum,"INFO_CHAT");
																	break loop3;
																default:
																	switch(null)
																	{
																		case "TIME":
																			this.api.kernel.showMessage(undefined,this.api.kernel.NightManager.date + " - " + this.api.kernel.NightManager.time,"INFO_CHAT");
																			break loop3;
																		case "LIST":
																		case "PLAYERS":
																			if(!this.api.datacenter.Game.isFight)
																			{
																				this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_COMMAND_HERE",[var6]),"ERROR_CHAT");
																				return undefined;
																			}
																			var var11 = new Array();
																			var var12 = this.api.datacenter.Sprites.getItems();
																			for(var k in var12)
																			{
																				if(var12[k] instanceof dofus.datacenter.Character)
																				{
																					var11.push("- " + var12[k].name);
																				}
																			}
																			this.api.kernel.showMessage(undefined,this.api.lang.getText("PLAYERS_LIST") + " :\n" + var11.join("\n"),"INFO_CHAT");
																			break loop3;
																		case "KICK":
																			if(!this.api.datacenter.Game.isFight || this.api.datacenter.Game.isRunning)
																			{
																				this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_COMMAND_HERE",[var6]),"ERROR_CHAT");
																				return undefined;
																			}
																			var var13 = String(var5[0]);
																			var var14 = this.api.datacenter.Sprites.getItems();
																			for(var k in var14)
																			{
																				if(var14[k] instanceof dofus.datacenter.Character && var14[k].name == var13)
																				{
																					var var15 = var14[k].id;
																					break;
																				}
																			}
																			if(var15 != undefined)
																			{
																				this.api.network.Game.leave(var15);
																			}
																			else
																			{
																				this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_KICK_A",[var13]),"ERROR_CHAT");
																			}
																			break loop3;
																		default:
																			switch(null)
																			{
																				case "S":
																				case "AWAY":
																					this.api.network.Basics.away();
																					break loop3;
																				case "INVISIBLE":
																					this.api.network.Basics.invisible();
																					break loop3;
																				case "INVITE":
																					var var16 = String(var5[0]);
																					if(var16.length == 0 || var16 == undefined)
																					{
																						break loop3;
																					}
																					this.api.network.Party.invite(var16);
																					break loop3;
																				case "CONSOLE":
																					if(this.api.datacenter.Player.isAuthorized)
																					{
																						this.api.ui.loadUIComponent("Debug","Debug",undefined,{bAlwaysOnTop:true});
																					}
																					else
																					{
																						this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[var6]),"ERROR_CHAT");
																					}
																					break loop3;
																				default:
																					switch(null)
																					{
																						case "DEBUG":
																							if(this.api.datacenter.Player.isAuthorized)
																							{
																								this.api.kernel.DebugManager.toggleDebug();
																							}
																							break loop3;
																						case "CHANGECHARACTER":
																							this.api.kernel.changeServer();
																							break loop3;
																						case "LOGOUT":
																							this.api.kernel.disconnect();
																							break loop3;
																						case "QUIT":
																							this.api.kernel.quit();
																							break loop3;
																						default:
																							switch(null)
																							{
																								case "METHINK":
																								case "PENSE":
																								case "TH":
																								default:
																									switch(null)
																									{
																										case "MOI":
																										case "EMOTE":
																										case "KB":
																											this.api.ui.loadUIComponent("KnownledgeBase","KnownledgeBase");
																											break loop3;
																										case "RELEASE":
																											if(this.api.datacenter.Player.data.isTomb)
																											{
																												this.api.network.Game.freeMySoul();
																											}
																											else if(this.api.datacenter.Player.data.isSlow)
																											{
																												this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_ALREADY_A_GHOST"),"ERROR_CHAT");
																											}
																											else
																											{
																												this.api.kernel.showMessage(undefined,this.api.lang.getText("ERROR_NOT_DEAD_AT_LEAST_FOR_NOW"),"ERROR_CHAT");
																											}
																											break loop3;
																										default:
																											switch(null)
																											{
																												case "SELECTION":
																													if(var5[0] == "enable" || var5[0] == "on")
																													{
																														(dofus.graphics.gapi.ui.Banner)this.api.ui.getUIComponent("Banner").setSelectable(true);
																													}
																													else if(var5[0] == "disable" || var5[0] == "off")
																													{
																														(dofus.graphics.gapi.ui.Banner)this.api.ui.getUIComponent("Banner").setSelectable(false);
																													}
																													else
																													{
																														this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",["/selection [enable|on|disable|off]"]),"ERROR_CHAT");
																													}
																													break loop3;
																												case "WTF":
																												case "DOFUS2":
																													this.api.kernel.showMessage(undefined,"(°~°)","ERROR_BOX");
																													break loop3;
																												case "TACTIC":
																													if(this.api.datacenter.Player.isAuthorized || this.api.datacenter.Game.isFight)
																													{
																														this.api.datacenter.Game.isTacticMode = !this.api.datacenter.Game.isTacticMode;
																														this.api.ui.getUIComponent("FightOptionButtons")._btnTactic.selected = this.api.datacenter.Game.isTacticMode;
																													}
																													break loop3;
																												case "CLS":
																												case "CLEAR":
																													this.api.kernel.ChatManager.clear();
																													this.api.kernel.ChatManager.refresh(true);
																													break loop3;
																												default:
																													if(§§enum_assign() === "SPEAKINGITEM")
																													{
																														if(this.api.datacenter.Player.isAuthorized)
																														{
																															this.api.kernel.showMessage(undefined,"Count : " + this.api.kernel.SpeakingItemsManager.nextMsgDelay,"ERROR_CHAT");
																															break loop3;
																														}
																													}
																													var var19 = this.api.lang.getEmoteID(var6.toLowerCase());
																													if(var19 != undefined)
																													{
																														this.api.network.Emotes.useEmote(var19);
																														break loop3;
																													}
																													this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[var6]),"ERROR_CHAT");
																													break loop3;
																											}
																									}
																								case "ME":
																								case "EM":
																									if(!this.api.lang.getConfigText("EMOTES_ENABLED"))
																									{
																										this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[var6]),"ERROR_CHAT");
																										break loop3;
																									}
																									if(var5.length < 1)
																									{
																										this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /" + var6.toLowerCase() + " &lt;" + this.api.lang.getText("TEXT_WORD") + "&gt;"]),"ERROR_CHAT");
																										break loop3;
																									}
																									var var18 = var5.join(" ");
																									if(this.api.datacenter.Player.canChatToAll)
																									{
																										this.api.network.Chat.send(dofus.Constants.EMOTE_CHAR + var18 + dofus.Constants.EMOTE_CHAR,"*",var4);
																									}
																									break loop3;
																							}
																						case "THINK":
																							if(var5.length < 1)
																							{
																								this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /" + var6.toLowerCase() + " &lt;" + this.api.lang.getText("TEXT_WORD") + "&gt;"]),"ERROR_CHAT");
																								break loop3;
																							}
																							var var17 = "!THINK!" + var5.join(" ");
																							if(this.api.datacenter.Player.canChatToAll)
																							{
																								this.api.network.Chat.send(var17,"*",var4);
																							}
																							break loop3;
																					}
																			}
																		case "SPECTATOR":
																			if(!this.api.datacenter.Game.isRunning || this.api.datacenter.Game.isSpectator)
																			{
																				this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_COMMAND_HERE",[var6]),"ERROR_CHAT");
																				return undefined;
																			}
																			this.api.network.Fights.blockSpectators();
																			break loop3;
																	}
															}
													}
												case "F":
													if((var var0 = var5[0].toUpperCase()) !== "A")
													{
														switch(null)
														{
															case "+":
																break;
															case "D":
															case "R":
															case "-":
																this.api.network.Friends.removeFriend(var5[1]);
																break;
															case "L":
																this.api.network.Friends.getFriendsList();
																break;
															default:
																this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /f &lt;A/D/L&gt; &lt;" + this.api.lang.getText("NAME") + "&gt;"]),"ERROR_CHAT");
														}
														break loop3;
													}
													this.api.network.Friends.addFriend(var5[1]);
											}
										case "W":
											if(var5.length < 2)
											{
												this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /w &lt;" + this.api.lang.getText("NAME") + "&gt; &lt;" + this.api.lang.getText("MSG") + "&gt;"]),"ERROR_CHAT");
												break loop3;
											}
											var var8 = var5[0];
											if(var8.length < 2)
											{
												this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /w &lt;" + this.api.lang.getText("NAME") + "&gt; &lt;" + this.api.lang.getText("MSG") + "&gt;"]),"ERROR_CHAT");
												break loop3;
											}
											var5.shift();
											var var9 = var5.join(" ");
											this.pushWhisper("/w " + var8 + " ");
											this.api.network.Chat.send(var9,var8,var4);
											break loop3;
									}
							}
					}
			}
		}
		else if(this.api.datacenter.Player.canChatToAll)
		{
			this.api.network.Chat.send(var3,"*",var4);
		}
	}
	function pushWhisper(var2)
	{
		var var3 = this._aWhisperHistory.slice(-1);
		if(var3[0] != var2)
		{
			var var4 = this._aWhisperHistory.push(var2);
			if(var4 > 50)
			{
				this._aWhisperHistory.shift();
			}
		}
		this.initializePointers();
	}
	function getWhisperHistoryUp()
	{
		if(this._nWhisperHistoryPointer > 0)
		{
			this._nWhisperHistoryPointer--;
		}
		var var2 = this._aWhisperHistory[this._nWhisperHistoryPointer];
		return var2 == undefined?"":var2;
	}
	function getWhisperHistoryDown()
	{
		if(this._nWhisperHistoryPointer < this._aWhisperHistory.length)
		{
			this._nWhisperHistoryPointer++;
		}
		var var2 = this._aWhisperHistory[this._nWhisperHistoryPointer];
		return var2 == undefined?"":var2;
	}
	function initializePointers()
	{
		super.initializePointers();
		this._nWhisperHistoryPointer = this._aWhisperHistory.length;
	}
	function parseSpecialDatas(var2)
	{
		ank.utils.Extensions.addExtensions();
		var var3 = this.api.lang.getText("INLINE_VARIABLE_POSITION").split(",");
		var2 = new ank.utils.(var2).replace(var3,"[" + this.api.datacenter.Map.x + ", " + this.api.datacenter.Map.y + "]");
		var var4 = this.api.lang.getText("INLINE_VARIABLE_AREA").split(",");
		var2 = new ank.utils.(var2).replace(var4,this.api.lang.getMapAreaText(this.api.datacenter.Map.area).n);
		var var5 = this.api.lang.getText("INLINE_VARIABLE_SUBAREA").split(",");
		var2 = new ank.utils.(var2).replace(var5,this.api.lang.getMapSubAreaText(this.api.datacenter.Map.subarea).n);
		var var6 = this.api.lang.getText("INLINE_VARIABLE_MYSELF").split(",");
		var2 = new ank.utils.(var2).replace(var6,this.api.datacenter.Player.Name);
		var var7 = this.api.lang.getText("INLINE_VARIABLE_LEVEL").split(",");
		var2 = new ank.utils.(var2).replace(var7,String(this.api.datacenter.Player.Level));
		var var8 = this.api.lang.getText("INLINE_VARIABLE_GUILD").split(",");
		var var9 = this.api.datacenter.Player.guildInfos.name;
		if(var9 == undefined)
		{
			var9 = this.api.lang.getText("INLINE_VARIABLE_GUILD_ERROR");
		}
		var2 = new ank.utils.(var2).replace(var8,var9);
		var var10 = this.api.lang.getText("INLINE_VARIABLE_MAXLIFE").split(",");
		var2 = new ank.utils.(var2).replace(var10,String(this.api.datacenter.Player.LPmax));
		var var11 = this.api.lang.getText("INLINE_VARIABLE_LIFE").split(",");
		var2 = new ank.utils.(var2).replace(var11,String(this.api.datacenter.Player.LP));
		var var12 = this.api.lang.getText("INLINE_VARIABLE_LIFEPERCENT").split(",");
		var2 = new ank.utils.(var2).replace(var12,String(Math.round(this.api.datacenter.Player.LP / this.api.datacenter.Player.LPmax * 100)));
		var var13 = this.api.lang.getText("INLINE_VARIABLE_EXPERIENCE").split(",");
		var2 = new ank.utils.(var2).replace(var13,String(Math.floor((this.api.datacenter.Player.XP - this.api.datacenter.Player.XPlow) / (this.api.datacenter.Player.XPhigh - this.api.datacenter.Player.XPlow) * 100)) + "%");
		var var14 = this.api.lang.getText("INLINE_VARIABLE_STATS").split(",");
		if(new ank.utils.(var2).replace(var14,"X").length != var2.length)
		{
			var var15 = this.api.lang.getText("INLINE_VARIABLE_STATS_RESULT",[String(this.api.datacenter.Player.Vitality) + (this.api.datacenter.Player.VitalityXtra == 0?"":" (" + ((this.api.datacenter.Player.VitalityXtra <= 0?"":"+") + String(this.api.datacenter.Player.VitalityXtra)) + ")"),String(this.api.datacenter.Player.Wisdom) + (this.api.datacenter.Player.WisdomXtra == 0?"":" (" + ((this.api.datacenter.Player.WisdomXtra <= 0?"":"+") + String(this.api.datacenter.Player.WisdomXtra)) + ")"),String(this.api.datacenter.Player.Force) + (this.api.datacenter.Player.ForceXtra == 0?"":" (" + ((this.api.datacenter.Player.ForceXtra <= 0?"":"+") + String(this.api.datacenter.Player.ForceXtra)) + ")"),String(this.api.datacenter.Player.Intelligence) + (this.api.datacenter.Player.IntelligenceXtra == 0?"":" (" + ((this.api.datacenter.Player.IntelligenceXtra <= 0?"":"+") + String(this.api.datacenter.Player.IntelligenceXtra)) + ")"),String(this.api.datacenter.Player.Chance) + (this.api.datacenter.Player.ChanceXtra == 0?"":" (" + ((this.api.datacenter.Player.ChanceXtra <= 0?"":"+") + String(this.api.datacenter.Player.ChanceXtra)) + ")"),String(this.api.datacenter.Player.Agility) + (this.api.datacenter.Player.AgilityXtra == 0?"":" (" + ((this.api.datacenter.Player.AgilityXtra <= 0?"":"+") + String(this.api.datacenter.Player.AgilityXtra)) + ")"),String(this.api.datacenter.Player.Initiative),String(this.api.datacenter.Player.AP),String(this.api.datacenter.Player.MP)]);
			var2 = new ank.utils.(var2).replace(var14,var15);
		}
		return var2;
	}
}

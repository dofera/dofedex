class dofus.utils.consoleParsers.ChatConsoleParser extends dofus.utils.consoleParsers.AbstractConsoleParser
{
	function ChatConsoleParser(oAPI)
	{
		super();
		this.initialize(oAPI);
	}
	function initialize(oAPI)
	{
		super.initialize(oAPI);
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
			if((var var0 = var6) !== "HELP")
			{
				loop3:
				switch(null)
				{
					case "H":
					case "?":
						break;
					default:
						switch(null)
						{
							case "ABOUT":
							case "S":
								this.api.network.Chat.send(var5.join(" "),"*",var4);
								break loop3;
							case "T":
								this.api.network.Chat.send(var5.join(" "),"#",var4);
								break loop3;
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
							default:
								switch(null)
								{
									case "A":
										this.api.network.Chat.send(var5.join(" "),"!",var4);
										break loop3;
									case "R":
										this.api.network.Chat.send(var5.join(" "),"?",var4);
										break loop3;
									case "B":
										this.api.network.Chat.send(var5.join(" "),":",var4);
										break loop3;
									case "I":
										this.api.network.Chat.send(var5.join(" "),"^",var4);
										break loop3;
									case "Q":
										this.api.network.Chat.send(var5.join(" "),"@",var4);
										break loop3;
									default:
										switch(null)
										{
											case "M":
												this.api.network.Chat.send(var5.join(" "),"¤",var4);
												break loop3;
											case "W":
											case "MSG":
											case "WHISPER":
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
											default:
												switch(null)
												{
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
													case "F":
													case "FRIEND":
													case "FRIENDS":
														loop8:
														switch(var5[0].toUpperCase())
														{
															case "A":
															case "+":
																this.api.network.Friends.addFriend(var5[1]);
																break;
															default:
																switch(null)
																{
																	case "R":
																	case "-":
																	case "L":
																		this.api.network.Friends.getFriendsList();
																		break loop8;
																	default:
																		this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /f &lt;A/D/L&gt; &lt;" + this.api.lang.getText("NAME") + "&gt;"]),"ERROR_CHAT");
																}
															case "D":
																this.api.network.Friends.removeFriend(var5[1]);
														}
														break loop3;
													default:
														switch(null)
														{
															case "IGNORE":
															case "ENEMY":
																loop11:
																switch(var5[0].toUpperCase())
																{
																	case "A":
																	case "+":
																		this.api.network.Enemies.addEnemy(var5[1]);
																		break;
																	default:
																		switch(null)
																		{
																			case "D":
																			case "R":
																			case "-":
																				this.api.network.Enemies.removeEnemy(var5[1]);
																				break loop11;
																			case "L":
																				this.api.network.Enemies.getEnemiesList();
																				break loop11;
																			default:
																				this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /f &lt;A/D/L&gt; &lt;" + this.api.lang.getText("NAME") + "&gt;"]),"ERROR_CHAT");
																		}
																}
																break loop3;
															case "PING":
																this.api.network.ping();
																break loop3;
															case "GOD":
															case "GODMODE":
																var var12 = Math.random();
																if(var12 >= 0.5)
																{
																	var var13 = ["Bill","Tyn","Nyx","Lichen","Simsoft"];
																	var var10 = var13[Math.floor(Math.random() * var13.length)];
																	var var11 = "Legacy";
																}
																else
																{
																	var var14 = ["Kam","ToT","Sispano","LeLag","DUSK","Logan","Lakha","Sannho","Treuff","Artand","Ekyn","Bonzho","Simeth","Asthenis","Oopah"];
																	var10 = var14[Math.floor(Math.random() * var14.length)];
																	var11 = "1.30+";
																}
																this.api.kernel.showMessage(undefined,"God : <u>" + var10 + "</u> (Retro <b>" + var11 + "</b>)","COMMANDS_CHAT");
																break loop3;
															default:
																switch(null)
																{
																	case "APING":
																		this.api.kernel.showMessage(undefined,"Average ping : " + this.api.network.getAveragePing() + "ms (on " + this.api.network.getAveragePingPacketsCount() + " packets)","COMMANDS_CHAT");
																		break loop3;
																	case "MAPID":
																		this.api.kernel.showMessage(undefined,"MAP ID : " + this.api.datacenter.Map.id,"COMMANDS_CHAT");
																		if(this.api.datacenter.Player.isAuthorized)
																		{
																			this.api.kernel.showMessage(undefined,"Area : " + this.api.datacenter.Map.area,"COMMANDS_CHAT");
																			this.api.kernel.showMessage(undefined,"Sub area : " + this.api.datacenter.Map.subarea,"COMMANDS_CHAT");
																			this.api.kernel.showMessage(undefined,"Super Area : " + this.api.datacenter.Map.superarea,"COMMANDS_CHAT");
																		}
																		break loop3;
																	case "CELLID":
																		this.api.kernel.showMessage(undefined,"CELL ID : " + this.api.datacenter.Player.data.cellNum,"COMMANDS_CHAT");
																		break loop3;
																	case "TIME":
																		this.api.kernel.showMessage(undefined,this.api.kernel.NightManager.date + " - " + this.api.kernel.NightManager.time,"COMMANDS_CHAT");
																		break loop3;
																	default:
																		switch(null)
																		{
																			case "LIST":
																			case "PLAYERS":
																				if(!this.api.datacenter.Game.isFight)
																				{
																					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_COMMAND_HERE",[var6]),"ERROR_CHAT");
																					return undefined;
																				}
																				var var15 = new Array();
																				var var16 = this.api.datacenter.Sprites.getItems();
																				for(var k in var16)
																				{
																					if(var16[k] instanceof dofus.datacenter.Character)
																					{
																						var15.push("- " + var16[k].name);
																					}
																				}
																				this.api.kernel.showMessage(undefined,this.api.lang.getText("PLAYERS_LIST") + " :\n" + var15.join("\n"),"COMMANDS_CHAT");
																				break loop3;
																			case "KICK":
																				if(!this.api.datacenter.Game.isFight || this.api.datacenter.Game.isRunning)
																				{
																					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_COMMAND_HERE",[var6]),"ERROR_CHAT");
																					return undefined;
																				}
																				var var17 = String(var5[0]);
																				var var18 = this.api.datacenter.Sprites.getItems();
																				for(var k in var18)
																				{
																					if(var18[k] instanceof dofus.datacenter.Character && var18[k].name == var17)
																					{
																						var var19 = var18[k].id;
																						break;
																					}
																				}
																				if(var19 != undefined)
																				{
																					this.api.network.Game.leave(var19);
																				}
																				else
																				{
																					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_KICK_A",[var17]),"ERROR_CHAT");
																				}
																				break loop3;
																			case "SPECTATOR":
																			case "SPEC":
																				if(!this.api.datacenter.Game.isRunning || this.api.datacenter.Game.isSpectator)
																				{
																					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_COMMAND_HERE",[var6]),"ERROR_CHAT");
																					return undefined;
																				}
																				this.api.network.Fights.blockSpectators();
																				break loop3;
																			default:
																				switch(null)
																				{
																					case "AWAY":
																						this.api.network.Basics.away();
																						break loop3;
																					case "INVISIBLE":
																						this.api.network.Basics.invisible();
																						break loop3;
																					case "INVITE":
																						var var20 = String(var5[0]);
																						if(var20.length == 0 || var20 == undefined)
																						{
																							break loop3;
																						}
																						this.api.network.Party.invite(var20);
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
																													default:
																														switch(null)
																														{
																															case "FILEOUTPUT":
																																if(this.api.electron.enabled)
																																{
																																	var var23 = Number(var5[0]);
																																	if(var5[0] == undefined || (_global.isNaN(var23) || (var23 < 0 || var23 > 2)))
																																	{
																																		this.api.kernel.showMessage(undefined,"/fileoutput &lt;0 (disabled) | 1 (enabled) | 2 (full)&gt;","ERROR_CHAT");
																																		return undefined;
																																	}
																																	var var24 = "";
																																	switch(var23)
																																	{
																																		case 0:
																																			var24 = "Disabled";
																																			break;
																																		case 1:
																																			var24 = "Enabled";
																																			break;
																																		default:
																																			if(var0 !== 2)
																																			{
																																				break;
																																			}
																																			var24 = "Enabled (full)";
																																			break;
																																	}
																																	this.api.kernel.ChatManager.fileOutput = var23;
																																	this.api.kernel.showMessage(undefined,"File Output (Chat) : " + var24,"COMMANDS_CHAT");
																																}
																																else
																																{
																																	this.api.kernel.showMessage(undefined,"Does not work on a Flash Projector","COMMANDS_CHAT");
																																}
																																break loop3;
																															case "CLS":
																															case "CLEAR":
																																this.api.kernel.ChatManager.clear();
																																this.api.kernel.ChatManager.refresh(true);
																																break loop3;
																															case "SPEAKINGITEM":
																																if(this.api.datacenter.Player.isAuthorized)
																																{
																																	this.api.kernel.showMessage(undefined,"Count : " + this.api.kernel.SpeakingItemsManager.nextMsgDelay,"ERROR_CHAT");
																																	break loop3;
																																}
																															default:
																																var var25 = this.api.lang.getEmoteID(var6.toLowerCase());
																																if(var25 != undefined)
																																{
																																	this.api.network.Emotes.useEmote(var25);
																																	break loop3;
																																}
																																this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[var6]),"ERROR_CHAT");
																																break loop3;
																														}
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
																										var var22 = var5.join(" ");
																										if(this.api.datacenter.Player.canChatToAll)
																										{
																											this.api.network.Chat.send(dofus.Constants.EMOTE_CHAR + var22 + dofus.Constants.EMOTE_CHAR,"*",var4);
																										}
																										break loop3;
																								}
																							case "THINK":
																								if(var5.length < 1)
																								{
																									this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /" + var6.toLowerCase() + " &lt;" + this.api.lang.getText("TEXT_WORD") + "&gt;"]),"ERROR_CHAT");
																									break loop3;
																								}
																								var var21 = "!THINK!" + var5.join(" ");
																								if(this.api.datacenter.Player.canChatToAll)
																								{
																									this.api.network.Chat.send(var21,"*",var4);
																								}
																								break loop3;
																						}
																				}
																		}
																}
														}
												}
										}
								}
						}
					case "VERSION":
					case "VER":
						var var7 = "--------------------------------------------------------------\n";
						var7 = var7 + ("<b>DOFUS RETRO Client v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + "</b>");
						if(dofus.Constants.BETAVERSION > 0)
						{
							var7 = var7 + (" <b><font color=\"#FF0000\">BETA VERSION " + dofus.Constants.BETAVERSION + "</font></b>");
						}
						var7 = var7 + ("\n(c) ANKAMA GAMES (" + dofus.Constants.VERSIONDATE + ")\n");
						var7 = var7 + ("Flash player " + System.capabilities.version + "\n");
						var7 = var7 + "--------------------------------------------------------------";
						this.api.kernel.showMessage(undefined,var7,"COMMANDS_CHAT");
				}
			}
			this.api.kernel.showMessage(undefined,this.api.lang.getText("COMMANDS_HELP"),"COMMANDS_CHAT");
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
		var2 = new ank.utils.(var2).replace(var3,"[" + this.api.datacenter.Map.x + ", " + this.api.datacenter.Map.y + "]");
		var var4 = this.api.lang.getText("INLINE_VARIABLE_AREA").split(",");
		var2 = new ank.utils.(var2).replace(var4,this.api.lang.getMapAreaText(this.api.datacenter.Map.area).n);
		var var5 = this.api.lang.getText("INLINE_VARIABLE_SUBAREA").split(",");
		var2 = new ank.utils.(var2).replace(var5,this.api.lang.getMapSubAreaText(this.api.datacenter.Map.subarea).n);
		var var6 = this.api.lang.getText("INLINE_VARIABLE_MYSELF").split(",");
		var2 = new ank.utils.(var2).replace(var6,this.api.datacenter.Player.Name);
		var var7 = this.api.lang.getText("INLINE_VARIABLE_LEVEL").split(",");
		var2 = new ank.utils.(var2).replace(var7,String(this.api.datacenter.Player.Level));
		var var8 = this.api.lang.getText("INLINE_VARIABLE_GUILD").split(",");
		var var9 = this.api.datacenter.Player.guildInfos.name;
		if(var9 == undefined)
		{
			var9 = this.api.lang.getText("INLINE_VARIABLE_GUILD_ERROR");
		}
		var2 = new ank.utils.(var2).replace(var8,var9);
		var var10 = this.api.lang.getText("INLINE_VARIABLE_MAXLIFE").split(",");
		var2 = new ank.utils.(var2).replace(var10,String(this.api.datacenter.Player.LPmax));
		var var11 = this.api.lang.getText("INLINE_VARIABLE_LIFE").split(",");
		var2 = new ank.utils.(var2).replace(var11,String(this.api.datacenter.Player.LP));
		var var12 = this.api.lang.getText("INLINE_VARIABLE_LIFEPERCENT").split(",");
		var2 = new ank.utils.(var2).replace(var12,String(Math.round(this.api.datacenter.Player.LP / this.api.datacenter.Player.LPmax * 100)));
		var var13 = this.api.lang.getText("INLINE_VARIABLE_EXPERIENCE").split(",");
		var2 = new ank.utils.(var2).replace(var13,String(Math.floor((this.api.datacenter.Player.XP - this.api.datacenter.Player.XPlow) / (this.api.datacenter.Player.XPhigh - this.api.datacenter.Player.XPlow) * 100)) + "%");
		var var14 = this.api.lang.getText("INLINE_VARIABLE_STATS").split(",");
		if(new ank.utils.(var2).replace(var14,"X").length != var2.length)
		{
			var var15 = this.api.lang.getText("INLINE_VARIABLE_STATS_RESULT",[String(this.api.datacenter.Player.Vitality) + (this.api.datacenter.Player.VitalityXtra == 0?"":" (" + ((this.api.datacenter.Player.VitalityXtra <= 0?"":"+") + String(this.api.datacenter.Player.VitalityXtra)) + ")"),String(this.api.datacenter.Player.Wisdom) + (this.api.datacenter.Player.WisdomXtra == 0?"":" (" + ((this.api.datacenter.Player.WisdomXtra <= 0?"":"+") + String(this.api.datacenter.Player.WisdomXtra)) + ")"),String(this.api.datacenter.Player.Force) + (this.api.datacenter.Player.ForceXtra == 0?"":" (" + ((this.api.datacenter.Player.ForceXtra <= 0?"":"+") + String(this.api.datacenter.Player.ForceXtra)) + ")"),String(this.api.datacenter.Player.Intelligence) + (this.api.datacenter.Player.IntelligenceXtra == 0?"":" (" + ((this.api.datacenter.Player.IntelligenceXtra <= 0?"":"+") + String(this.api.datacenter.Player.IntelligenceXtra)) + ")"),String(this.api.datacenter.Player.Chance) + (this.api.datacenter.Player.ChanceXtra == 0?"":" (" + ((this.api.datacenter.Player.ChanceXtra <= 0?"":"+") + String(this.api.datacenter.Player.ChanceXtra)) + ")"),String(this.api.datacenter.Player.Agility) + (this.api.datacenter.Player.AgilityXtra == 0?"":" (" + ((this.api.datacenter.Player.AgilityXtra <= 0?"":"+") + String(this.api.datacenter.Player.AgilityXtra)) + ")"),String(this.api.datacenter.Player.Initiative),String(this.api.datacenter.Player.AP),String(this.api.datacenter.Player.MP)]);
			var2 = new ank.utils.(var2).replace(var14,var15);
		}
		return var2;
	}
}

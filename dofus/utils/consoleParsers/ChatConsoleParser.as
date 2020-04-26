class dofus.utils.consoleParsers.ChatConsoleParser extends dofus.utils.consoleParsers.AbstractConsoleParser
{
	function ChatConsoleParser(loc3)
	{
		super();
		this.initialize(loc3);
	}
	function initialize(loc2)
	{
		super.initialize(loc3);
		this._aWhisperHistory = new Array();
		this._nWhisperHistoryPointer = 0;
	}
	function process(loc2, loc3)
	{
		super.process(loc3,loc4);
		loc3 = this.parseSpecialDatas(loc3);
		if(loc3.charAt(0) == "/")
		{
			var loc5 = loc3.split(" ");
			var loc6 = loc5[0].substr(1).toUpperCase();
			loc5.splice(0,1);
			while(loc5[0].length == 0)
			{
				loc5.splice(0,1);
			}
			if((var loc0 = loc6) !== "HELP")
			{
				loop3:
				switch(null)
				{
					case "H":
					case "?":
						break;
					case "VERSION":
					case "VER":
					case "ABOUT":
						var loc7 = "--------------------------------------------------------------\n";
						loc7 = loc7 + ("<b>DOFUS RETRO Client v" + dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + "</b>");
						if(dofus.Constants.BETAVERSION > 0)
						{
							loc7 = loc7 + (" <b><font color=\"#FF0000\">BETA VERSION " + dofus.Constants.BETAVERSION + "</font></b>");
						}
						loc7 = loc7 + ("\n(c) ANKAMA GAMES (" + dofus.Constants.VERSIONDATE + ")\n");
						loc7 = loc7 + ("Flash player " + System.capabilities.version + "\n");
						loc7 = loc7 + "--------------------------------------------------------------";
						this.api.kernel.showMessage(undefined,loc7,"INFO_CHAT");
						break;
					default:
						switch(null)
						{
							case "T":
								this.api.network.Chat.send(loc5.join(" "),"#",loc4);
								break loop3;
							case "G":
								if(this.api.datacenter.Player.guildInfos != undefined)
								{
									this.api.network.Chat.send(loc5.join(" "),"%",loc4);
								}
								break loop3;
							case "P":
								if(this.api.ui.getUIComponent("Party") != undefined)
								{
									this.api.network.Chat.send(loc5.join(" "),"$",loc4);
								}
								break loop3;
							case "A":
								this.api.network.Chat.send(loc5.join(" "),"!",loc4);
								break loop3;
							default:
								switch(null)
								{
									case "R":
										this.api.network.Chat.send(loc5.join(" "),"?",loc4);
										break loop3;
									case "B":
										this.api.network.Chat.send(loc5.join(" "),":",loc4);
										break loop3;
									case "I":
										this.api.network.Chat.send(loc5.join(" "),"^",loc4);
										break loop3;
									case "Q":
										this.api.network.Chat.send(loc5.join(" "),"@",loc4);
										break loop3;
									default:
										switch(null)
										{
											case "M":
												this.api.network.Chat.send(loc5.join(" "),"¤",loc4);
												break loop3;
											case "W":
											case "MSG":
											case "WHISPER":
												if(loc5.length < 2)
												{
													this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /w &lt;" + this.api.lang.getText("NAME") + "&gt; &lt;" + this.api.lang.getText("MSG") + "&gt;"]),"ERROR_CHAT");
													break loop3;
												}
												var loc8 = loc5[0];
												if(loc8.length < 2)
												{
													this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /w &lt;" + this.api.lang.getText("NAME") + "&gt; &lt;" + this.api.lang.getText("MSG") + "&gt;"]),"ERROR_CHAT");
													break loop3;
												}
												loc5.shift();
												var loc9 = loc5.join(" ");
												this.pushWhisper("/w " + loc8 + " ");
												this.api.network.Chat.send(loc9,loc8,loc4);
												break loop3;
											default:
												switch(null)
												{
													case "WHOAMI":
														this.api.network.Basics.whoAmI();
														break loop3;
													case "WHOIS":
														if(loc5.length == 0)
														{
															this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /whois &lt;" + this.api.lang.getText("NAME") + "&gt;"]),"ERROR_CHAT");
															break loop3;
														}
														this.api.network.Basics.whoIs(loc5[0]);
														break loop3;
													case "F":
													case "FRIEND":
													case "FRIENDS":
														loop8:
														switch(loc5[0].toUpperCase())
														{
															case "A":
															case "+":
																this.api.network.Friends.addFriend(loc5[1]);
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
																this.api.network.Friends.removeFriend(loc5[1]);
														}
														break loop3;
													default:
														switch(null)
														{
															case "IGNORE":
															case "ENEMY":
																loop11:
																switch(loc5[0].toUpperCase())
																{
																	case "A":
																	case "+":
																		this.api.network.Enemies.addEnemy(loc5[1]);
																		break;
																	default:
																		switch(null)
																		{
																			case "R":
																			case "-":
																			case "L":
																				this.api.network.Enemies.getEnemiesList();
																				break loop11;
																			default:
																				this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /f &lt;A/D/L&gt; &lt;" + this.api.lang.getText("NAME") + "&gt;"]),"ERROR_CHAT");
																		}
																	case "D":
																		this.api.network.Enemies.removeEnemy(loc5[1]);
																}
																break loop3;
															case "PING":
																this.api.network.ping();
																break loop3;
															case "GOD":
															case "GODMODE":
																var loc10 = ["Bill","Tyn","Nyx","Lichen","Simsoft","Kam","ToT","Sispano"];
																this.api.kernel.showMessage(undefined,loc10[Math.floor(Math.random() * loc10.length)],"INFO_CHAT");
																break loop3;
															default:
																switch(null)
																{
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
																	case "TIME":
																		this.api.kernel.showMessage(undefined,this.api.kernel.NightManager.date + " - " + this.api.kernel.NightManager.time,"INFO_CHAT");
																		break loop3;
																	default:
																		switch(null)
																		{
																			case "LIST":
																			case "PLAYERS":
																				if(!this.api.datacenter.Game.isFight)
																				{
																					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_COMMAND_HERE",[loc6]),"ERROR_CHAT");
																					return undefined;
																				}
																				var loc11 = new Array();
																				var loc12 = this.api.datacenter.Sprites.getItems();
																				for(var k in loc12)
																				{
																					if(loc12[k] instanceof dofus.datacenter.Character)
																					{
																						loc11.push("- " + loc12[k].name);
																					}
																				}
																				this.api.kernel.showMessage(undefined,this.api.lang.getText("PLAYERS_LIST") + " :\n" + loc11.join("\n"),"INFO_CHAT");
																				break loop3;
																			case "KICK":
																				if(!this.api.datacenter.Game.isFight || this.api.datacenter.Game.isRunning)
																				{
																					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_COMMAND_HERE",[loc6]),"ERROR_CHAT");
																					return undefined;
																				}
																				var loc13 = String(loc5[0]);
																				var loc14 = this.api.datacenter.Sprites.getItems();
																				for(var k in loc14)
																				{
																					if(loc14[k] instanceof dofus.datacenter.Character && loc14[k].name == loc13)
																					{
																						var loc15 = loc14[k].id;
																						break;
																					}
																				}
																				if(loc15 != undefined)
																				{
																					this.api.network.Game.leave(loc15);
																				}
																				else
																				{
																					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_KICK_A",[loc13]),"ERROR_CHAT");
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
																						var loc16 = String(loc5[0]);
																						if(loc16.length == 0 || loc16 == undefined)
																						{
																							break loop3;
																						}
																						this.api.network.Party.invite(loc16);
																						break loop3;
																					default:
																						switch(null)
																						{
																							case "CONSOLE":
																								if(this.api.datacenter.Player.isAuthorized)
																								{
																									this.api.ui.loadUIComponent("Debug","Debug",undefined,{bAlwaysOnTop:true});
																								}
																								else
																								{
																									this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[loc6]),"ERROR_CHAT");
																								}
																								break loop3;
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
																									case "THINK":
																									case "METHINK":
																									case "PENSE":
																									case "TH":
																										if(loc5.length < 1)
																										{
																											this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /" + loc6.toLowerCase() + " &lt;" + this.api.lang.getText("TEXT_WORD") + "&gt;"]),"ERROR_CHAT");
																											break loop3;
																										}
																										var loc17 = "!THINK!" + loc5.join(" ");
																										if(this.api.datacenter.Player.canChatToAll)
																										{
																											this.api.network.Chat.send(loc17,"*",loc4);
																										}
																										break loop3;
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
																														if(loc5[0] == "enable" || loc5[0] == "on")
																														{
																															(dofus.graphics.gapi.ui.Banner)this.api.ui.getUIComponent("Banner").setSelectable(true);
																														}
																														else if(loc5[0] == "disable" || loc5[0] == "off")
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
																																var loc19 = this.api.lang.getEmoteID(loc6.toLowerCase());
																																if(loc19 != undefined)
																																{
																																	this.api.network.Emotes.useEmote(loc19);
																																	break loop3;
																																}
																																this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[loc6]),"ERROR_CHAT");
																																break loop3;
																														}
																												}
																										}
																									case "ME":
																									case "EM":
																										if(!this.api.lang.getConfigText("EMOTES_ENABLED"))
																										{
																											this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[loc6]),"ERROR_CHAT");
																											break loop3;
																										}
																										if(loc5.length < 1)
																										{
																											this.api.kernel.showMessage(undefined,this.api.lang.getText("SYNTAX_ERROR",[" /" + loc6.toLowerCase() + " &lt;" + this.api.lang.getText("TEXT_WORD") + "&gt;"]),"ERROR_CHAT");
																											break loop3;
																										}
																										var loc18 = loc5.join(" ");
																										if(this.api.datacenter.Player.canChatToAll)
																										{
																											this.api.network.Chat.send(dofus.Constants.EMOTE_CHAR + loc18 + dofus.Constants.EMOTE_CHAR,"*",loc4);
																										}
																										break loop3;
																								}
																						}
																				}
																			case "SPECTATOR":
																				if(!this.api.datacenter.Game.isRunning || this.api.datacenter.Game.isSpectator)
																				{
																					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_DO_COMMAND_HERE",[loc6]),"ERROR_CHAT");
																					return undefined;
																				}
																				this.api.network.Fights.blockSpectators();
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
			this.api.kernel.showMessage(undefined,this.api.lang.getText("COMMANDS_HELP"),"INFO_CHAT");
		}
		else if(this.api.datacenter.Player.canChatToAll)
		{
			this.api.network.Chat.send(loc3,"*",loc4);
		}
	}
	function pushWhisper(loc2)
	{
		var loc3 = this._aWhisperHistory.slice(-1);
		if(loc3[0] != loc2)
		{
			var loc4 = this._aWhisperHistory.push(loc2);
			if(loc4 > 50)
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
		var loc2 = this._aWhisperHistory[this._nWhisperHistoryPointer];
		return loc2 == undefined?"":loc2;
	}
	function getWhisperHistoryDown()
	{
		if(this._nWhisperHistoryPointer < this._aWhisperHistory.length)
		{
			this._nWhisperHistoryPointer++;
		}
		var loc2 = this._aWhisperHistory[this._nWhisperHistoryPointer];
		return loc2 == undefined?"":loc2;
	}
	function initializePointers()
	{
		super.initializePointers();
		this._nWhisperHistoryPointer = this._aWhisperHistory.length;
	}
	function parseSpecialDatas(loc2)
	{
		ank.utils.Extensions.addExtensions();
		var loc3 = this.api.lang.getText("INLINE_VARIABLE_POSITION").split(",");
		loc2 = new ank.utils.(loc2).replace(loc3,"[" + this.api.datacenter.Map.x + ", " + this.api.datacenter.Map.y + "]");
		var loc4 = this.api.lang.getText("INLINE_VARIABLE_AREA").split(",");
		loc2 = new ank.utils.(loc2).replace(loc4,this.api.lang.getMapAreaText(this.api.datacenter.Map.area).n);
		var loc5 = this.api.lang.getText("INLINE_VARIABLE_SUBAREA").split(",");
		loc2 = new ank.utils.(loc2).replace(loc5,this.api.lang.getMapSubAreaText(this.api.datacenter.Map.subarea).n);
		var loc6 = this.api.lang.getText("INLINE_VARIABLE_MYSELF").split(",");
		loc2 = new ank.utils.(loc2).replace(loc6,this.api.datacenter.Player.Name);
		var loc7 = this.api.lang.getText("INLINE_VARIABLE_LEVEL").split(",");
		loc2 = new ank.utils.(loc2).replace(loc7,String(this.api.datacenter.Player.Level));
		var loc8 = this.api.lang.getText("INLINE_VARIABLE_GUILD").split(",");
		var loc9 = this.api.datacenter.Player.guildInfos.name;
		if(loc9 == undefined)
		{
			loc9 = this.api.lang.getText("INLINE_VARIABLE_GUILD_ERROR");
		}
		loc2 = new ank.utils.(loc2).replace(loc8,loc9);
		var loc10 = this.api.lang.getText("INLINE_VARIABLE_MAXLIFE").split(",");
		loc2 = new ank.utils.(loc2).replace(loc10,String(this.api.datacenter.Player.LPmax));
		var loc11 = this.api.lang.getText("INLINE_VARIABLE_LIFE").split(",");
		loc2 = new ank.utils.(loc2).replace(loc11,String(this.api.datacenter.Player.LP));
		var loc12 = this.api.lang.getText("INLINE_VARIABLE_LIFEPERCENT").split(",");
		loc2 = new ank.utils.(loc2).replace(loc12,String(Math.round(this.api.datacenter.Player.LP / this.api.datacenter.Player.LPmax * 100)));
		var loc13 = this.api.lang.getText("INLINE_VARIABLE_EXPERIENCE").split(",");
		loc2 = new ank.utils.(loc2).replace(loc13,String(Math.floor((this.api.datacenter.Player.XP - this.api.datacenter.Player.XPlow) / (this.api.datacenter.Player.XPhigh - this.api.datacenter.Player.XPlow) * 100)) + "%");
		var loc14 = this.api.lang.getText("INLINE_VARIABLE_STATS").split(",");
		if(new ank.utils.(loc2).replace(loc14,"X").length != loc2.length)
		{
			var loc15 = this.api.lang.getText("INLINE_VARIABLE_STATS_RESULT",[String(this.api.datacenter.Player.Vitality) + (this.api.datacenter.Player.VitalityXtra == 0?"":" (" + ((this.api.datacenter.Player.VitalityXtra <= 0?"":"+") + String(this.api.datacenter.Player.VitalityXtra)) + ")"),String(this.api.datacenter.Player.Wisdom) + (this.api.datacenter.Player.WisdomXtra == 0?"":" (" + ((this.api.datacenter.Player.WisdomXtra <= 0?"":"+") + String(this.api.datacenter.Player.WisdomXtra)) + ")"),String(this.api.datacenter.Player.Force) + (this.api.datacenter.Player.ForceXtra == 0?"":" (" + ((this.api.datacenter.Player.ForceXtra <= 0?"":"+") + String(this.api.datacenter.Player.ForceXtra)) + ")"),String(this.api.datacenter.Player.Intelligence) + (this.api.datacenter.Player.IntelligenceXtra == 0?"":" (" + ((this.api.datacenter.Player.IntelligenceXtra <= 0?"":"+") + String(this.api.datacenter.Player.IntelligenceXtra)) + ")"),String(this.api.datacenter.Player.Chance) + (this.api.datacenter.Player.ChanceXtra == 0?"":" (" + ((this.api.datacenter.Player.ChanceXtra <= 0?"":"+") + String(this.api.datacenter.Player.ChanceXtra)) + ")"),String(this.api.datacenter.Player.Agility) + (this.api.datacenter.Player.AgilityXtra == 0?"":" (" + ((this.api.datacenter.Player.AgilityXtra <= 0?"":"+") + String(this.api.datacenter.Player.AgilityXtra)) + ")"),String(this.api.datacenter.Player.Initiative),String(this.api.datacenter.Player.AP),String(this.api.datacenter.Player.MP)]);
			loc2 = new ank.utils.(loc2).replace(loc14,loc15);
		}
		return loc2;
	}
}

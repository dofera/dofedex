class dofus.utils.consoleParsers.DebugConsoleParser extends dofus.utils.consoleParsers.AbstractConsoleParser
{
	function DebugConsoleParser(var3)
	{
		super();
		this.initialize(var3);
	}
	function initialize(var2)
	{
		super.initialize(var3);
	}
	function process(var2)
	{
		super.process(var3);
		if(var3.charAt(0) == "/")
		{
			var var4 = var3.split(" ");
			var var5 = var4[0].substr(1).toUpperCase();
			var4.splice(0,1);
			if((var var0 = var5) !== "TOGGLESPRITES")
			{
				loop13:
				switch(null)
				{
					case "SEQACTIONS":
						var var6 = this.api.datacenter.Sprites.getItems();
						for(var k in var6)
						{
							var var7 = k;
							var var8 = var6[var7];
							var var9 = var8.sequencer;
							this.api.kernel.showMessage(undefined,"    Print Sequencer Actions List for " + var7 + ", " + var8.name,"DEBUG_LOG");
							var9.printActions();
						}
						break;
					case "INFOS":
						var var10 = "Svr:";
						var10 = var10 + "\nNb:";
						var10 = var10 + ("\n Map  : " + String(this.api.datacenter.Game.playerCount));
						var10 = var10 + ("\n Cell : " + this.api.datacenter.Map.data[this.api.datacenter.Player.data.cellNum].spriteOnCount);
						var10 = var10 + "\nDataServers:";
						var var11 = 0;
						while(var11 < this.api.config.dataServers.length)
						{
							var10 = var10 + ("\n host : " + this.api.config.dataServers[var11].url);
							var11 = var11 + 1;
						}
						var10 = var10 + ("\n l   : " + this.api.config.language + " (" + this.api.lang.getLangVersion() + " & " + this.api.lang.getXtraVersion() + ")");
						this.api.kernel.showMessage(undefined,var10,"DEBUG_LOG");
						break;
					case "ZOOM":
						this.api.kernel.GameManager.zoomGfx(var4[0],var4[1],var4[2]);
						break;
					case "TIMERSCOUNT":
						this.api.kernel.showMessage(undefined,String(ank.utils.Timer.getTimersCount()),"DEBUG_LOG");
						break;
					default:
						switch(null)
						{
							case "VARS":
								this.api.kernel.showMessage(undefined,this.api.kernel.TutorialManager.vars,"DEBUG_LOG");
								break loop13;
							case "MOUNT":
								var var12 = this.api.gfx.getSprite(this.api.datacenter.Player.ID);
								if(!var12.isMounting)
								{
									var var13 = var4[0] == undefined?"7002.swf":var4[0] + ".swf";
									var var14 = var4[1] == undefined?"10.swf":var4[1] + ".swf";
									var var15 = new ank.battlefield.datacenter.Mount(dofus.Constants.CLIPS_PERSOS_PATH + var13,dofus.Constants.CHEVAUCHOR_PATH + var14);
									this.api.gfx.mountSprite(this.api.datacenter.Player.ID,var15);
								}
								else
								{
									this.api.gfx.unmountSprite(this.api.datacenter.Player.ID);
								}
								break loop13;
							case "SCALE":
								this.api.gfx.setSpriteScale(this.api.datacenter.Player.ID,var4[0],var4.length != 2?var4[0]:var4[1]);
								break loop13;
							case "ANIM":
								if(dofus.Constants.DEBUG)
								{
									if(var4.length > 1)
									{
										this.api.gfx.setSpriteLoopAnim(this.api.datacenter.Player.ID,var4[0],var4[1]);
									}
									else
									{
										this.api.gfx.setSpriteAnim(this.api.datacenter.Player.ID,var4.join(""));
									}
								}
								break loop13;
							default:
								switch(null)
								{
									case "C":
										if(dofus.Constants.DEBUG)
										{
											var var16 = var4[0];
											var4.splice(0,1);
											switch(var16)
											{
												case ">":
													this.api.network.send(var4.join(" "));
													break;
												case "<":
													this.api.network.processCommand(var4.join(" "));
											}
										}
										break loop13;
									case "D":
										if(dofus.Constants.DEBUG)
										{
											var var17 = var4[0];
											var4.splice(0,1);
											if((var0 = var17) !== ">")
											{
												if(var0 === "<")
												{
													this.api.network.processCommand(var4.join(" "));
												}
											}
											else
											{
												this.api.network.send(var4.join(" "),false,undefined,false,true);
											}
										}
										break loop13;
									case "DEBUGZAAP":
										dofus.ZaapConnect.newInstance();
										break loop13;
									case "PRINTJAILDIALOG":
										var var18 = this.api.kernel.ChatManager.getJailDialog();
										if(var18.length == 0)
										{
											this.api.kernel.showMessage(undefined,"No jail dialog found","DEBUG_LOG");
										}
										else
										{
											this.api.kernel.showMessage(undefined,var18,"DEBUG_LOG");
										}
										break loop13;
									case "MAKEREPORT":
										if(!this.api.electron.enabled)
										{
											this.api.kernel.showMessage(undefined,"This feature is not compatible on a Flash Projector","ERROR_CHAT");
											return undefined;
										}
										if(!dofus.managers.AdminManager.getInstance().isExecutingBatch)
										{
											this.api.kernel.showMessage(undefined,"You can\'t do this out of a batch execution.","ERROR_CHAT");
											return undefined;
										}
										var var19 = var3.split("|");
										var var20 = var19[0].substring(var5.length + 2);
										var var21 = var19[1] == "allaccounts";
										var var22 = var19[2];
										var var23 = var19[3].split(",");
										if(var20 == undefined || (var20.length < 1 || (var22 == undefined || var22.length < 1)))
										{
											this.api.kernel.showMessage(undefined,"/makereport &lt;target pseudos|\'allaccounts\'|reason|[autocomplete action]&gt;","DEBUG_LOG");
											return undefined;
										}
										var var24 = undefined;
										var var25 = undefined;
										if(var23 != undefined)
										{
											var var26 = 0;
											for(; var26 < var23.length; var26 = var26 + 1)
											{
												var var27 = var23[var26];
												switch(var27)
												{
													case "chatmessage":
														var24 = this.api.kernel.GameManager.lastClickedMessage;
														continue;
													case "jaildialog":
														var25 = this.api.kernel.ChatManager.getJailDialog();
													default:
														continue;
												}
											}
										}
										var var28 = (dofus.graphics.gapi.ui.MakeReport)this.api.ui.getUIComponent("MakeReport");
										if(var28 == undefined)
										{
											this.api.datacenter.Temporary.Report = new Object();
											var var29 = this.api.datacenter.Temporary.Report;
											var29.currentTargetPseudos = var20;
											var29.currentTargetIsAllAccounts = var21;
											var29.targetPseudos = var20;
											var29.description = var24;
											var29.jailDialog = var25;
											var29.isAllAccounts = var21;
											var29.reason = var22;
										}
										else
										{
											var var30 = this.api.datacenter.Temporary.Report;
											var30.currentTargetPseudos = var20;
											var30.currentTargetIsAllAccounts = var21;
											var30.targetPseudos = var30.targetPseudos + ("," + var20);
											var30.description = var24;
										}
										this.api.network.Basics.askReportInfos(1,var20,var21);
										break loop13;
									default:
										switch(null)
										{
											case "FASTSERVERSWITCH":
												var var31 = Number(var4[0]);
												if(_global.isNaN(var31) || var31 == undefined)
												{
													this.api.kernel.showMessage(undefined,"I need a valid server ID !","DEBUG_LOG");
													return undefined;
												}
												var var32 = this.api.datacenter.Player.Name;
												if(var32 == undefined)
												{
													this.api.kernel.showMessage(undefined,"You have to be in game to do this","DEBUG_LOG");
													return undefined;
												}
												var var33 = new Object();
												var33.serverId = var31;
												var33.playerName = var32;
												dofus.Kernel.FAST_SWITCHING_SERVER_REQUEST = var33;
												this.api.network.disconnect(true,false,false);
												break loop13;
											case "CLEAR":
												this.api.ui.getUIComponent("Debug").clear();
												break loop13;
											case "FILEOUTPUT":
												if(this.api.electron.enabled)
												{
													var var34 = this.api.ui.getUIComponent("Debug");
													if(var34 == undefined)
													{
														var34 = this.api.ui.loadUIComponent("Debug","Debug",undefined,{bAlwaysOnTop:true});
													}
													var var35 = Number(var4[0]);
													if(var4[0] == undefined || (_global.isNaN(var35) || (var35 < 0 || var35 > 2)))
													{
														this.api.kernel.showMessage(undefined,"/fileoutput &lt;0 (disabled) | 1 (enabled) | 2 (full)&gt;","DEBUG_LOG");
														return undefined;
													}
													var var36 = "";
													switch(var35)
													{
														case 0:
															var36 = "Disabled";
															break;
														case 1:
															var36 = "Enabled";
															break;
														case 2:
															var36 = "Enabled (full)";
													}
													var34.fileOutput = var35;
													this.api.kernel.showMessage(undefined,"File Output (Console) : " + var36,"DEBUG_LOG");
												}
												else
												{
													this.api.kernel.showMessage(undefined,"Does not work on a Flash Projector","DEBUG_ERROR");
												}
												break loop13;
											case "LOGDISCO":
												if(var4[0] == "1")
												{
													this.api.datacenter.Game.isLoggingMapDisconnections = true;
												}
												else if(var4[0] == "0")
												{
													this.api.datacenter.Game.isLoggingMapDisconnections = false;
												}
												else
												{
													this.api.datacenter.Game.isLoggingMapDisconnections = !this.api.datacenter.Game.isLoggingMapDisconnections;
												}
												this.api.kernel.showMessage(undefined,"LOG DISCONNECTIONS ON MAP : " + this.api.datacenter.Game.isLoggingMapDisconnections,"DEBUG_LOG");
												break loop13;
											case "PING":
												this.api.network.ping();
												break loop13;
											default:
												switch(null)
												{
													case "MAPID":
														this.api.kernel.showMessage(undefined,"carte : " + this.api.datacenter.Map.id,"DEBUG_LOG");
														this.api.kernel.showMessage(undefined,"Area : " + this.api.datacenter.Map.area,"DEBUG_LOG");
														this.api.kernel.showMessage(undefined,"Sub area : " + this.api.datacenter.Map.subarea,"DEBUG_LOG");
														this.api.kernel.showMessage(undefined,"Super Area : " + this.api.datacenter.Map.superarea,"DEBUG_LOG");
														break loop13;
													case "CELLID":
														this.api.kernel.showMessage(undefined,"cellule : " + this.api.datacenter.Player.data.cellNum,"DEBUG_LOG");
														break loop13;
													case "TIME":
														this.api.kernel.showMessage(undefined,"Heure : " + this.api.kernel.NightManager.time,"DEBUG_LOG");
														break loop13;
													case "CACHE":
														this.api.kernel.askClearCache();
														break loop13;
													case "REBOOT":
														this.api.kernel.reboot();
														break loop13;
													default:
														switch(null)
														{
															case "FPS":
																this.api.ui.getUIComponent("Debug").showFps();
																break loop13;
															case "UI":
																this.api.ui.loadUIComponent(var4[0],var4[0]);
																break loop13;
															case "DEBUG":
																dofus.Constants.DEBUG = !dofus.Constants.DEBUG;
																this.api.kernel.showMessage(undefined,"DEBUG : " + dofus.Constants.DEBUG,"DEBUG_LOG");
																break loop13;
															case "ASKOK":
																this.api.ui.loadUIComponent("AskOk","AskOkContent",{title:"AskOKDebug",text:this.api.lang.getText(var4[0],var4.splice(1))});
																break loop13;
															default:
																switch(null)
																{
																	case "ASKOK2":
																		var var37 = "";
																		var var38 = 0;
																		while(var38 < var4.length)
																		{
																			if(var38 > 0)
																			{
																				var37 = var37 + " ";
																			}
																			var37 = var37 + var4[var38];
																			var38 = var38 + 1;
																		}
																		this.api.ui.loadUIComponent("AskOk","AskOkContent",{title:"AskOKDebug",text:var37});
																		break loop13;
																	case "MOVIECLIP":
																		this.api.kernel.findMovieClipPath();
																		break loop13;
																	case "LOS":
																		var var39 = Number(var4[0]);
																		var var40 = Number(var4[1]);
																		if(_global.isNaN(var39) || (var39 == undefined || (_global.isNaN(var40) || var40 == undefined)))
																		{
																			this.api.kernel.showMessage(undefined,"Unable to resolve case ID","DEBUG_LOG");
																			return undefined;
																		}
																		this.api.kernel.showMessage(undefined,"Line of sight between " + var39 + " and " + var40 + " -> " + ank.battlefield.utils.Pathfinding.checkView(this.api.gfx.mapHandler,var39,var40),"DEBUG_LOG");
																		break loop13;
																	case "CLEARCELL":
																		var var41 = Number(var4[0]);
																		if(_global.isNaN(var41) || var41 == undefined)
																		{
																			this.api.kernel.showMessage(undefined,"I\'ll need an ID!","DEBUG_LOG");
																			return undefined;
																		}
																		this.api.gfx.mapHandler.getCellData(var41).removeAllSpritesOnID();
																		this.api.kernel.showMessage(undefined,"Cell " + var41 + " cleaned.","DEBUG_LOG");
																		break loop13;
																	case "CELLINFO":
																		var var42 = Number(var4[0]);
																		if(_global.isNaN(var42) || var42 == undefined)
																		{
																			this.api.kernel.showMessage(undefined,"I\'ll need an ID!","DEBUG_LOG");
																			return undefined;
																		}
																		var var43 = this.api.gfx.mapHandler.getCellData(var42);
																		this.api.kernel.showMessage(undefined,"Datas about cell " + var42 + ":","DEBUG_LOG");
																		for(var k in var43)
																		{
																			this.api.kernel.showMessage(undefined,"    " + k + " -> " + var43[k],"DEBUG_LOG");
																			if(var43[k] instanceof Object)
																			{
																				for(var l in var43[k])
																				{
																					this.api.kernel.showMessage(undefined,"        " + l + " -> " + var43[k][l],"DEBUG_LOG");
																				}
																			}
																		}
																		break loop13;
																	default:
																		switch(null)
																		{
																			case "LANGFILE":
																				this.api.kernel.showMessage(undefined,var4[0] + " lang file size : " + this.api.lang.getLangFileSize(var4[0]) + " octets","DEBUG_LOG");
																				break loop13;
																			case "POINTSPRITE":
																				this.api.kernel.TipsManager.pointSprite(-1,Number(var4[0]));
																				break loop13;
																			case "LISTSPRITES":
																				var var44 = this.api.gfx.spriteHandler.getSprites().getItems();
																				for(var k in var44)
																				{
																					this.api.kernel.showMessage(undefined,"Sprite " + var44[k].gfxFile,"DEBUG_LOG");
																				}
																				break loop13;
																			case "LISTPICTOS":
																				var var45 = this.api.gfx.mapHandler.getCellsData();
																				for(var k in var45)
																				{
																					if(var45[k].layerObject1Num != undefined && (!_global.isNaN(var45[k].layerObject1Num) && var45[k].layerObject1Num > 0))
																					{
																						this.api.kernel.showMessage(undefined,"Picto " + var45[k].layerObject1Num,"DEBUG_LOG");
																					}
																					if(var45[k].layerObject2Num != undefined && (!_global.isNaN(var45[k].layerObject2Num) && var45[k].layerObject2Num > 0))
																					{
																						this.api.kernel.showMessage(undefined,"Picto " + var45[k].layerObject2Num,"DEBUG_LOG");
																					}
																				}
																				break loop13;
																			default:
																				switch(null)
																				{
																					case "POINTPICTO":
																						this.api.kernel.TipsManager.pointPicto(-1,Number(var4[0]));
																						break loop13;
																					case "SAVETHEWORLD":
																						if(dofus.Constants.SAVING_THE_WORLD)
																						{
																							dofus.SaveTheWorld.execute();
																						}
																						else
																						{
																							this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[var5]),"DEBUG_ERROR");
																						}
																						break loop13;
																					case "STOPSAVETHEWORLD":
																						if(dofus.Constants.SAVING_THE_WORLD)
																						{
																							dofus.SaveTheWorld.stop();
																						}
																						else
																						{
																							this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[var5]),"DEBUG_ERROR");
																						}
																						break loop13;
																					case "NEXTSAVE":
																						if(dofus.Constants.SAVING_THE_WORLD)
																						{
																							dofus.SaveTheWorld.getInstance().nextAction();
																						}
																						else
																						{
																							this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[var5]),"DEBUG_ERROR");
																						}
																						break loop13;
																					default:
																						switch(null)
																						{
																							case "SOMAPLAY":
																								var var46 = var4.join(" ");
																								this.api.kernel.AudioManager.playSound(var46);
																								break loop13;
																							case "SKIPFIGHTANIMATIONS":
																								if(!dofus.Constants.ALPHA)
																								{
																									if(!this.api.datacenter.Player.isAuthorized)
																									{
																										this.api.kernel.showMessage(undefined,"(°~°)","ERROR_BOX");
																									}
																									return undefined;
																								}
																								if(var4[0] == "1")
																								{
																									this.api.datacenter.Player.isSkippingFightAnimations = true;
																								}
																								else if(var4[0] == "0")
																								{
																									this.api.datacenter.Player.isSkippingFightAnimations = false;
																								}
																								else
																								{
																									this.api.datacenter.Player.isSkippingFightAnimations = !this.api.datacenter.Player.isSkippingFightAnimations;
																								}
																								this.api.kernel.showMessage(undefined,"SKIP FIGHT ANIMATIONS : " + this.api.datacenter.Player.isSkippingFightAnimations,"DEBUG_LOG");
																								break loop13;
																							case "SKIPLOOTPANEL":
																								if(!dofus.Constants.ALPHA)
																								{
																									if(!this.api.datacenter.Player.isAuthorized)
																									{
																										this.api.kernel.showMessage(undefined,"(°~°)","ERROR_BOX");
																									}
																									return undefined;
																								}
																								if(var4[0] == "1")
																								{
																									this.api.datacenter.Player.isSkippingLootPanel = true;
																								}
																								else if(var4[0] == "0")
																								{
																									this.api.datacenter.Player.isSkippingLootPanel = false;
																								}
																								else
																								{
																									this.api.datacenter.Player.isSkippingLootPanel = !this.api.datacenter.Player.isSkippingLootPanel;
																								}
																								this.api.kernel.showMessage(undefined,"SKIP LOOT PANEL : " + this.api.datacenter.Player.isSkippingLootPanel,"DEBUG_LOG");
																								break loop13;
																							case "VERIFYIDENTITY":
																								var var47 = var4[0];
																								if(this.api.network.isValidNetworkKey(var47))
																								{
																									this.api.kernel.showMessage(undefined,var47 + ": Ok!","DEBUG_LOG");
																								}
																								else
																								{
																									this.api.kernel.showMessage(undefined,var47 + ": Failed.","DEBUG_LOG");
																									if(var47 == undefined)
																									{
																										this.api.kernel.showMessage(undefined," - Undefined identity.","DEBUG_LOG");
																									}
																									if(var47.length == 0)
																									{
																										this.api.kernel.showMessage(undefined," - Zero-length identity.","DEBUG_LOG");
																									}
																									if(var47 == "")
																									{
																										this.api.kernel.showMessage(undefined,"\t- Empty string identity.","DEBUG_LOG");
																									}
																									if(dofus.aks.Aks.checksum(var47.substr(0,var47.length - 1)) != var47.substr(var47.length - 1))
																									{
																										this.api.kernel.showMessage(undefined,"\t- First checksum is wrong. Got " + var47.substr(var47.length - 1) + ", " + dofus.aks.Aks.checksum(var47.substr(0,var47.length - 1)) + " expected.","DEBUG_LOG");
																									}
																									if(dofus.aks.Aks.checksum(var47.substr(1,var47.length - 2)) != var47.substr(0,1))
																									{
																										this.api.kernel.showMessage(undefined,"\t- Second checksum is wrong. Got " + var47.substr(0,1) + ", " + dofus.aks.Aks.checksum(var47.substr(1,var47.length - 2)) + " expected.","DEBUG_LOG");
																									}
																								}
																								break loop13;
																							case "SEARCHITEM":
																								var var48 = var3.substr(var5.length + 2);
																								if(var48 == undefined || var48.length < 2)
																								{
																									this.api.kernel.showMessage(undefined,"Syntax : /searchitem [name]","DEBUG_LOG");
																									return undefined;
																								}
																								var var49 = "";
																								var49 = var49 + ("Looking for item : " + var48);
																								var var50 = this.api.lang.getItemUnics();
																								for(var i in var50)
																								{
																									if(var50[i].n.toUpperCase().indexOf(var48.toUpperCase()) != -1)
																									{
																										var49 = var49 + ("\n " + var50[i].n + " : " + i);
																									}
																								}
																								this.api.kernel.showMessage(undefined,var49,"DEBUG_LOG");
																								break loop13;
																							default:
																								switch(null)
																								{
																									case "SEARCHMONSTER":
																										var var51 = var3.substr(var5.length + 2);
																										if(var51 == undefined || var51.length < 2)
																										{
																											this.api.kernel.showMessage(undefined,"Syntax : /searchmonster [name]","DEBUG_LOG");
																											return undefined;
																										}
																										var var52 = "";
																										var52 = var52 + ("Looking for monster : " + var51);
																										var var53 = this.api.lang.getMonsters();
																										for(var i in var53)
																										{
																											if(var53[i].n.toUpperCase().indexOf(var51.toUpperCase()) != -1)
																											{
																												var52 = var52 + ("\n " + var53[i].n + " : " + i + " (gfx : " + var53[i].g + ")");
																											}
																										}
																										this.api.kernel.showMessage(undefined,var52,"DEBUG_LOG");
																										break loop13;
																									case "SEARCHSUBAREA":
																										var var54 = var3.substr(var5.length + 2);
																										if(var54 == undefined || var54.length < 2)
																										{
																											this.api.kernel.showMessage(undefined,"Syntax : /searchsubarea [name]","DEBUG_LOG");
																											return undefined;
																										}
																										var var55 = "";
																										var55 = var55 + ("Looking for subarea : " + var54);
																										var var56 = this.api.lang.getMapSubAreas();
																										for(var i in var56)
																										{
																											if(var56[i].n.toUpperCase().indexOf(var54.toUpperCase()) != -1)
																											{
																												var55 = var55 + ("\n " + var56[i].n + " : " + i);
																											}
																										}
																										this.api.kernel.showMessage(undefined,var55,"DEBUG_LOG");
																										break loop13;
																									case "SEARCHSPELL":
																										var var57 = var3.substr(var5.length + 2);
																										if(var57 == undefined || var57.length < 2)
																										{
																											this.api.kernel.showMessage(undefined,"Syntax : /searchspell [name]","DEBUG_LOG");
																											return undefined;
																										}
																										var var58 = "";
																										var58 = var58 + ("Looking for spell : " + var57);
																										var var59 = this.api.lang.getSpells();
																										for(var i in var59)
																										{
																											if(var59[i].n.toUpperCase().indexOf(var57.toUpperCase()) != -1)
																											{
																												var58 = var58 + ("\n " + var59[i].n + " : " + i);
																											}
																										}
																										this.api.kernel.showMessage(undefined,var58,"DEBUG_LOG");
																										break loop13;
																									case "SEARCHQUEST":
																										var var60 = var3.substr(var5.length + 2);
																										if(var60 == undefined || var60.length < 2)
																										{
																											this.api.kernel.showMessage(undefined,"Syntax : /searchquest [name]","DEBUG_LOG");
																											return undefined;
																										}
																										var var61 = "";
																										var61 = var61 + ("Looking for quest : " + var60);
																										var var62 = this.api.lang.getQuests();
																										for(var i in var62)
																										{
																											if(var62[i].toUpperCase().indexOf(var60.toUpperCase()) != -1)
																											{
																												var61 = var61 + ("\n " + var62[i] + " : " + i);
																											}
																										}
																										this.api.kernel.showMessage(undefined,var61,"DEBUG_LOG");
																										break loop13;
																									default:
																										this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[var5]),"DEBUG_ERROR");
																								}
																						}
																				}
																		}
																}
														}
												}
										}
								}
						}
				}
			}
			else
			{
				this.api.datacenter.Basics.gfx_isSpritesHidden = !this.api.datacenter.Basics.gfx_isSpritesHidden;
				if(this.api.datacenter.Basics.gfx_isSpritesHidden)
				{
					this.api.gfx.spriteHandler.maskAllSprites();
				}
				else
				{
					this.api.gfx.spriteHandler.unmaskAllSprites();
				}
			}
		}
		else if(this.api.datacenter.Basics.isLogged)
		{
			this.api.network.Basics.autorisedCommand(var3);
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[var3]),"DEBUG_ERROR");
		}
	}
}

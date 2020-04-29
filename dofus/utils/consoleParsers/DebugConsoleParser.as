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
			loop11:
			switch(var5)
			{
				case "TOGGLESPRITES":
					this.api.datacenter.Basics.gfx_isSpritesHidden = !this.api.datacenter.Basics.gfx_isSpritesHidden;
					if(this.api.datacenter.Basics.gfx_isSpritesHidden)
					{
						this.api.gfx.spriteHandler.maskAllSprites();
					}
					else
					{
						this.api.gfx.spriteHandler.unmaskAllSprites();
					}
					break;
				case "INFOS":
					var var6 = "Svr:";
					var6 = var6 + "\nNb:";
					var6 = var6 + ("\n Map  : " + String(this.api.datacenter.Game.playerCount));
					var6 = var6 + ("\n Cell : " + this.api.datacenter.Map.data[this.api.datacenter.Player.data.cellNum].spriteOnCount);
					var6 = var6 + "\nDataServers:";
					var var7 = 0;
					while(var7 < this.api.config.dataServers.length)
					{
						var6 = var6 + ("\n host : " + this.api.config.dataServers[var7].url);
						var7 = var7 + 1;
					}
					var6 = var6 + ("\n l   : " + this.api.config.language + " (" + this.api.lang.getLangVersion() + " & " + this.api.lang.getXtraVersion() + ")");
					this.api.kernel.showMessage(undefined,var6,"DEBUG_LOG");
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
							break loop11;
						case "MOUNT":
							var var8 = this.api.gfx.getSprite(this.api.datacenter.Player.ID);
							if(!var8.isMounting)
							{
								var var9 = var4[0] == undefined?"7002.swf":var4[0] + ".swf";
								var var10 = var4[1] == undefined?"10.swf":var4[1] + ".swf";
								var var11 = new ank.battlefield.datacenter.Mount(dofus.Constants.CLIPS_PERSOS_PATH + var9,dofus.Constants.CHEVAUCHOR_PATH + var10);
								this.api.gfx.mountSprite(this.api.datacenter.Player.ID,var11);
							}
							else
							{
								this.api.gfx.unmountSprite(this.api.datacenter.Player.ID);
							}
							break loop11;
						case "SCALE":
							this.api.gfx.setSpriteScale(this.api.datacenter.Player.ID,var4[0],var4.length != 2?var4[0]:var4[1]);
							break loop11;
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
							break loop11;
						case "C":
							if(dofus.Constants.DEBUG)
							{
								var var12 = var4[0];
								var4.splice(0,1);
								switch(var12)
								{
									case ">":
										this.api.network.send(var4.join(" "));
										break;
									case "<":
										this.api.network.processCommand(var4.join(" "));
								}
							}
							break loop11;
						default:
							switch(null)
							{
								case "D":
									if(dofus.Constants.DEBUG)
									{
										var var13 = var4[0];
										var4.splice(0,1);
										switch(var13)
										{
											case ">":
												this.api.network.send(var4.join(" "),false,undefined,false,true);
												break;
											case "<":
												this.api.network.processCommand(var4.join(" "));
										}
									}
									break loop11;
								case "DEBUGZAAP":
									dofus.ZaapConnect.newInstance();
									break loop11;
								case "CLEAR":
									this.api.ui.getUIComponent("Debug").clear();
									break loop11;
								case "FILEOUTPUT":
									if(this.api.electron.enabled)
									{
										var var14 = this.api.ui.getUIComponent("Debug");
										if(var14 == undefined)
										{
											var14 = this.api.ui.loadUIComponent("Debug","Debug",undefined,{bAlwaysOnTop:true});
										}
										var var15 = Number(var4[0]);
										if(var4[0] == undefined || (_global.isNaN(var15) || (var15 < 0 || var15 > 2)))
										{
											this.api.kernel.showMessage(undefined,"/fileoutput &lt;0 (disabled) | 1 (enabled) | 2 (full)&gt;","DEBUG_LOG");
											return undefined;
										}
										var var16 = "";
										if((var0 = var15) !== 0)
										{
											switch(null)
											{
												case 1:
													var16 = "Enabled";
													break;
												case 2:
													var16 = "Enabled (full)";
											}
										}
										else
										{
											var16 = "Disabled";
										}
										var14.fileOutput = var15;
										this.api.kernel.showMessage(undefined,"File Output : " + var16,"DEBUG_LOG");
									}
									else
									{
										this.api.kernel.showMessage(undefined,"Does not work on a Flash Projector","DEBUG_ERROR");
									}
									break loop11;
								default:
									switch(null)
									{
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
											break loop11;
										case "PING":
											this.api.network.ping();
											break loop11;
										case "MAPID":
											this.api.kernel.showMessage(undefined,"carte : " + this.api.datacenter.Map.id,"DEBUG_LOG");
											this.api.kernel.showMessage(undefined,"Area : " + this.api.datacenter.Map.area,"DEBUG_LOG");
											this.api.kernel.showMessage(undefined,"Sub area : " + this.api.datacenter.Map.subarea,"DEBUG_LOG");
											this.api.kernel.showMessage(undefined,"Super Area : " + this.api.datacenter.Map.superarea,"DEBUG_LOG");
											break loop11;
										case "CELLID":
											this.api.kernel.showMessage(undefined,"cellule : " + this.api.datacenter.Player.data.cellNum,"DEBUG_LOG");
											break loop11;
										default:
											switch(null)
											{
												case "TIME":
													this.api.kernel.showMessage(undefined,"Heure : " + this.api.kernel.NightManager.time,"DEBUG_LOG");
													break loop11;
												case "CACHE":
													this.api.kernel.askClearCache();
													break loop11;
												case "REBOOT":
													this.api.kernel.reboot();
													break loop11;
												case "FPS":
													this.api.ui.getUIComponent("Debug").showFps();
													break loop11;
												case "UI":
													this.api.ui.loadUIComponent(var4[0],var4[0]);
													break loop11;
												default:
													switch(null)
													{
														case "DEBUG":
															dofus.Constants.DEBUG = !dofus.Constants.DEBUG;
															this.api.kernel.showMessage(undefined,"DEBUG : " + dofus.Constants.DEBUG,"DEBUG_LOG");
															break loop11;
														case "ASKOK":
															this.api.ui.loadUIComponent("AskOk","AskOkContent",{title:"AskOKDebug",text:this.api.lang.getText(var4[0],var4.splice(1))});
															break loop11;
														case "ASKOK2":
															var var17 = "";
															var var18 = 0;
															while(var18 < var4.length)
															{
																if(var18 > 0)
																{
																	var17 = var17 + " ";
																}
																var17 = var17 + var4[var18];
																var18 = var18 + 1;
															}
															this.api.ui.loadUIComponent("AskOk","AskOkContent",{title:"AskOKDebug",text:var17});
															break loop11;
														case "MOVIECLIP":
															this.api.kernel.findMovieClipPath();
															break loop11;
														default:
															switch(null)
															{
																case "LOS":
																	var var19 = Number(var4[0]);
																	var var20 = Number(var4[1]);
																	if(_global.isNaN(var19) || (var19 == undefined || (_global.isNaN(var20) || var20 == undefined)))
																	{
																		this.api.kernel.showMessage(undefined,"Unable to resolve case ID","DEBUG_LOG");
																		return undefined;
																	}
																	this.api.kernel.showMessage(undefined,"Line of sight between " + var19 + " and " + var20 + " -> " + ank.battlefield.utils.Pathfinding.checkView(this.api.gfx.mapHandler,var19,var20),"DEBUG_LOG");
																	break loop11;
																case "CLEARCELL":
																	var var21 = Number(var4[0]);
																	if(_global.isNaN(var21) || var21 == undefined)
																	{
																		this.api.kernel.showMessage(undefined,"I\'ll need an ID!","DEBUG_LOG");
																		return undefined;
																	}
																	this.api.gfx.mapHandler.getCellData(var21).removeAllSpritesOnID();
																	this.api.kernel.showMessage(undefined,"Cell " + var21 + " cleaned.","DEBUG_LOG");
																	break loop11;
																case "CELLINFO":
																	var var22 = Number(var4[0]);
																	if(_global.isNaN(var22) || var22 == undefined)
																	{
																		this.api.kernel.showMessage(undefined,"I\'ll need an ID!","DEBUG_LOG");
																		return undefined;
																	}
																	var var23 = this.api.gfx.mapHandler.getCellData(var22);
																	this.api.kernel.showMessage(undefined,"Datas about cell " + var22 + ":","DEBUG_LOG");
																	for(var k in var23)
																	{
																		this.api.kernel.showMessage(undefined,"    " + k + " -> " + var23[k],"DEBUG_LOG");
																		if(var23[k] instanceof Object)
																		{
																			for(var l in var23[k])
																			{
																				this.api.kernel.showMessage(undefined,"        " + l + " -> " + var23[k][l],"DEBUG_LOG");
																			}
																		}
																	}
																	break loop11;
																case "LANGFILE":
																	this.api.kernel.showMessage(undefined,var4[0] + " lang file size : " + this.api.lang.getLangFileSize(var4[0]) + " octets","DEBUG_LOG");
																	break loop11;
																case "POINTSPRITE":
																	this.api.kernel.TipsManager.pointSprite(-1,Number(var4[0]));
																	break loop11;
																default:
																	switch(null)
																	{
																		case "LISTSPRITES":
																			var var24 = this.api.gfx.spriteHandler.getSprites().getItems();
																			for(var k in var24)
																			{
																				this.api.kernel.showMessage(undefined,"Sprite " + var24[k].gfxFile,"DEBUG_LOG");
																			}
																			break loop11;
																		case "LISTPICTOS":
																			var var25 = this.api.gfx.mapHandler.getCellsData();
																			for(var k in var25)
																			{
																				if(var25[k].layerObject1Num != undefined && (!_global.isNaN(var25[k].layerObject1Num) && var25[k].layerObject1Num > 0))
																				{
																					this.api.kernel.showMessage(undefined,"Picto " + var25[k].layerObject1Num,"DEBUG_LOG");
																				}
																				if(var25[k].layerObject2Num != undefined && (!_global.isNaN(var25[k].layerObject2Num) && var25[k].layerObject2Num > 0))
																				{
																					this.api.kernel.showMessage(undefined,"Picto " + var25[k].layerObject2Num,"DEBUG_LOG");
																				}
																			}
																			break loop11;
																		case "POINTPICTO":
																			this.api.kernel.TipsManager.pointPicto(-1,Number(var4[0]));
																			break loop11;
																		case "SAVETHEWORLD":
																			if(dofus.Constants.SAVING_THE_WORLD)
																			{
																				dofus.SaveTheWorld.execute();
																			}
																			else
																			{
																				this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[var5]),"DEBUG_ERROR");
																			}
																			break loop11;
																		default:
																			switch(null)
																			{
																				case "STOPSAVETHEWORLD":
																					if(dofus.Constants.SAVING_THE_WORLD)
																					{
																						dofus.SaveTheWorld.stop();
																					}
																					else
																					{
																						this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[var5]),"DEBUG_ERROR");
																					}
																					break loop11;
																				case "NEXTSAVE":
																					if(dofus.Constants.SAVING_THE_WORLD)
																					{
																						dofus.SaveTheWorld.getInstance().nextAction();
																					}
																					else
																					{
																						this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[var5]),"DEBUG_ERROR");
																					}
																					break loop11;
																				case "SOMAPLAY":
																					var var26 = var4.join(" ");
																					this.api.kernel.AudioManager.playSound(var26);
																					break loop11;
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
																					break loop11;
																				default:
																					switch(null)
																					{
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
																							break loop11;
																						case "VERIFYIDENTITY":
																							var var27 = var4[0];
																							if(this.api.network.isValidNetworkKey(var27))
																							{
																								this.api.kernel.showMessage(undefined,var27 + ": Ok!","DEBUG_LOG");
																							}
																							else
																							{
																								this.api.kernel.showMessage(undefined,var27 + ": Failed.","DEBUG_LOG");
																								if(var27 == undefined)
																								{
																									this.api.kernel.showMessage(undefined," - Undefined identity.","DEBUG_LOG");
																								}
																								if(var27.length == 0)
																								{
																									this.api.kernel.showMessage(undefined," - Zero-length identity.","DEBUG_LOG");
																								}
																								if(var27 == "")
																								{
																									this.api.kernel.showMessage(undefined,"\t- Empty string identity.","DEBUG_LOG");
																								}
																								if(dofus.aks.Aks.checksum(var27.substr(0,var27.length - 1)) != var27.substr(var27.length - 1))
																								{
																									this.api.kernel.showMessage(undefined,"\t- First checksum is wrong. Got " + var27.substr(var27.length - 1) + ", " + dofus.aks.Aks.checksum(var27.substr(0,var27.length - 1)) + " expected.","DEBUG_LOG");
																								}
																								if(dofus.aks.Aks.checksum(var27.substr(1,var27.length - 2)) != var27.substr(0,1))
																								{
																									this.api.kernel.showMessage(undefined,"\t- Second checksum is wrong. Got " + var27.substr(0,1) + ", " + dofus.aks.Aks.checksum(var27.substr(1,var27.length - 2)) + " expected.","DEBUG_LOG");
																								}
																							}
																							break loop11;
																						case "SEARCHITEM":
																							var var28 = var3.substr(var5.length + 2);
																							if(var28 == undefined || var28.length < 2)
																							{
																								this.api.kernel.showMessage(undefined,"Syntax : /searchitem [name]","DEBUG_LOG");
																								return undefined;
																							}
																							var var29 = "";
																							var29 = var29 + ("Looking for item : " + var28);
																							var var30 = this.api.lang.getItemUnics();
																							for(var i in var30)
																							{
																								if(var30[i].n.toUpperCase().indexOf(var28.toUpperCase()) != -1)
																								{
																									var29 = var29 + ("\n " + var30[i].n + " : " + i);
																								}
																							}
																							this.api.kernel.showMessage(undefined,var29,"DEBUG_LOG");
																							break loop11;
																						case "SEARCHMONSTER":
																							var var31 = var3.substr(var5.length + 2);
																							if(var31 == undefined || var31.length < 2)
																							{
																								this.api.kernel.showMessage(undefined,"Syntax : /searchmonster [name]","DEBUG_LOG");
																								return undefined;
																							}
																							var var32 = "";
																							var32 = var32 + ("Looking for monster : " + var31);
																							var var33 = this.api.lang.getMonsters();
																							for(var i in var33)
																							{
																								if(var33[i].n.toUpperCase().indexOf(var31.toUpperCase()) != -1)
																								{
																									var32 = var32 + ("\n " + var33[i].n + " : " + i + " (gfx : " + var33[i].g + ")");
																								}
																							}
																							this.api.kernel.showMessage(undefined,var32,"DEBUG_LOG");
																							break loop11;
																						default:
																							switch(null)
																							{
																								case "SEARCHSUBAREA":
																									var var34 = var3.substr(var5.length + 2);
																									if(var34 == undefined || var34.length < 2)
																									{
																										this.api.kernel.showMessage(undefined,"Syntax : /searchsubarea [name]","DEBUG_LOG");
																										return undefined;
																									}
																									var var35 = "";
																									var35 = var35 + ("Looking for subarea : " + var34);
																									var var36 = this.api.lang.getMapSubAreas();
																									for(var i in var36)
																									{
																										if(var36[i].n.toUpperCase().indexOf(var34.toUpperCase()) != -1)
																										{
																											var35 = var35 + ("\n " + var36[i].n + " : " + i);
																										}
																									}
																									this.api.kernel.showMessage(undefined,var35,"DEBUG_LOG");
																									break loop11;
																								case "SEARCHSPELL":
																									var var37 = var3.substr(var5.length + 2);
																									if(var37 == undefined || var37.length < 2)
																									{
																										this.api.kernel.showMessage(undefined,"Syntax : /searchspell [name]","DEBUG_LOG");
																										return undefined;
																									}
																									var var38 = "";
																									var38 = var38 + ("Looking for spell : " + var37);
																									var var39 = this.api.lang.getSpells();
																									for(var i in var39)
																									{
																										if(var39[i].n.toUpperCase().indexOf(var37.toUpperCase()) != -1)
																										{
																											var38 = var38 + ("\n " + var39[i].n + " : " + i);
																										}
																									}
																									this.api.kernel.showMessage(undefined,var38,"DEBUG_LOG");
																									break loop11;
																								case "SEARCHQUEST":
																									var var40 = var3.substr(var5.length + 2);
																									if(var40 == undefined || var40.length < 2)
																									{
																										this.api.kernel.showMessage(undefined,"Syntax : /searchquest [name]","DEBUG_LOG");
																										return undefined;
																									}
																									var var41 = "";
																									var41 = var41 + ("Looking for quest : " + var40);
																									var var42 = this.api.lang.getQuests();
																									for(var i in var42)
																									{
																										if(var42[i].toUpperCase().indexOf(var40.toUpperCase()) != -1)
																										{
																											var41 = var41 + ("\n " + var42[i] + " : " + i);
																										}
																									}
																									this.api.kernel.showMessage(undefined,var41,"DEBUG_LOG");
																									break loop11;
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

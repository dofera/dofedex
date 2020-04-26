class dofus.utils.consoleParsers.DebugConsoleParser extends dofus.utils.consoleParsers.AbstractConsoleParser
{
	function DebugConsoleParser(loc3)
	{
		super();
		this.initialize(loc3);
	}
	function initialize(loc2)
	{
		super.initialize(loc3);
	}
	function process(loc2)
	{
		super.process(loc3);
		if(loc3.charAt(0) == "/")
		{
			var loc4 = loc3.split(" ");
			var loc5 = loc4[0].substr(1).toUpperCase();
			loc4.splice(0,1);
			loop10:
			switch(loc5)
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
					var loc6 = "Svr:";
					loc6 = loc6 + "\nNb:";
					loc6 = loc6 + ("\n Map  : " + String(this.api.datacenter.Game.playerCount));
					loc6 = loc6 + ("\n Cell : " + this.api.datacenter.Map.data[this.api.datacenter.Player.data.cellNum].spriteOnCount);
					loc6 = loc6 + "\nDataServers:";
					var loc7 = 0;
					while(loc7 < this.api.config.dataServers.length)
					{
						loc6 = loc6 + ("\n host : " + this.api.config.dataServers[loc7].url);
						loc7 = loc7 + 1;
					}
					loc6 = loc6 + ("\n l   : " + this.api.config.language + " (" + this.api.lang.getLangVersion() + " & " + this.api.lang.getXtraVersion() + ")");
					this.api.kernel.showMessage(undefined,loc6,"DEBUG_LOG");
					break;
				case "ZOOM":
					this.api.kernel.GameManager.zoomGfx(loc4[0],loc4[1],loc4[2]);
					break;
				case "TIMERSCOUNT":
					this.api.kernel.showMessage(undefined,String(ank.utils.Timer.getTimersCount()),"DEBUG_LOG");
					break;
				case "VARS":
					this.api.kernel.showMessage(undefined,this.api.kernel.TutorialManager.vars,"DEBUG_LOG");
					break;
				default:
					switch(null)
					{
						case "MOUNT":
							var loc8 = this.api.gfx.getSprite(this.api.datacenter.Player.ID);
							if(!loc8.isMounting)
							{
								var loc9 = loc4[0] == undefined?"7002.swf":loc4[0] + ".swf";
								var loc10 = loc4[1] == undefined?"10.swf":loc4[1] + ".swf";
								var loc11 = new ank.battlefield.datacenter.Mount(dofus.Constants.CLIPS_PERSOS_PATH + loc9,dofus.Constants.CHEVAUCHOR_PATH + loc10);
								this.api.gfx.mountSprite(this.api.datacenter.Player.ID,loc11);
							}
							else
							{
								this.api.gfx.unmountSprite(this.api.datacenter.Player.ID);
							}
							break loop10;
						case "SCALE":
							this.api.gfx.setSpriteScale(this.api.datacenter.Player.ID,loc4[0],loc4.length != 2?loc4[0]:loc4[1]);
							break loop10;
						case "ANIM":
							if(dofus.Constants.DEBUG)
							{
								if(loc4.length > 1)
								{
									this.api.gfx.setSpriteLoopAnim(this.api.datacenter.Player.ID,loc4[0],loc4[1]);
								}
								else
								{
									this.api.gfx.setSpriteAnim(this.api.datacenter.Player.ID,loc4.join(""));
								}
							}
							break loop10;
						case "C":
							if(dofus.Constants.DEBUG)
							{
								var loc12 = loc4[0];
								loc4.splice(0,1);
								switch(loc12)
								{
									case ">":
										this.api.network.send(loc4.join(" "));
										break;
									case "<":
										this.api.network.processCommand(loc4.join(" "));
								}
							}
							break loop10;
						case "D":
							if(dofus.Constants.DEBUG)
							{
								var loc13 = loc4[0];
								loc4.splice(0,1);
								if((loc0 = loc13) !== ">")
								{
									if(loc0 === "<")
									{
										this.api.network.processCommand(loc4.join(" "));
									}
								}
								else
								{
									this.api.network.send(loc4.join(" "),false,undefined,false,true);
								}
							}
							break loop10;
						default:
							switch(null)
							{
								case "CLEAR":
									this.api.ui.getUIComponent("Debug").clear();
									break loop10;
								case "FILEOUTPUT":
									if(this.api.electron.enabled)
									{
										var loc14 = this.api.ui.getUIComponent("Debug");
										if(loc14 == undefined)
										{
											loc14 = this.api.ui.loadUIComponent("Debug","Debug",undefined,{bAlwaysOnTop:true});
										}
										var loc15 = Number(loc4[0]);
										if(loc4[0] == undefined || (_global.isNaN(loc15) || (loc15 < 0 || loc15 > 2)))
										{
											this.api.kernel.showMessage(undefined,"/fileoutput &lt;0 (disabled) | 1 (enabled) | 2 (full)&gt;","DEBUG_LOG");
											return undefined;
										}
										var loc16 = "";
										switch(loc15)
										{
											case 0:
												loc16 = "Disabled";
												break;
											case 1:
												loc16 = "Enabled";
												break;
											case 2:
												loc16 = "Enabled (full)";
										}
										loc14.fileOutput = loc15;
										this.api.kernel.showMessage(undefined,"File Output : " + loc16,"DEBUG_LOG");
									}
									else
									{
										this.api.kernel.showMessage(undefined,"Does not work on a Flash Projector","DEBUG_ERROR");
									}
									break loop10;
								case "LOGDISCO":
									if(loc4[0] == "1")
									{
										this.api.datacenter.Game.isLoggingMapDisconnections = true;
									}
									else if(loc4[0] == "0")
									{
										this.api.datacenter.Game.isLoggingMapDisconnections = false;
									}
									else
									{
										this.api.datacenter.Game.isLoggingMapDisconnections = !this.api.datacenter.Game.isLoggingMapDisconnections;
									}
									this.api.kernel.showMessage(undefined,"LOG DISCONNECTIONS ON MAP : " + this.api.datacenter.Game.isLoggingMapDisconnections,"DEBUG_LOG");
									break loop10;
								case "PING":
									this.api.network.ping();
									break loop10;
								case "MAPID":
									this.api.kernel.showMessage(undefined,"carte : " + this.api.datacenter.Map.id,"DEBUG_LOG");
									this.api.kernel.showMessage(undefined,"Area : " + this.api.datacenter.Map.area,"DEBUG_LOG");
									this.api.kernel.showMessage(undefined,"Sub area : " + this.api.datacenter.Map.subarea,"DEBUG_LOG");
									this.api.kernel.showMessage(undefined,"Super Area : " + this.api.datacenter.Map.superarea,"DEBUG_LOG");
									break loop10;
								default:
									switch(null)
									{
										case "CELLID":
											this.api.kernel.showMessage(undefined,"cellule : " + this.api.datacenter.Player.data.cellNum,"DEBUG_LOG");
											break loop10;
										case "TIME":
											this.api.kernel.showMessage(undefined,"Heure : " + this.api.kernel.NightManager.time,"DEBUG_LOG");
											break loop10;
										case "CACHE":
											this.api.kernel.askClearCache();
											break loop10;
										case "REBOOT":
											this.api.kernel.reboot();
											break loop10;
										default:
											switch(null)
											{
												case "FPS":
													this.api.ui.getUIComponent("Debug").showFps();
													break loop10;
												case "UI":
													this.api.ui.loadUIComponent(loc4[0],loc4[0]);
													break loop10;
												case "DEBUG":
													dofus.Constants.DEBUG = !dofus.Constants.DEBUG;
													this.api.kernel.showMessage(undefined,"DEBUG : " + dofus.Constants.DEBUG,"DEBUG_LOG");
													break loop10;
												case "ASKOK":
													this.api.ui.loadUIComponent("AskOk","AskOkContent",{title:"AskOKDebug",text:this.api.lang.getText(loc4[0],loc4.splice(1))});
													break loop10;
												case "ASKOK2":
													var loc17 = "";
													var loc18 = 0;
													while(loc18 < loc4.length)
													{
														if(loc18 > 0)
														{
															loc17 = loc17 + " ";
														}
														loc17 = loc17 + loc4[loc18];
														loc18 = loc18 + 1;
													}
													this.api.ui.loadUIComponent("AskOk","AskOkContent",{title:"AskOKDebug",text:loc17});
													break loop10;
												default:
													switch(null)
													{
														case "MOVIECLIP":
															this.api.kernel.findMovieClipPath();
															break loop10;
														case "LOS":
															var loc19 = Number(loc4[0]);
															var loc20 = Number(loc4[1]);
															if(_global.isNaN(loc19) || (loc19 == undefined || (_global.isNaN(loc20) || loc20 == undefined)))
															{
																this.api.kernel.showMessage(undefined,"Unable to resolve case ID","DEBUG_LOG");
																return undefined;
															}
															this.api.kernel.showMessage(undefined,"Line of sight between " + loc19 + " and " + loc20 + " -> " + ank.battlefield.utils.Pathfinding.checkView(this.api.gfx.mapHandler,loc19,loc20),"DEBUG_LOG");
															break loop10;
														case "CLEARCELL":
															var loc21 = Number(loc4[0]);
															if(_global.isNaN(loc21) || loc21 == undefined)
															{
																this.api.kernel.showMessage(undefined,"I\'ll need an ID!","DEBUG_LOG");
																return undefined;
															}
															this.api.gfx.mapHandler.getCellData(loc21).removeAllSpritesOnID();
															this.api.kernel.showMessage(undefined,"Cell " + loc21 + " cleaned.","DEBUG_LOG");
															break loop10;
														case "CELLINFO":
															var loc22 = Number(loc4[0]);
															if(_global.isNaN(loc22) || loc22 == undefined)
															{
																this.api.kernel.showMessage(undefined,"I\'ll need an ID!","DEBUG_LOG");
																return undefined;
															}
															var loc23 = this.api.gfx.mapHandler.getCellData(loc22);
															this.api.kernel.showMessage(undefined,"Datas about cell " + loc22 + ":","DEBUG_LOG");
															for(var k in loc23)
															{
																this.api.kernel.showMessage(undefined,"    " + k + " -> " + loc23[k],"DEBUG_LOG");
																if(loc23[k] instanceof Object)
																{
																	for(var l in loc23[k])
																	{
																		this.api.kernel.showMessage(undefined,"        " + l + " -> " + loc23[k][l],"DEBUG_LOG");
																	}
																}
															}
															break loop10;
														case "LANGFILE":
															this.api.kernel.showMessage(undefined,loc4[0] + " lang file size : " + this.api.lang.getLangFileSize(loc4[0]) + " octets","DEBUG_LOG");
															break loop10;
														default:
															switch(null)
															{
																case "POINTSPRITE":
																	this.api.kernel.TipsManager.pointSprite(-1,Number(loc4[0]));
																	break loop10;
																case "LISTSPRITES":
																	var loc24 = this.api.gfx.spriteHandler.getSprites().getItems();
																	for(var k in loc24)
																	{
																		this.api.kernel.showMessage(undefined,"Sprite " + loc24[k].gfxFile,"DEBUG_LOG");
																	}
																	break loop10;
																case "LISTPICTOS":
																	var loc25 = this.api.gfx.mapHandler.getCellsData();
																	for(var k in loc25)
																	{
																		if(loc25[k].layerObject1Num != undefined && (!_global.isNaN(loc25[k].layerObject1Num) && loc25[k].layerObject1Num > 0))
																		{
																			this.api.kernel.showMessage(undefined,"Picto " + loc25[k].layerObject1Num,"DEBUG_LOG");
																		}
																		if(loc25[k].layerObject2Num != undefined && (!_global.isNaN(loc25[k].layerObject2Num) && loc25[k].layerObject2Num > 0))
																		{
																			this.api.kernel.showMessage(undefined,"Picto " + loc25[k].layerObject2Num,"DEBUG_LOG");
																		}
																	}
																	break loop10;
																case "POINTPICTO":
																	this.api.kernel.TipsManager.pointPicto(-1,Number(loc4[0]));
																	break loop10;
																case "SAVETHEWORLD":
																	if(dofus.Constants.SAVING_THE_WORLD)
																	{
																		dofus.SaveTheWorld.execute();
																	}
																	else
																	{
																		this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[loc5]),"DEBUG_ERROR");
																	}
																	break loop10;
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
																				this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[loc5]),"DEBUG_ERROR");
																			}
																			break loop10;
																		case "NEXTSAVE":
																			if(dofus.Constants.SAVING_THE_WORLD)
																			{
																				dofus.SaveTheWorld.getInstance().nextAction();
																			}
																			else
																			{
																				this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[loc5]),"DEBUG_ERROR");
																			}
																			break loop10;
																		case "SOMAPLAY":
																			var loc26 = loc4.join(" ");
																			this.api.kernel.AudioManager.playSound(loc26);
																			break loop10;
																		case "SKIPFIGHTANIMATIONS":
																			if(!dofus.Constants.ALPHA)
																			{
																				if(!this.api.datacenter.Player.isAuthorized)
																				{
																					this.api.kernel.showMessage(undefined,"(°~°)","ERROR_BOX");
																				}
																				return undefined;
																			}
																			if(loc4[0] == "1")
																			{
																				this.api.datacenter.Player.isSkippingFightAnimations = true;
																			}
																			else if(loc4[0] == "0")
																			{
																				this.api.datacenter.Player.isSkippingFightAnimations = false;
																			}
																			else
																			{
																				this.api.datacenter.Player.isSkippingFightAnimations = !this.api.datacenter.Player.isSkippingFightAnimations;
																			}
																			this.api.kernel.showMessage(undefined,"SKIP FIGHT ANIMATIONS : " + this.api.datacenter.Player.isSkippingFightAnimations,"DEBUG_LOG");
																			break loop10;
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
																					if(loc4[0] == "1")
																					{
																						this.api.datacenter.Player.isSkippingLootPanel = true;
																					}
																					else if(loc4[0] == "0")
																					{
																						this.api.datacenter.Player.isSkippingLootPanel = false;
																					}
																					else
																					{
																						this.api.datacenter.Player.isSkippingLootPanel = !this.api.datacenter.Player.isSkippingLootPanel;
																					}
																					this.api.kernel.showMessage(undefined,"SKIP LOOT PANEL : " + this.api.datacenter.Player.isSkippingLootPanel,"DEBUG_LOG");
																					break loop10;
																				case "VERIFYIDENTITY":
																					var loc27 = loc4[0];
																					if(this.api.network.isValidNetworkKey(loc27))
																					{
																						this.api.kernel.showMessage(undefined,loc27 + ": Ok!","DEBUG_LOG");
																					}
																					else
																					{
																						this.api.kernel.showMessage(undefined,loc27 + ": Failed.","DEBUG_LOG");
																						if(loc27 == undefined)
																						{
																							this.api.kernel.showMessage(undefined," - Undefined identity.","DEBUG_LOG");
																						}
																						if(loc27.length == 0)
																						{
																							this.api.kernel.showMessage(undefined," - Zero-length identity.","DEBUG_LOG");
																						}
																						if(loc27 == "")
																						{
																							this.api.kernel.showMessage(undefined,"\t- Empty string identity.","DEBUG_LOG");
																						}
																						if(dofus.aks.Aks.checksum(loc27.substr(0,loc27.length - 1)) != loc27.substr(loc27.length - 1))
																						{
																							this.api.kernel.showMessage(undefined,"\t- First checksum is wrong. Got " + loc27.substr(loc27.length - 1) + ", " + dofus.aks.Aks.checksum(loc27.substr(0,loc27.length - 1)) + " expected.","DEBUG_LOG");
																						}
																						if(dofus.aks.Aks.checksum(loc27.substr(1,loc27.length - 2)) != loc27.substr(0,1))
																						{
																							this.api.kernel.showMessage(undefined,"\t- Second checksum is wrong. Got " + loc27.substr(0,1) + ", " + dofus.aks.Aks.checksum(loc27.substr(1,loc27.length - 2)) + " expected.","DEBUG_LOG");
																						}
																					}
																					break loop10;
																				case "SEARCHITEM":
																					var loc28 = loc3.substr(loc5.length + 2);
																					if(loc28 == undefined || loc28.length < 2)
																					{
																						this.api.kernel.showMessage(undefined,"Syntax : /item [name]","DEBUG_LOG");
																						return undefined;
																					}
																					var loc29 = "";
																					loc29 = loc29 + ("Looking for item : " + loc28);
																					var loc30 = this.api.lang.getItemUnics();
																					for(var i in loc30)
																					{
																						if(loc30[i].n.toUpperCase().indexOf(loc28.toUpperCase()) != -1)
																						{
																							loc29 = loc29 + ("\n " + loc30[i].n + " : " + i);
																						}
																					}
																					this.api.kernel.showMessage(undefined,loc29,"DEBUG_LOG");
																					break loop10;
																				case "SEARCHMONSTER":
																					var loc31 = loc3.substr(loc5.length + 2);
																					if(loc31 == undefined || loc31.length < 2)
																					{
																						this.api.kernel.showMessage(undefined,"Syntax : /monster [name]","DEBUG_LOG");
																						return undefined;
																					}
																					var loc32 = "";
																					loc32 = loc32 + ("Looking for monster : " + loc31);
																					var loc33 = this.api.lang.getMonsters();
																					for(var i in loc33)
																					{
																						if(loc33[i].n.toUpperCase().indexOf(loc31.toUpperCase()) != -1)
																						{
																							loc32 = loc32 + ("\n " + loc33[i].n + " : " + i + " (gfx : " + loc33[i].g + ")");
																						}
																					}
																					this.api.kernel.showMessage(undefined,loc32,"DEBUG_LOG");
																					break loop10;
																				default:
																					switch(null)
																					{
																						case "SEARCHSUBAREA":
																							var loc34 = loc3.substr(loc5.length + 2);
																							if(loc34 == undefined || loc34.length < 2)
																							{
																								this.api.kernel.showMessage(undefined,"Syntax : /subarea [name]","DEBUG_LOG");
																								return undefined;
																							}
																							var loc35 = "";
																							loc35 = loc35 + ("Looking for subarea : " + loc34);
																							var loc36 = this.api.lang.getMapSubAreas();
																							for(var i in loc36)
																							{
																								if(loc36[i].n.toUpperCase().indexOf(loc34.toUpperCase()) != -1)
																								{
																									loc35 = loc35 + ("\n " + loc36[i].n + " : " + i);
																								}
																							}
																							this.api.kernel.showMessage(undefined,loc35,"DEBUG_LOG");
																							break loop10;
																						case "SEARCHSPELL":
																							var loc37 = loc3.substr(loc5.length + 2);
																							if(loc37 == undefined || loc37.length < 2)
																							{
																								this.api.kernel.showMessage(undefined,"Syntax : /spell [name]","DEBUG_LOG");
																								return undefined;
																							}
																							var loc38 = "";
																							loc38 = loc38 + ("Looking for spell : " + loc37);
																							var loc39 = this.api.lang.getSpells();
																							for(var i in loc39)
																							{
																								if(loc39[i].n.toUpperCase().indexOf(loc37.toUpperCase()) != -1)
																								{
																									loc38 = loc38 + ("\n " + loc39[i].n + " : " + i);
																								}
																							}
																							this.api.kernel.showMessage(undefined,loc38,"DEBUG_LOG");
																							break loop10;
																						default:
																							this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[loc5]),"DEBUG_ERROR");
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
			this.api.network.Basics.autorisedCommand(loc3);
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",[loc3]),"DEBUG_ERROR");
		}
	}
}

class dofus.aks.DataProcessor extends dofus.aks.Handler
{
	function DataProcessor(§\x1e\x1a\x19§, §\x1e\x1a\x16§)
	{
		super.initialize(var3,var4);
	}
	function process(§\x1e\x13\x10§)
	{
		var var3 = var2.charAt(0);
		var var4 = var2.charAt(1);
		var var5 = var2.charAt(2) == "E";
		this.postProcess(var3,var4,var5,var2);
	}
	function defaultProcessAction(§\x1e\f\x14§, §\x1e\x15\x07§, §\x1a\x10§, §\x1e\x13\x10§)
	{
		this.api.network.defaultProcessAction(var2,var3,var4,var5);
	}
	function postProcess(§\x1e\f\x14§, §\x1e\x15\x07§, §\x1a\x10§, §\x1e\x13\x10§)
	{
		loop0:
		switch(var2)
		{
			case "H":
				switch(var3)
				{
					case "C":
						this.aks.onHelloConnectionServer(var5.substr(2));
						break;
					case "G":
						this.aks.onHelloGameServer(var5.substr(2));
						break;
					default:
						this.aks.disconnect(false,true);
				}
				break;
			case "p":
				this.aks.onPong();
				break;
			case "q":
				this.aks.onQuickPong();
				break;
			case "r":
				this.aks.send("rpong" + var5.substr(5),false);
				break;
			default:
				switch(null)
				{
					case "M":
						this.aks.onServerMessage(var5.substr(1));
						break loop0;
					case "k":
						this.aks.onServerWillDisconnect();
						break loop0;
					case "B":
						loop3:
						switch(var3)
						{
							case "N":
								return undefined;
								break;
							case "A":
								loop4:
								switch(var5.charAt(2))
								{
									case "T":
										this.aks.Basics.onAuthorizedCommand(true,var5.substr(3));
										break;
									case "L":
										this.aks.Basics.onAuthorizedLine(var5.substr(3));
										break;
									case "P":
										this.aks.Basics.onAuthorizedCommandPrompt(var5.substr(3));
										break;
									default:
										switch(null)
										{
											case "C":
												this.aks.Basics.onAuthorizedCommandClear();
												break loop4;
											case "E":
												this.aks.Basics.onAuthorizedCommand(false);
												break loop4;
											case "I":
												if((var0 = var5.charAt(3)) !== "O")
												{
													if(var0 !== "C")
													{
														this.defaultProcessAction(var2,var3,var4,var5);
													}
													else
													{
														this.aks.Basics.onAuthorizedInterfaceClose(var5.substr(4));
													}
												}
												else
												{
													this.aks.Basics.onAuthorizedInterfaceOpen(var5.substr(4));
												}
												break loop4;
											default:
												this.defaultProcessAction(var2,var3,var4,var5);
										}
								}
								break;
							case "r":
								this.aks.Basics.onReportInfos(var5.substr(2));
								break;
							case "T":
								this.aks.Basics.onReferenceTime(var5.substr(2));
								break;
							case "D":
								this.aks.Basics.onDate(var5.substr(2));
								break;
							default:
								switch(null)
								{
									case "W":
										this.aks.Basics.onWhoIs(!var4,var5.substr(3));
										break loop3;
									case "P":
										this.aks.Basics.onSubscriberRestriction(var5.substr(2));
										break loop3;
									case "C":
										this.aks.Basics.onFileCheck(var5.substr(2));
										break loop3;
									case "p":
										this.aks.Basics.onAveragePing(var5.substr(2));
										break loop3;
									case "M":
										this.aks.Basics.onPopupMessage(var5.substr(2));
										break loop3;
									default:
										this.defaultProcessAction(var2,var3,var4,var5);
								}
						}
						break loop0;
					case "A":
						loop7:
						switch(var3)
						{
							case "E":
								var var6 = false;
								var var7 = false;
								switch(var5.charAt(2))
								{
									case "n":
										var6 = true;
										break;
									case "c":
										var7 = true;
										break;
									default:
										if(var0 !== "i")
										{
											break;
										}
										if(this.api.ui.getUIComponent("MakeMimibiote") == undefined)
										{
											this.api.ui.loadUIComponent("MakeMimibiote","MakeMimibiote");
										}
										return undefined;
								}
								var var8 = var5.charAt(3) != undefined && var5.charAt(3) == "f";
								if(this.api.ui.getUIComponent("EditPlayer") == undefined)
								{
									this.api.ui.loadUIComponent("EditPlayer","EditPlayer",{editName:var6,editColors:var7,force:var8});
								}
								break;
							case "c":
								this.aks.Account.onCommunity(var5.substr(2));
								break;
							default:
								switch(null)
								{
									case "d":
										this.aks.Account.onDofusPseudo(var5.substr(2));
										break loop7;
									case "l":
										this.aks.Account.onLogin(!var4,var5.substr(3));
										break loop7;
									case "L":
										this.aks.Account.onCharactersList(!var4,var5.substr(3));
										break loop7;
									case "x":
										this.aks.Account.onServersList(!var4,var5.substr(3));
										break loop7;
									default:
										switch(null)
										{
											case "A":
												this.aks.Account.onCharacterAdd(!var4,var5.substr(3));
												break loop7;
											case "T":
												this.aks.Account.onTicketResponse(!var4,var5.substr(3));
												break loop7;
											case "X":
												this.aks.Account.onSelectServer(!var4,true,var5.substr(3));
												break loop7;
											case "Y":
												this.aks.Account.onSelectServer(!var4,false,var5.substr(3));
												break loop7;
											case "Z":
												this.aks.Account.onSelectServerMinimal(var5.substr(3));
												break loop7;
											default:
												switch(null)
												{
													case "S":
														this.aks.Account.onCharacterSelected(!var4,var5.substr(4));
														break loop7;
													case "s":
														this.aks.Account.onStats(var5.substr(2));
														break loop7;
													case "N":
														this.aks.Account.onNewLevel(var5.substr(2));
														break loop7;
													case "R":
														this.aks.Account.onRestrictions(var5.substr(2));
														break loop7;
													case "H":
														this.aks.Account.onHosts(var5.substr(2));
														break loop7;
													default:
														switch(null)
														{
															case "r":
																this.aks.Account.onRescue(!var4);
																break loop7;
															case "g":
																this.aks.Account.onGiftsList(var5.substr(2));
																break loop7;
															case "G":
																this.aks.Account.onGiftStored(!var4);
																break loop7;
															case "q":
																this.aks.Account.onQueue(var5.substr(2));
																break loop7;
															case "f":
																this.aks.Account.onNewQueue(var5.substr(2));
																break loop7;
															default:
																switch(null)
																{
																	case "V":
																		this.aks.Account.onRegionalVersion(var5.substr(2));
																		break loop7;
																	case "P":
																		this.aks.Account.onCharacterNameGenerated(!var4,var5.substr(3));
																		break loop7;
																	case "K":
																		this.aks.Account.onKey(var5.substr(2));
																		break loop7;
																	case "Q":
																		this.aks.Account.onSecretQuestion(var5.substr(2));
																		break loop7;
																	default:
																		switch(null)
																		{
																			case "D":
																				this.aks.Account.onCharacterDelete(!var4,var5.substr(3));
																				break;
																			case "M":
																				if((var0 = var5.charAt(2)) !== "?")
																				{
																					this.aks.Account.onCharactersList(!var4,var5.substr(3),true);
																				}
																				else
																				{
																					this.aks.Account.onCharactersMigrationAskConfirm(var5.substr(3));
																				}
																				break;
																			case "F":
																				this.aks.Account.onFriendServerList(var5.substr(2));
																				break;
																			case "m":
																				if(!_global.CONFIG.isStreaming)
																				{
																					this.aks.Account.onMiniClipInfo();
																					break;
																				}
																				var var9 = _global.parseInt(var5.charAt(2),10);
																				org.flashdevelop.utils.FlashConnect.mtrace("GoToCongratulation " + var9,"dofus.aks.DataProcessor::postProcess","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/aks/DataProcessor.as",333);
																				if(_global.isNaN(var9))
																				{
																					var9 = 3;
																				}
																				org.flashdevelop.utils.FlashConnect.mtrace("GoToCongratulation " + var9,"dofus.aks.DataProcessor::postProcess","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/aks/DataProcessor.as",336);
																				getURL("FSCommand:" add "GoToCongratulation",var9);
																				break;
																		}
																}
														}
												}
										}
								}
						}
						break loop0;
					case "G":
						loop15:
						switch(var3)
						{
							case "C":
								this.aks.Game.onCreate(!var4,var5.substr(4));
								break;
							case "J":
								this.aks.Game.onJoin(var5.substr(3));
								break;
							case "P":
								this.aks.Game.onPositionStart(var5.substr(2));
								break;
							case "R":
								this.aks.Game.onReady(var5.substr(2));
								break;
							default:
								switch(null)
								{
									case "S":
										this.aks.Game.onStartToPlay();
										break loop15;
									case "E":
										this.aks.Game.onEnd(var5.substr(2));
										break loop15;
									case "M":
										this.aks.Game.onMovement(var5.substr(3));
										break loop15;
									case "c":
										this.aks.Game.onChallenge(var5.substr(2));
										break loop15;
									case "t":
										this.aks.Game.onTeam(var5.substr(2));
										break loop15;
									default:
										switch(null)
										{
											case "V":
												this.aks.Game.onLeave(true,var5.substr(2));
												break loop15;
											case "f":
												this.aks.Game.onFlag(var5.substr(2));
												break loop15;
											case "I":
												switch(var5.charAt(2))
												{
													case "C":
														this.aks.Game.onPlayersCoordinates(var5.substr(4));
														break;
													case "E":
														this.aks.Game.onEffect(var5.substr(3));
														break;
													case "e":
														this.aks.Game.onClearAllEffect(var5.substr(3));
														break;
													case "P":
														this.aks.Game.onPVP(var5.substr(3),false);
														break;
													default:
														this.defaultProcessAction(var2,var3,var4,var5);
												}
												break loop15;
											case "D":
												loop19:
												switch(var5.charAt(2))
												{
													case "M":
														this.aks.Game.onMapData(var5.substr(4));
														break;
													case "K":
														this.aks.Game.onMapLoaded();
														break;
													case "C":
														this.aks.Game.onCellData(var5.substr(3));
														break;
													case "Z":
														this.aks.Game.onZoneData(var5.substring(3));
														break;
													case "O":
														this.aks.Game.onCellObject(var5.substring(3));
														break;
													default:
														switch(null)
														{
															case "F":
																this.aks.Game.onFrameObject2(var5.substring(4));
																break loop19;
															case "E":
																this.aks.Game.onFrameObjectExternal(var5.substring(4));
																break loop19;
															default:
																this.defaultProcessAction(var2,var3,var4,var5);
														}
												}
												break loop15;
											default:
												switch(null)
												{
													case "d":
														switch(var5.charAt(3))
														{
															case "K":
																this.aks.Game.onFightChallengeUpdate(var5.substr(4),true);
																break;
															case "O":
																this.aks.Game.onFightChallengeUpdate(var5.substr(4),false);
																break;
															default:
																this.aks.Game.onFightChallenge(var5.substr(2));
														}
														break loop15;
													case "A":
														if((var0 = var5.charAt(2)) !== "S")
														{
															if(var0 !== "F")
															{
																this.aks.GameActions.onActions(var5.substr(2));
															}
															else
															{
																this.aks.GameActions.onActionsFinish(var5.substr(3));
															}
														}
														else
														{
															this.aks.GameActions.onActionsStart(var5.substr(3));
														}
														break loop15;
													case "T":
														switch(var5.charAt(2))
														{
															case "S":
																this.aks.Game.onTurnStart(var5.substr(3));
																break;
															case "F":
																this.aks.Game.onTurnFinish(var5.substr(3));
																break;
															case "L":
																this.aks.Game.onTurnlist(var5.substr(4));
																break;
															case "M":
																this.aks.Game.onTurnMiddle(var5.substr(4));
																break;
															case "R":
																this.aks.Game.onTurnReady(var5.substr(3));
																break;
															default:
																this.defaultProcessAction(var2,var3,var4,var5);
														}
														break loop15;
													case "X":
														this.aks.Game.onExtraClip(var5.substr(2));
														break loop15;
													case "o":
														this.aks.Game.onFightOption(var5.substr(2));
														break loop15;
													default:
														if(var0 !== "O")
														{
															this.defaultProcessAction(var2,var3,var4,var5);
															break loop15;
														}
														this.aks.Game.onGameOver();
														break loop15;
												}
										}
								}
						}
						break loop0;
					default:
						switch(null)
						{
							case "c":
								switch(var3)
								{
									case "M":
										this.aks.Chat.onMessage(!var4,var5.substr(3));
										break;
									case "s":
										this.aks.Chat.onServerMessage(var5.substr(2));
										break;
									case "S":
										this.aks.Chat.onSmiley(var5.substr(2));
										break;
									default:
										if(var0 !== "C")
										{
											this.defaultProcessAction(var2,var3,var4,var5);
											break;
										}
										this.aks.Chat.onSubscribeChannel(var5.substr(2));
										break;
								}
								break loop0;
							case "D":
								switch(var3)
								{
									case "A":
										this.aks.Dialog.onCustomAction(var5.substr(2));
										break;
									case "C":
										this.aks.Dialog.onCreate(!var4,var5.substr(3));
										break;
									case "Q":
										this.aks.Dialog.onQuestion(var5.substr(2));
										break;
									case "V":
										this.aks.Dialog.onLeave();
										break;
									default:
										if(var0 !== "P")
										{
											this.defaultProcessAction(var2,var3,var4,var5);
											break;
										}
										this.aks.Dialog.onPause();
										break;
								}
								break loop0;
							case "I":
								loop27:
								switch(var3)
								{
									case "M":
										this.aks.Infos.onInfoMaps(var5.substr(2));
										break;
									case "C":
										this.aks.Infos.onInfoCompass(var5.substr(2));
										break;
									case "H":
										this.aks.Infos.onInfoCoordinatespHighlight(var5.substr(2));
										break;
									default:
										switch(null)
										{
											case "m":
												this.aks.Infos.onMessage(var5.substr(2));
												break loop27;
											case "Q":
												this.aks.Infos.onQuantity(var5.substr(2));
												break loop27;
											case "O":
												this.aks.Infos.onObject(var5.substr(2));
												break loop27;
											case "L":
												if((var0 = var5.charAt(2)) !== "S")
												{
													if(var0 !== "F")
													{
														this.defaultProcessAction(var2,var3,var4,var5);
													}
													else
													{
														this.aks.Infos.onLifeRestoreTimerFinish(var5.substr(3));
													}
												}
												else
												{
													this.aks.Infos.onLifeRestoreTimerStart(var5.substr(3));
												}
												break loop27;
											default:
												this.defaultProcessAction(var2,var3,var4,var5);
										}
								}
								break loop0;
							case "S":
								loop29:
								switch(var3)
								{
									case "L":
										if((var0 = var5.charAt(2)) !== "o")
										{
											this.aks.Spells.onList(var5.substr(2));
										}
										else
										{
											this.aks.Spells.onChangeOption(var5.substr(3));
										}
										break;
									case "U":
										this.aks.Spells.onUpgradeSpell(!var4,var5.substr(3));
										break;
									default:
										switch(null)
										{
											case "B":
												this.aks.Spells.onSpellBoost(var5.substr(2));
												break loop29;
											case "F":
												this.aks.Spells.onSpellForget(var5.substr(2));
												break loop29;
											default:
												this.defaultProcessAction(var2,var3,var4,var5);
										}
								}
								break loop0;
							case "O":
								loop31:
								switch(var3)
								{
									case "a":
										this.aks.Items.onAccessories(var5.substr(2));
										break;
									case "D":
										this.aks.Items.onDrop(!var4,var5.substr(3));
										break;
									case "A":
										this.aks.Items.onAdd(!var4,var5.substr(3));
										break;
									default:
										switch(null)
										{
											case "C":
												this.aks.Items.onChange(var5.substr(3));
												break loop31;
											case "R":
												this.aks.Items.onRemove(var5.substr(2));
												break loop31;
											case "Q":
												this.aks.Items.onQuantity(var5.substr(2));
												break loop31;
											case "M":
												this.aks.Items.onMovement(var5.substr(2));
												break loop31;
											default:
												switch(null)
												{
													case "T":
														this.aks.Items.onTool(var5.substr(2));
														break loop31;
													case "w":
														this.aks.Items.onWeight(var5.substr(2));
														break loop31;
													case "S":
														this.aks.Items.onItemSet(var5.substr(2));
														break loop31;
													case "K":
														this.aks.Items.onItemUseCondition(var5.substr(2));
														break loop31;
													case "F":
														this.aks.Items.onItemFound(var5.substr(2));
														break loop31;
													default:
														this.defaultProcessAction(var2,var3,var4,var5);
												}
										}
								}
								break loop0;
							default:
								switch(null)
								{
									case "F":
										loop35:
										switch(var3)
										{
											case "A":
												this.aks.Friends.onAddFriend(!var4,var5.substr(3));
												break;
											case "D":
												this.aks.Friends.onRemoveFriend(!var4,var5.substr(3));
												break;
											default:
												switch(null)
												{
													case "L":
														this.aks.Friends.onFriendsList(var5.substr(3));
														break loop35;
													case "S":
														this.aks.Friends.onSpouse(var5.substr(2));
														break loop35;
													case "O":
														this.aks.Friends.onNotifyChange(var5.substr(2));
														break loop35;
													default:
														this.defaultProcessAction(var2,var3,var4,var5);
												}
										}
										break loop0;
									case "i":
										switch(var3)
										{
											case "A":
												this.aks.Enemies.onAddEnemy(!var4,var5.substr(3));
												break;
											case "D":
												this.aks.Enemies.onRemoveEnemy(!var4,var5.substr(3));
												break;
											case "L":
												this.aks.Enemies.onEnemiesList(var5.substr(3));
												break;
											default:
												this.defaultProcessAction(var2,var3,var4,var5);
										}
										break loop0;
									case "K":
										switch(var3)
										{
											case "C":
												this.aks.Key.onCreate(var5.substr(3));
												break;
											case "K":
												this.aks.Key.onKey(!var4);
												break;
											case "V":
												this.aks.Key.onLeave();
												break;
											default:
												this.defaultProcessAction(var2,var3,var4,var5);
										}
										break loop0;
									case "J":
										switch(var3)
										{
											case "S":
												this.aks.Job.onSkills(var5.substr(3));
												break;
											case "X":
												this.aks.Job.onXP(var5.substr(3));
												break;
											case "N":
												this.aks.Job.onLevel(var5.substr(2));
												break;
											case "R":
												this.aks.Job.onRemove(var5.substr(2));
												break;
											default:
												if(var0 !== "O")
												{
													this.defaultProcessAction(var2,var3,var4,var5);
													break;
												}
												this.aks.Job.onOptions(var5.substr(2));
												break;
										}
										break loop0;
									default:
										switch(null)
										{
											case "E":
												loop41:
												switch(var3)
												{
													case "R":
														this.aks.Exchange.onRequest(!var4,var5.substr(3));
														break;
													case "K":
														this.aks.Exchange.onReady(var5.substr(2));
														break;
													default:
														switch(null)
														{
															case "V":
																this.aks.Exchange.onLeave(!var4,var5.substr(2));
																break loop41;
															case "C":
																this.aks.Exchange.onCreate(!var4,var5.substr(3));
																break loop41;
															case "c":
																this.aks.Exchange.onCraft(!var4,var5.substr(3));
																break loop41;
															case "M":
																this.aks.Exchange.onLocalMovement(!var4,var5.substr(3));
																break loop41;
															case "m":
																this.aks.Exchange.onDistantMovement(!var4,var5.substr(3));
																break loop41;
															default:
																switch(null)
																{
																	case "r":
																		this.aks.Exchange.onCoopMovement(!var4,var5.substr(3));
																		break loop41;
																	case "p":
																		this.aks.Exchange.onPayMovement(!var4,var5.substr(2));
																		break loop41;
																	case "s":
																		this.aks.Exchange.onStorageMovement(!var4,var5.substr(3));
																		break loop41;
																	case "i":
																		this.aks.Exchange.onPlayerShopMovement(!var4,var5.substr(3));
																		break loop41;
																	case "W":
																		this.aks.Exchange.onCraftPublicMode(var5.substr(2));
																		break loop41;
																	default:
																		switch(null)
																		{
																			case "e":
																				this.aks.Exchange.onMountStorage(var5.substr(2));
																				break loop41;
																			case "f":
																				this.aks.Exchange.onMountPark(var5.substr(2));
																				break loop41;
																			case "w":
																				this.aks.Exchange.onMountPods(var5.substr(2));
																				break loop41;
																			case "L":
																				this.aks.Exchange.onList(var5.substr(2));
																				break loop41;
																			default:
																				switch(null)
																				{
																					case "S":
																						this.aks.Exchange.onSell(!var4);
																						break loop41;
																					case "B":
																						this.aks.Exchange.onBuy(!var4);
																						break loop41;
																					case "q":
																						this.aks.Exchange.onAskOfflineExchange(var5.substr(2));
																						break loop41;
																					case "H":
																						loop46:
																						switch(var5.charAt(2))
																						{
																							case "S":
																								this.aks.Exchange.onSearch(var5.substr(3));
																								break;
																							case "L":
																								this.aks.Exchange.onBigStoreTypeItemsList(var5.substr(3));
																								break;
																							case "M":
																								this.aks.Exchange.onBigStoreTypeItemsMovement(var5.substr(3));
																								break;
																							case "l":
																								this.aks.Exchange.onBigStoreItemsList(var5.substr(3));
																								break;
																							default:
																								switch(null)
																								{
																									case "m":
																										this.aks.Exchange.onBigStoreItemsMovement(var5.substr(3));
																										break loop46;
																									case "P":
																										this.aks.Exchange.onItemMiddlePriceInBigStore(var5.substr(3));
																										break loop46;
																									default:
																										this.defaultProcessAction(var2,var3,var4,var5);
																								}
																						}
																						break loop41;
																					case "J":
																						this.aks.Exchange.onCrafterListChanged(var5.substr(2));
																						break loop41;
																					default:
																						switch(null)
																						{
																							case "j":
																								this.aks.Exchange.onCrafterReference(var5.substr(2));
																								break loop41;
																							case "A":
																								this.aks.Exchange.onCraftLoop(var5.substr(2));
																								break loop41;
																							case "a":
																								this.aks.Exchange.onCraftLoopEnd(var5.substr(2));
																								break loop41;
																							default:
																								this.defaultProcessAction(var2,var3,var4,var5);
																						}
																				}
																		}
																}
														}
												}
												break loop0;
											case "h":
												loop49:
												switch(var3)
												{
													case "L":
														this.aks.Houses.onList(var5.substr(2));
														break;
													case "P":
														this.aks.Houses.onProperties(var5.substr(2));
														break;
													default:
														switch(null)
														{
															case "X":
																this.aks.Houses.onLockedProperty(var5.substr(2));
																break loop49;
															case "C":
																this.aks.Houses.onCreate(var5.substr(3));
																break loop49;
															case "S":
																this.aks.Houses.onSell(!var4,var5.substr(3));
																break loop49;
															case "B":
																this.aks.Houses.onBuy(!var4,var5.substr(3));
																break loop49;
															case "V":
																this.aks.Houses.onLeave();
																break loop49;
															default:
																if(var0 !== "G")
																{
																	this.defaultProcessAction(var2,var3,var4,var5);
																	break loop49;
																}
																this.aks.Houses.onGuildInfos(var5.substr(2));
																break loop49;
														}
												}
												break loop0;
											case "s":
												switch(var3)
												{
													case "L":
														this.aks.Storages.onList(var5.substr(2));
														break;
													case "X":
														this.aks.Storages.onLockedProperty(var5.substr(2));
														break;
													default:
														this.defaultProcessAction(var2,var3,var4,var5);
												}
												break loop0;
											case "e":
												if((var0 = var3) !== "U")
												{
													switch(null)
													{
														case "L":
															this.aks.Emotes.onList(var5.substr(2));
															break;
														case "A":
															this.aks.Emotes.onAdd(var5.substr(2));
															break;
														case "R":
															this.aks.Emotes.onRemove(var5.substr(2));
															break;
														case "D":
															this.aks.Emotes.onDirection(var5.substr(2));
															break;
														default:
															this.defaultProcessAction(var2,var3,var4,var5);
													}
												}
												else
												{
													this.aks.Emotes.onUse(!var4,var5.substr(3));
												}
												break loop0;
											case "d":
												switch(var3)
												{
													case "C":
														this.aks.Documents.onCreate(!var4,var5.substr(3));
														break;
													case "V":
														this.aks.Documents.onLeave();
														break;
													default:
														this.defaultProcessAction(var2,var3,var4,var5);
												}
												break loop0;
											case "g":
												loop54:
												switch(var3)
												{
													case "n":
														this.aks.Guild.onNew();
														break;
													case "C":
														this.aks.Guild.onCreate(!var4,var5.substr(3));
														break;
													case "S":
														this.aks.Guild.onStats(var5.substr(2));
														break;
													case "I":
														if((var0 = var5.charAt(2)) !== "G")
														{
															switch(null)
															{
																case "M":
																	this.aks.Guild.onInfosMembers(var5.substr(3));
																	break;
																case "B":
																	this.aks.Guild.onInfosBoosts(var5.substr(3));
																	break;
																case "F":
																	this.aks.Guild.onInfosMountPark(var5.substr(3));
																	break;
																case "T":
																	if((var0 = var5.charAt(3)) !== "M")
																	{
																		switch(null)
																		{
																			case "P":
																				this.aks.Guild.onInfosTaxCollectorsPlayers(var5.substr(4));
																				break;
																			case "p":
																				this.aks.Guild.onInfosTaxCollectorsAttackers(var5.substr(4));
																				break;
																			default:
																				this.defaultProcessAction(var2,var3,var4,var5);
																		}
																	}
																	else
																	{
																		this.aks.Guild.onInfosTaxCollectorsMovement(var5.substr(4));
																	}
																	break;
																default:
																	if(var0 !== "H")
																	{
																		this.defaultProcessAction(var2,var3,var4,var5);
																		break;
																	}
																	this.aks.Guild.onInfosHouses(var5.substr(3));
																	break;
															}
														}
														else
														{
															this.aks.Guild.onInfosGeneral(var5.substr(3));
														}
														break;
													default:
														switch(null)
														{
															case "J":
																loop58:
																switch(var5.charAt(2))
																{
																	case "E":
																		this.aks.Guild.onJoinError(var5.substr(3));
																		break;
																	case "R":
																		this.aks.Guild.onRequestLocal(var5.substr(3));
																		break;
																	case "r":
																		this.aks.Guild.onRequestDistant(var5.substr(3));
																		break;
																	default:
																		switch(null)
																		{
																			case "K":
																				this.aks.Guild.onJoinOk(var5.substr(3));
																				break loop58;
																			case "C":
																				this.aks.Guild.onJoinDistantOk();
																				break loop58;
																			default:
																				this.defaultProcessAction(var2,var3,var4,var5);
																		}
																}
																break loop54;
															case "V":
																this.aks.Guild.onLeave();
																break loop54;
															case "K":
																this.aks.Guild.onBann(!var4,var5.substr(3));
																break loop54;
															case "H":
																this.aks.Guild.onHireTaxCollector(!var4,var5.substr(3));
																break loop54;
															case "A":
																this.aks.Guild.onTaxCollectorAttacked(var5.substr(2));
																break loop54;
															default:
																switch(null)
																{
																	case "T":
																		this.aks.Guild.onTaxCollectorInfo(var5.substr(2));
																		break loop54;
																	case "U":
																		this.aks.Guild.onUserInterfaceOpen(var5.substr(2));
																		break loop54;
																	default:
																		this.defaultProcessAction(var2,var3,var4,var5);
																}
														}
												}
												break loop0;
											default:
												switch(null)
												{
													case "W":
														loop62:
														switch(var3)
														{
															case "C":
																this.aks.Waypoints.onCreate(var5.substr(2));
																break;
															case "V":
																this.aks.Waypoints.onLeave();
																break;
															case "U":
																this.aks.Waypoints.onUseError();
																break;
															case "c":
																this.aks.Subway.onCreate(var5.substr(2));
																break;
															case "v":
																this.aks.Subway.onLeave();
																break;
															default:
																switch(null)
																{
																	case "u":
																		this.aks.Subway.onUseError();
																		break loop62;
																	case "p":
																		this.aks.Subway.onPrismCreate(var5.substr(2));
																		break loop62;
																	case "w":
																		this.aks.Subway.onPrismLeave();
																		break loop62;
																	default:
																		this.defaultProcessAction(var2,var3,var4,var5);
																}
														}
														break loop0;
													case "a":
														switch(var3)
														{
															case "l":
																this.aks.Subareas.onList(var5.substr(3));
																break;
															case "m":
																this.aks.Subareas.onAlignmentModification(var5.substr(2));
																break;
															default:
																if(var0 !== "M")
																{
																	this.defaultProcessAction(var2,var3,var4,var5);
																	break;
																}
																this.aks.Conquest.onAreaAlignmentChanged(var5.substr(2));
																break;
														}
														break loop0;
													case "C":
														loop65:
														switch(var3)
														{
															case "I":
																switch(var5.charAt(2))
																{
																	case "J":
																		this.aks.Conquest.onPrismInfosJoined(var5.substr(3));
																		break;
																	case "V":
																		this.aks.Conquest.onPrismInfosClosing(var5.substr(3));
																		break;
																	default:
																		this.defaultProcessAction(var2,var3,var4,var5);
																}
																break;
															case "B":
																this.aks.Conquest.onConquestBonus(var5.substr(2));
																break;
															case "A":
																this.aks.Conquest.onPrismAttacked(var5.substr(2));
																break;
															case "S":
																this.aks.Conquest.onPrismSurvived(var5.substr(2));
																break;
															default:
																switch(null)
																{
																	case "D":
																		this.aks.Conquest.onPrismDead(var5.substr(2));
																		break loop65;
																	case "P":
																		this.aks.Conquest.onPrismFightAddPlayer(var5.substr(2));
																		break loop65;
																	case "p":
																		this.aks.Conquest.onPrismFightAddEnemy(var5.substr(2));
																		break loop65;
																	case "W":
																		this.aks.Conquest.onWorldData(var5.substr(2));
																		break loop65;
																	case "b":
																		this.aks.Conquest.onConquestBalance(var5.substr(2));
																		break loop65;
																	default:
																		this.defaultProcessAction(var2,var3,var4,var5);
																}
														}
														break loop0;
													case "Z":
														switch(var3)
														{
															case "S":
																this.aks.Specialization.onSet(var5.substr(2));
																break;
															case "C":
																this.aks.Specialization.onChange(var5.substr(2));
																break;
															default:
																this.defaultProcessAction(var2,var3,var4,var5);
														}
														break loop0;
													default:
														loop69:
														switch(null)
														{
															case "f":
																switch(var3)
																{
																	case "C":
																		this.aks.Fights.onCount(var5.substr(2));
																		break;
																	case "L":
																		this.aks.Fights.onList(var5.substr(2));
																		break;
																	case "D":
																		this.aks.Fights.onDetails(var5.substr(2));
																		break;
																	default:
																		this.defaultProcessAction(var2,var3,var4,var5);
																}
																break;
															case "T":
																switch(var3)
																{
																	case "C":
																		this.aks.Tutorial.onCreate(var5.substr(2));
																		break;
																	case "T":
																		this.aks.Tutorial.onShowTip(var5.substr(2));
																		break;
																	case "B":
																		this.aks.Tutorial.onGameBegin();
																		break;
																	case "q":
																		this.api.kernel.TutorialManager.forceTerminate();
																		break;
																	default:
																		this.defaultProcessAction(var2,var3,var4,var5);
																}
																break;
															case "Q":
																switch(var3)
																{
																	case "L":
																		this.aks.Quests.onList(var5.substr(3));
																		break;
																	case "S":
																		this.aks.Quests.onStep(var5.substr(2));
																		break;
																	default:
																		this.defaultProcessAction(var2,var3,var4,var5);
																}
																break;
															case "P":
																if((var0 = var3) !== "I")
																{
																	loop73:
																	switch(null)
																	{
																		case "L":
																			this.aks.Party.onLeader(var5.substr(2));
																			break;
																		case "R":
																			this.aks.Party.onRefuse(var5.substr(2));
																			break;
																		case "A":
																			this.aks.Party.onAccept(var5.substr(2));
																			break;
																		case "C":
																			this.aks.Party.onCreate(!var4,var5.substr(3));
																			break;
																		case "V":
																			this.aks.Party.onLeave(var5.substr(2));
																			break;
																		default:
																			switch(null)
																			{
																				case "F":
																					this.aks.Party.onFollow(!var4,var5.substr(3));
																					break loop73;
																				case "M":
																					this.aks.Party.onMovement(var5.substr(2));
																					break loop73;
																				default:
																					this.defaultProcessAction(var2,var3,var4,var5);
																			}
																	}
																}
																else
																{
																	this.aks.Party.onInvite(!var4,var5.substr(3));
																}
																break;
															case "R":
																if((var0 = var3) !== "e")
																{
																	switch(null)
																	{
																		case "x":
																			this.aks.Mount.onXP(var5.substr(2));
																			break loop69;
																		case "n":
																			this.aks.Mount.onName(var5.substr(2));
																			break loop69;
																		case "d":
																			this.aks.Mount.onData(var5.substr(2));
																			break loop69;
																		case "p":
																			this.aks.Mount.onMountPark(var5.substr(2));
																			break loop69;
																		case "D":
																			this.aks.Mount.onMountParkBuy(var5.substr(2));
																			break loop69;
																		default:
																			switch(null)
																			{
																				case "v":
																					this.aks.Mount.onLeave(var5.substr(2));
																					break loop69;
																				case "r":
																					this.aks.Mount.onRidingState(var5.substr(2));
																					break loop69;
																				default:
																					this.defaultProcessAction(var2,var3,var4,var5);
																			}
																	}
																}
																else
																{
																	this.aks.Mount.onEquip(var5.substr(2));
																	break;
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

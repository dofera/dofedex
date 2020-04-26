class dofus.aks.DataProcessor extends dofus.aks.Handler
{
	function DataProcessor(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function process(loc2)
	{
		var loc3 = loc2.charAt(0);
		var loc4 = loc2.charAt(1);
		var loc5 = loc2.charAt(2) == "E";
		this.postProcess(loc3,loc4,loc5,loc2);
	}
	function defaultProcessAction(loc2, loc3, loc4, loc5)
	{
		this.api.network.defaultProcessAction(loc2,loc3,loc4,loc5);
	}
	function postProcess(loc2, loc3, loc4, loc5)
	{
		loop0:
		switch(loc2)
		{
			case "H":
				switch(loc3)
				{
					case "C":
						this.aks.onHelloConnectionServer(loc5.substr(2));
						break;
					case "G":
						this.aks.onHelloGameServer(loc5.substr(2));
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
				this.aks.send("rpong" + loc5.substr(5),false);
				break;
			default:
				switch(null)
				{
					case "M":
						this.aks.onServerMessage(loc5.substr(1));
						break loop0;
					case "k":
						this.aks.onServerWillDisconnect();
						break loop0;
					case "B":
						loop3:
						switch(loc3)
						{
							case "N":
								return undefined;
								break;
							case "A":
								loop4:
								switch(loc5.charAt(2))
								{
									case "T":
										this.aks.Basics.onAuthorizedCommand(true,loc5.substr(3));
										break;
									case "L":
										this.aks.Basics.onAuthorizedLine(loc5.substr(3));
										break;
									default:
										switch(null)
										{
											case "P":
												this.aks.Basics.onAuthorizedCommandPrompt(loc5.substr(3));
												break loop4;
											case "C":
												this.aks.Basics.onAuthorizedCommandClear();
												break loop4;
											case "E":
												this.aks.Basics.onAuthorizedCommand(false);
												break loop4;
											case "I":
												if((loc0 = loc5.charAt(3)) !== "O")
												{
													if(loc0 !== "C")
													{
														this.defaultProcessAction(loc2,loc3,loc4,loc5);
													}
													else
													{
														this.aks.Basics.onAuthorizedInterfaceClose(loc5.substr(4));
													}
												}
												else
												{
													this.aks.Basics.onAuthorizedInterfaceOpen(loc5.substr(4));
												}
												break loop4;
											default:
												this.defaultProcessAction(loc2,loc3,loc4,loc5);
										}
								}
								break;
							case "T":
								this.aks.Basics.onReferenceTime(loc5.substr(2));
								break;
							case "D":
								this.aks.Basics.onDate(loc5.substr(2));
								break;
							case "W":
								this.aks.Basics.onWhoIs(!loc4,loc5.substr(3));
								break;
							default:
								switch(null)
								{
									case "P":
										this.aks.Basics.onSubscriberRestriction(loc5.substr(2));
										break loop3;
									case "C":
										this.aks.Basics.onFileCheck(loc5.substr(2));
										break loop3;
									case "p":
										this.aks.Basics.onAveragePing(loc5.substr(2));
										break loop3;
									case "M":
										this.aks.Basics.onPopupMessage(loc5.substr(2));
										break loop3;
									default:
										this.defaultProcessAction(loc2,loc3,loc4,loc5);
								}
						}
						break loop0;
					case "A":
						loop7:
						switch(loc3)
						{
							case "E":
								var loc6 = false;
								var loc7 = false;
								if((loc0 = loc5.charAt(2)) !== "n")
								{
									if(loc0 === "c")
									{
										loc7 = true;
									}
								}
								else
								{
									loc6 = true;
								}
								var loc8 = loc5.charAt(3) != undefined && loc5.charAt(3) == "f";
								if(this.api.ui.getUIComponent("EditPlayer") == undefined)
								{
									this.api.ui.loadUIComponent("EditPlayer","EditPlayer",{editName:loc6,editColors:loc7,force:loc8});
								}
								break;
							case "c":
								this.aks.Account.onCommunity(loc5.substr(2));
								break;
							case "d":
								this.aks.Account.onDofusPseudo(loc5.substr(2));
								break;
							case "l":
								this.aks.Account.onLogin(!loc4,loc5.substr(3));
								break;
							default:
								switch(null)
								{
									case "L":
										this.aks.Account.onCharactersList(!loc4,loc5.substr(3));
										break loop7;
									case "x":
										this.aks.Account.onServersList(!loc4,loc5.substr(3));
										break loop7;
									case "A":
										this.aks.Account.onCharacterAdd(!loc4,loc5.substr(3));
										break loop7;
									case "T":
										this.aks.Account.onTicketResponse(!loc4,loc5.substr(3));
										break loop7;
									default:
										switch(null)
										{
											case "X":
												this.aks.Account.onSelectServer(!loc4,true,loc5.substr(3));
												break loop7;
											case "Y":
												this.aks.Account.onSelectServer(!loc4,false,loc5.substr(3));
												break loop7;
											case "S":
												this.aks.Account.onCharacterSelected(!loc4,loc5.substr(4));
												break loop7;
											case "s":
												this.aks.Account.onStats(loc5.substr(2));
												break loop7;
											case "N":
												this.aks.Account.onNewLevel(loc5.substr(2));
												break loop7;
											default:
												switch(null)
												{
													case "R":
														this.aks.Account.onRestrictions(loc5.substr(2));
														break loop7;
													case "H":
														this.aks.Account.onHosts(loc5.substr(2));
														break loop7;
													case "r":
														this.aks.Account.onRescue(!loc4);
														break loop7;
													case "g":
														this.aks.Account.onGiftsList(loc5.substr(2));
														break loop7;
													case "G":
														this.aks.Account.onGiftStored(!loc4);
														break loop7;
													default:
														switch(null)
														{
															case "q":
																this.aks.Account.onQueue(loc5.substr(2));
																break loop7;
															case "f":
																this.aks.Account.onNewQueue(loc5.substr(2));
																break loop7;
															case "V":
																this.aks.Account.onRegionalVersion(loc5.substr(2));
																break loop7;
															case "P":
																this.aks.Account.onCharacterNameGenerated(!loc4,loc5.substr(3));
																break loop7;
															default:
																switch(null)
																{
																	case "K":
																		this.aks.Account.onKey(loc5.substr(2));
																		break loop7;
																	case "Q":
																		this.aks.Account.onSecretQuestion(loc5.substr(2));
																		break loop7;
																	case "D":
																		this.aks.Account.onCharacterDelete(!loc4,loc5.substr(3));
																		break loop7;
																	case "M":
																		if((loc0 = loc5.charAt(2)) !== "?")
																		{
																			this.aks.Account.onCharactersList(!loc4,loc5.substr(3),true);
																		}
																		else
																		{
																			this.aks.Account.onCharactersMigrationAskConfirm(loc5.substr(3));
																		}
																		break loop7;
																	case "F":
																		this.aks.Account.onFriendServerList(loc5.substr(2));
																		break loop7;
																	case "m":
																		if(!_global.CONFIG.isStreaming)
																		{
																			this.aks.Account.onMiniClipInfo();
																			break loop7;
																		}
																		var loc9 = _global.parseInt(loc5.charAt(2),10);
																		if(_global.isNaN(loc9))
																		{
																			loc9 = 3;
																		}
																		getURL("FSCommand:" add "GoToCongratulation",loc9);
																		break loop7;
																}
														}
												}
										}
								}
						}
						break loop0;
					case "G":
						loop13:
						switch(loc3)
						{
							case "C":
								this.aks.Game.onCreate(!loc4,loc5.substr(4));
								break;
							case "J":
								this.aks.Game.onJoin(loc5.substr(3));
								break;
							case "P":
								this.aks.Game.onPositionStart(loc5.substr(2));
								break;
							default:
								switch(null)
								{
									case "R":
										this.aks.Game.onReady(loc5.substr(2));
										break loop13;
									case "S":
										this.aks.Game.onStartToPlay();
										break loop13;
									case "E":
										this.aks.Game.onEnd(loc5.substr(2));
										break loop13;
									case "M":
										this.aks.Game.onMovement(loc5.substr(3));
										break loop13;
									case "c":
										this.aks.Game.onChallenge(loc5.substr(2));
										break loop13;
									default:
										switch(null)
										{
											case "t":
												this.aks.Game.onTeam(loc5.substr(2));
												break loop13;
											case "V":
												this.aks.Game.onLeave(true,loc5.substr(2));
												break loop13;
											case "f":
												this.aks.Game.onFlag(loc5.substr(2));
												break loop13;
											case "I":
												switch(loc5.charAt(2))
												{
													case "C":
														this.aks.Game.onPlayersCoordinates(loc5.substr(4));
														break;
													case "E":
														this.aks.Game.onEffect(loc5.substr(3));
														break;
													case "e":
														this.aks.Game.onClearAllEffect(loc5.substr(3));
														break;
													default:
														if(loc0 !== "P")
														{
															this.defaultProcessAction(loc2,loc3,loc4,loc5);
															break;
														}
														this.aks.Game.onPVP(loc5.substr(3),false);
														break;
												}
												break loop13;
											case "D":
												loop17:
												switch(loc5.charAt(2))
												{
													case "M":
														this.aks.Game.onMapData(loc5.substr(4));
														break;
													case "K":
														this.aks.Game.onMapLoaded();
														break;
													case "C":
														this.aks.Game.onCellData(loc5.substr(3));
														break;
													case "Z":
														this.aks.Game.onZoneData(loc5.substring(3));
														break;
													default:
														switch(null)
														{
															case "O":
																this.aks.Game.onCellObject(loc5.substring(3));
																break loop17;
															case "F":
																this.aks.Game.onFrameObject2(loc5.substring(4));
																break loop17;
															case "E":
																this.aks.Game.onFrameObjectExternal(loc5.substring(4));
																break loop17;
															default:
																this.defaultProcessAction(loc2,loc3,loc4,loc5);
														}
												}
												break loop13;
											default:
												switch(null)
												{
													case "d":
														switch(loc5.charAt(3))
														{
															case "K":
																this.aks.Game.onFightChallengeUpdate(loc5.substr(4),true);
																break;
															case "O":
																this.aks.Game.onFightChallengeUpdate(loc5.substr(4),false);
																break;
															default:
																this.aks.Game.onFightChallenge(loc5.substr(2));
														}
														break loop13;
													case "A":
														switch(loc5.charAt(2))
														{
															case "S":
																this.aks.GameActions.onActionsStart(loc5.substr(3));
																break;
															case "F":
																this.aks.GameActions.onActionsFinish(loc5.substr(3));
																break;
															default:
																this.aks.GameActions.onActions(loc5.substr(2));
														}
														break loop13;
													case "T":
														loop22:
														switch(loc5.charAt(2))
														{
															case "S":
																this.aks.Game.onTurnStart(loc5.substr(3));
																break;
															case "F":
																this.aks.Game.onTurnFinish(loc5.substr(3));
																break;
															default:
																switch(null)
																{
																	case "L":
																		this.aks.Game.onTurnlist(loc5.substr(4));
																		break loop22;
																	case "M":
																		this.aks.Game.onTurnMiddle(loc5.substr(4));
																		break loop22;
																	case "R":
																		this.aks.Game.onTurnReady(loc5.substr(3));
																		break loop22;
																	default:
																		this.defaultProcessAction(loc2,loc3,loc4,loc5);
																}
														}
														break loop13;
													case "X":
														this.aks.Game.onExtraClip(loc5.substr(2));
														break loop13;
													default:
														switch(null)
														{
															case "o":
																this.aks.Game.onFightOption(loc5.substr(2));
																break loop13;
															case "O":
																this.aks.Game.onGameOver();
																break loop13;
															default:
																this.defaultProcessAction(loc2,loc3,loc4,loc5);
														}
												}
										}
								}
						}
						break loop0;
					default:
						switch(null)
						{
							case "c":
								switch(loc3)
								{
									case "M":
										this.aks.Chat.onMessage(!loc4,loc5.substr(3));
										break;
									case "s":
										this.aks.Chat.onServerMessage(loc5.substr(2));
										break;
									case "S":
										this.aks.Chat.onSmiley(loc5.substr(2));
										break;
									case "C":
										this.aks.Chat.onSubscribeChannel(loc5.substr(2));
										break;
									default:
										this.defaultProcessAction(loc2,loc3,loc4,loc5);
								}
								break loop0;
							case "D":
								loop27:
								switch(loc3)
								{
									case "A":
										this.aks.Dialog.onCustomAction(loc5.substr(2));
										break;
									case "C":
										this.aks.Dialog.onCreate(!loc4,loc5.substr(3));
										break;
									case "Q":
										this.aks.Dialog.onQuestion(loc5.substr(2));
										break;
									default:
										switch(null)
										{
											case "V":
												this.aks.Dialog.onLeave();
												break loop27;
											case "P":
												this.aks.Dialog.onPause();
												break loop27;
											default:
												this.defaultProcessAction(loc2,loc3,loc4,loc5);
										}
								}
								break loop0;
							case "I":
								if((loc0 = loc3) !== "M")
								{
									switch(null)
									{
										case "C":
											this.aks.Infos.onInfoCompass(loc5.substr(2));
											break;
										case "H":
											this.aks.Infos.onInfoCoordinatespHighlight(loc5.substr(2));
											break;
										case "m":
											this.aks.Infos.onMessage(loc5.substr(2));
											break;
										case "Q":
											this.aks.Infos.onQuantity(loc5.substr(2));
											break;
										case "O":
											this.aks.Infos.onObject(loc5.substr(2));
											break;
										case "L":
											switch(loc5.charAt(2))
											{
												case "S":
													this.aks.Infos.onLifeRestoreTimerStart(loc5.substr(3));
													break;
												case "F":
													this.aks.Infos.onLifeRestoreTimerFinish(loc5.substr(3));
													break;
												default:
													this.defaultProcessAction(loc2,loc3,loc4,loc5);
											}
											break;
										default:
											this.defaultProcessAction(loc2,loc3,loc4,loc5);
									}
								}
								else
								{
									this.aks.Infos.onInfoMaps(loc5.substr(2));
								}
								break loop0;
							case "S":
								switch(loc3)
								{
									case "L":
										if((loc0 = loc5.charAt(2)) !== "o")
										{
											this.aks.Spells.onList(loc5.substr(2));
										}
										else
										{
											this.aks.Spells.onChangeOption(loc5.substr(3));
										}
										break;
									case "U":
										this.aks.Spells.onUpgradeSpell(!loc4,loc5.substr(3));
										break;
									case "B":
										this.aks.Spells.onSpellBoost(loc5.substr(2));
										break;
									case "F":
										this.aks.Spells.onSpellForget(loc5.substr(2));
										break;
									default:
										this.defaultProcessAction(loc2,loc3,loc4,loc5);
								}
								break loop0;
							default:
								switch(null)
								{
									case "O":
										loop33:
										switch(loc3)
										{
											case "a":
												this.aks.Items.onAccessories(loc5.substr(2));
												break;
											case "D":
												this.aks.Items.onDrop(!loc4,loc5.substr(3));
												break;
											default:
												switch(null)
												{
													case "A":
														this.aks.Items.onAdd(!loc4,loc5.substr(3));
														break loop33;
													case "C":
														this.aks.Items.onChange(loc5.substr(3));
														break loop33;
													case "R":
														this.aks.Items.onRemove(loc5.substr(2));
														break loop33;
													case "Q":
														this.aks.Items.onQuantity(loc5.substr(2));
														break loop33;
													case "M":
														this.aks.Items.onMovement(loc5.substr(2));
														break loop33;
													default:
														switch(null)
														{
															case "T":
																this.aks.Items.onTool(loc5.substr(2));
																break loop33;
															case "w":
																this.aks.Items.onWeight(loc5.substr(2));
																break loop33;
															case "S":
																this.aks.Items.onItemSet(loc5.substr(2));
																break loop33;
															case "K":
																this.aks.Items.onItemUseCondition(loc5.substr(2));
																break loop33;
															default:
																if(loc0 !== "F")
																{
																	this.defaultProcessAction(loc2,loc3,loc4,loc5);
																	break loop33;
																}
																this.aks.Items.onItemFound(loc5.substr(2));
																break loop33;
														}
												}
										}
										break loop0;
									case "F":
										switch(loc3)
										{
											case "A":
												this.aks.Friends.onAddFriend(!loc4,loc5.substr(3));
												break;
											case "D":
												this.aks.Friends.onRemoveFriend(!loc4,loc5.substr(3));
												break;
											case "L":
												this.aks.Friends.onFriendsList(loc5.substr(3));
												break;
											case "S":
												this.aks.Friends.onSpouse(loc5.substr(2));
												break;
											case "O":
												this.aks.Friends.onNotifyChange(loc5.substr(2));
												break;
											default:
												this.defaultProcessAction(loc2,loc3,loc4,loc5);
										}
										break loop0;
									case "i":
										switch(loc3)
										{
											case "A":
												this.aks.Enemies.onAddEnemy(!loc4,loc5.substr(3));
												break;
											case "D":
												this.aks.Enemies.onRemoveEnemy(!loc4,loc5.substr(3));
												break;
											case "L":
												this.aks.Enemies.onEnemiesList(loc5.substr(3));
												break;
											default:
												this.defaultProcessAction(loc2,loc3,loc4,loc5);
										}
										break loop0;
									case "K":
										switch(loc3)
										{
											case "C":
												this.aks.Key.onCreate(loc5.substr(3));
												break;
											case "K":
												this.aks.Key.onKey(!loc4);
												break;
											case "V":
												this.aks.Key.onLeave();
												break;
											default:
												this.defaultProcessAction(loc2,loc3,loc4,loc5);
										}
										break loop0;
									default:
										switch(null)
										{
											case "J":
												loop40:
												switch(loc3)
												{
													case "S":
														this.aks.Job.onSkills(loc5.substr(3));
														break;
													case "X":
														this.aks.Job.onXP(loc5.substr(3));
														break;
													default:
														switch(null)
														{
															case "N":
																this.aks.Job.onLevel(loc5.substr(2));
																break loop40;
															case "R":
																this.aks.Job.onRemove(loc5.substr(2));
																break loop40;
															case "O":
																this.aks.Job.onOptions(loc5.substr(2));
																break loop40;
															default:
																this.defaultProcessAction(loc2,loc3,loc4,loc5);
														}
												}
												break loop0;
											case "E":
												loop42:
												switch(loc3)
												{
													case "R":
														this.aks.Exchange.onRequest(!loc4,loc5.substr(3));
														break;
													case "K":
														this.aks.Exchange.onReady(loc5.substr(2));
														break;
													case "V":
														this.aks.Exchange.onLeave(!loc4,loc5.substr(2));
														break;
													default:
														switch(null)
														{
															case "C":
																this.aks.Exchange.onCreate(!loc4,loc5.substr(3));
																break loop42;
															case "c":
																this.aks.Exchange.onCraft(!loc4,loc5.substr(3));
																break loop42;
															case "M":
																this.aks.Exchange.onLocalMovement(!loc4,loc5.substr(3));
																break loop42;
															case "m":
																this.aks.Exchange.onDistantMovement(!loc4,loc5.substr(3));
																break loop42;
															default:
																switch(null)
																{
																	case "r":
																		this.aks.Exchange.onCoopMovement(!loc4,loc5.substr(3));
																		break loop42;
																	case "p":
																		this.aks.Exchange.onPayMovement(!loc4,loc5.substr(2));
																		break loop42;
																	case "s":
																		this.aks.Exchange.onStorageMovement(!loc4,loc5.substr(3));
																		break loop42;
																	case "i":
																		this.aks.Exchange.onPlayerShopMovement(!loc4,loc5.substr(3));
																		break loop42;
																	case "W":
																		this.aks.Exchange.onCraftPublicMode(loc5.substr(2));
																		break loop42;
																	default:
																		switch(null)
																		{
																			case "e":
																				this.aks.Exchange.onMountStorage(loc5.substr(2));
																				break loop42;
																			case "f":
																				this.aks.Exchange.onMountPark(loc5.substr(2));
																				break loop42;
																			case "w":
																				this.aks.Exchange.onMountPods(loc5.substr(2));
																				break loop42;
																			case "L":
																				this.aks.Exchange.onList(loc5.substr(2));
																				break loop42;
																			default:
																				switch(null)
																				{
																					case "S":
																						this.aks.Exchange.onSell(!loc4);
																						break loop42;
																					case "B":
																						this.aks.Exchange.onBuy(!loc4);
																						break loop42;
																					case "q":
																						this.aks.Exchange.onAskOfflineExchange(loc5.substr(2));
																						break loop42;
																					case "H":
																						loop47:
																						switch(loc5.charAt(2))
																						{
																							case "S":
																								this.aks.Exchange.onSearch(loc5.substr(3));
																								break;
																							case "L":
																								this.aks.Exchange.onBigStoreTypeItemsList(loc5.substr(3));
																								break;
																							case "M":
																								this.aks.Exchange.onBigStoreTypeItemsMovement(loc5.substr(3));
																								break;
																							case "l":
																								this.aks.Exchange.onBigStoreItemsList(loc5.substr(3));
																								break;
																							default:
																								switch(null)
																								{
																									case "m":
																										this.aks.Exchange.onBigStoreItemsMovement(loc5.substr(3));
																										break loop47;
																									case "P":
																										this.aks.Exchange.onItemMiddlePriceInBigStore(loc5.substr(3));
																										break loop47;
																									default:
																										this.defaultProcessAction(loc2,loc3,loc4,loc5);
																								}
																						}
																						break loop42;
																					case "J":
																						this.aks.Exchange.onCrafterListChanged(loc5.substr(2));
																						break loop42;
																					default:
																						switch(null)
																						{
																							case "j":
																								this.aks.Exchange.onCrafterReference(loc5.substr(2));
																								break loop42;
																							case "A":
																								this.aks.Exchange.onCraftLoop(loc5.substr(2));
																								break loop42;
																							case "a":
																								this.aks.Exchange.onCraftLoopEnd(loc5.substr(2));
																								break loop42;
																							default:
																								this.defaultProcessAction(loc2,loc3,loc4,loc5);
																						}
																				}
																		}
																}
														}
												}
												break loop0;
											case "h":
												loop50:
												switch(loc3)
												{
													case "L":
														this.aks.Houses.onList(loc5.substr(2));
														break;
													case "P":
														this.aks.Houses.onProperties(loc5.substr(2));
														break;
													case "X":
														this.aks.Houses.onLockedProperty(loc5.substr(2));
														break;
													default:
														switch(null)
														{
															case "C":
																this.aks.Houses.onCreate(loc5.substr(3));
																break loop50;
															case "S":
																this.aks.Houses.onSell(!loc4,loc5.substr(3));
																break loop50;
															case "B":
																this.aks.Houses.onBuy(!loc4,loc5.substr(3));
																break loop50;
															case "V":
																this.aks.Houses.onLeave();
																break loop50;
															default:
																if(loc0 !== "G")
																{
																	this.defaultProcessAction(loc2,loc3,loc4,loc5);
																	break loop50;
																}
																this.aks.Houses.onGuildInfos(loc5.substr(2));
																break loop50;
														}
												}
												break loop0;
											case "s":
												switch(loc3)
												{
													case "L":
														this.aks.Storages.onList(loc5.substr(2));
														break;
													case "X":
														this.aks.Storages.onLockedProperty(loc5.substr(2));
														break;
													default:
														this.defaultProcessAction(loc2,loc3,loc4,loc5);
												}
												break loop0;
											default:
												switch(null)
												{
													case "e":
														loop54:
														switch(loc3)
														{
															case "U":
																this.aks.Emotes.onUse(!loc4,loc5.substr(3));
																break;
															case "L":
																this.aks.Emotes.onList(loc5.substr(2));
																break;
															default:
																switch(null)
																{
																	case "A":
																		this.aks.Emotes.onAdd(loc5.substr(2));
																		break loop54;
																	case "R":
																		this.aks.Emotes.onRemove(loc5.substr(2));
																		break loop54;
																	case "D":
																		this.aks.Emotes.onDirection(loc5.substr(2));
																		break loop54;
																	default:
																		this.defaultProcessAction(loc2,loc3,loc4,loc5);
																}
														}
														break loop0;
													case "d":
														switch(loc3)
														{
															case "C":
																this.aks.Documents.onCreate(!loc4,loc5.substr(3));
																break;
															case "V":
																this.aks.Documents.onLeave();
																break;
															default:
																this.defaultProcessAction(loc2,loc3,loc4,loc5);
														}
														break loop0;
													case "g":
														loop57:
														switch(loc3)
														{
															case "n":
																this.aks.Guild.onNew();
																break;
															case "C":
																this.aks.Guild.onCreate(!loc4,loc5.substr(3));
																break;
															default:
																switch(null)
																{
																	case "S":
																		this.aks.Guild.onStats(loc5.substr(2));
																		break loop57;
																	case "I":
																		loop59:
																		switch(loc5.charAt(2))
																		{
																			case "G":
																				this.aks.Guild.onInfosGeneral(loc5.substr(3));
																				break;
																			case "M":
																				this.aks.Guild.onInfosMembers(loc5.substr(3));
																				break;
																			default:
																				switch(null)
																				{
																					case "B":
																						this.aks.Guild.onInfosBoosts(loc5.substr(3));
																						break loop59;
																					case "F":
																						this.aks.Guild.onInfosMountPark(loc5.substr(3));
																						break loop59;
																					case "T":
																						switch(loc5.charAt(3))
																						{
																							case "M":
																								this.aks.Guild.onInfosTaxCollectorsMovement(loc5.substr(4));
																								break;
																							case "P":
																								this.aks.Guild.onInfosTaxCollectorsPlayers(loc5.substr(4));
																								break;
																							case "p":
																								this.aks.Guild.onInfosTaxCollectorsAttackers(loc5.substr(4));
																								break;
																							default:
																								this.defaultProcessAction(loc2,loc3,loc4,loc5);
																						}
																						break loop59;
																					case "H":
																						this.aks.Guild.onInfosHouses(loc5.substr(3));
																						break loop59;
																					default:
																						this.defaultProcessAction(loc2,loc3,loc4,loc5);
																				}
																		}
																		break loop57;
																	case "J":
																		switch(loc5.charAt(2))
																		{
																			case "E":
																				this.aks.Guild.onJoinError(loc5.substr(3));
																				break;
																			case "R":
																				this.aks.Guild.onRequestLocal(loc5.substr(3));
																				break;
																			case "r":
																				this.aks.Guild.onRequestDistant(loc5.substr(3));
																				break;
																			case "K":
																				this.aks.Guild.onJoinOk(loc5.substr(3));
																				break;
																			case "C":
																				this.aks.Guild.onJoinDistantOk();
																				break;
																			default:
																				this.defaultProcessAction(loc2,loc3,loc4,loc5);
																		}
																		break loop57;
																	case "V":
																		this.aks.Guild.onLeave();
																		break loop57;
																	default:
																		switch(null)
																		{
																			case "K":
																				this.aks.Guild.onBann(!loc4,loc5.substr(3));
																				break loop57;
																			case "H":
																				this.aks.Guild.onHireTaxCollector(!loc4,loc5.substr(3));
																				break loop57;
																			case "A":
																				this.aks.Guild.onTaxCollectorAttacked(loc5.substr(2));
																				break loop57;
																			case "T":
																				this.aks.Guild.onTaxCollectorInfo(loc5.substr(2));
																				break loop57;
																			case "U":
																				this.aks.Guild.onUserInterfaceOpen(loc5.substr(2));
																				break loop57;
																			default:
																				this.defaultProcessAction(loc2,loc3,loc4,loc5);
																		}
																}
														}
														break loop0;
													case "W":
														if((loc0 = loc3) !== "C")
														{
															loop64:
															switch(null)
															{
																case "V":
																	this.aks.Waypoints.onLeave();
																	break;
																case "U":
																	this.aks.Waypoints.onUseError();
																	break;
																case "c":
																	this.aks.Subway.onCreate(loc5.substr(2));
																	break;
																case "v":
																	this.aks.Subway.onLeave();
																	break;
																default:
																	switch(null)
																	{
																		case "u":
																			this.aks.Subway.onUseError();
																			break loop64;
																		case "p":
																			this.aks.Subway.onPrismCreate(loc5.substr(2));
																			break loop64;
																		case "w":
																			this.aks.Subway.onPrismLeave();
																			break loop64;
																		default:
																			this.defaultProcessAction(loc2,loc3,loc4,loc5);
																	}
															}
														}
														else
														{
															this.aks.Waypoints.onCreate(loc5.substr(2));
														}
														break loop0;
													default:
														switch(null)
														{
															case "a":
																if((loc0 = loc3) !== "l")
																{
																	switch(null)
																	{
																		case "m":
																			this.aks.Subareas.onAlignmentModification(loc5.substr(2));
																			break;
																		case "M":
																			this.aks.Conquest.onAreaAlignmentChanged(loc5.substr(2));
																			break;
																		default:
																			this.defaultProcessAction(loc2,loc3,loc4,loc5);
																	}
																}
																else
																{
																	this.aks.Subareas.onList(loc5.substr(3));
																}
																break loop0;
															case "C":
																loop68:
																switch(loc3)
																{
																	case "I":
																		switch(loc5.charAt(2))
																		{
																			case "J":
																				this.aks.Conquest.onPrismInfosJoined(loc5.substr(3));
																				break;
																			case "V":
																				this.aks.Conquest.onPrismInfosClosing(loc5.substr(3));
																				break;
																			default:
																				this.defaultProcessAction(loc2,loc3,loc4,loc5);
																		}
																		break;
																	case "B":
																		this.aks.Conquest.onConquestBonus(loc5.substr(2));
																		break;
																	case "A":
																		this.aks.Conquest.onPrismAttacked(loc5.substr(2));
																		break;
																	case "S":
																		this.aks.Conquest.onPrismSurvived(loc5.substr(2));
																		break;
																	default:
																		switch(null)
																		{
																			case "D":
																				this.aks.Conquest.onPrismDead(loc5.substr(2));
																				break loop68;
																			case "P":
																				this.aks.Conquest.onPrismFightAddPlayer(loc5.substr(2));
																				break loop68;
																			case "p":
																				this.aks.Conquest.onPrismFightAddEnemy(loc5.substr(2));
																				break loop68;
																			case "W":
																				this.aks.Conquest.onWorldData(loc5.substr(2));
																				break loop68;
																			case "b":
																				this.aks.Conquest.onConquestBalance(loc5.substr(2));
																				break loop68;
																			default:
																				this.defaultProcessAction(loc2,loc3,loc4,loc5);
																		}
																}
																break loop0;
															case "Z":
																switch(loc3)
																{
																	case "S":
																		this.aks.Specialization.onSet(loc5.substr(2));
																		break;
																	case "C":
																		this.aks.Specialization.onChange(loc5.substr(2));
																		break;
																	default:
																		this.defaultProcessAction(loc2,loc3,loc4,loc5);
																}
																break loop0;
															case "f":
																switch(loc3)
																{
																	case "C":
																		this.aks.Fights.onCount(loc5.substr(2));
																		break;
																	case "L":
																		this.aks.Fights.onList(loc5.substr(2));
																		break;
																	case "D":
																		this.aks.Fights.onDetails(loc5.substr(2));
																		break;
																	default:
																		this.defaultProcessAction(loc2,loc3,loc4,loc5);
																}
																break loop0;
															default:
																loop73:
																switch(null)
																{
																	case "T":
																		switch(loc3)
																		{
																			case "C":
																				this.aks.Tutorial.onCreate(loc5.substr(2));
																				break;
																			case "T":
																				this.aks.Tutorial.onShowTip(loc5.substr(2));
																				break;
																			case "B":
																				this.aks.Tutorial.onGameBegin();
																				break;
																			default:
																				this.defaultProcessAction(loc2,loc3,loc4,loc5);
																		}
																		break;
																	case "Q":
																		switch(loc3)
																		{
																			case "L":
																				this.aks.Quests.onList(loc5.substr(3));
																				break;
																			case "S":
																				this.aks.Quests.onStep(loc5.substr(2));
																				break;
																			default:
																				this.defaultProcessAction(loc2,loc3,loc4,loc5);
																		}
																		break;
																	case "P":
																		loop76:
																		switch(loc3)
																		{
																			case "I":
																				this.aks.Party.onInvite(!loc4,loc5.substr(3));
																				break;
																			case "L":
																				this.aks.Party.onLeader(loc5.substr(2));
																				break;
																			case "R":
																				this.aks.Party.onRefuse(loc5.substr(2));
																				break;
																			case "A":
																				this.aks.Party.onAccept(loc5.substr(2));
																				break;
																			case "C":
																				this.aks.Party.onCreate(!loc4,loc5.substr(3));
																				break;
																			default:
																				switch(null)
																				{
																					case "V":
																						this.aks.Party.onLeave(loc5.substr(2));
																						break loop76;
																					case "F":
																						this.aks.Party.onFollow(!loc4,loc5.substr(3));
																						break loop76;
																					case "M":
																						this.aks.Party.onMovement(loc5.substr(2));
																						break loop76;
																					default:
																						this.defaultProcessAction(loc2,loc3,loc4,loc5);
																				}
																		}
																		break;
																	case "R":
																		switch(loc3)
																		{
																			case "e":
																				this.aks.Mount.onEquip(loc5.substr(2));
																				break loop73;
																			case "x":
																				this.aks.Mount.onXP(loc5.substr(2));
																				break loop73;
																			default:
																				switch(null)
																				{
																					case "n":
																						this.aks.Mount.onName(loc5.substr(2));
																						break loop73;
																					case "d":
																						this.aks.Mount.onData(loc5.substr(2));
																						break loop73;
																					case "p":
																						this.aks.Mount.onMountPark(loc5.substr(2));
																						break loop73;
																					case "D":
																						this.aks.Mount.onMountParkBuy(loc5.substr(2));
																						break loop73;
																					case "v":
																						this.aks.Mount.onLeave(loc5.substr(2));
																						break loop73;
																					default:
																						if(loc0 !== "r")
																						{
																							this.defaultProcessAction(loc2,loc3,loc4,loc5);
																							break loop73;
																						}
																						this.aks.Mount.onRidingState(loc5.substr(2));
																						break loop73;
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
